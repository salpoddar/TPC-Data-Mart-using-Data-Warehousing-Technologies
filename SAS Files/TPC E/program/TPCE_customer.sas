* TPC_E customer cleaning;
LIBNAME MyLib '/folders/myfolders/Lab3';
DATA MyLib.TPCEcustomer;
INFILE '/folders/myfolders/Lab3/customer.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover
lrecl = 32767;
FORMAT NAME $100.;
FORMAT ADDR1 $50.;
FORMAT ADDR2 $50.; 
FORMAT CITY $30.;
FORMAT STATE $20.;
FORMAT ZIP $5.;
FORMAT CustTypeID $10.;
INPUT CustID NAME $ ADDR1 $ ADDR2 $ CITY $ STATE $ ZIP $ CustTypeID $;
RUN;

proc sort DATA = MyLib.TPCEcustomer noduprecs;
by CustID;
RUN;

DATA MyLib.TPCEcustomer;
MODIFY MyLib.TPCEcustomer;

* Trimming strings;
NAME = TRIM(NAME);
ADDR1 = TRIM(ADDR1);
ADDR2 = TRIM(ADDR2);
CITY = TRIM(CITY);
STATE = TRIM(STATE);
ZIP = TRIM(ZIP);
CustTypeID = TRIM(CustTypeID);

* Handling Missing Values;

IF MISSING(ADDR1) THEN ADDR1 = 'Suite 999';
IF Length(ZIP) = 3 THEN ZIP = "00" || ZIP;
IF Length(ZIP) = 4 THEN ZIP = "0" || ZIP;
IF FINDW(NAME,'Inc') > 0 THEN NAME = TRANWRD(NAME,'Inc','Incorporated');
IF FINDW(NAME,'Co') > 0 THEN NAME = TRANWRD(NAME,'Co','Company');
IF FINDW(NAME,'Corp')> 0 THEN NAME = TRANWRD(NAME,'Corp','Corporation');
s='';
NAME = COMPRESS(NAME,".",s);
NAME = COMPRESS(NAME,"-",s);
RUN;

PROC EXPORT data=MyLib.TPCEcustomer outfile='/folders/myfolders/Lab3/clean files/TPCEcustomer_clean.csv' dbms=dlm replace;
delimiter=',';
RUN;