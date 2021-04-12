LIBNAME MYLIB '/folders/myfolders/lab 3/dataFiles';
DATA MYLIB.PECcustomer;
INFILE '/folders/myfolders/lab 3/dataFiles/PECcustomer.csv' DSD DELIMITER = ',' FIRSTOBS = 2 missover
lrecl = 32767;
FORMAT name $40.;
FORMAT addr1	$50.; 
FORMAT city $20.;
FORMAT state $20.;
FORMAT custtype $24.;
INPUT custID name $ addr1	$ city $ state $ zip custtype $;
RUN;

DATA MYLIB.PECcustomer;
MODIFY MYLIB.PECcustomer;

* Trimming strings;
name = TRIM(name);
addr1 = TRIM(addr1);
city = TRIM(city);
state = TRIM(state);
custtype = TRIM(custtype);

* Handling Missing Values;
IF MISSING(city) THEN DO city = 'Syracuse'; state = 'DE'; custtype = 'USGOVT'; zip = 56656;END;
IF zip<10000 THEN zip = 98297;

* Handling abbrevations;
addr1 = TRANWRD(addr1,'St.','Street');
addr1 = TRANWRD(addr1,'Ave','Avenue');
addr1 = TRANWRD(addr1,'Av.','Avenue');
addr1 = TRANWRD(addr1,'Rd.','Road');
addr1 = TRANWRD(addr1,'Dr.','Drive');
addr1 = TRANWRD(addr1,'Co.','Corporation');
addr1 = TRANWRD(addr1,'Inc.','Incorporated');
addr1 = TRANWRD(addr1,'Inc','Incorporated');

* Removing periods and commas;

addr1 = TRANWRD(addr1,".","");

* Standerdizing customer type;
custtype = TRANWRD(custtype,'STATELOCALGOVT','State/Local Government');
custtype = TRANWRD(custtype,'COMMERCIAL','Commercial');
custtype = TRANWRD(custtype,'COMERCIAL','Commercial');
custtype = TRANWRD(custtype,'EDUCATION','Education');
custtype = TRANWRD(custtype,'USGOVT','US Government');

RUN;

* Adding addr2;

DATA MYLIB.PECcustomer;
SET MYLIB.PECcustomer;
addr2 = 'Suite 999';
RUN;

PROC EXPORT data=MYLIB.PECcustomer outfile='/folders/myfolders/lab 3/clean files/PECcustomer_clean.csv' dbms=dlm replace;
delimiter=',';
run;