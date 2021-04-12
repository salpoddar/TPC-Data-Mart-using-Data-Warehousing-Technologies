* TPC_E invoice_details cleaning;
LIBNAME MyLib '/folders/myfolders/Lab3';
DATA MyLib.TPCEinvoice_details;
INFILE '/folders/myfolders/Lab3/invoice_details.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover
lrecl = 32767;
INPUT InvoiceID ProdID AMT QTY DISCOUNTED;
RUN;

proc sort DATA = MyLib.TPCEinvoice_details noduprecs;
by InvoiceID;
RUN;

PROC EXPORT data=MyLib.TPCEinvoice_details outfile='/folders/myfolders/Lab3/clean files/TPCEinvoice_details_clean.csv' dbms=dlm replace;
delimiter=',';
run;