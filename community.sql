-- Drop tables if they exist first
drop table if exists with_spouse;

drop table if exists citizen;

drop table if exists name;

drop table if exists person;

-- Then create the new empty tables for the database.

-- create a new empty table person
create table person
( personid	char(9) not null,
  sex		char check (sex in ('M','F')),
  emailid	varchar(30),
  address	varchar(30),
  phone		char(12),
  education	varchar(30),
  webpage	varchar(50),
  dyear		char(4),
  dplace	varchar(10),
  bdate		char(10),
  bcountry	varchar(10),
  bcity		varchar(10),
  msgfile	varchar(30),
  motherid	char(9),
  fatherid	char(9),
  constraint personpk
	primary key (personid),
  constraint matfk
 	foreign key (motherid) references person(personid),
  constraint patfk
 	foreign key (fatherid) references person(personid)
);

-- create a new empty table name whose identity is 
-- partially reliant on table person.
create table name
( pid 		char(9) not null,
  fname 	varchar(15) not null,
  mname 	varchar(15) not null,
  lname 	varchar(15) not null,
  remark 	varchar(30),
  constraint namepk
	primary key (pid, fname, mname, lname),
  constraint namepersonfk
	foreign key (pid) references person(personid)
);

-- create a new empty table citizen whose identity is
-- partially reliant on table person.
create table citizen
( pid		char(9) not null,
  ccountry	varchar(10) not null,
  cstatus	varchar(10),
  ccomment	varchar(30),
  constraint citpk
	primary key (pid, ccountry),
  constraint citpersonfk
	foreign key (pid) references person(personid)
);

-- create a new empty table with_spouse
-- separate table due to M:N relationship
create table with_spouse
( pid1		char(9) not null,
  pid2		char(9) not null,
  mstatus	varchar(10) not null,
  constraint spousepk
	primary key (pid1, pid2),
  constraint pid1fk
	foreign key (pid1) references person(personid),
  constraint pid2fk
	foreign key (pid2) references person(personid)
);