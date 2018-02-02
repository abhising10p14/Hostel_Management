


create table student_information
(
rollno number primary key,
first_name char(250),
middle_name char(250),
last_name char(250),
dob date,
class char(250),
year number,
branch char(250),
hostel char(250) references hostel_info(name),
room char(250),
password char(250),
balance number
);



create or replace trigger f_key_student_information
before insert or update of hostel on student_information
for each row
declare 
temp hostel_info.name%type;
begin
select name into temp from hostel_info where name=:new.hostel;
exception
when no_data_found then
raise_application_error(-20006,'reference not found');
end;



create or replace trigger trig_1 
before insert or update  on student_information
for each row 
begin
:new.first_name:=UPPER(:new.first_name);
:new.middle_name:=UPPER(:new.middle_name);
:new.last_name:=UPPER(:new.last_name);
end;




DECLARE
   rno student_information.rollno%type := 3;
   naam  student_information.first_name%type;
BEGIN
   SELECT  first_name INTO  naam
   FROM student_information
   WHERE rollno = rno;

   DBMS_OUTPUT.PUT_LINE ('Name: '||  naam);
EXCEPTION
   WHEN no_data_found THEN
      dbms_output.put_line('No such student!');
   WHEN others THEN
      dbms_output.put_line('Error!');
END;





DECLARE
  firstname  student_information.first_name%TYPE;   
  lastname   student_information.last_name%TYPE;  
  CURSOR cursor1 IS
    SELECT first_name, last_name FROM student_information;
BEGIN
  OPEN cursor1;
  loop
  FETCH cursor1 INTO firstname, lastname; 
  DBMS_OUTPUT.PUT_LINE('Student name: ' || firstname || ' ' || lastname);
  exit when cursor1%notfound;
  end loop;
  CLOSE cursor1;
END;




insert into student_information values(101510007,'Abhishek','Kumar','Singh','30-Nov-1996','Btech',2,'CML-1','k','203','IamMad');
insert into student_information values(101510016,'Ankur',NULL,'Sharma','10-Dec-1996','Btech',2,'CML-1','l','103','IamInsane');
insert into student_information values(101690013,'Sannya',NULL,'Singal','3-Jun-1997','Btech',2,'CML-3','i','110','XYZ');



create or replace procedure update_info(roll_number in number) is
begin
update student_information 
set branch='COE'
where rollno=roll_number;
end;



create table student_phone
(
rollno number
references student_information(rollno),
stu_phone number,
primary key(rollno,stu_phone)
);



insert into student_phone values(101510007,9888637271);
insert into student_phone values(101510007,9888456778);
insert into student_phone values(101510016,7888637979);
insert into student_phone values(101690013,9000639278);
insert into student_phone values(101510016,7888637209);



create table parent_phone
(
rollno number references student_information(rollno),
par_phone number,
primary key(rollno,par_phone)
);



insert into parent_phone values(101510007,9888637000);
insert into parent_phone values(101510007,9000456778);
insert into parent_phone values(101690013,9028880002);
insert into parent_phone values(101510016,9998637979);



create table student_email
(
rollno number
references student_information(rollno),
stu_mail char(250),
primary key(rollno,stu_mail)

);
insert into student_email values(101510007,'abhishek123@gmail.com');
insert into student_email values(101690013,'sannyasingal@gmail.com');
insert into student_email values(101690013,'san.singal@yahoo.com');
insert into student_email values(101510016,'ankuria1213@gmail.com');


