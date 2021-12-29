# Azure CLI script to deploy the flask web app from a directory to Azure App Service.
# Be sure to run this script with source ./deployment.sh 

echo "Provisioning Azure App Service and deploying the flask web app"

az webapp up \
    --name webapp$POSTFIX \
    --resource-group $RESOURCE_GROUP_NAME \
    --location $AZURE_LOCATION \
    --sku F1 \
    --verbose
