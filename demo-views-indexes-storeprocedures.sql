drop database if exists demo_views_indexes_procedures;
create database demo_views_indexes_procedures;
use demo_views_indexes_procedures;
create table products
(
    Id                 int(11) primary key,
    productCode        nvarchar(20),
    productName        nvarchar(45),
    productPrice       int,
    productAmount      int,
    productDescription nvarchar(255),
    productStatus      bit
);
insert into products values (1,'11111','Tivi Samsung',320,10,'45 inch',1);
insert into products values (2,'22222','Điều hoà Panasonic',180,8,'45 inch',1);
insert into products values (3,'22A33','Máy giặt apple',300,15,'8 kg',1);
insert into products values (4,'33B43','Tủ Lạnh',280,30,'15L',1);
insert into products values (5,'55555','Máy tính để bàn',380,20,'8 GB RAM',1);
use demo_views_indexes_procedures;
# explain select * from products where productCode = '22222';
alter table products
    add index idx_productCode (productCode);
explain
select *
from products
where productCode = '22222';
alter table products
    add index idx_product_info (productName, productPrice);
explain
select *
from products
where productName = 'Máy giặt apple'
   or productPrice = 300;
ALTER TABLE products
    DROP INDEX idx_product_info;
create view product_view as
select productCode, productName, productPrice
from products;
select *
from product_view;
create or replace view product_view as
select productName, productPrice
from products
where productName = 'Máy giặt apple';
select *
from product_view;
drop view product_view;
delimiter $$
drop procedure if exists product_proceduce;
create procedure product_proceduce()
begin
    select * from products;
end $$
delimiter ;
call product_proceduce();
delimiter $$
drop procedure if exists add_new_product_proceduce;
create procedure add_new_product_proceduce(id int(11), productCode nvarchar(20), productName nvarchar(45), productPrice int, productAmount int, productDescription nvarchar(255), productStatus bit)
begin
    insert into products value (id, productCode,productName, productPrice, productAmount, productDescription, productStatus);
end $$
delimiter ;
call add_new_product_proceduce(6,'68686','Apple M1',500,2,'Chip M1',1);

call product_proceduce();
delimiter $$
drop procedure if exists update_product_proceduce;
create procedure update_product_proceduce(id_update int(11), newProductAmount int, newProductDescription nvarchar(255), newProductStatus bit)
begin
    update products
    set  productAmount = newProductAmount,
        productDescription = newProductDescription,
        productStatus = newProductStatus
    where Id = id_update;
end $$
delimiter ;
call update_product_proceduce(6,0,'M1 Pro',0);
call product_proceduce();
delimiter $$
drop procedure if exists delete_product_proceduce;
create procedure delete_product_proceduce(id_delete int(11))
begin
    delete from products
    where Id = id_delete;
end $$
delimiter ;
call delete_product_proceduce(6);
call product_proceduce();
