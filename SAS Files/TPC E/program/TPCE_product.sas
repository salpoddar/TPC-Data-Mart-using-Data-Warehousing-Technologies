* TPC_E product cleaning;
LIBNAME MyLib '/folders/myfolders/Lab3';
DATA MyLib.TPCEproduct;
INFILE '/folders/myfolders/Lab3/product.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover
lrecl = 32767;
FORMAT DESC $100.;
INPUT ProdID DESC $ Price1 Price2 ProdTypeID UnitCost SupplierID;
RUN;

proc sort DATA = MyLib.TPCEproduct noduprecs;
by PRODID;
RUN;

DATA MyLib.TPCEproduct;
MODIFY MyLib.TPCEproduct;

* Trimming strings;
DESC = TRIM(DESC);
IF FINDW(DESC,'Equip') > 0 THEN DESC = TRANWRD(DESC,'Equip','Equipment');
RUN;

PROC EXPORT data=MyLib.TPCEproduct outfile='/folders/myfolders/Lab3/clean files/TPCEproduct_clean.csv' dbms=dlm replace;
delimiter=',';
run;