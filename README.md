# Article CMS Web Application deployed to Azure

In this project I built a Python article Content Management System (CMS) web application with Flask, a micro web framework written in Python. The user can log in and out and create/edit articles. An article consists of a title, author, and body of text stored in an Azure SQL Server along with an image that is stored in Azure Blob Storage. You will also implement OAuth2 with Sign in with Microsoft using the `msal` library, along with app logging.

## Application Demo
**TODO**: add a screen video of working application!

## Creating an App Service


## Dependencies

1. A free Azure account
2. A GitHub account
3. Python 3.7 or later
4. Visual Studio 2019 Community Edition (Free)
5. The latest Azure CLI (helpful; not required - all actions can be done in the portal)

All Python dependencies are stored in the [requirements.txt](requirements.txt) file. To install them, using on the command line, simply type:

```
pip install -r requirements.txt 
```

Alternatively, to install them using Visual Studio 2019 Community Edition:

1. In the Solution Explorer, expand "Python Environments"
2. Right click on "Python 3.7 (64-bit) (global default)" and select "Install from requirements.txt"
