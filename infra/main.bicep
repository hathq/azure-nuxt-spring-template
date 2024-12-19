param environment string
param location string
param resourcePrefix string
param appServiceSku string

var rgName = '${resourcePrefix}-rg-${environment}'
var acrName = '${resourcePrefix}acr${environment}'
var kvName = '${resourcePrefix}-kv-${environment}'
var aiName = '${resourcePrefix}-ai-${environment}'
var appConfigName = '${resourcePrefix}-appconfig-${environment}'
var cosmosName = '${resourcePrefix}-cosmos-${environment}'
var planName = '${resourcePrefix}-plan-${environment}'
var frontendAppName = '${resourcePrefix}-frontend-${environment}'
var backendAppName = '${resourcePrefix}-backend-${environment}'

module rg 'modules/resourceGroup.bicep' = {
  name: 'rgDeployment'
  params: {
    rgName: rgName
    location: location
  }
  scope: subscription()
}

module acr 'modules/acr.bicep' = {
  name: 'acrDeployment'
  dependsOn: [rg]
  params: {
    acrName: acrName
    location: location
    sku: 'Basic'
  }
}

module kv 'modules/keyVault.bicep' = {
  name: 'kvDeployment'
  dependsOn: [rg]
  params: {
    vaultName: kvName
    location: location
  }
}

module ai 'modules/applicationInsights.bicep' = {
  name: 'aiDeployment'
  dependsOn: [rg]
  params: {
    aiName: aiName
    location: location
  }
}

module appConfig 'modules/appConfig.bicep' = {
  name: 'appConfigDeployment'
  dependsOn: [rg]
  params: {
    appConfigName: appConfigName
    location: location
  }
}

module cosmos 'modules/cosmosdb.bicep' = {
  name: 'cosmosDeployment'
  dependsOn: [rg]
  params: {
    cosmosName: cosmosName
    location: location
  }
}

module plan 'modules/appServicePlan.bicep' = {
  name: 'planDeployment'
  dependsOn: [rg]
  params: {
    planName: planName
    location: location
    sku: appServiceSku
  }
}

module frontendApp 'modules/appService.bicep' = {
  name: 'frontendAppDeployment'
  dependsOn: [rg, plan]
  params: {
    appName: frontendAppName
    location: location
    planName: planName
  }
}

module backendApp 'modules/appService.bicep' = {
  name: 'backendAppDeployment'
  dependsOn: [rg, plan]
  params: {
    appName: backendAppName
    location: location
    planName: planName
  }
}

output resourceGroupName string = rgName
output frontendAppName string = frontendAppName
output backendAppName string = backendAppName
output acrLoginServer string = '${acrName}.azurecr.io'
