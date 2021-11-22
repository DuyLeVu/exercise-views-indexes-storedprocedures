use demo20062;
delimiter $$
drop procedure if exists printname;
create procedure printname(in id int, out name varchar(45))
begin
    select customer.name into name
    from customer
        where customer.id = id;
end $$
call printname(1,@name);
select @name;
delimiter $$
drop procedure if exists calprice;
create procedure calprice(in id int, out result varchar(45))
begin
    DECLARE productPrice int;
    select product.price into productPrice
    from product
    where product.id = id;
    if productPrice > 200 then
        set result = 'Đắt quá';
        else
        set result = 'Rẻ quá';
    end if;
end $$
delimiter $$
call calprice(2,@result);
select @result;

