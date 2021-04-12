LIBNAME MyLib '/folders/myfolders/Lab3';
DATA MyLib.TPCEproduct_type;
INFILE '/folders/myfolders/Lab3/prod_type.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover
lrecl = 32767;
FORMAT TypeDescription $50.;
FORMAT BUID	$2.; 

INPUT ProdType TypeDescription $ BUID $;
RUN;

proc sort DATA = MyLib.TPCEproduct_type noduprecs;
by ProdType;
RUN;

DATA MyLib.TPCEproduct_type;
MODIFY MyLib.TPCEproduct_type;

* Trimming strings;
TypeDescription = TRIM(TypeDescription);
BUID = TRIM(BUID);
IF FINDW(TypeDescription,'Equip') > 0 THEN TypeDescription = TRANWRD(TypeDescription,'Equip','Equipment');
RUN;
PROC EXPORT data=MyLib.TPCEproduct_type outfile='/folders/myfolders/Lab3/clean files/TPCEproduct_type_clean.csv' dbms=dlm replace;
delimiter=',';
run;