use Afonin_308_1
go

--alter table Afonin_308_1.dbo.Cars drop constraint Cars_Stations_Id_fk
--alter table Afonin_308_1.dbo.Cars drop column StationId

create table Cities (
    Id int identity constraint Cities_pk primary key,
    Name varchar(255) not null,
)

create unique index Cities_Id_uindex 
    on Cities(Id)

insert into Cities (Name) values ('Mykolaiv')
insert into Cities (Name) values ('Odesa')

alter table Afonin_308_1.dbo.Stations
add CityId int constraint Stations_Cities_Id_fk references Cities(Id)

create table ParkingHistory (
    Id int identity constraint  ParkingHistory_pk primary key,
    OwnerId int constraint ParkingHistory_Owners_fk references Owners(Id),
)

create unique index ParkingHistory_OwnerId_uindex
    on ParkingHistory(OwnerId)

insert into ParkingHistory (OwnerId) values (1);
insert into  ParkingHistory (OwnerId) values (2);

create unique index ParkingHistory_Id_uindex 
    on ParkingHistory(Id)


alter table Afonin_308_1.dbo.ParkingDetails
    add ParkingHistoryId int constraint ParkingDetails_ParkingHistory_Id_fk references ParkingHistory(Id)


insert into ParkingDetails (CarId, StationId, ExpireTime, BookTime, ParkingHistoryId) values (1, 1, '', '', 1);
insert into ParkingDetails (CarId, StationId, ExpireTime, BookTime, ParkingHistoryId) values (2, 2, '', '', 2);

-- max seats of car on station
select s.Name, c.MaxSeats
from Stations s OUTER APPLY 
    (select top 1 max(c.SeatsCount) MaxSeats
    from Cars c 
        inner join ParkingDetails PD 
            on c.Id = PD.CarId
        where PD.StationId = s.Id
        ) c

