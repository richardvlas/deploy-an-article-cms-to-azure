# Azure CLI script to provision the Azure resources needed for the project.

# Be sure to run this script with source ./provision.sh 
# to set environment variables in the current session. By doing so, you have 
# those variables in place if you want to run test file test.sh (not included) 
# or repeat other commands.

# Sign in to Azure

echo "Running az login; a browser window will open"

az login

# Set an Azure location to use: note that not all services are available in
# all regions.

export AZURE_LOCATION=westus2

# Setup: Create environment variables to use as resource/service names

# First, the resource group, which need be unique only within your
# subscription.

export RESOURCE_GROUP_NAME=cms-resource-group

# Names that must be unique across Azure and thus use the postfix.

# Many resource names must be unique across Azure. To ensure uniqueness,
# set the POSTFIX environment variable to something like your name or
# company name, whatever value is likely to be unique. 
# This script by default uses a random number.

export POSTFIX=$RANDOM

# Set sql server name
export SQL_SERVER_NAME=sql-server-$POSTFIX

# Sql server user/admin name and password 
# This should be placed in a key-vault instead
export SQL_USER_NAME=databaseadmin
export SQL_PASSWORD=p@ssword1234

# Set sql database name
export SQL_DATABASE=sql-database-$POSTFIX

# Get your public IP address to be used when configuring firewall rules 
# down below
export CLIENT_IP=$(curl ifconfig.me)

# Set the name of the storage account (above the container level)
export BLOB_ACCOUNT=blob$POSTFIX

# Set the name of the container level for images to be stored
export BLOB_CONTAINER=images

# We're now ready to provision resources.

# Part 1: Provision a containing resource group (1) for all the other
# resources. When you're done using this project, you can just delete
# the resource group to delete all the resources within it to avoid
# incurring any ongoing charges.

echo "Provisioning resource group $RESOURCE_GROUP_NAME"

az group create \
    --name $RESOURCE_GROUP_NAME \
    --location $AZURE_LOCATION

# Create an SQL Server in Azure

echo "Creating an SQL Server $SQL_SERVER_NAME"

az sql server create \
    --resource-group $RESOURCE_GROUP_NAME \
    --location $AZURE_LOCATION \
    --name $SQL_SERVER_NAME \
    --admin-user $SQL_USER_NAME \
    --admin-password $SQL_PASSWORD\
    --enable-public-network true \
    --verbose

# Create firewall rules
# First one to allow Allow Azure services and resources to access the server

echo "Creating firewall rules"

az sql server firewall-rule create \
    --resource-group $RESOURCE_GROUP_NAME \
    --server $SQL_SERVER_NAME \
    --name azureaccess \
    --start-ip-address 0.0.0.0 \
    --end-ip-address 0.0.0.0 \
    --verbose

# The second rule is to set your computer's public Ip address to the server's 
# firewall.

az sql server firewall-rule create \
    --resource-group $RESOURCE_GROUP_NAME \
    --server $SQL_SERVER_NAME \
    --name clientip \
    --start-ip-address $CLIENT_IP \
    --end-ip-address $CLIENT_IP \
    --verbose

# Create an SQL Database in Azure

echo "Creating an SQL database $SQL_DB_NAME"

az sql db create \
    --name $SQL_DATABASE \
    --resource-group $RESOURCE_GROUP_NAME \
    --server $SQL_SERVER_NAME \
    --tier Basic \
    --verbose

# Create a Storage Account in Azure

echo "Creating a storage account in Azure"

az storage account create \
    --name $BLOB_ACCOUNT \
    --resource-group $RESOURCE_GROUP_NAME \
    --location $AZURE_LOCATION

# Create a Storage Container in Azure for images to be stored in a container

echo "Creating a storage container in Azure for images to be stored"

az storage container create \
    --account-name $BLOB_ACCOUNT \
    --name $BLOB_CONTAINER \
    --auth-mode login \
    --public-access container
