* TPC_E invoice cleaning;
LIBNAME MyLib '/folders/myfolders/Lab3';
DATA MyLib.TPCEinvoice;
INFILE '/folders/myfolders/Lab3/invoice.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover
lrecl = 32767;
FORMAT SalesDate $10.;
INPUT InvoiceID CustID SalesDate $;
RUN;

proc sort DATA = MyLib.TPCEinvoice noduprecs;
by InvoiceID;
RUN;

DATA MyLib.TPCEinvoice;
MODIFY MyLib.TPCEinvoice;
SalesDate = TRIM(SalesDate);


SalesDate = TRANSLATE(SalesDate,'-','/');
day = SCAN(SalesDate,2,'-');
month = SCAN(SalesDate,1,'-');
year = SCAN(SalesDate,3,'-');
IF LENGTH(day)<2 THEN day = ("0"||day); 
IF LENGTH(month)<2 THEN month = ("0"||month); 
SalesDate = cats(year,"-",month,"-",day);

RUN;

PROC EXPORT data=MyLib.TPCEinvoice outfile='/folders/myfolders/Lab3/clean files/TPCEinvoice_clean.csv' dbms=dlm replace;
delimiter=',';
run;