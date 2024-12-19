param appName string
param location string
param planName string

resource app 'Microsoft.Web/sites@2024-04-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: resourceId('Microsoft.Web/serverfarms', planName)
    httpsOnly: true
  }
}

output appUrl string = 'https://${appName}.azurewebsites.net'
