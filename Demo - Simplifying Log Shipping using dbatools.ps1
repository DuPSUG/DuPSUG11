Break

# 01 - Find all the commands related to log shipping
Find-DbaCommand -Pattern "logshipping"

# 02 - Get the amount of parameters for the Invoke-DbaLogShipping command
[object[]]$params = (Get-ChildItem function:\Invoke-DbaLogShipping).Parameters.Keys
$params.Count

# 03 - Get the help for the Invoke-DbaLogShipping command
Get-Help Invoke-DbaLogShipping -Detailed

# 04 - Get the databases for the primary instance
Get-DbaDatabase -SqlInstance SQLDB1, SQLDB3 | Select-Object SqlInstance, Name | Format-Table -AutoSize

# 05 - Start the Invoke-DbaLogShipping command
$result = Invoke-DbaLogShipping -SourceSqlInstance SQLDB1 `
    -DestinationSqlInstance SQLDB3 `
    -Database DB1 `
    -BackupNetworkPath \\sqldb1\logshipping\Backup `
    -BackupLocalPath D:\LogShipping\Backup `
    -CompressBackup `
    -GenerateFullBackup `
    -CopyDestinationFolder \\sqldb3\LogShipping\copy `
    -Force

# 06 - Start the Invoke-DbaLogShipping command with standby
$result = Invoke-DbaLogShipping -SourceSqlInstance SQLDB1 `
    -DestinationSqlInstance SQLDB3 `
    -Database DB2 `
    -BackupNetworkPath \\sqldb1\logshipping\Backup `
    -BackupLocalPath D:\LogShipping\Backup `
    -CompressBackup `
    -GenerateFullBackup `
    -CopyDestinationFolder \\sqldb3\LogShipping\copy `
    -Standby -StandbyDirectory \\sqldb3\LogShipping\standby `
    -Force

# 07 - Test the log shipping status
Test-DbaLogShippingStatus -SqlInstance SQLDB1 -Simple

# 08 - Test the log shipping status with different parameters
Test-DbaLogShippingStatus -SqlInstance SQLDB1 -Simple -Primary

Test-DbaLogShippingStatus -SqlInstance SQLDB1 -Simple -Secondary

Test-DbaLogShippingStatus -SqlInstance SQLDB1 -Simple -Database DB1_LS

# 09 - Lots of errors with log shipping
Get-DbaLogShippingError -SqlInstance SQLDB1

# 10 - Count the errors
(Get-DbaLogShippingError -SqlInstance SQLDB1).Count

# 11 - Restore database to normal state
Invoke-DbaLogShippingRecovery -SqlInstance SQLDB1 -Database DB3__LS

<# $result = Invoke-DbaLogShipping -SourceSqlInstance SQLDB1 `
    -DestinationSqlInstance SQLDB1 `
    -Database DB3 `
    -BackupNetworkPath \\sstad-pc\logshipping\backup `
    -BackupLocalPath C:\temp\logshipping\backup `
    -CompressBackup `
    -GenerateFullBackup `
    -CopyDestinationFolder \\sstad-pc\logshipping\copy `
    -SecondaryDatabaseSuffix "_LS" `
    -Force #>




