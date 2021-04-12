LIBNAME MYLIB '/folders/myfolders/lab 3/dataFiles';
DATA MYLIB.PECbusiness_unit;
INFILE '/folders/myfolders/lab 3/dataFiles/PECbusiness_unit.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover
lrecl = 32767;
format BUID $5.;
format NAME $30.; 
format ABBREV $20.;
INPUT BUID $ NAME $ ABBREV $;
RUN;

DATA MYLIB.PECbusiness_unit;
MODIFY MYLIB.PECbusiness_unit;

* Cleaning ABBREV;
ABBREV = TRIM(ABBREV);
IF MISSING(ABBREV) THEN ABBREV = 'Misc';
RUN;

PROC EXPORT data=MYLIB.PECbusiness_unit outfile='/folders/myfolders/lab 3/clean files/PECbusiness_unit_clean.txt' dbms=dlm replace;
delimiter= ",";
run;

