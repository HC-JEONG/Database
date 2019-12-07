create table Project
    (ProjectName varchar2(40), ProjectBudget number(6),
    constraint projectpk primary key (projectname)
);


Create table Manager
    (ManagerName varchar2(20), ManagerPhone char(12),
    ProjectName varchar2(40),
    constraint managerpk primary key (managername),
    constraint managerfk foreign key (projectname) 
    references project(projectname)
);


insert into project values ('Company Profile Website', 1000)
insert into project values ('Industrial IoT', 2500)
insert into project values ('Big Data', 3300)
insert into project values ('Technology Forecasting', 4100)
insert into project values ('Industrial AI Application', 5600)
insert into project values ('Building Cloud Server', 15000)

insert into manager values ('John Smith', '02-2260-1234', 'Company Profile Website');
insert into manager values ('Dave John', '02-2260-1235', 'Industrial IoT');
insert into manager values ('Jerry Miller', '02-2260-1236', 'Big Data');
insert into manager values ('Fred Stuart', '02-2260-1237', 'Technology Forecasting');
insert into manager values ('Joe Done', '02-2260-1238', 'Industrial AI Application');
insert into manager values ('Doug Hope', '02-2260-1239', 'Building Cloud Server');

select m.managername, m.managerphone, p.projectname, p.ProjectBudget
from manager m, project p
where m.projectname=p.projectname;


