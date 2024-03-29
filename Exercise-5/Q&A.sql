-- https://en.wikibooks.org/wiki/SQL_Exercises/Pieces_and_providers
-- 5.1 Select the name of all the pieces. 
select Name from Pieces

-- 5.2  Select all the providers' data. 
select * from Providers

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
select Piece, avg(Price) as AvgPrice from Provides
group by Piece

-- 5.4  Obtain the names of all providers who supply piece 1.
select Name from Providers prd
join provides prs on prd.code=prs.provider
where prs.piece = 1

-- 5.5 Select the name of pieces provided by provider with code "HAL".
select p.Name from Providers prd
join provides prs on prd.code=prs.provider
join pieces p on prs.Piece=p.Code
where prd.code = 'HAL'

-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------
select t2.* from 
(
select Piece, MAX(Price) AS HighestPrice from Provides
group by Piece) t1
JOIN 
(select p.code, p.Name AS PieceName, prd.Name as ProviderName, prs.Price
from Pieces p 
 JOIN Provides prs on p.Code = prs.Piece
 JOIN Providers prd on prs.Provider = prd.Code) t2
 ON t1.Piece = t2.Code and t1.HighestPrice = t2.Price
 
-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
INSERT INTO Provides(Piece, Provider, Price) values (1, 'TNBC', 7)

-- 5.8 Increase all prices by one cent.
UPDATE Provides
SET Price = Price + 0.01

-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
DELETE FROM Provides 
WHERE provider = 'RBT' AND Piece = 4

-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).
