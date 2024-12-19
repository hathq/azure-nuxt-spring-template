param vaultName string
param location string

resource kv 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: vaultName
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
    accessPolicies: []
    enabledForDeployment: false
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: false
  }
}

output keyVaultUri string = kv.properties.vaultUri
