param planName string
param location string
param sku string

resource plan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: planName
  location: location
  sku: {
    name: sku
    capacity: 1
  }
  properties: {
    reserved: false
  }
}

output planId string = plan.id
