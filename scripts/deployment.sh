# Azure CLI script to deploy the flask web app from a directory to Azure App Service.
# Be sure to run this script with source ./deployment.sh 

# Names that must be unique across Azure and thus use the postfix.

# Many resource names must be unique across Azure. To ensure uniqueness,
# set the POSTFIX environment variable to something like your name or
# company name, whatever value is likely to be unique. 
# This script by default uses a random number.

export POSTFIX=$RANDOM

echo "Provisioning Azure App Service and deploying the flask web app"

cd ..

az webapp up \
    --name webapp$POSTFIX \
    --resource-group $RESOURCE_GROUP_NAME \
    --location $AZURE_LOCATION \
    --sku F1 \
    --verbose
