# This IaC script provisions a VM within Azure
#
[CmdletBinding()]
param(
    [Parameter(Mandatory = $True)]
    [string]
    $servicePrincipal,

    [Parameter(Mandatory = $True)]
    [string]
    $servicePrincipalSecret,

    [Parameter(Mandatory = $True)]
    [string]
    $servicePrincipalTenantId,

    [Parameter(Mandatory = $True)]
    [string]
    $azureSubscriptionName,

    [Parameter(Mandatory = $True)]
    [string]
    $resourceGroupName,

    [Parameter(Mandatory = $True)]
    [string]
    $resourceGroupNameRegion,

    [Parameter(Mandatory = $True)]  
    [string]
    $serverName,

    [Parameter(Mandatory = $True)]  
    [string]
    $adminLogin,

    [Parameter(Mandatory = $True)]  
    [String]
    $adminPassword,

    [Parameter(Mandatory = $True)]  
    [String]
    $SERVER_USER
)


#region Login
# This logs into Azure with a Service Principal Account
#
Write-Output "Logging in to Azure with a service principal..."
az login `
    --service-principal `
    --username $servicePrincipal `
    --password $servicePrincipalSecret `
    --tenant $servicePrincipalTenantId
Write-Output "Done"
Write-Output ""
#endregion

#region Subscription
#This sets the subscription the resources will be created in

Write-Output "Setting default azure subscription..."
az account set `
    --subscription $azureSubscriptionName
Write-Output "Done"
Write-Output ""
#endregion

# #region Create Resource Group
# # This creates the resource group used to house the VM
# Write-Output "Creating resource group $resourceGroupName in region $resourceGroupNameRegion..."
# az group create `
#     --name $resourceGroupName `
#     --location $resourceGroupNameRegion
#     Write-Output "Done creating resource group"
#     Write-Output ""
#  #endregion

#region Delete VM
# Delete a VM in the resource group
Write-Output "Deleting VM..."
try {
    az vm delete  `
        --resource-group $resourceGroupName `
        --name $serverName `
        --yes
    }
catch {
    Write-Output "VM deletion failed"
    }
Write-Output "Done Deleting VM"
Write-Output ""
#endregion