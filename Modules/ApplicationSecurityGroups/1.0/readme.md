# ApplicationSecurityGroups

This module deploys Application Security Groups.

## Resources

- Microsoft.Network/applicationSecurityGroups

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `applicationSecurityGroupName` | string | | Required. Name of the Application Security Group.
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources.
| `lockForDeletion` | bool | `true` | | Optional. Switch to lock Virtual Network Gateway from deletion.
| `tags` | object | {} | Complex structure, see below. | Optional. Tags of the Virtual Network Gateway resource.

### Parameter Usage: `tags`

Tag names and tag values can be provided as needed. A tag can be left without a value.

```json
"tags": {
    "value": {
        "Environment": "Non-Prod",
        "Contact": "test.user@testcompany.com",
        "PurchaseOrder": "1234",
        "CostCenter": "7890",
        "ServiceName": "DeploymentValidation",
        "Role": "DeploymentValidation"
    }
}
```

## Outputs

| Output Name | Descriptions |
| :-          | :-          |
| `applicationSecurityGroupResourceGroup` | The name of the Resource Group the Application Security Groups were created in.
| `applicationSecurityGroupResourceId` | The Resource Ids of the Application Security Group deployed.
| `applicationSecurityGroupName` | The Name of the Application Security Group deployed.

## Considerations

*N/A*

## Additional resources

- [Application Security Groups](https://docs.microsoft.com/en-us/azure/virtual-network/security-overview#application-security-groups)
- [Microsoft.Network applicationSecurityGroups template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2018-08-01/applicationsecuritygroups)