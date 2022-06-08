create trigger modifyAmountOfSeats
    on Cars
    after insert, update, delete
    as
begin
    update Cars
    set SeatsCount = 0
    where 1 = 1
end