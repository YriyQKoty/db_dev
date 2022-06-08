create table cars_to_insert (
    RowId int primary key identity (1,1),
    Number varchar(55) unique not null,
    SeatsCount int,
    OwnerId int,
    StationId int 
)

insert into cars_to_insert (number, seatscount, ownerid, stationid) values ('fqwf', 5, 2, 1);

drop procedure if exists seed_cars
go

create proc seed_cars @all_update bit, @rowId int, @processed_rows int output
as 
    declare @added_rows int = 0
    set @processed_rows = 0

    declare @id int, @number varchar(55), @seatsCount int, @ownerId int, @stationId int
        if @all_update = 1
            begin
                declare cur cursor local fast_forward 
                    for select * from cars_to_insert
                open cur
                
                fetch next From cur into @id,@number, @seatsCount, @ownerId, @stationId
                while @@fetch_status = 0
                    begin
                        if not exists(select 1 from Stations where Id = @stationId)
                            throw 50001, 'station does not exist',1
                        
                        if not exists(select 1 from Owners where Id = @ownerId)
                            throw 50001, 'owner with such name does not exist',1

                        if exists(select 1 from Cars where Number = @number)
                            throw 50001, 'car with such number already exist',1
                        
                        insert into Cars (number, seatscount, ownerid) values (@number, @seatsCount, @ownerId);
                        delete from cars_to_insert where RowId = @id;
                        
                        set @processed_rows = @processed_rows + 1
                        set @added_rows = @added_rows + 2
                        
                        fetch next FROM cur into @id, @seatsCount, @number, @stationId, @ownerId
                    end
                close cur
                deallocate cur
            end
        else    
            begin 
                    if @rowId is null
                        throw 50001,  'row is null',1
                
                    select @id = RowId,
                           @number = Number,
                           @seatsCount = SeatsCount,
                           @ownerId = OwnerId,
                           @stationId = StationId
                    from cars_to_insert
                    where RowId = @rowId
                
                    if @id is null 
                        throw 50001, 'row does not exist', 1

                    if not exists(select 1 from Stations where Id = @stationId)
                        throw 50001, 'station does not exist',1

                    if not exists(select 1 from Owners where Id = @ownerId)
                        throw 50001, 'owner with such name does not exist',1

                    if exists(select 1 from Cars where Number = @number)
                        throw 50001, 'car with such number already exist',1

                    insert into Cars (number, seatscount, ownerid) values (@number, @seatsCount, @ownerId);
                    
                    print @@identity
                    delete from cars_to_insert where RowId = @id;
                    
                    set @processed_rows = 1
                    set @added_rows = 2

            end

    return @added_rows

declare @t int;
exec seed_cars 1, null, @processed_rows = @t output 
print @t