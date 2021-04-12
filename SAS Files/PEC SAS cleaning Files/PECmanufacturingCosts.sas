LIBNAME MYLIB '/folders/myfolders/lab 3/dataFiles';
DATA MYLIB.PECmanufacturingCosts;
INFILE '/folders/myfolders/lab 3/dataFiles/PECmanufacturingCosts.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover;
INPUT year month prodID manufacturingCost;
RUN;

PROC EXPORT data=MYLIB.PECmanufacturingCosts outfile='/folders/myfolders/lab 3/clean files/PECmanufacturingCosts_clean.txt' dbms=dlm replace;
delimiter=',';
run;