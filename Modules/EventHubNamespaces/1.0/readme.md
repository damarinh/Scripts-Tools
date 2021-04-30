# EventHub Namespace

This module deploys EventHub Namespace

## Resources

The following Resources are deployed.

- Microsoft.EventHub/namespaces
- Microsoft.EventHub/namespaces/providers/diagnosticSettings
- Microsoft.EventHub/namespaces/providers/locks
- Microsoft.EventHub/namespaces/AuthorizationRules
- Microsoft.EventHub/namespaces/eventhubs
- Microsoft.EventHub/namespaces/eventhubs/consumergroups

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `namespaceName` | string | | | Required. The name of the EventHub namespace
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources.
| `skuName` | string | `Standard` | Basic, Standard | Optional. EventHub Plan sku name
| `skuCapacity` | int | 1 | 1-20 | Optional. EventHub Plan scale-out capacity of the resource
| `zoneRedundant` | bool | `false` | | Optional. Switch to make the Event Hub Namespace zone redundant.
| `isAutoInflateEnabled` | bool | `false` | | Optional. Switch to enable the Auto Inflate feature of Event Hub.
| `maximumThroughputUnits` | int | 1 | 0-20 | Optional. Upper limit of throughput units when AutoInflate is enabled, value should be within 0 to 20 throughput units.
| `partnerNamespaceId` | string | "" | | Optional. ARM Id of the Primary/Secondary eventhub namespace name, which is part of GEO DR pairing
| `namespaceAlias` | string | "" | | Optional. The Disaster Recovery configuration name
| `authorizationRules` | array | Complex structure, see below. | Complex structure, see below. | Optional. Authorization Rules for the Event Hub
| `vNetId` | string | "" | | Optional. Virtual Network Identifier used to create a service endpoint.
| `networkAcls` | object | {} | Complex structure, see below. | Optional. Network ACLs, this value contains IPs to whitelist and/or Subnet information.
| `diagnosticLogsRetentionInDays` | int | `365` | | Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.
| `diagnosticStorageAccountId` | string | "" | | Optional. Resource identifier of the Diagnostic Storage Account.
| `workspaceId` | string | "" | | Optional. Resource identifier of Log Analytics.
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

### Parameter Usage: `authorizationRules`

Default value:

```json
"authorizationRules": {
    "value": [
        {
            "name": "RootManageSharedAccessKey",
            "properties": {
                "rights": [
                    "Listen",
                    "Manage",
                    "Send"
                ]
            }
        }
    ]
}
```

### Parameter Usage: `networkAcls`

```json
"networkAcls": {
    "value": {
        "bypass": "AzureServices",
        "defaultAction": "Deny",
        "virtualNetworkRules": [
            {
                "subnet": "sharedsvcs"
            }
        ],
        "ipRules": []
    }
}
```

### Parameter Usage: `vNetId`

```json
"vNetId": {
    "value": "/subscriptions/00000000/resourceGroups/resourceGroup"
}
```

## Outputs

| Output Name | Description |
| :-          | :-          |
| `namespaceName` |  EventHub Namespace Name output parameter
| `namespaceResourceId` | EventHub Namespace ResourceId output parameter
| `namespaceResourceGroup` | EventHub Namespace ResourceGroup output parameter
| `namespaceConnectionString` | EventHub Namespace Connection String
| `sharedAccessPolicyPrimaryKey` | EventHub Namespace Shared Access Policy Primary Key

## Scripts

- There is no Scripts for this Module

## Considerations

- There is no deployment considerations for this Module

## Additional resources

- [Microsoft EventHub template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.eventhub/allversions)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)