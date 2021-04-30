<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		File:		module.tests.ps1

		Purpose:	Pester - Test ARM Templates

		Version: 	1.0.0.0 - 1st April 2019 - Microsoft Consulting Services
		==============================================================================================

	.SYNOPSIS
		This script contains functionality used to test ARM template synatax.

	.DESCRIPTION
		This script contains functionality used to test ARM template synatax.

		Deployment steps of the script are outlined below.
        1) Test Template File Syntax
		2) Test Parameter File Syntax
		3) Test Template and Parameter File Compatibility
#>

#Requires -Version 5

#region - Parameters
$parametersLocation = 'Parameters'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$here = Join-Path $here ".."
$template = (Get-Item $here).parent.Name
$TemplateFileTestCases = @()
ForEach ( $File in (Get-ChildItem (Join-Path "$here" "deploy.json") -Recurse | Select-Object  -ExpandProperty Name) ) {
    $TemplateFileTestCases += @{ TemplateFile = $File }
}
$ParameterFileTestCases = @()
ForEach ( $File in (Get-ChildItem (Join-Path "$here" "$parametersLocation" -AdditionalChildPath @("*parameters.json")) -Recurse -ErrorAction SilentlyContinue | Select-Object  -ExpandProperty Name) ) {
	$ParameterFileTestCases += @{ ParameterFile = Join-Path "$parametersLocation" $File }
}
$Modules = @();
ForEach ( $File in (Get-ChildItem (Join-Path "$here" "deploy.json") ) ) {
	$Module = [PSCustomObject]@{
		'Template' = $null
		'Parameters' = $null
	}
	$Module.Template = $File.FullName
	$Parameters = @()
	ForEach ( $ParameterFile in (Get-ChildItem (Join-Path "$here" "$parametersLocation" -AdditionalChildPath @("*parameters.json")) -Recurse -ErrorAction SilentlyContinue | Select-Object  -ExpandProperty Name) ) {
		$Parameters += (Join-Path "$here" "$parametersLocation" -AdditionalChildPath @("$ParameterFile") )
	}
	$Module.Parameters = $Parameters
	$Modules += @{ Module = $Module }
}
#endregion

#region - Run Pester Test Script
Describe "Template: $template" -Tags Unit {
	
	Context "Template File Syntax" {
		
		It "JSON template file (deploy.json) exists" {
			(Join-Path "$here" "deploy.json") | Should Exist
		}
		
		It "Template file (deploy.json) converts from JSON and has all expected properties" -TestCases $TemplateFileTestCases {
			Param ($TemplateFile)
			$expectedProperties = '$schema',
			'contentVersion',
			'parameters',
			'variables',
			'resources',
			'outputs'| Sort-Object
			$templateProperties = (Get-Content (Join-Path "$here" "$TemplateFile") `
				| ConvertFrom-Json -ErrorAction SilentlyContinue) `
				| Get-Member -MemberType NoteProperty `
				| Sort-Object -Property Name `
				| ForEach-Object Name
			$templateProperties | Should Be $expectedProperties
		}
	}
	
	Context "Parameter File Syntax" {
	   
		It "Parameter file ($ParameterFile) does contain all expected properties" -TestCases $ParameterFileTestCases {
            Param ($ParameterFile)
            $expectedProperties = '$schema',
            'contentVersion',
			'parameters' | Sort-Object
			$templateFileProperties = (Get-Content (Join-Path "$here" "$ParameterFile") `
				| ConvertFrom-Json -ErrorAction SilentlyContinue) `
				| Get-Member -MemberType NoteProperty `
				| Sort-Object -Property Name `
				| ForEach-Object Name
            $templateFileProperties | Should Be $expectedProperties 
        }
    }

	Context "Template and Parameter Compatibility" {

		It "Count of required parameters in template file ($((Get-Item $Module.Template).Name)) is equal or less than count of all parameters in parameters file ($((Get-Item $Module.Parameters).Name))" -TestCases $Modules {
			Param ($Module)
			
			$requiredParametersInTemplateFile = (Get-Content "$($Module.Template)" `
				| ConvertFrom-Json -ErrorAction SilentlyContinue).Parameters.PSObject.Properties `
				| Where-Object -FilterScript { -not ($_.Value.PSObject.Properties.Name -eq "defaultValue") } `
				| Sort-Object -Property Name `
				| ForEach-Object Name
			ForEach ( $Parameter in $Module.Parameters ) {
				$allParametersInParametersFile = (Get-Content $Parameter `
					| ConvertFrom-Json -ErrorAction SilentlyContinue).Parameters.PSObject.Properties `
					| Sort-Object -Property Name `
					| ForEach-Object Name
				if ($requiredParametersInTemplateFile.Count -gt $allParametersInParametersFile.Count) {
					Write-Host "Mismatch found, parameters from parameter file are more than the expected in the template"
					Write-Host "Required parameters are: $(ConvertTo-Json $requiredParametersInTemplateFile)"
					Write-Host "Parameters from parameter file are: $(ConvertTo-Json $allParametersInParametersFile)"
				}
				$requiredParametersInTemplateFile.Count | Should Not BeGreaterThan $allParametersInParametersFile.Count;
			}
		}

		It "All parameters in parameters file ($((Get-Item $Module.Parameters).Name)) exist in template file ($((Get-Item $Module.Template).Name))" -TestCases $Modules {
			Param( $Module )

			$allParametersInTemplateFile = (Get-Content "$($Module.Template)" `
				| ConvertFrom-Json -ErrorAction SilentlyContinue).Parameters.PSObject.Properties `
				| Sort-Object -Property Name `
				| ForEach-Object Name
			ForEach ( $Parameter in $Module.Parameters ) {
				$allParametersInParametersFile = (Get-Content $Parameter `
					| ConvertFrom-Json -ErrorAction SilentlyContinue).Parameters.PSObject.Properties `
					| Sort-Object -Property Name `
					| ForEach-Object Name
				$result = @($allParametersInParametersFile| Where-Object {$allParametersInTemplateFile -notcontains $_});
				if($result) {Write-Host "Invalid parameters: $(ConvertTo-Json $result)"}
				@($allParametersInParametersFile| Where-Object {$allParametersInTemplateFile -notcontains $_}).Count | Should Be 0;
			}
		}

		It "All required parameters in template file existing in parameters file" -TestCases $Modules {
			Param ($Module)

			$requiredParametersInTemplateFile = (Get-Content "$($Module.Template)" `
				| ConvertFrom-Json -ErrorAction SilentlyContinue).Parameters.PSObject.Properties `
				| Where-Object -FilterScript { -not ($_.Value.PSObject.Properties.Name -eq "defaultValue") } `
				| Sort-Object -Property Name `
				| ForEach-Object Name
			ForEach ( $Parameter in $Module.Parameters ) {
				
				$allParametersInParametersFile = (Get-Content $Parameter `
					| ConvertFrom-Json -ErrorAction SilentlyContinue).Parameters.PSObject.Properties `
					| Sort-Object -Property Name `
					| ForEach-Object Name
				
				$invalid = $requiredParametersInTemplateFile | Where-Object {$allParametersInParametersFile -notcontains $_}
				if ($invalid.Count -gt 0) {
					Write-Host "Invalid parameters: $(ConvertTo-Json $invalid)"
				}
				@($requiredParametersInTemplateFile | Where-Object {$allParametersInParametersFile -notcontains $_}).Count | Should Be 0;
			}
		}
	}

}
#endregion