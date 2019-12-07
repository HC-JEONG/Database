-- Assignment 1

create table department(
dept_id number(4),
dept_name varchar2(30),
dept_phone char(12),
dept_webpage char(17),
constraint deptPK primary key(dept_id));

create sequence dept start with 1;

create or replace trigger dept_id_trigger
before insert on department
for each row
begin
    select dept.nextval
    into :new.dept_id
    from dual;
end;
/

insert into department (dept_name, dept_phone, dept_webpage)
values ('Chemical Engineering', '02-2260-3706', 'ce.dongguk.edu');

insert into department (dept_name, dept_phone, dept_webpage)
values('Civil Engineering', '02-2260-3839', 'ci.dongguk.edu');

insert into department (dept_name, dept_phone, dept_webpage)
values('Computer Engineering', '02-2260-3829', 'cs.dongguk.edu');

insert into department (dept_name, dept_phone, dept_webpage)
values('Industrial Engineering', '02-2260-3377', 'ie.dongguk.edu');


select * from department;