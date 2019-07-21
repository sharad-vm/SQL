--Q1. Find the titles of all movies directed by Steven Spielberg. 
select title 
from movie
where director = 'Steven Spielberg'

--Q2. Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. 
SELECT DISTINCT year
FROM  Movie m
JOIN Rating r 
ON m.mID = r.mID
WHERE (stars = 4 OR stars = 5)
ORDER BY year 

--Q3. Find the titles of all movies that have no ratings. 
SELECT title
FROM  Movie m
LEFT JOIN Rating r 
ON m.mID = r.mID
WHERE stars IS NULL

--Q4. Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date. 
SELECT name
 FROM Reviewer re
 JOIN Rating ra 
 ON re.rID=ra.rID
WHERE ratingDate IS NULL

--Q5. Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. 
SELECT name as ReviewerName, title as MoveTitle, stars, ratingDate
 FROM Movie m 
 JOIN Rating ra ON m.mID = ra.mID
 JOIN Reviewer re ON ra.rID = re.rID
ORDER BY name, title, stars

--Q6. For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.
 SELECT name, title
  FROM Movie m 
  JOIN (
        SELECT r1.rID, r1.mID
          FROM Rating r1
          JOIN Rating r2 ON r1.rID=r2.rID AND r1.mID = r2.mID
         WHERE r1.stars > r2.stars AND r1.ratingDate > r2.ratingDate
 ) r on r.mID = m.mID
  JOIN Reviewer re on r.rID=re.rID
  
--Q7. For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.
SELECT title, MAX(stars)
 FROM Movie m
 JOIN Rating r on m.mID = r.mID
GROUP BY title
ORDER BY title

--Q8. For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. 
SELECT title, MAX(stars) - MIN(stars) AS RatingSpread
  FROM Movie m 
  JOIN Rating r ON m.mID = r.mID
GROUP BY title
ORDER BY RatingSpread DESC

--Q9. 
Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.) 
SELECT AVG(EarlyAverages) - AVG(LateAverages)
 FROM  (
        SELECT AVG(stars) AS EarlyAverages, r.mID
          FROM Rating r
          JOIN Movie m ON m.mID = r.mID
         WHERE year < 1980
         GROUP BY r.mID
      ) e
 JOIN (
        SELECT AVG(stars) AS LateAverages, r.mID
          FROM Rating r
          JOIN Movie m ON m.mID = r.mID
         WHERE year > 1980
         GROUP BY r.mID
      ) l
