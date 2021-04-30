# RouteTables

This template deploys User Defined Route Tables.

## Resources

- Microsoft.Network/routeTables
- Microsoft.Network/routeTables/providers/locks

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `routeTableName` | string | | | Required. Name given for the Route Table.
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources.
| `routes` | array | [] | Complex structure, see below. | Optional. An Array of Routes to be established within the Route Table. **nextHopType**: The type of Azure hop the packet should be sent to. - VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance, None. **nextHopIpAddress**: The IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance.
| `disableBgpRoutePropagation` | bool | `false` | | Optional. Switch to disable BGP route propagation.
| `lockForDeletion` | bool | `true` | | Optional. Switch to lock Virtual Network Gateway from deletion.
| `tags` | object | {} | Complex structure, see below. | Optional. Tags of the Virtual Network Gateway resource.

### Parameter Usage: ``

The `routes` parameter accepts a JSON Array of Route objects to deploy to the Route Table.

Here's an example of specifying a few routes:

```json
"routes": {
  "value": [
    {
      "name": "tojumpboxes",
      "properties": {
        "addressPrefix": "172.16.0.48/28",
        "nextHopType": "VnetLocal"
      }
    },
    {
      "name": "tosharedservices",
      "properties": {
        "addressPrefix": "172.16.0.64/27",
        "nextHopType": "VnetLocal"
      }
    },
    {
      "name": "toonprem",
      "properties": {
        "addressPrefix": "10.0.0.0/8",
        "nextHopType": "VirtualNetworkGateway"
      }
    },
    {
      "name": "tonva",
      "properties": {
        "addressPrefix": "172.16.0.0/18",
        "nextHopType": "VirtualAppliance",
        "nextHopIpAddress": "172.16.0.20"
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
| `routeTableResourceGroup` | The name of the Resource Group the Route Table was deployed to.
| `routeTableName` | The name of the Route Table deployed.
| `routeTableResourceId` | The Resource id of the Virtual Network deployed.

## Considerations

*N/A*

## Additional resources

- [Microsoft.Network routeTables template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2019-09-01/routetables)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)
