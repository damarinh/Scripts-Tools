# LogAnalytics

This template deploys Log Analytics.

## Resources

- Microsoft.OperationalInsights/workspaces
- Microsoft.OperationalInsights/workspaces/savedSearches
- Microsoft.OperationalInsights/workspaces/datasources
- Microsoft.OperationalInsights/workspaces/storageinsightconfigs
- Microsoft.OperationalInsights/workspaces/providers/locks
- Microsoft.OperationsManagement/solutions

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `logAnalyticsWorkspaceName` | string | | | Required. Name of the Log Analytics workspace
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources.
| `serviceTier` | string | PerGB2018 | PerGB2018, Free, Standalone, PerNode | Optional. Service Tier: Free, Standalone, PerGB or PerNode
| `dataRetention` | int | 365 | | Optional. Number of days data will be retained for
| `automationAccountId` | string| `""` | | Optional. Automation Account resource identifier, value used to create a LinkedService between Log Analytics and an Automation Account
| `activityLogAdditionalSubscriptionIDs` | array | [] | | Optional. List of additional Subscription IDs to collect Activity logs from. The subscription holding the Log Analytics workspace is added by default. The user/SPN/managed identity has to have reader access on the subscription you'd like to collect Activity logs from.
| `diagnosticStorageAccountId` | string | "" | | Optional. Resource identifier of the Diagnostic Storage Account.
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
| `logAnalyticsWorkspaceResourceId` | The Resource Id of the Log Analytics workspace deployed.
| `logAnalyticsWorkspaceResourceGroup` | The Resource Group log analytics was deployed to.
| `logAnalyticsWorkspaceName` | The Name of the Log Analytics workspace deployed.
| `logAnalyticsWorkspaceId` | The Workspace Id for Log Analytics.
| `logAnalyticsPrimarySharedKey` | The Primary Shared Key for Log Analytics.

## Considerations

*N/A*

## Additional resources

- [Microsoft.OperationalInsights workspaces template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.operationalinsights/2015-11-01-preview/workspaces)
- [Microsoft.OperationalManagement solutions template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.operationsmanagement/2015-11-01-preview/solutions)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)