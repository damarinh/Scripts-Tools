# vNet

This template deploys Network Watcher.

## Resources

- Microsoft.Network/networkWatchers

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `networkWatcherName` | string | | Required. Name of the Network Watcher resource (hidden)
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources.

## Outputs

| Output Name | Description |
| :-          | :-          |
| `networkWatcherResourceGroup` | The name of the Resource Group the Network Watcher was created in.
| `networkWatcherResourceId` | The Resource id of the Network Watcher deployed.
| `networkWatcherName` | The name of the Network Watcher deployed.

## Considerations

N/A

## Additional resources

- [Microsoft.Network networkWatchers template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2019-04-01/networkwatchers)
- [What is Azure Network Watcher?](https://docs.microsoft.com/en-us/azure/network-watcher/network-watcher-monitoring-overview)
