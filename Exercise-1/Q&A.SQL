-- LINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_computer_store

-- 1.1 Select the names of all the products in the store.
select * from products

-- 1.2 Select the names and the prices of all the products in the store.
select name, price form products

-- 1.3 Select the name of the products with a price less than or equal to $200.
select name form products 
where price <= 200

-- 1.4 Select all the products with a price between $60 and $120.
select * from products
where Price >= 60 and Price <= 120

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
select Name, Price*100 as PriceInCents from products

-- 1.6 Compute the average price of all the products.
select avg(price) from products

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
select avg(price) from products 
where manufacturer = 2

-- 1.8 Compute the number of products with a price larger than or equal to $180.
select count(*) from products 
where price >= 180

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
select name, price from products 
where price >= 180
order by price DESC

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
select * from products p
inner join manufacturers m on m.code = p.manufacturer

-- 1.11 Select the product name, price, and manufacturer name of all the products.
select p.name as ProductName, Price, m.name as ManufacturerName from products p
inner join manufacturers m on m.code = p.manufacturer

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
select manufacturer, avg(price) 
from products
group by manufacturer

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
select m.name as Manufacturer, avg(price) 
from products p
inner join manufacturers m on m.code = p.manufacturer
group by m.name

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
select m.name as Manufacturer, avg(price) 
from products p
inner join manufacturers m on m.code = p.manufacturer
group by m.name
having avg(price) >= 150

-- 1.15 Select the name and price of the cheapest product.
select name, price from products
where price = (select min(price) from products)

--MS SQL Solution
select top 1 name, price from products
order by price asc

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
select m.Name as Manufacturer, t2.name as product, MostExpensive
from (
select manufacturer, max(price) AS MostExpensive
from Products 
group by manufacturer) t1
LEFT JOIN 
(select name, manufacturer, price from products) t2
ON t1.manufacturer = t2.manufacturer 
and t1.MostExpensive = t2.price
inner join manufacturers m on t1.manufacturer = m.code

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO Products values (11, 'Loudspeakers', 70, 2)

-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE Products
SET Name = 'Laser Printer'
WHERE Code = 8

-- 1.19 Apply a 10% discount to all products.
UPDATE Products
SET Price = Price*0.9

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
UPDATE Products
SET Price = Price*0.9
WHERE Price >= 120
