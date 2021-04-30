# AzureSecurityCenter

This template enables Azure Security Center - Standard tier by default, could be overridden.

## Resources

- Microsoft.Security/autoProvisioningSettings
- Microsoft.Security/deviceSecurityGroups
- Microsoft.Security/iotSecuritySolutions
- Microsoft.Security/pricings
- Microsoft.Security/securityContacts
- Microsoft.Security/workspaceSettings

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `workspaceId` | string |  |  | Required. The full Azure ID of the workspace to save the data in. |
| `scope` | string |  |  | Required. All the VMs in this scope will send their security data to the mentioned workspace unless overridden by a setting with more specific scope. |
| `autoProvision` | string | `Off` | On/Off | Optional. Describes what kind of security agent provisioning action to take. - On or Off |
| `deviceSecurityGroupProperties` | object | `{}` | Complex structure, see below. | Optional. Device Security group data |
| `ioTSecuritySolutionProperties` | object | `{}` | Complex structure, see below. | Optional. Security Solution data |
| `virtualMachinesPricingTier` | string | `Standard` | Free/Standard | Optional. The pricing tier value for VMs. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard |
| `sqlServersPricingTier` | string | `Standard` | Free/Standard | Optional. The pricing tier value for SqlServers. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard |
| `appServicesPricingTier` | string | `Standard` | Free/Standard | Optional. The pricing tier value for AppServices. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard |
| `storageAccountsPricingTier` | string | `Standard` | Free/Standard | Optional. The pricing tier value for StorageAccounts. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard |
| `sqlServerVirtualMachinesPricingTier` | string | `Standard` | Free/Standard | Optional. The pricing tier value for SqlServerVirtualMachines. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard |
| `kubernetesServicePricingTier` | string | `Standard` | Free/Standard | Optional. The pricing tier value for KubernetesService. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard |
| `containerRegistryPricingTier` | string | `Standard` | Free/Standard | Optional. The pricing tier value for ContainerRegistry. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard |
| `securityContactProperties` | object | `{}` | Complex structure, see below. | Optional. Security contact data |

### Parameter Usage: `deviceSecurityGroupProperties`

```json
"deviceSecurityGroupProperties": {
    "value": {
        "thresholdRules": [
          {
            "isEnabled": "boolean",
            "ruleType": "string",
            "minThreshold": "integer",
            "maxThreshold": "integer"
          }
        ],
        "timeWindowRules": [
          {
            "isEnabled": "boolean",
            "ruleType": "string",
            "minThreshold": "integer",
            "maxThreshold": "integer",
            "timeWindowSize": "string"
          }
        ],
        "allowlistRules": [
          {
            "isEnabled": "boolean",
            "ruleType": "string",
            "allowlistValues": [
              "string"
            ]
          }
        ],
        "denylistRules": [
          {
            "isEnabled": "boolean",
            "ruleType": "string",
            "denylistValues": [
              "string"
            ]
          }
        ]
    }
}
```

### Parameter Usage: `ioTSecuritySolutionProperties`

```json
"ioTSecuritySolutionProperties": {
  "value": {
      "workspace": "string",
      "displayName": "string",
      "status": "string",
      "export": [
        "RawEvents"
      ],
      "disabledDataSources": [
        "TwinData"
      ],
      "iotHubs": [
        "string"
      ],
      "userDefinedResources": {
        "query": "string",
        "querySubscriptions": [
          "string"
        ]
      },
      "recommendationsConfiguration": [
        {
          "recommendationType": "string",
          "status": "string"
        }
      ]
    }
}
```

### Parameter Usage: `securityContactProperties`

```json
"securityContactProperties": {
  "value": {
      "email": "test@contoso.com",
      "phone": "+12345678",
      "alertNotifications": "On",
      "alertsToAdmins": "Off"
  }
}
```

## Outputs

No deployment outputs

## Additional resources

- [What is Azure Security Center?](https://docs.microsoft.com/en-us/azure/security-center/security-center-intro)
- [Microsoft.Security template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.security/allversions)