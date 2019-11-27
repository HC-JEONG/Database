create table employee(
    emp_id number(6) not null,
    emp_name varchar2(15) not null,
    emp_address varchar2(15) null,
    constraint empPK primary key(emp_id)
);

insert into employee(emp_id, emp_name, emp_address) values(201901, 'jack', 'seoul korea');
insert into employee(emp_id, emp_name, emp_address) values(201902, 'mike', 'incheon korea');
insert into employee(emp_id, emp_name, emp_address) values(201903, 'david', 'seoul korea');
insert into employee(emp_id, emp_name, emp_address) values(201904, 'lee', 'incheon korea');
insert into employee(emp_id, emp_name, emp_address) values(201905, 'han', 'busan korea');

select * from employee;