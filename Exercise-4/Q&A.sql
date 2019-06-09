-- https://en.wikibooks.org/wiki/SQL_Exercises/Movie_theatres
-- 4.1 Select the title of all movies.
select * from movies

-- 4.2 Show all the distinct ratings in the database.
select distinct rating from movies

select rating from movies
group by rating

-- 4.3  Show all unrated movies.
select * from movies
where rating is null

-- 4.4 Select all movie theaters that are not currently showing a movie.
select * from movietheaters
where Movie is null

-- 4.5 Select all data from all movie theaters 
    -- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
select * from movietheaters t
left join movies m on t.Movie=m.Code

-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
select * from movietheaters t
right join movies m on t.Movie=m.Code

-- 4.7 Show the titles of movies not currently being shown in any theaters.
select m.Title from movietheaters t
right join movies m on t.Movie=m.Code
where t.code is null

-- 4.8 Add the unrated movie "One, Two, Three".
INSERT INTO Movies values (9,'One, Two, Three',NULL)

-- 4.9 Set the rating of all unrated movies to "G".
UPDATE Movies
SET Rating = 'G'
WHERE Rating is null

-- 4.10 Remove movie theaters projecting movies rated "NC-17".
DELETE from Movies
where Rating = 'NC-17'
