**#Question 1**



**Can you get all data about movies?**



SELECT \* 

FROM movies;





**#Question 2**



**How do you get all data about directors?**



SELECT \* 

FROM directors;





**#Question 3**



**Check how many movies are in IMDb.**



SELECT COUNT(\*) AS total\_movies 

FROM movies;





**#Question 4**



**Find these 3 directors: James Cameron, Luc Besson, John Woo.**



SELECT \* 

FROM directors

WHERE name IN ('James Cameron', 'Luc Besson', 'John Woo');





**#Question 5**



**Find all directors with name starting with Steven.**



SELECT \* 

FROM directors

WHERE name LIKE 'Steven%';



**#Question 6**



**Count female directors (gender = 1).**



SELECT COUNT(\*) AS female\_directors

FROM directors

WHERE gender = 1;



**#Question 7**



**Find the name of the 10 first women directors.**



SELECT name 

FROM directors

WHERE gender = 1

ORDER BY name

LIMIT 10;



**#Question 8**



**What are the 3 most popular movies?**



SELECT title, popularity

FROM movies

ORDER BY popularity DESC

LIMIT 3;



**#Question 9**



**What are the 3 most bankable movies (with the highest revenue)?**



SELECT title, revenue

FROM movies

ORDER BY revenue DESC

LIMIT 3;



**#Question 10**



**What is the most awarded average vote since January 1, 2000?**



SELECT strftime('%Y', release\_date) AS year, 

&nbsp;      AVG(vote\_average) AS avg\_vote

FROM movies

WHERE release\_date >= '2000-01-01'

GROUP BY year

ORDER BY avg\_vote DESC

LIMIT 1;



**#Question 11**



**Which movie(s) were directed by Brenda Chapman?**



SELECT m.title

FROM movies m

JOIN directors d ON m.director\_id = d.id

WHERE d.name = 'Brenda Chapman';



**#Question 12**



**Which director made the most movies?**



SELECT d.name, COUNT(m.id) AS total\_movies

FROM directors d

JOIN movies m ON m.director\_id = d.id

GROUP BY d.name

ORDER BY total\_movies DESC

LIMIT 1;



**#Question 13**



**Which director is the most bankable (highest total revenue)?**



SELECT d.name, SUM(m.revenue) AS total\_revenue

FROM directors d

JOIN movies m ON m.director\_id = d.id

GROUP BY d.name

ORDER BY total\_revenue DESC

LIMIT 1;

