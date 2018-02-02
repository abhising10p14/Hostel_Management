

create table night_mess(
item_no number primary key,
item_name char(250),
stock number,
price number
)


insert into night_mess values(1,'maggi',100,20);
insert into night_mess values(2,'samosa',100,10);
insert into night_mess values(3,'sandwich',100,15);
insert into night_mess values(4,'hot coffee',100,10);



create table bill(
b_no number primary key,
rollno number references student_information(rollno),
item_no number references night_mess(item_no),
qty number,
amt number,
dated date,
paid number,
status char(50)
)



create or replace trigger update_mess
after insert or update on bill
for each row 
begin
update night_mess
set stock=stock- :new.qty where night_mess.item_no=:new.item_no;
end;



create or replace trigger bal_check
before insert or update on bill
for each row
declare 
net number;
rec student_information%rowtype;
begin
select * into rec from student_information where student_information.rollno=:new.rollno;
net := rec.balance + :new.paid - :new.amt ;
if net<-500 then 
raise_application_error(-20006,'please pay the previous balance first');
end if;
end;


create or replace procedure insert_bill(rno in number, ino in number, qt in number, pay in number) is
ctr number;
amount number;
quantity number;
rec night_mess%rowtype;
begin
select * into rec from night_mess where night_mess.item_no=ino;
select stock into quantity from night_mess where night_mess.item_no=ino;
if qt>quantity then 
dbms_output.put_line('not_enough_stock');
return;
end if;
select count(*) into ctr from bill;
ctr:=ctr+1;
amount:=rec.price*qt;
insert into bill values(ctr,rno,ino,qt,amount,to_char(sysdate),pay,NULL);
exception
when no_data_found then
dbms_output.put_line('please check for item no and roll no');
end;




create or replace trigger bal_upd 
before insert or update on bill
for each row
declare
rno number;
begin
rno:=:new.rollno;
update student_information
set balance=balance + :new.paid - :new.amt where student_information.rollno=rno;
end;




create or replace procedure delete_bill(billno in number) is
rec bill%rowtype;
rec1 night_mess%rowtype;
rec2 student_information%rowtype;
begin
select * into rec from bill where bill.b_no=billno;
select * into rec1 from night_mess where item_no = rec.item_no; 
select * into rec2 from student_information where rollno=rec.rollno;
if rec.status='cancelled' then 
dbms_output.put_line('bill already cancelled');
return;
end if;
update bill
set status='cancelled' where bill.b_no=rec.b_no;
update night_mess
set stock = rec1.stock + rec.qty where item_no = rec.item_no;
update student_information
set balance = rec2.balance + rec.amt where rollno = rec.rollno;
exception
when no_data_found then
dbms_output.put_line('please enter correct bill no');
end;

