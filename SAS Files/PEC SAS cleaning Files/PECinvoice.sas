LIBNAME MYLIB '/folders/myfolders/lab 3/dataFiles';
DATA MYLIB.PECinvoice;
INFILE '/folders/myfolders/lab 3/dataFiles/PECinvoice.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover
lrecl = 32767;

format salesDate $10.;
format shipMethod $10.; 
format paymentMethod $10.;
format orderMethod $10.; 
format orderDate $10.;

INPUT Invoice	custID	salesDate $	prodid	amt	qty	shipMethod $
shipCost	paymentMethod $	orderMethod	$ orderDate	$ discounted;
RUN;

/* DATA MYLIB.PECinvoice; */
/* SET MYLIB.PECinvoice; */
/* saleDate = ""; */
/* RUN; */

DATA MYLIB.PECinvoice;
MODIFY MYLIB.PECinvoice;

* Correcting records;

IF Invoice = 12485 THEN DO custID = 33 ; salesDate = '04/01/09'; prodid = 21 ; amt = 355 ; qty = 104; 
shipMethod = 'train'; shipCost = 7.1 ; paymentMethod = 'cod'; orderMethod = 'phone'; orderDate = '05/31/09'; 
END;

IF salesDate = '28' THEN DO custID = 25563; salesDate = '07/15/05'; prodid = 28; amt = 116; qty = 100; 
shipMethod = 'air'; shipCost = 9.28; paymentMethod = 'charge'; orderMethod = 'email'; orderDate = '07/10/07';
END;

IF salesDate = '200805-16' THEN salesDate = '05/16/08';

* Correcting sales date format;

salesDate = TRANSLATE(salesDate,'-','/');
day = SCAN(salesDate,2,'-');
month = SCAN(salesDate,1,'-');
year = SCAN(salesDate,3,'-');
num_year = input(year,8.);
IF LENGTH(day)<2 THEN day = ("0"||day);
IF LENGTH(month)<2 THEN month = ("0"||month);
IF num_year<19 THEN year = ("20"||year); ELSE year = ("19"||year);
salesDate = cats(year,"-",month,"-",day);

* Correcting order date format;
orderDate = TRANSLATE(orderDate,'-','/');
day = SCAN(orderDate,2,'-');
month = SCAN(orderDate,1,'-');
year = SCAN(orderDate,3,'-');
num_year = input(year,8.);
IF LENGTH(day)<2 THEN day = ("0"||day);
IF LENGTH(month)<2 THEN month = ("0"||month);
IF num_year<19 THEN year = ("20"||year); ELSE year = ("19"||year);
orderDate = cats(year,"-",month,"-",day);

* Correcting shipping method.;
IF shipMethod IN ('trran','trrain','trainn') THEN shipMethod = 'train';
IF shipMethod IN ('trick','tuck') THEN shipMethod = 'truck';
IF shipMethod IN ('aiir') THEN shipMethod = 'air';

RUN;

PROC EXPORT data=MYLIB.PECinvoice outfile='/folders/myfolders/lab 3/clean files/PECinvoice_clean.txt' dbms=dlm replace;
delimiter=',';
run;