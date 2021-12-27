import os

basedir = os.path.abspath(os.path.dirname(__file__))

class Config(object):
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'secret-key'
    
    # Storage account name
    BLOB_ACCOUNT = os.environ.get('BLOB_ACCOUNT') or 'blob8911'
    # Blob storage account access key
    BLOB_STORAGE_KEY = os.environ.get('BLOB_STORAGE_KEY') or 'Jb2vrxcCzq4RHXHKoC7eRyKqS0Nf/dqNNy77LNAsT27iVy6k+VgiqESSSgK2lqA3/9O9YxgIE5BD8CqodmMYcA=='
    # Container name within a blob storage
    BLOB_CONTAINER = os.environ.get('BLOB_CONTAINER') or 'images'
    
    # SQL server name: 'ENTER_SQL_SERVER_NAME.database.windows.net'
    SQL_SERVER = os.environ.get('SQL_SERVER') or 'sql-server-8911.database.windows.net'
    # SQL database name
    SQL_DATABASE = os.environ.get('SQL_DATABASE') or 'sql-database-8911'
    # User name for SQL server admin account
    SQL_USER_NAME = os.environ.get('SQL_USER_NAME') or 'databaseadmin'
    # Password for SQL server admin account (TODO: move to key-vault)
    SQL_PASSWORD = os.environ.get('SQL_PASSWORD') or 'p@ssword1234'
    # Below URI may need some adjustments for driver version, based on your OS, if running locally
    SQLALCHEMY_DATABASE_URI = 'mssql+pyodbc://' + SQL_USER_NAME + '@' + SQL_SERVER + ':' + SQL_PASSWORD + '@' + SQL_SERVER + ':1433/' + SQL_DATABASE  + '?driver=ODBC+Driver+17+for+SQL+Server'
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    ### Info for MS Authentication ###
    ### As adapted from: https://github.com/Azure-Samples/ms-identity-python-webapp ###
    CLIENT_SECRET = "ENTER_CLIENT_SECRET_HERE"
    # In your production app, Microsoft recommends you to use other ways to store your secret,
    # such as KeyVault, or environment variable as described in Flask's documentation here:
    # https://flask.palletsprojects.com/en/1.1.x/config/#configuring-from-environment-variables
    # CLIENT_SECRET = os.getenv("CLIENT_SECRET")
    # if not CLIENT_SECRET:
    #     raise ValueError("Need to define CLIENT_SECRET environment variable")

    AUTHORITY = "https://login.microsoftonline.com/common"  # For multi-tenant app, else put tenant name
    # AUTHORITY = "https://login.microsoftonline.com/Enter_the_Tenant_Name_Here"

    CLIENT_ID = "ENTER_CLIENT_ID_HERE"

    REDIRECT_PATH = "/getAToken"  # Used to form an absolute URL; must match to app's redirect_uri set in AAD

    # You can find the proper permission names from this document
    # https://docs.microsoft.com/en-us/graph/permissions-reference
    SCOPE = ["User.Read"] # Only need to read user profile for this app

    SESSION_TYPE = "filesystem"  # Token cache will be stored in server-side session
