# Azure CLI script to provision the Azure resources needed for
# the project. The resources are numbered in parenthases.

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

# Many resource names must be unique across Azure. To ensure uniqueness,
# set the PREFIX environment variable to something like your name or
# company name, whatever value is likely to be unique. This script by 
# default uses a random number.

# ??

# We're now ready to provision resources.

# Part 1: Provision a containing resource group (1) for all the other
# resources. When you're done using this project, you can just delete
# the resource group to delete all the resources within it to avoid
# incurring any ongoing charges.

echo "Provisioning resource group $RESOURCE_GROUP_NAME"

az group create \
    --name=$RESOURCE_GROUP_NAME \
    --location=$AZURE_LOCATION

