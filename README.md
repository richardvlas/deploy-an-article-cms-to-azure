# Article CMS Web Application deployed to Azure

In this project I built a Python article Content Management System (CMS) web application with Flask, a micro web framework written in Python. The user can log in and out and create/edit articles. An article consists of a title, author, and body of text stored in an Azure SQL Server along with an image that is stored in Azure Blob Storage. I also implemented OAuth2 with Sign in with Microsoft using the `msal` library, along with app logging.

## Azure Virtual Machines vs. App Service
I have choosen App Service as the deployment option in Azure and in this section I describe and compare both options from the costs, scalability, availability, and workflow perspectives.

||Virtual Machines|App Service|
|--|----------------|-----------|
|Costs|Lower up-front cost compared to purchasing and maintaining on premise hardware but they are more expensive compared to App Service.|You can set the amount of hardware allocated to host your application, and the cost varies based on the plan you choose. There are three different tiers - Dev/Test, Production, and Isolated. Compared to VMs App services a more cost-effective solution.|
|Scalability|Multiple VMs can be grouped to provide high availability, scalability, and redundancy. There are two options when it comes to scaling — Virtual Machine Scale Sets and Load Balancers.|Vertical or Horizontal scaling. Vertical scaling increases or decreases resources allocated to our App Service, such as the amount of vCPUs or RAM, by changing the App Service pricing tier. Horizontal scaling increases or decreases the number of Virtual Machine instances our App Service is running.|
|Access|VMs allow full access and control of the VM, that includes control over the underlying operating system and software you install on the VM. Azure supports both Linux and windows VMs.|fsdffaaaa|
|Availability|fsdsfd|fsdffaaaa|
|Workflow|VMs can be more time consuming for the developer to configure and set up than other compute options|fsdffaaaa|

The web app that has been developed in this project is a simple CMS system that doesn't require high computing performance and it only utilizes a relational database, a blob storage and consists of a few webpages where no complex calculations are performed as it would be the case in a web app that utilizes a Machine Learning algorithm for training and predictions. Therefore it is sufficient to use App Service as the deployment option.


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

## Provision Azure resources
This section demonstrates how Azure resources can be created. Ensure that the requirements stated above are created and then:

1. Change to the [scripts](scripts) folder:

  ```bash
  cd scripts
  ```

2. Run the [provision.sh](scripts/provision.sh) script. 

  ```bash
  source ./provision.sh
  ```
  
By running the shell script, a new storage account was created in Azure as well as a new container `images` for images to be stored in that container.
This was accomplished by runing the following Azure CLI commands:

**Create a Storage Account in Azure**
```bash
az storage account create \
    --name $BLOB_ACCOUNT \
    --resource-group $RESOURCE_GROUP_NAME \
    --location $AZURE_LOCATION
```

**Create a Storage Container in Azure**
```bash
az storage container create \
    --account-name $BLOB_ACCOUNT \
    --name $BLOB_CONTAINER \
    --auth-mode login \
    --public-access container
```

**Environmental variables**

The environmental variables were set in the shell script as follows:

```bash
export RESOURCE_GROUP_NAME=cms-resource-group
export AZURE_LOCATION=westus2

export POSTFIX=$RANDOM
export BLOB_ACCOUNT=blob$POSTFIX
export BLOB_CONTAINER=images
```

For more details please refer to the [provision.sh](scripts/provision.sh) script.

