LIBNAME MYLIB '/folders/myfolders/lab 3/dataFiles';
DATA MYLIB.PECproduct;
INFILE '/folders/myfolders/lab 3/dataFiles/PECproduct.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover
lrecl = 32767;
FORMAT prodDescription $40.;
FORMAT supplierName $10.;
INPUT prodid prodDescription $	price1	price2	unitCost	supplierName $ productTypeID;
RUN;

*Adding supplier address details columns;
DATA MYLIB.PECproduct;
SET MYLIB.PECproduct;

LENGTH Supplier_ID $20;
LENGTH Supplier_addr1 $20;
LENGTH Supplier_addr2 $20;
LENGTH Supplier_City $20;
LENGTH Supplier_State $20;
LENGTH Supplier_Zip $20;

RUN;

DATA MYLIB.PECproduct;
MODIFY MYLIB.PECproduct;
IF SUBSTR(prodDescription,LENGTH(prodDescription)-4) = 'Equip' THEN 
prodDescription = SUBSTR(prodDescription,1,LENGTH(prodDescription)-5)||" Equipment";

IF supplierName = "" THEN supplierName = "PEC";

* Updating supplier addresses;

IF supplierName = "PEC" THEN DO
Supplier_ID ="9001";
Supplier_addr1="29843 Klingon Road";
Supplier_addr2="Dept #2";
Supplier_City="Naperville";
Supplier_State="IL";
Supplier_Zip="60563";
END;

IF supplierName = "TPC West" THEN DO
Supplier_ID ="9002";
Supplier_addr1="21 E Bullard Avenue";
Supplier_addr2="1";
Supplier_City="Stratford";
Supplier_State="NY";
Supplier_Zip="13470";
END;

IF supplierName = "TPC East" THEN DO
Supplier_ID ="9003";
Supplier_addr1="20021 Barnes Road";
Supplier_addr2="1";
Supplier_City="Fresno";
Supplier_State="CA";
Supplier_Zip="93650";
END;

* Correcting ptoduct type id.;
IF prodid = 28 THEN productTypeID = 3;

RUN;

PROC EXPORT data=MYLIB.PECproduct outfile='/folders/myfolders/lab 3/clean files/PECproduct_clean.csv' dbms=dlm replace;
delimiter=',';
run;