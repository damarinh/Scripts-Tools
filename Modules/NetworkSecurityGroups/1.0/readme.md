# NetworkSecurityGroups

This template deploys a Network Security Groups (NSG) with optional security rules.

## Resources

- Microsoft.Network/networkSecurityGroups

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `networkSecurityGroupName` | | Required. Name of the Network Security Group.
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources.
| `networkSecurityGroupSecurityRules` | array | {} | Complex structure, see below. | Required. Array of Security Rules to deploy to the Network Security Group.
| `diagnosticLogsRetentionInDays` | int | `365` | | Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.
| `diagnosticStorageAccountId` | string | "" | | Optional. Resource identifier of the Diagnostic Storage Account.
| `workspaceId` | string | "" | | Optional. Resource identifier of Log Analytics.
| `eventHubAuthorizationRuleId` | string | "" | | Optional. Resource ID of the event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.
| `eventHubName` | string | "" | | Optional. Name of the event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.
| `lockForDeletion` | bool | `true` | | Optional. Switch to lock Virtual Network Gateway from deletion.
| `tags` | object | {} | Complex structure, see below. | Optional. Tags of the Virtual Network Gateway resource.

### Parameter Usage: `networkSecurityGroupSecurityRules`

The `networkSecurityGroupSecurityRules` parameter accepts a JSON Array of `securityRule` to deploy to the Network Security Group (NSG).

Here's an example of specifying a couple security rules:

```json
    "networkSecurityGroupSecurityRules": {
      "value": [
        {
          "name": "Port_8080",
          "properties": {
              "description": "Allow inbound access on TCP 8080",
              "protocol": "*",
              "sourcePortRange": "*",
              "destinationPortRange": "8080",
              "sourceAddressPrefix": "*",
              "destinationAddressPrefix": null,
              "access": "Allow",
              "priority": 100,
              "direction": "Inbound",
              "sourcePortRanges": [],
              "destinationPortRanges": [],
              "sourceAddressPrefixes": [],
              "destinationAddressPrefixes": [],
              "destinationApplicationSecurityGroups": [
                  {
                    "name": "test-asg"
                  }
              ],
              "sourceApplicationSecurityGroups": []
          }
        },
        {
            "name": "Port_RDP",
            "properties": {
                "description": "Allow inbound access on TCP 3389",
                "protocol": "TCP",
                "sourcePortRange": "*",
                "destinationPortRange": "3389",
                "sourceAddressPrefix": "*",
                "destinationAddressPrefix": "*",
                "access": "Allow",
                "priority": 110,
                "direction": "Inbound",
                "sourcePortRanges": [],
                "destinationPortRanges": [],
                "sourceAddressPrefixes": [],
                "destinationAddressPrefixes": [],
                "destinationApplicationSecurityGroups": [],
                "sourceApplicationSecurityGroups": []
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
| :- | :- |
| `networkSecurityGroupResourceGroup` | The name of the Resource Group the Network Security Groups were created in.
| `networkSecurityGroupResourceId` | The Resource Ids of the Network Security Group deployed.
| `networkSecurityGroupName` | The Name of the Network Security Group deployed.

## Considerations

When specifying the Security Rules for the Network Security Group (NSG) with the `networkSecurityGroupSecurityRules` parameter, pass in the Security Rules as a JSON Array in the same format as would be used for the `securityRules` property of the `Microsoft.Network/networkSecurityGroups` resource provider in an ARM Template.

## Additional resources

- [Azure Network Security Groups](https://docs.microsoft.com/en-us/azure/virtual-network/security-overview)
- [Microsoft.Network networkSecurityGroups template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2018-11-01/networksecuritygroups)
- [Microsoft.Network networkSecurityGroups/securityRules template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2018-11-01/networksecuritygroups/securityrules)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)