## Populate Azure SQL database
Once the resources are provisioned, populate the new SQL database with tables (a user table and an article table) by running the scripts provided in the [sql_scripts](sql_scripts) folder in the Query Editor on Azure portal shown below  

  **User table**
  ```sql
  CREATE TABLE USERS (
      id INT NOT NULL IDENTITY(1, 1),
      username VARCHAR(64) NOT NULL,
      password_hash VARCHAR(128) NOT NULL,
      PRIMARY KEY (id)
  );

  INSERT INTO dbo.users (username, password_hash)
  VALUES ('admin', 'pbkdf2:sha256:150000$QlIrz6Hg$5f4cd25d78a6c79906a53f74ef5d3bb2609af2b39d9e5dd6f3beabd8c854dd60')
  ```

  **Article table**
  ```sql
  CREATE TABLE POSTS(
      id INT NOT NULL IDENTITY(1, 1),
      title VARCHAR(150) NOT NULL,
      author VARCHAR(75) NOT NULL,
    body VARCHAR(800) NOT NULL,
    image_path VARCHAR(100) NULL,
    timestamp DATETIME NOT NULL DEFAULT(GETDATE()),
    user_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id)
  );

  INSERT INTO dbo.posts (title, author, body, user_id)
  VALUES (
      'Lorem ipsum dolor sit amet',
      'John Smith',
      'Proin sit amet mi ornare, ultrices augue quis, facilisis tellus. Quisque neque dui, tincidunt sed volutpat quis, maximus sed est. Sed justo orci, rhoncus ac nulla eu, rhoncus luctus justo. Etiam maximus, felis eu varius fermentum, libero orci egestas purus, id condimentum mauris orci nec nibh. Vivamus risus ipsum, semper vel nibh in, suscipit commodo massa. Suspendisse non velit vitae neque condimentum viverra vel eget enim. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vivamus fermentum sagittis ligula et fringilla. Aenean nec lacinia lacus.',
      1
  );
  ```

## Web app login

### Log In Credentials for FlaskWebProject 

- Username: admin
- Password: pass

### Sign In With Microsoft button functionality

The functionality to sign in the Sign In With Microsoft button is added. The button will automatically log into the admin account. This required to add the functionality in the [views.py](FlaskWebProject/views.py) file by using the `msal` library, along with appropriate registration in Azure Active Directory.

## Web app deployment to Azure 

After the Azure resources are provisioned and the SQL database is populated with tables and data, the app implemented in this repository can be deployed to Azure App service. 

Ensure that you are located in `deploy-an-article-cms-to-azure` folder (root folder on this project) and run the [deployment.sh](scripts/deployment.sh) script. 

  ```bash
  source ./deployment.sh
  ```
  
By running the shell script, a new App service is created and deployment of the code in the local folder is performed.

## example_images Folder

This folder contains sample screenshots that are showing the various tasks throughout the project.

1. [article-cms-solution.png](example_images/article-cms-solution.png) is a screenshot from running the FlaskWebProject on Azure to demonstrate that one is able to create a new entry. The Title, Author, and Body fields are populated to prove that the data is being retrieved from the Azure SQL Database while the image on the right proves that an image was uploaded and pulled from Azure Blob Storage.
2. [azure-portal-resource-group.png](example_images/azure-portal-resource-group.png) is a screenshot from the Azure Portal showing all of the contents of the Resource Group the are created during provisioning and deployment. The resource group contain the following:
	- Storage Account
	- SQL Server
	- SQL Database
	- Resources related to deploying the app
3. [sql-storage-solution.png](example_images/sql-storage-solution.png) is a screenshot showing the created tables and one query of data from (at least) the initial scripts.
4. [blob-solution.png](example_images/blob-solution.png) is a screenshot showing an example of blob endpoints for where images are sent for storage.
5. [uri-redirects-solution.png](example_images/uri-redirects-solution.png) is a screenshot of the redirect URIs related to Microsoft authentication.
6. [log-solution.png](example_images/log-solution.png) is a screenshot showing one potential form of logging with an "Invalid login attempt" and "admin logged in successfully", taken from the app's Log stream. 

## Clean up resources
The resources you created in this projecet may incur ongoing costs. To clean up the resources, you need only delete the resource group that contains them:

```bash
# replace with your resource group
RESOURCE_GROUP="<YOUR-RESOURCE-GROUP>"
# run this command
az group delete --name $RESOURCE_GROUP
```

## Troubleshooting

- Mac users may need to install `unixodbc` as well as related drivers as shown below:
    ```bash
    brew install unixodbc
    ```
- Check [here](https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/install-microsoft-odbc-driver-sql-server-macos?view=sql-server-ver15) to add SQL Server drivers for Mac.
