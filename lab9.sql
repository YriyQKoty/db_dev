use Afonin_308_1
go

--1 task
declare @number int = 5
set @number = 1
print @number
select @number

--2,3,4,6 tasks
declare @result int = (select count(Id) from Cars)
if @result > 8
    begin
        print '>8'
        select @result
    end
else
    begin
        print '<8'
        select @result
    end

declare @i int = 0
while @i < @result
    begin
        exec('select * from Cars where Id = ' + @i)
        print @i
        set @i = @i + 1
    end

-- 5 task
begin try
    set @result = 'qqqq'
end try
begin catch
    print 'result is a number'
end catch