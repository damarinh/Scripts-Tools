param (
    [string] $OutputDir = '.',
    [string] $OutputFileName = 'RBACs.txt' )

#--------------------------------------------------------------------------------- 
# The sample scripts are not supported under any Microsoft standard support 
# program or service. The sample scripts are provided AS IS without warranty  
# of any kind. Microsoft further disclaims all implied warranties including,  
# without limitation, any implied warranties of merchantability or of fitness for 
# a particular purpose. The entire risk arising out of the use or performance of  
# the sample scripts and documentation remains with you. In no event shall 
# Microsoft, its authors, or anyone else involved in the creation, production, or 
# delivery of the scripts be liable for any damages whatsoever (including, 
# without limitation, damages for loss of business profits, business interruption, 
# loss of business information, or other pecuniary loss) arising out of the use 
# of or inability to use the sample scripts or documentation, even if Microsoft 
# has been advised of the possibility of such damages 
#--------------------------------------------------------------------------------- 

# Imprime messengens e informações de log
function Trace(
    [Parameter(ValueFromPipeline=$true)]
	[string] $Message,
    [string] $Type = 'Info',
    [string] $Source = $null)
{
    if ($Source) { $Message = "[$Source] $Message" }
    if ($Type) { $Message = "[$Type] $Message" }
    Write-Output $Message
    $Message = "[$(Get-Date)] $Message"

	Add-Content -Path "$OutputDir\script.log" -Value $Message -Force -Encoding UTF8 -ErrorAction SilentlyContinue
}


function ListaOwnerExcessivos()
{
    #----Script para listar as subscription com mais de 3 owners ----#

    Trace "Listing Subscriptions with more than 3 owners" 
    Add-Content -Path "$OutputDir\$OutputFileName" -Value "`n[$(Get-Date)] Listando Subscriptions com +3 Owners" -Force -Encoding UTF8 -ErrorAction SilentlyContinue

    #Observação: Para executar este script o usuário precisar de Global Admin no Azure AD e habilitar a elevação de User Access Administrator nas propriedades do AAD. Lembrar de desfazer
    #a elevação após a rotina. E utilizar o PIM para atribuir temporiariamente a função de Global Admin. 

    try
    {
        # Lista todos os Subscription Ids que o usuário que está executando é usuário
        $SubscriptionIds = (az account list --query '[*].id') | Out-String | ConvertFrom-Json
    }
    catch
    {
        Trace "$_" -Type 'Error' -Source 'List_ExceededOwners'
    }



    #Percorre todos as subscriptions 
    foreach ($subscriptionId in $SubscriptionIds) 
    { 
        try
        {
            #Lista o escopo da subscription na quantidade de Owners que ela tiver.
            $scope = (az role assignment list --role "Owner" --subscription $subscriptionId --include-inherited --query '[*].scope') | Out-String | ConvertFrom-Json
        }
        catch
        {
            Trace "$_" -Type 'Error' -Source 'List_ExceededOwners'
        }
    
        #Se a listagem for maior que 3, significa que tem 4 owners ou mais e imprime a subscription que deve ser avaliada
        if($scope.count -eq 3)
        {
            Trace "`t`tEscopo ($($scope[0]))"
            Add-Content -Path "$OutputDir\$OutputFileName" -Value "`n +3 Owners: $($scope[0])" -Force -Encoding UTF8 -ErrorAction SilentlyContinue
        } 
    }
}



