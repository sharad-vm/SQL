--Q1. Find the names of all reviewers who rated Gone with the Wind. 
SELECT DISTINCT name 
  FROM Movie m 
  JOIN Rating r on m.mID=r.mID
  JOIN Reviewer re on r.rID=re.rID
 WHERE title = 'Gone with the Wind'
 
 --Q2. For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.
 SELECT name, title, stars
  FROM Movie m
  JOIN rating r ON m.mID=r.mID
  JOIN Reviewer re ON r.rID=re.rID
 WHERE director = name
 
 --Q3. Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".) 
 SELECT *
  FROM (
SELECT DISTINCT name AS Name
  FROM Reviewer
UNION
SELECT DISTINCT title AS Name
  FROM Movie
  )
ORDER BY Name

--Q4. Find the titles of all movies not reviewed by Chris Jackson. 
SELECT DISTINCT title 
  FROM Movie m
 WHERE title NOT IN (
SELECT DISTINCT title 
  FROM Movie m
  JOIN Rating r ON m.mID=r.mID
  JOIN Reviewer re ON r.rID=re.rID
WHERE name = 'Chris Jackson'
 )
 
 --Q5. For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order. 
 SELECT DISTINCT re1.name AS Reviewer1, re2.name as Reviewer2
  FROM Rating r1
  JOIN Reviewer re1 on r1.rID=re1.rID
  JOIN Rating r2 on r1.mID = r2.mID
  JOIN Reviewer re2 on r2.rID=re2.rID
 WHERE re1.name != re2.name and re1.name < re2.name
 
 --Q6. For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars. 
 SELECT name AS Reviewer, title, stars
 FROM Movie m 
 JOIN Rating r ON m.mID=r.mID
 JOIN Reviewer re ON r.rID=re.rID
WHERE stars = (SELECT MIN(stars) FROM rating)

--Q7. List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order. 
SELECT title, AVG(stars) AS AverageRatings
 FROM Movie m 
 JOIN Rating r ON m.mID=r.mID
GROUP BY title
ORDER BY AverageRatings DESC, title

--Q8. Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.)
SELECT name
 FROM Movie m 
 JOIN Rating r on m.mID=r.mID
 JOIN Reviewer re on r.rID=re.rID
GROUP BY name
HAVING COUNT(*) > 2

--Q9. Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.) 
SELECT title, director
FROM Movie 
WHERE director IN (
SELECT director
 FROM Movie
GROUP BY director
HAVING COUNT(*) > 1
)
ORDER BY director, title

--Q10. Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.) 
SELECT title, AVG(stars) AS AverageRating
 FROM Movie m
 JOIN Rating r on m.mID=r.mID
GROUP BY title
ORDER BY AverageRating DESC
LIMIT 1

--Q11. Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.) 
SELECT title, AVG(stars)
FROM Movie m
JOIN Rating r on m.mID=r.mID
GROUP BY title
HAVING AVG(stars) = 
(SELECT MIN(AverageRating) 
FROM (
SELECT title, AVG(stars) AS AverageRating
 FROM Movie m
 JOIN Rating r on m.mID=r.mID
GROUP BY title
))

--Q12. For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL. 
SELECT DISTINCT director, title, stars
 FROM Movie m1 
 JOIN Rating r on m1.mID=r.mID
WHERE director IS NOT NULL
AND stars IN (
                SELECT MAX(stars)
                  FROM Movie m2
                  JOIN Rating r on m2.mID=r.mID
                  WHERE director IS NOT NULL
                  AND m1.director = m2.director
              )
              
