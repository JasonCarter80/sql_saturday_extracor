sql_saturday_extratcor
=====================

This utility was built to extract SQL Saturday XML data into a MSSQL Database for analysis.  

Credentials:
If credentials are not provided a trusted connection will be used.  

Range:
Specifics events can be specified by using the range function.
    1.    Default Range:   		1-100
	2.    Comma Seperated:   	2,10,25,100,125
	3.    Combination:     		2,10,25-50,125, 173
	
If the SQL Saturday event has not been assigned (ie #645) it will return an empty result set, instead of a HTTP 404.
Once the reader encounters  2 consecutive empty results files, it will stop requesting more, so the sky is the limit 
and it won't run away.


SQLSaturday Database Filler 1.0.0.0

  -s, --server       Required. Database Server

  -d, --database     Required. Name of Database

  -u, --u            Database User Name

  -p, --pasword      Database Password

  -r, --range        (Default: 1-10000) Provide a range of events to download

  -o, --operation    (Default: Drop) Operation to perform:
                     Drop - Drops all Objects and Recreates them, Importing Everything Fresh
                     Refresh - Refreshes Data wihtout Modifying

  --help             Display this help screen.

