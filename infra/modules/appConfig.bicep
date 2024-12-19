param appConfigName string
param location string

resource appConfig 'Microsoft.AppConfiguration/configurationStores@2024-05-01' = {
  name: appConfigName
  location: location
  sku: {
    name: 'Standard'
  }
}

output appConfigEndpoint string = appConfig.properties.endpoint
