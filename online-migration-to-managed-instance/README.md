# Online migrate SQL server to SQL managed instance via Log Replay Service

## Architecture
![img](../docs/architecture/online-migration-to-managed-instance.png)

## Steps
```
CREATE CREDENTIAL [https://<myStorageAccount>.blob.core.windows.net] WITH IDENTITY = '<myStorageAccount>'  
 ,SECRET = '<my_primary_access_key>'; 
GO

BACKUP DATABASE [AdventureWorks2012]
TO URL = 'https://<myStorageAccount>.blob.core.windows.net/<myContainer>/AdventureWorks2012.bak'
WITH CREDENTIAL = 'https://<myStorageAccount>.blob.core.windows.net'
     ,COMPRESSION
     ,STATS = 5
     ,CHECKSUM;
GO
```