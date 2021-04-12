* TPC_E supplier cleaning;
LIBNAME MyLib '/folders/myfolders/Lab3';
DATA MyLib.TPCEsupplier;
INFILE '/folders/myfolders/Lab3/supplier.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover
lrecl = 32767;
FORMAT NAME $100.;
FORMAT ADDR1 $50.;
FORMAT ADDR2 $50.; 
FORMAT CITY $40.;
FORMAT STATE $10.;
INPUT SupplierID NAME $ ADDR1 $ ADDR2 $ CITY $ STATE $ ZIP;
RUN;

proc sort DATA = MyLib.TPCEsupplier noduprecs;
by SupplierID;
RUN;


DATA MyLib.TPCEsupplier;
MODIFY MyLib.TPCEsupplier;

* Trimming strings;
NAME = TRIM(NAME);
ADDR1 = TRIM(ADDR1);
ADDR2 = TRIM(ADDR2);
CITY = TRIM(CITY);
STATE = TRIM(STATE);
IF FINDW(NAME,'Inc') > 0 THEN NAME = TRANWRD(NAME,'Inc','Incorporated');
s='';
NAME = COMPRESS(NAME,".",s);
RUN;

PROC EXPORT data=MyLib.TPCEsupplier outfile='/folders/myfolders/Lab3/clean files/TPCEsupplier_clean.csv' dbms=dlm replace;
delimiter=',';
run;