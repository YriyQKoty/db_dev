use Afonin_308_1
go

-- for each station display max,min,avg car seat count
select *
from Stations s
         cross apply (
    select max(c.SeatsCount) as max_seats,
           min(c.SeatsCount) as min_seats,
           avg(c.SeatsCount) as avg_seats
    from Cars c
    where c.StationId = s.id
) as x;
go

-- select cars with expiring booking date
select C.Number, Expires from ParkingDetails 
    INNER JOIN Cars C on C.Id = ParkingDetails.CarId

-- select stations (names) with places more than 50 ordered by descending
SELECT s.Name, PlacesCount
FROM Stations as s
WHERE PlacesCount > 50
ORDER by PlacesCount DESC;