function ListaContasDesabilitadas()
{
    #----Script para Listar RBAC das contas desabilitadas do Azure AD de todas as subscriptions ----#
    
    Trace "Listando contas desabilitadas e roles associadas" 
    Add-Content -Path "$OutputDir\$OutputFileName" -Value "`n[$(Get-Date)] Listando contas desabilitadas e roles associadas" -Force -Encoding UTF8 -ErrorAction SilentlyContinue

    #Observação: Para executar este script o usuário precisar de Global Admin no Azure AD e habilitar a elevação de User Access Administrator nas propriedades do AAD. Lembrar de desfazer
    #a elevação após a rotina. E utilizar o PIM para atribuir temporiariamente a função de Global Admin. 

     try
    {
        #Lista e armazena todos os ObjectIds das contas desabilitadas no Azure AD
        $objectIds = (az ad user list --filter "accountEnabled eq false" --query "[].{objectId:objectId}") | Out-String | ConvertFrom-Json
    }
    catch
    {
        Trace "$_" -Type 'Error' -Source 'ListaContasDesabilitadas'
    }
        
    # Lista todos os Subscription Ids que o usuário que está executando é usuário
    $SubscriptionIds = (az account list --query '[*].id') | Out-String | ConvertFrom-Json

    #Percorre todos as subscriptions 
    foreach ($subscriptionId in $SubscriptionIds) 
    { 
        Trace "Avaliando {subscriptionId=$($subscriptionId)}"
        az account set --subscription $subscriptionId

        #Lista e imprime todas as permissões RBAC  dos Ids extraídos acima
        foreach ($objectId in $objectIds) 
        { 
            Trace "Avaliando $($objectId)"
            try
            {
                #Lista e imprime todas as permissões RBAC  para cada ObjectId extraído acima
                $roles = az role assignment list --include-inherited  --all --assignee ($objectId.objectid) 
                Trace "$roles"
                Add-Content -Path "$OutputDir\$OutputFileName" -Value "$objectId `n $roles" -Force -Encoding UTF8 -ErrorAction SilentlyContinue 
            }
            catch
            {
                Trace "$_" -Type 'Error' -Source 'ListaContasDesabilitadas'
            }  
         }
    }
}


function RemoveContasDesabilitadas()
{
    #----Script para Listar RBAC das contas desabilitadas do Azure AD de todas as subscriptions ----#
    
    Trace "Removendo roles associadas a contas desabilitadas"
    Add-Content -Path "$OutputDir\$OutputFileName" -Value "`n[$(Get-Date)] Removendo roles associadas a contas desabilitadas" -Force -Encoding UTF8 -ErrorAction SilentlyContinue 

    #Observação: Para executar este script o usuário precisar de Global Admin no Azure AD e habilitar a elevação de User Access Administrator nas propriedades do AAD. Lembrar de desfazer
    #a elevação após a rotina. E utilizar o PIM para atribuir temporiariamente a função de Global Admin. 

     try
    {
        #Lista e armazena todos os ObjectIds das contas desabilitadas no Azure AD
        $objectIds = (az ad user list --filter "accountEnabled eq false" --query "[].{objectId:objectId}") | Out-String | ConvertFrom-Json
    }
    catch
    {
        Trace "$_" -Type 'Error' -Source 'ListaContasDesabilitadas'
    }
        
    # Lista todos os Subscription Ids que o usuário que está executando é usuário
    $SubscriptionIds = (az account list --query '[*].id') | Out-String | ConvertFrom-Json

    #Percorre todos as subscriptions 
    foreach ($subscriptionId in $SubscriptionIds) 
    { 
        Trace "Avaliando {subscriptionId=$($subscriptionId)}"
        az account set --subscription $subscriptionId

        #Lista e imprime todas as permissões RBAC  dos Ids extraídos acima
        foreach ($objectId in $objectIds) 
        { 
             try
            {
                #Lista e imprime todas as permissões RBAC  para cada ObjectId extraído acima
                $roles = az role assignment list --include-inherited  --all --assignee ($objectId.objectid) 
                Trace "$roles"
            }
            catch
            {
                Trace "$_" -Type 'Error' -Source 'ListaContasDesabilitadas'
            }
       
            #Se a lista não for vazia, então faz as deleções
            if($roles -ne '[]'){ 
               #Remove todas as permissões RBACs de todas as subscriptions e management group 
               Get-AzRoleAssignment -ObjectId ($objectId.objectid)  | Remove-AzRoleAssignment -Confirm
               Add-Content -Path "$OutputDir\$OutputFileName" -Value "$objectId `n $roles `t removed" -Force -Encoding UTF8 -ErrorAction SilentlyContinue    
               #az role assignment delete --include-inherited --assignee $objectId --yes -y
            }   
         }
    }
}


