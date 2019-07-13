SELECT suser_sname(owner_sid) AS 'Owner', state_desc, *
FROM sys.databases

ALTER AUTHORIZATION ON DATABASE::AdventureWorks2017 TO [KemalPC\kemal]