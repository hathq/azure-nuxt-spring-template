param acrName string
param location string
param sku string

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: acrName
  location: location
  sku: {
    name: sku
  }
  properties: {
    adminUserEnabled: false
  }
}

output acrId string = acr.id
output acrLoginServer string = acr.properties.loginServer
