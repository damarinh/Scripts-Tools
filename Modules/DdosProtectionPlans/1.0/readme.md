# DDoS Protection Plan

This template deploys a DDoS protection plan.

## Resources

- Microsoft.Network/ddosProtectionPlans
- Microsoft.Network/ddosProtectionPlans/providers/locks

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `ddosProtectionPlanName` | string | | | Optional. Name of the DDoS protection plan to assign the VNET to. If it's left blank, DDoS protection will not be configured. If it's provided, a DDoS protection plan will be provisioned within the same subscription.
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

| Output Name | Description |
| :-          | :-          |
| `ddosProtectionPlanResourceGroup` | The name of the Resource Group the DDoS Protection Plan was created in.
| `ddosProtectionPlanResourceId` | The Resource id of the DDoS Protection Plan deployed.
| `ddosProtectionPlanName` | The name of the DDoS Protection Plan deployed.

## Considerations

N/A

## Additional resources

- [Microsoft.Network ddosProtectionPlans template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2019-04-01/ddosprotectionplans)
- [Manage Azure DDoS Protection Standard using the Azure portal](https://docs.microsoft.com/en-us/azure/virtual-network/manage-ddos-protection)
- [Azure DDoS Protection Standard overview](https://docs.microsoft.com/en-us/azure/virtual-network/ddos-protection-overview)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)