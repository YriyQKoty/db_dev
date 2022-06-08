use Afonin_308_1
go

alter table Stations
    add CarsCount int;

declare cur1 cursor local scroll_locks
    for select v.Id, count(*) c
        from Cars v
        group by v.Id
open cur1

declare @t int, @q int;
fetch next from cur1 into @t, @q;

while @@fetch_status = 0
    begin
        update Stations set CarsCount = @q where id = @t;
        fetch next from cur1 into @t, @q;
    end
close cur1;
deallocate cur1;

-----

declare cur2 cursor local scroll_locks
    for select Id
        from Stations
open cur2

declare @type int;
fetch next from cur2 into @type;

declare @type_qty int;
while @@fetch_status = 0
    begin
        select @type_qty = count(*) from Stations where Id = @type;
        update Stations set Stations.CarsCount= @type_qty where current of cur2;
        fetch next from cur2 into @type;
    end
close cur2;
deallocate cur2;