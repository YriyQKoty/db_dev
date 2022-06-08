create function f_get_avg_seats ()
    returns int
    as 
  begin
        declare @avg_seats int
        select @avg_seats = avg(SeatsCount) from Cars
        return @avg_seats
  end
    go

  select COUNT(*) as stations_count, dbo.f_get_avg_seats() as avg_seats
  from Stations

  create function fn_get_top_car_seats(@stationId int)
      returns table
          as
          return select max(c.SeatsCount) as top_seats
                 from Cars c 
                     inner join ParkingDetails PD on c.Id = PD.CarId 
                     inner join Stations S on S.Id = PD.StationId
                 where s.Id= @stationId
                GROUP BY S.Id


  select * from Stations s cross apply fn_get_top_car_seats(s.id)

  
    