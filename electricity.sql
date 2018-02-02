
create table electricity(
rollno number references student_information(rollno),
complaint_id number primary key,
complaint char(100),
dor date,
feasible_date date,
current_status char(50)
)


insert into electricity values(101510007,1001,'fan not working','29-nov-2016','1-dec-16','not done')
insert into electricity values(101510016,1002,'ac not working','29-nov-2016','1-dec-16','not done')
insert into electricity values(101690013,1003,'light not working','29-nov-2016','1-dec-16','not done')


create  or replace trigger p_key_electricity
before insert or update of complaint_id on electricity
for each row
declare 
c electricity.complaint_id%type;
begin
if :new.complaint_id is NULL then 
raise_application_error(-20006,'complaint_id cant be null');
end if;
select count(*)into c from electricity where complaint_id = :new.complaint_id ;
if c>0 then raise_application_error(-20009,'complaint_id should be unique');
end if;
exception 
when no_data_found then 
null ;
end;


