select *
from Owners
begin transaction
update Owners
set Surname = 'Hopkins'
where Id = 1
select *
from Owners
commit transaction
select *
from Owners


select *
from Cars
begin transaction
update Cars
set SeatsCount = 10
where OwnerId = 1
select *
from Cars
rollback transaction
select *
from Cars


select *
from Owners
begin transaction
update Owners
set Surname = 'qwerty'
where Id = 1
save transaction save_owners
select *
from Owners
rollback transaction save_owners
commit transaction
select *
from Owners


begin transaction
begin try
    insert into Owners(Surname) values ('Bikson')
    commit transaction
end try
begin catch
    rollback transaction
end catch

set transaction isolation level SERIALIZABLE
begin transaction first
update Owners
set Surname = 'Jonson'
where Id = 1
select *
from Owners
where Id in (1, 2)

begin transaction second
update Cars
set SeatsCount = 5
where Id = 2
select *
from Cars
where Id in (1, 2)

commit transaction first
commit transaction second