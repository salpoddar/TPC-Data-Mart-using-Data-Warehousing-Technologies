* TPC_E business_unit cleaning;
LIBNAME MyLib '/folders/myfolders/Lab3';
DATA MyLib.TPCEbusiness_unit;
INFILE '/folders/myfolders/Lab3/business_unit.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover
lrecl = 32767;
format BUID $5.;
format NAME $50.; 
format ABBREV $20.;
INPUT BUID $ NAME $ ABBREV $;
RUN;

proc sort DATA = MyLib.TPCEbusiness_unit noduprecs;
by BUID;
RUN;

DATA MyLib.TPCEbusiness_unit;
MODIFY MyLib.TPCEbusiness_unit;

* Cleaning ABBREV;
ABBREV = TRIM(ABBREV);
IF MISSING(ABBREV) THEN ABBREV = 'Misc';
RUN;

PROC EXPORT data=MyLib.TPCbusiness_unit outfile='/folders/myfolders/Lab3/clean files/TPCEbusiness_unit_clean.csv' dbms=dlm replace;
delimiter=',';
run;