LIBNAME MYLIB '/folders/myfolders/lab 3/dataFiles';
DATA MYLIB.PECproduct_type;
INFILE '/folders/myfolders/lab 3/dataFiles/PECproduct_type.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover
lrecl = 32767;
FORMAT prodtype $2.;
FORMAT typedescription $30.;
FORMAT BUID	$2.; 

INPUT prodtype $ typedescription$ BUID $;
RUN;

DATA MYLIB.PECproduct_type;
MODIFY MYLIB.PECproduct_type;
If typedescription = 'Manufacturing Equip' THEN typedescription = 'Manufacturing Equipment'; 
RUN;

PROC EXPORT data=MYLIB.PECproduct_type outfile='/folders/myfolders/lab 3/clean files/PECproduct_type_clean.csv' dbms=dlm replace;
delimiter=',';
run;