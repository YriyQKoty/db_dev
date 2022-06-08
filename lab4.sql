use Afonin_308_1
go

create table ParkingDetails (
    Id int identity constraint ParkingDetails_pk primary key,
    CarId int constraint ParkingDetails_Cars_Id_fk references Cars(Id),
    StationId int constraint ParkingDetails_Stations_fk references Stations(Id),
    Expires datetime not null,
    BookTime datetime  not null             
)

create unique index ParkingDetails_Id_uindex
    on ParkingDetails(Id)


--1
select sum(PlacesCount) from Afonin_308_1.dbo.Stations;

--2
select s.Name,  s.PlacesCount - Count(C.StationId) from Stations s 
    join Cars C on s.Id = C.StationId 
    group by s.Name, s.PlacesCount
    
--3
select Surname from Cars INNER JOIN Owners O on O.Id = Cars.OwnerId 
                where SeatsCount > 10

