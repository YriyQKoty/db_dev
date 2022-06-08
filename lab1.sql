drop database if exists  Afonin_308_1
EXEC master.sys.xp_delete_files
     '/var/opt/mssql/data/';
go
create database Afonin_308_1
go
USE Afonin_308_1
go
use master;
go
exec sp_detach_db @dbname = 'Afonin_308_1'
go
exec sp_attach_db @dbname = 'Afonin_308_1', @filename1 = '/var/opt/mssql/data/Afonin_308_1.mdf'
go
use Afonin_308_1
go
backup database Afonin_308_1 to disk = '/var/opt/mssql/data/Afonin_308_1.bak'
go
USE master;
DROP DATABASE Afonin_308_1;
RESTORE FILELISTONLY FROM DISK = '/var/opt/mssql/data/Afonin_308_1.bak';
RESTORE DATABASE Afonin_308_1
    FROM DISK = '/var/opt/mssql/data/Afonin_308_1.bak'
    WITH MOVE 'Afonin_308_1' TO '/var/opt/mssql/data/Afonin_308_1.mdf',
    MOVE 'Afonin_308_1_log' TO '/var/opt/mssql/dataAfonin_308_1_log.ldf'
go