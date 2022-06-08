use Afonin_308_1
GO

drop table if exists Cars;
drop table if exists Owners;
drop table if exists Stations;
create table Owners(
                       Id int identity constraint Owners_pk primary key ,
                       Surname varchar(100) not null
)
go

create unique index Owners_Id_uindex
    on Owners(Id)
go

drop table if exists Stations;
create table Stations(
    Id int identity constraint Stations_pk primary key ,
    Name varchar (100) not null,
    PlacesCount int check ([PlacesCount] >= 10 and [PlacesCount] < 10000)
)

create unique index Stations_Id_uindex
    on Stations(Id)
go

create unique index Stations_Name_uindex
    on Stations(Name)
go


create table Cars (
    Id int identity constraint Cars_pk primary key,
    Number varchar (55) not null,
    SeatsCount int default 1,
    OwnerId int constraint Cars_Owners_Id_fk references Owners(Id),
    StationId int constraint Cars_Stations_Id_fk references Stations(Id)
)
go

create unique index Cars_Id_uindex
    on Cars(Id)
go

create unique index Cars_Number_uindex
    on Cars(Number)
go


insert into Afonin_308_1.dbo.Owners (Surname) values ('Kools');
insert into Afonin_308_1.dbo.Owners (Surname) values ('Jack')
insert into Afonin_308_1.dbo.Owners (Surname) values ('Bill')
insert into Afonin_308_1.dbo.Owners (Surname) values ('Catrin')
insert into Afonin_308_1.dbo.Owners (Surname) values ('John')


insert into Afonin_308_1.dbo.Stations (Name, PlacesCount) values ('avc', 50);
insert into Afonin_308_1.dbo.Stations (Name, PlacesCount) values ('ewf', 100);
insert into Afonin_308_1.dbo.Stations (Name, PlacesCount) values ('Ber', 65);
insert into Afonin_308_1.dbo.Stations (Name, PlacesCount) values ('t4', 100);
insert into Afonin_308_1.dbo.Stations (Name, PlacesCount) values ('geg', 25);


insert into Afonin_308_1.dbo.Cars (Number, SeatsCount, OwnerId, StationId) values ('4124', 5, 1, 1);
insert into Afonin_308_1.dbo.Cars (Number, SeatsCount, OwnerId, StationId) values ('51251', 3, 2, 1);

insert into Afonin_308_1.dbo.Cars (Number, SeatsCount, OwnerId, StationId) values ('4t435', 6, 3, 3);
insert into Afonin_308_1.dbo.Cars (Number, SeatsCount, OwnerId, StationId) values ('54671', 6, 4, 4);

select * from Afonin_308_1.dbo.Stations
select * from Afonin_308_1.dbo.Owners
select * from Afonin_308_1.dbo.Cars

insert into Afonin_308_1.dbo.Cars (Number, SeatsCount, OwnerId, StationId) values ('54671', 6, 4, 4); --unique  

insert into Afonin_308_1.dbo.Stations (Name, PlacesCount) values ('geg', 2); --check

insert into Afonin_308_1.dbo.Cars (Number, SeatsCount, OwnerId, StationId) values (null, 6, 4, 4); --null