function ListaContasExcluidas()
{
    Trace "Listando permissões de contas excluidas"
    Add-Content -Path "$OutputDir\$OutputFileName" -Value "`n[$(Get-Date)] Listando permissões de contas excluidas" -Force -Encoding UTF8 -ErrorAction SilentlyContinue

    #--------Script para remover RBAC das contas excluídas do Azure AD de todas as subscriptions --------#

    #Observação: Para executar este script o usuário precisar de Global Admin no Azure AD e habilitar a elevação de User Access Administrator nas propriedades do AAD. Lembrar de desfazer
    #a elevação após a rotina. E utilizar o PIM para atribuir temporiariamente a função de Global Admin. 

    try
    {
        # Lista todos os Subscription Ids que o usuário que está executando é usuário
        $subscriptions = Get-AzSubscription
    }
    catch
    {
        Trace "$_" -Type 'Error' -Source 'ListaContasExcluidas'
    }
   

    #Percorre todos as subscriptions 
    foreach ($subscription in $subscriptions) 
    { 
        Set-AzContext -Subscription $subscription.Id
        Trace "Avaliando {subscriptionId=$($subscription.Id)}"
        try
        {
            #Lista todas as roles do ambiente
            $roles = Get-AzRoleAssignment
        }
        catch
        {
            Trace "$_" -Type 'Error' -Source 'ListaContasExcluidas'
        }


        #Percorre todo permissionamento para identificar contas excluidas do Azure AD com RBAC atribuído
        foreach ($role in $roles) 
        { 
            #Se a conta estiver Desconhecida entra para remover
            if($role.ObjectType -eq "Unknown")
            {
                 Trace ($role|Out-String)
                 Add-Content -Path "$OutputDir\$OutputFileName" -Value ($role|Out-String) -Force -Encoding UTF8 -ErrorAction SilentlyContinue 
            } 
        }
    }
}



function RemoveContasExcluidas()
{

    Trace "Listando permissões de contas excluidas"
    Add-Content -Path "$OutputDir\$OutputFileName" -Value "`n[$(Get-Date)] Listando permissões de contas excluidas" -Force -Encoding UTF8 -ErrorAction SilentlyContinue
    #--------Script para remover RBAC das contas excluídas do Azure AD de todas as subscriptions --------#

    #Observação: Para executar este script o usuário precisar de Global Admin no Azure AD e habilitar a elevação de User Access Administrator nas propriedades do AAD. Lembrar de desfazer
    #a elevação após a rotina. E utilizar o PIM para atribuir temporiariamente a função de Global Admin. 

    try
    {
        # Lista todos os Subscription Ids que o usuário que está executando é usuário
        $subscriptions = Get-AzSubscription
    }
    catch
    {
        Trace "$_" -Type 'Error' -Source 'RemoveContasExcluidas'
    }
   

    #Percorre todos as subscriptions 
    foreach ($subscription in $subscriptions) 
    { 
        Set-AzContext -Subscription $subscription.Id
        Trace "Avaliando {subscriptionId=$($subscription.Id)}"
        try
        {
            #Lista todas as roles do ambiente
            $roles = Get-AzRoleAssignment
        }
        catch
        {
            Trace "$_" -Type 'Error' -Source 'RemoveContasExcluidas'
        }


        #Percorre todo permissionamento para identificar contas excluidas do Azure AD com RBAC atribuído
        foreach ($role in $roles) 
        { 
            #Se a conta estiver Desconhecida entra para remover
            if($role.ObjectType -eq "Unknown")
            {
                Trace ($role|Out-String) 
                try
                {
                    #Remove todos os permissionamentos RBACs das contas excluídas do Azure AD
                    Get-AzRoleAssignment -ObjectId $role.ObjectId  | Remove-AzRoleAssignment -Confirm
                    Add-Content -Path "$OutputDir\$OutputFileName" -Value "$($role|Out-String) `t Removed" -Force -Encoding UTF8 -ErrorAction SilentlyContinue  
                }
                catch
                {
                    Trace "$_" -Type 'Error' -Source 'RemoveContasExcluidas'
                }

            } 
        }
    }
}