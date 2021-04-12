* TPC_E customer_type cleaning;
LIBNAME MyLib '/folders/myfolders/Lab3';
DATA MyLib.TPCEcustomer_type;
INFILE '/folders/myfolders/Lab3/customer_type.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover
lrecl = 32767;
FORMAT CustType $1.;
FORMAT TypeName	$50.; 
INPUT Custtype $ TypeName$;
RUN;

proc sort DATA = MyLib.TPCEcustomer_type noduprecs;
by CustType;
RUN;

DATA MyLib.TPCEcustomer_type;
MODIFY MyLib.TPCEcustomer_type;

* Trimming strings;
CustType = TRIM(CustType);
TypeName = TRIM (TYPENAME);
TypeName = TRANSLATE (TypeName,'/','_');

IF SUBSTR(TypeName,LENGTH(TypeName)-2)= 'Gov' THEN TypeName = SUBSTR(TypeName,1,LENGTH(TypeName)-3)||'Government';
IF SUBSTR(TypeName,LENGTH(TypeName)-3)= 'Govt' THEN TypeName = SUBSTR(TypeName,1,LENGTH(TypeName)-4)||'Government';



PROC EXPORT data=MyLib.TPCEcustomer_type outfile='/folders/myfolders/Lab3/clean files/TPCEcustomer_type_clean.csv' dbms=dlm replace;
delimiter=',';
RUN;