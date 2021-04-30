# EventHub Namespace

This module deploys EventHub. 

## Resources

The following Resources are deployed.

- Microsoft.EventHub/namespaces/eventhubs
- Microsoft.EventHub/namespaces/eventhubs/consumergroups
- Microsoft.EventHub/namespaces/eventhubs/AuthorizationRules

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `namespaceName` | string | | | Required | The name of the EventHub namespace
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources.
| `eventHubName` | string | | | Required. The name of the EventHub
| `authorizationRules` | array | Complex structure, see below. | Complex structure, see below. | Optional. Authorization Rules for the Event Hub
| `eventHubConfiguration` | object | Complex structure, see below. | Complex structure, see below. | Optional. Object to configure all properties of an Event Hub instance
| `lockForDeletion` | bool | `true` | | Optional. Switch to lock Event Hub from deletion.

### Parameter Usage: `eventHubConfiguration`

Default value:

```json
"eventHubConfiguration": {
    "value": {
        "properties": {
            "messageRetentionInDays": 1,
            "partitionCount": 2,
            "status": "Active",
            "captureDescription": {
                "enabled": false,
                "encoding": "Avro",
                "intervalInSeconds": 300,
                "sizeLimitInBytes": 314572800,
                "destination": {
                    "name": "EventHubArchive.AzureBlockBlob",
                    "properties": {
                        "storageAccountResourceId": "",
                        "blobContainer": "eventhub",
                        "archiveNameFormat": "{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}"
                    }
                },
                "skipEmptyArchives": true
            }
        },
        "consumerGroups": [
            {
                "name": "$Default"
            }
        ]
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

Example for 2 authorization rules:

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
        },
        {
            "name": "AnotherKey",
            "properties": {
                "rights": [
                    "Listen",
                    "Send"
                ]
            }
        }
    ]
}
```

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
| `namespaceName` |  EventHub Namespace Name output parameter
| `eventHubId` | The Resource Id of the EventHub Namespace
| `namespaceResourceGroup` | EventHub Namespace ResourceGroup output parameter
| `authRuleResourceId` | The Id of the authorization rule marked by the variable with the same name.
| `namespaceConnectionString` | EventHub Namespace Connection String
| `sharedAccessPolicyPrimaryKey` | EventHub Namespace Shared Access Policy Primary Key

## Scripts

- There is no Scripts for this Module

## Considerations

- There is no deployment considerations for this Module

## Additional resources

- [Microsoft EventHub template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.eventhub/allversions)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)