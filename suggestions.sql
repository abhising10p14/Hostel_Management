create table suggestions(
rollno number references student_information(rollno),
unique_id number primary key,
suggestion char(100),
dor date,
feasible_date date,
current_status char(50)
)



