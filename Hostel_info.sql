create table hostel_info(
name char(250) primary key,
b_g char(250),
strength number,
residing number
)

insert into hostel_info values ('k','b',600,590);
insert into hostel_info values ('l','b',300,290);
insert into hostel_info values ('i','g',500,450);


create or replace procedure insert_hostel_info(a in char,b in char, c in number, d in number) as
begin
insert into hostel_info values(a,b,c,d);
end;



create table official_info(
 faculty_no number primary key,
 first_name char(250),
 middle_name char(250),
 last_name char(250),
 post char(250),
 hostel char(250) references hostel_info(name),
 password char(250)
)


create or replace procedure delete_official(fac_no in number) is
begin
delete from official_info where faculty_no=fac_no;
end;


insert into official_info values (1,'parminder','singh','rana','prof','k','10p14');
insert into official_info values (2,'Muhhamad','Fahrukh','Khan','warden','l','md@fk');
insert into official_info values (3,'Sunita','NULL','DEVI','warden','i','abc@123');



create or replace trigger f_key_official_info
before insert or update of hostel on official_info
for each row
declare 
temp hostel_info.name%type;
begin
select name into temp from hostel_info where name=:new.hostel;
exception
when no_data_found then
raise_application_error(-20006,'reference not found');
end;



create table official_phone(
  faculty_no number references official_info(faculty_no),
  ph_no number ,
  primary key(faculty_no,ph_no)
)

insert into official_phone values(1,8195819590);
insert into official_phone values(2,9195719590);
insert into official_phone values(3,8556899590);
insert into official_phone values(3,9876543210);



create table official_mail (
  faculty_no number references official_info(faculty_no),
 email_id char(250),
 primary key(faculty_no,email_id )
)



