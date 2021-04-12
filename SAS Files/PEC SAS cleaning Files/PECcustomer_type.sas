LIBNAME MYLIB '/folders/myfolders/lab 3/dataFiles';
DATA MYLIB.PECcustomer_type;
INFILE '/folders/myfolders/lab 3/dataFiles/PECcustomer_type.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover
lrecl = 32767;
FORMAT custtype $1.;
FORMAT typename	$30.; 
INPUT custtype $ typename$;
RUN;

DATA MYLIB.PECcustomer_type;
MODIFY MYLIB.PECcustomer_type;
IF custtype = 'S' THEN typename = 'State/Local Government';
IF custtype = 'F' THEN typename = 'US Government';
RUN;

PROC EXPORT data=MYLIB.PECcustomer_type outfile='/folders/myfolders/lab 3/clean files/PECcustomer_type_clean.txt' dbms=dlm replace;
delimiter=',';
run;