# Article CMS Web Application deployed to Azure

In this project I built a Python article Content Management System (CMS) web application with Flask, a micro web framework written in Python. The user can log in and out and create/edit articles. An article consists of a title, author, and body of text stored in an Azure SQL Server along with an image that is stored in Azure Blob Storage. You will also implement OAuth2 with Sign in with Microsoft using the `msal` library, along with app logging.

## Application Demo
**TODO**: add a screen video of working application!

## Dependencies

1. An (free) Azure account
2. A GitHub account
3. Python 3.7 or later
4. Visual Studio 2019 Community Edition (Free)
5. The latest [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest) (helpful; not required - all actions can be done in the portal)

You will also need to install all Python dependencies that are stored in the [requirements.txt](requirements.txt) file. 

To install them, first open a terminal window and create & activate a virtual environment: 

```bash
python3 -m venv .venv
source .venv/bin/activate
```

Then install the dependencies from the [requirements.txt](requirements.txt) file:

```bash
pip install -r requirements.txt 
```

Alternatively, to install them using Visual Studio 2019 Community Edition:

1. In the Solution Explorer, expand "Python Environments"
2. Right click on "Python 3.7 (64-bit) (global default)" and select "Install from requirements.txt"

### To provision the project 
This section is optional and demonstrates how Azure resources can be created. Ensure that the requirements stated above are created and then:

1. Change to the scripts folder:

```bash
cd scripts
```

## Project instructions

### Creating an App Service

## Clean up resources
The resources you created in this projecet may incur ongoing costs. To clean up the resources, you need only delete the resource group that contains them:

```bash
# replace with your resource group
RESOURCE_GROUP="<YOUR-RESOURCE-GROUP>"
# run this command
az group delete --name $RESOURCE_GROUP
```
