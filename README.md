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

## Provision Azure resources
This section demonstrates how Azure resources can be created. Ensure that the requirements stated above are created and then:

1. Change to the [scripts](scripts) folder:

  ```bash
  cd scripts
  ```

2. Run the [provision.sh](provision.sh) script. 

  ```bash
  source ./provision.sh
  ```

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

## Web app deployment to Azure 




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
