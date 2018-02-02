

create table mess_off(
rollno number references student_information(rollno),
dated date,
from_date date,
to_date date,
location char(250)
)


insert into mess_off values(101690013,'23-Nov-2016','24-Nov-2016','26-Nov-2016','Bathinda');
insert into mess_off values(101510007,'12-Nov-2016','12-Nov-2016','17-Nov-2016','Chandigarh');
insert into mess_off values(101510016,'3-Nov-2016','4-Nov-2016','6-Nov-2016','Delhi');





create table leave_entry
(
 s_no number primary key,
 rollno number references student_information(rollno) ,
 dated date ,
arr_dated  date ,
location char(250),
time_out char(250) ,
time_in char(250)
)


insert into leave_entry values(6,101510007,'25-may-2014','2-jun-2014','Chandigarh','12:23pm','08:23am');
insert into leave_entry values(3,101510016,'25-nov-2017','15-dec-2099','nabha jail','5:10pm','8:30am');





