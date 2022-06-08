use Afonin_308_1
go
drop table if exists  ParkingFees;
create table ParkingFees
(
    id             int          not null,
    price          money        not null,
    expirationDate datetime2    not null,
);

select *
from ParkingFees

drop table ParkingFees;
create table ParkingFees
(
    id             int          primary key,
    price          money        not null,
    expirationDate datetime2    not null,
);

select *
from ParkingFees

select *
from ParkingFees
where id = 10

create nonclustered index idx_exp_dte on ParkingFees(expirationDate)

select *
from ParkingFees
where expirationDate = GETDATE()

select *
from ParkingFees
         with (index (idx_exp_dte))

create nonclustered index idx_price on ParkingFees(id,price)

select *
from ParkingFees
where price = 50

select id, price
from ParkingFees
where price = 53.5

drop table ParkingFees;