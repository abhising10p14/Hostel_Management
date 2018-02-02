
create table other_comp(
rollno number references student_information(rollno),
complaint_id number primary key,
complaint char(100),
dor date,
feasible_date date,
current_status char(50)
)


insert into other_comp values(101510007,1001,'mess food not good','29-nov-2016','1-dec-16','not done');
insert into other_comp values(101510016,1002,'room cleaning','29-nov-2016','1-dec-16','not done');
insert into other_comp values(101690013,1003,'washroom no clean','29-nov-2016','1-dec-16','not done');


