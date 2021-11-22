use classicmodels;
# delimiter $$
# drop procedure if exists getCusById;
# create procedure getCusById
# (in cusNum int(11))
# begin
# 	select *from customers where customerNumber = cusNum;
# end $$
# delimiter ;
# call getCusById(175);
delimiter $$
drop procedure if exists GetCustomersCountByCity;
create procedure GetCustomersCountByCity(in in_city varchar(50), out total int)
begin 
	select count(customerNumber) into total 
    from customers 
    where city = in_city;
end $$
delimiter ;
call GetCustomersCountByCity('Lyon', @total);
select @total;

DELIMITER //
CREATE PROCEDURE SetCounter( INOUT counter INT, IN inc INT)
BEGIN
 SET counter = counter + inc;
END//
DELIMITER ;
SET @counter = 1;

CALL SetCounter(@counter,1); -- 2

CALL SetCounter(@counter,1); -- 3

CALL SetCounter(@counter,5); -- 8

SELECT @counter; -- 8
