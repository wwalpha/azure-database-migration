# Azure Database Migration

## Migration Scenarios
- discovery using azure migration (assessment)
- offline migration using backup/restore
- online migration using ADS(Azure Data Studio)
- online migration using ADS(Azure Data Studio) and LRS(Log Replay Service)

![img](./docs/migration_scenarios.png)

## Offline migration
![img](./docs/offline_to_azurevm.png)

## Online migration
![img](./docs/online_migration_to_managed_instance.png)

## AdventureWorks sample databases
https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms

## Enable TLS 1.2 for windows 2012 or before
You can automatic configure windows with registry file ([here](./materials/enable_tls_1.2.reg)), then restart os.

### Documents
- [How to enable TLS 1.2 on clients](https://learn.microsoft.com/ja-jp/mem/configmgr/core/plan-design/security/enable-tls-1-2-client)
- [Configuring schannel protocols](https://learn.microsoft.com/ja-jp/dotnet/framework/network-programming/tls#configuring-schannel-protocols-in-the-windows-registry)
- [Update to enable TLS 1.1 and TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/en-us/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392)