create table artist(
    ArtistID int not null,
    LastName char(25) not null,
    FirstName char(25) not null,
    Nationality char(30) null,
    DateOfBirth number(4) null,
    DateDeceased number(4) null,
    constraint artistpk primary key(ArtistID),
    constraint artistaki unique(LastName, FirstName),
    constraint nationalityvalues check (Nationality in
    ('Canadian', 'English', 'French', 'German', 'Mexican', 'Russian', 'Spanish', 'United State')),
    constraint birthvaluescheck check (DateOfBirth<DateDeceased),
    constraint validbirthyear check ((DateOfBirth>=1000) and (DateOfBirth<=2100)),
    constraint validdeathyear check ((DateDeceased>=1000) and (DateDeceased<=2100))
);

create table work(
    WorkID int not null,
    Title char(35) not null,
    Copy char(12) not null,
    Medium Char (35) null,
    Description Varchar(1000) default 'Unknown provenance' null,
    ArtistID int not null,
    constraint workpk primary key(WorkID),
    constraint workaki unique(Title, Copy),
    constraint artistfk foreign key(ArtistID) references artist(ArtistID)
);

create table customer(
    CustomerID int not null,
    LastName char(25) not null,
    FirstName char(25) not null,
    EmailAddress varchar2(100) null,
    EncryptedPassword varchar2(50) null,
    Street char(30) null,
    City char(35) null,
    State char(2) null,
    ZIPorPostalCode char(9) null,
    Country char(50) null,
    AreaCode char(3) null,
    PhoneNumber char(8) null,
    constraint customerpk primary key(CustomerID),
    constraint emailaddressaki unique(EmailAddress)
);

create table trans(
    TransactionID int not null,
    DateAcquired date not null,
    AcquisitionPrice number(8,2) not null,
    AskingPrice number(8,2) null,
    DateSold date null,
    SalesPrice number(8,2) null,
    CustomerID int null,
    WorkID int null,
    constraint transpk primary key(TransactionID),
    constraint transworkfk foreign key(WorkID) references work(WorkID),
    constraint transcustomerfk foreign key(CustomerID) references customer(CustomerID),
    constraint salespricerange check ((SalesPrice>0) and (SalesPrice<=500000)),
    constraint validtransdate check (DateAcquired<=DateSold)
);