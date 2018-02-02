create table laundry(
rollno number references student_information(rollno),
complaint_id number primary key,
complaint char(100),
dor date,
feasible_date date,
current_status char(50)
)



insert into laundry values(101510007,1001,'clothes not properly washed','29-nov-2016','1-dec-16','not done');
insert into laundry values(101510016,1002,'wrinkled clothes','29-nov-2016','1-dec-16','not done');
insert into laundry values(101690013,1003,'harsh detergents used','29-nov-2016','1-dec-16','not done');

