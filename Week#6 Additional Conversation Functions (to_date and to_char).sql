/*
TO_DATE function은 string을 date로 변환하는 기능을 가지고 있다.

문법
TO_DATE(string1, format_mask)

매개변수 설명
string1 : date로 변환 될 string
format_mask : string1을 date로 변환할 때 어떻게 변환할 것인지에 대한 조건 (입력하지 않으면 기본 값으로 변환)
*/

select sysdate from dual;
select to_date('2019/12/01', 'yyyy/mm/dd') from dual;
select to_date('080903', 'mmddyy') from dual;
select to_date('20191201', 'yyyymmdd') from dual;
select to_date('2019/12/01 8:30:25', 'yyyy/mm/dd hh:mi:ss') from dual;

/*
TO_CHAR function은 number 또는 date를 string으로 변환해준다.

문법
TO_CHAR(value, format_mask)

매개변수 설명
value : string으로 변환 될 date 또는 number
format_mask : date, number를 string으로 변환할 때 어떻게 변환할 것인지에 대한 조건 (입력하지 않으면 기본 값으로 전환)
*/
select to_char(1210.734, '$9,999.99') from dual;
select to_char(1210.734, '$9,999.00') from dual;
select to_char(21, '000099') from dual;

select to_char(sysdate, 'yyyy/mm/dd') from dual;
select to_char(sysdate, 'month dd, yyyy') from dual;
select to_char(sysdate, 'fmmonth dd, yyyy') from dual;
select to_char(sysdate, 'mon ddth, yyyy') from dual;
select to_char(sysdate, 'fmmon ddth, yyyy') from dual;

