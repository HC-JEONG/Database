/* employee 테이블 만들기 */
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

/* department 테이블 만들기 */
create table department(
    dept_id number(6) not null,
    dept_name varchar2(15) not null,
    constraint deptpk primary key(dept_id)
);

create sequence dept_seq start with 19001;

create or replace trigger dept_id_trigger
before insert on department
for each row
begin
    select dept_seq.nextval
    into :new.dept_id
    from dual;
end;
/

insert into department(dept_name) values('accounting');
insert into department(dept_name) values('sales');
insert into department(dept_name) values('marketing');
insert into department(dept_name) values('research');

select * from department;

/* Salary 테이블 만들기 */
create table salary(
    sal_id number(6) not null,
    emp_id number(6) not null,
    dept_id number(6) not null,
    sal_date date not null,
    sal_bonus number(10) null,
    constraint salpk primary key(sal_id),
    constraint empfk foreign key(emp_id) references employee(emp_id),
    constraint deptfk foreign key(dept_id) references department(dept_id)
);

create sequence sal_seq start with 1;

create or replace trigger sal_id_trigger
before insert on salary
for each row
begin
    select sal_seq.nextval
    into :new.sal_id
    from dual;
end;
/

insert into salary(emp_id, dept_id, sal_date, sal_val, sal_bonus) values(201901, 19001, date '2019-09-17', 1000, 500);
insert into salary(emp_id, dept_id, sal_date, sal_val, sal_bonus) values(201902, 19001, date '2019-09-17', 1200, 300);
insert into salary(emp_id, dept_id, sal_date, sal_val, sal_bonus) values(201903, 19002, date '2019-09-17', 1300, 600);
insert into salary(emp_id, dept_id, sal_date, sal_val, sal_bonus) values(201904, 19002, date '2019-09-17', 1300, 800);
insert into salary(emp_id, dept_id, sal_date, sal_val, sal_bonus) values(201905, 19002, date '2019-09-17', 1300);

update salary set sal_bonus=0 where emp_id=201905 and dept_id=19002;

/* 테스트 데이터 생성 */
insert into employee(emp_id, emp_name, emp_address) values(201906, 'test', 'jeju korea');

select * from employee;

insert into department(dept_name) values('testing');

select * from department;

insert into salary(emp_id, dept_id, sal_date, sal_val, sal_bonus) values(201906, 19005, date '2019-10-02', 2000, 450);

select * from salary;

update employee set emp_name='park' where emp_id=201906;

/* like 연산자의 와일드카드 (%)를 이용해 해당 문자 포함된 데이터 추출 */
select * from employee where emp_address like 'seoul%';
select * from employee where emp_address like '%eo%';
select * from employee where emp_address like '%korea';
select * from department where dept_name like '%ing';
select * from department where dept_name like '%es%';

/* order by 연산자의 desc, asc를 이용해 내림차순, 오름차순으로 데이터 정렬 */
select * from employee order by emp_name asc;
select * from employee order by emp_name desc;
select * from salary order by sal_date asc;
select * from salary order by sal_date desc;

/* count, min, max, avg, stddev, to_char를 이용해 데이터 계산, 변환 */
select count(*) as nums_emp from employee;
select min(sal_val) min_sal, max(sal_val), max_sal, avg(sal_val) mean_sal, stddev(sal_val) std_sal from salary;
/* to_char는 숫자나 날짜 형식의 데이터를 특정한 형식으로 바꾸는 연산자이며 데이터 형식은 string으로 바뀐다 */
select emp_id, to_char(sal_val, '$9,999.99') salary from salary;
select emp_id, to_char(sal_val, '$9,999.99') salary, to_char(sal_date, 'yyyy-mm') year_month from salary;

/* group by는 특정 열의 결과를 그룹화해서 보여줌 */
select dept_id, count(*) nums_emp from salary group by dept_id;
/* having은 결과값을 필터링 하는 역할 */
select dept_id, avg(sal_val) mean_sal from salary group by dept_id having avg(sal_val)>=1000;
select dept_id, max(sal_val) max_sal from salary group by dept_id having max(sal_val)>=2000;
select dept_id, min(sal_val) main_sal from salary group by dept_it having min(sal_val)<=1000;

/* join은 두 테이블 이상의 데이터를 합칠 때 쓰는 연산자 */
select d.dept_id, d.dept_name, count(s.dept_id) nums_emp from salary s, department d
where s.dept_id=d.dept_id group by d.dept_id, d.dept_name;

select d.dept_id, d.dept_name avg(s.sal_val) mean_sal from salary s, department d
where s.dept_id=d.dept_id group by d.dept_id, d.dept_name having avg(sal_val)>=1000;

select d.dept_id, d.dept_name, max(s.sal_val) max_sal from salary s, department d
where s.dept_id=d.dept_id group by d.dept_id, d.dept_name having max(sal_val)>=2000;

select d.dept_id, d.dept_name, min(s.sal_val) min_sal from salary s, department d
where s.dept_id=d.dept_id group by d.dept_id, d.dept_name having min(sal_val)<=1000;

/* subquery 쿼리 안에 쿼리가 있는 형태, 구체적인 조건을 구현할 때 씀 */
select e.emp_name from employee e, salary s
where s.emp_id=e.emp_id and s.dept_id in
(select dept_id) from department where dept_name like '%ing%');

select e.emp_name from employee e, salary s
where s.emp_id=e.emp_id and s.dept_id not in
(select dept_id from department where dept_name like '%ing%');

select e.emp_name, d.dept_name from employee e, salary s, department d
where s.emp_id=e.emp_id and s.dept_id=d.dept_id and s.dept_id in
(select dept_id from department where dept_name like '%ing%');

select e.emp_name, d.dept_name from employee e, salary sm department d
where s.emp_id=e.emp_id and s.dept_id=d.dept_id and s.dept_id not in
(select dept_id from department where dept_name like '%ing%');

selected e.emp_name, d.dept_name, s.sal_val from employee e, salary s, department d
where s.emp_id=e.emp_id and s.dept_id=d.dept_id and s.sal_val>
(select avg(sal_val) from salary where dept_id=s.dept_id);

select e.emp_name, d.dept_name, s.sal_val from employee e, salary s, department d 
where s.emp_id=e.emp_id and s.dept_id=d.dept_id and s.sal_val<
(select avg(sal_val) from salary where dept_id=s.dept_id);

select e.emp_name, d.dept_name, s.sal_val from employee e, salary s, department d 
where s.emp_id=e.emp_id and s.dept_id=d.dept_id and s.sal_val=
(select avg(sal_val) from salary where dept_id=s.dept_id);

/*