/* 1. Create the following tables and make sure the data structures are same as shown in the figures
below. Don’t forget to create constraint for each tables as described in the table design below.
Please create a sequence and trigger for each primary key in the tables so that the value of
primary can be set automatically by the database system (auto increment value from 1, 2, 3,
5…,so on). */

create table customers(
    cust_id number(5) not null,
    cust_name varchar2(10) not null,
    cust_address varchar2(10) null,
    constraint custPK primary key(cust_id)
);


create table products(
    prod_id number(5) not null,
    prod_name varchar2(10) not null,
    prod_price number(10) null,
    constraint prodPK primary key(prod_id)
);



create table transactions(
    trans_id number(5) not null,
    cust_id number(5) not null,
    prod_id number(5) not null,
    trans_date date null,
    trans_quantity number(5) not null,
    constraint transPK primary key(trans_id),
    constraint transFKcust foreign key(cust_id) references customers(cust_id),
    constraint transFKprod foreign key(prod_id) references products(prod_id)
);


create sequence cust_seq start with 1;

create or replace trigger cust_id_trigger
before insert on customers
for each row
begin
    select cust_seq.nextval
    into :new.cust_id
    from dual;
end;
/

create sequence prod_seq start with 1;

create or replace trigger prod_id_trigger
before insert on products
for each row
begin
    select prod_seq.nextval
    into :new.prod_id
    from dual;
end;
/

create sequence trans_seq start with 1;

create or replace trigger trans_id_trigger
before insert on transactions
for each row
begin
    select trans_seq.nextval
    into :new.trans_id
    from dual;
end;
/


/* 2. Insert the data into the tables. Make sure your data is same with the examples as shown in the
figures below: */

insert into customers(cust_name, cust_address) values('Cust 1', 'Seoul');
insert into customers(cust_name, cust_address) values('Cust 2', 'Jeju');
insert into customers(cust_name, cust_address) values('Cust 3', 'Busan');
insert into customers(cust_name, cust_address) values('Cust 4', 'Daegu');
insert into customers(cust_name, cust_address) values('Cust 5', 'Seoul');

insert into products(prod_name, prod_price) values('Kimchi', 1000);
insert into products(prod_name, prod_price) values('Coffee', 2000);
insert into products(prod_name, prod_price) values('Green Tea', 3500);
insert into products(prod_name, prod_price) values('Milk', 1500);
insert into products(prod_name, prod_price) values('Bread', 4000);

insert into transactions(cust_id, prod_id, trans_date, trans_quantity) values(1,1, to_date('2019-10-12 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2);
insert into transactions(cust_id, prod_id, trans_date, trans_quantity) values(1,3, to_date('2019-10-12 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4);
insert into transactions(cust_id, prod_id, trans_date, trans_quantity) values(2,2, to_date('2019-10-12 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2);
insert into transactions(cust_id, prod_id, trans_date, trans_quantity) values(2,4, to_date('2019-10-12 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3);
insert into transactions(cust_id, prod_id, trans_date, trans_quantity) values(2,5, to_date('2019-10-12 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);
insert into transactions(cust_id, prod_id, trans_date, trans_quantity) values(3,1, to_date('2019-10-12 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);
insert into transactions(cust_id, prod_id, trans_date, trans_quantity) values(3,2, to_date('2019-10-12 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2);
insert into transactions(cust_id, prod_id, trans_date, trans_quantity) values(4,5, to_date('2019-10-12 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);
insert into transactions(cust_id, prod_id, trans_date, trans_quantity) values(5,1, to_date('2019-10-12 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2);
insert into transactions(cust_id, prod_id, trans_date, trans_quantity) values(5,2, to_date('2019-10-12 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3);
insert into transactions(cust_id, prod_id, trans_date, trans_quantity) values(5,3, to_date('2019-10-12 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3);
insert into transactions(cust_id, prod_id, trans_date, trans_quantity) values(5,4, to_date('2019-10-12 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);

select * from customers;
select * from products;
select * from transactions;

/* 3.Create an SQL statement/command that can be used to “present the total sales of each
product from the transactions data”. The results should be like in the figure below: */
select p.prod_id, p.prod_name product, sum(t.trans_quantity*p.prod_price) total from products p, transactions t
where p.prod_id=t.prod_id group by p.prod_id, p.prod_name;


/* 4. Create an SQL command that can be used to “present the total transactions of each customers
and sort by using the total transactions value from high to low”. The results should be like in
the figure below: */
select c.cust_id, c.cust_name, sum(t.trans_quantity*p.prod_price) total from customers c, products p, transactions t 
where c.cust_id=t.cust_id and p.prod_id=t.prod_id group by c.cust_id, c.cust_name order by total desc;


/* 5. Create an SQL command that can be used to “present the total transactions of each customers
which the total transactions is less than or equal to 12500, and sort results by using the total
transactions value from low to high”. The results should be like in the figure below: */
select c.cust_id, c.cust_name, sum(t.trans_quantity*p.prod_price) total from customers c, products p, transactions t 
where c.cust_id=t.cust_id and p.prod_id=t.prod_id group by c.cust_id, c.cust_name having sum(t.trans_quantity*p.prod_price)<=12500 order by total asc;


/* 6. Create an SQL command that can be used to “present the customer/s who bought ‘Bread’ or
‘Coffee’ or ‘Milk’ product”. The results should be like in the figure below: */
select c.cust_id, c.cust_name, p.prod_name from customers c, products p, transactions t 
where c.cust_id=t.cust_id and p.prod_id=t.prod_id and p.prod_name in ('Bread', 'Coffee', 'Milk');