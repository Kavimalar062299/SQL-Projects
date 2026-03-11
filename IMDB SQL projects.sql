#question 1
#can you get all data about movies?
select *
from movies;

#question 2
#how do you get all data about directors?
select *
from directors;

#question 3
#check how many movies are in imdb.
select count(*) as total_movies
from movies;

#question 4
#find these 3 directors: james cameron, luc besson, john woo.
select *
from directors
where name in ('James Cameron', 'Luc Besson', 'John Woo');

#question 5
#find all directors with name starting with steven.
select *
from directors
where name like 'Steven%';

#question 6
#count female directors (gender = 1).
select count(*) as female_directors
from directors
where gender = 1;

#question 7
#find the name of the 10 first women directors.
select name
from directors
where gender = 1
order by name
limit 10;

#question 8
#what are the 3 most popular movies?
select title, popularity
from movies
order by popularity desc
limit 3;

#question 9
#what are the 3 most bankable movies (with the highest revenue)?
select title, revenue
from movies
order by revenue desc
limit 3;

#question 10
#what is the most awarded average vote since january 1, 2000?
select strftime('%Y', release_date) as year,
       avg(vote_average) as avg_vote
from movies
where release_date >= '2000-01-01'
group by year
order by avg_vote desc
limit 1;

#question 11
#which movie(s) were directed by brenda chapman?
select m.title
from movies m
join directors d on m.director_id = d.id
where d.name = 'Brenda Chapman';

#question 12
#which director made the most movies?
select d.name, count(m.id) as total_movies
from directors d
join movies m on m.director_id = d.id
group by d.name
order by total_movies desc
limit 1;

#question 13
#which director is the most bankable (highest total revenue)?
select d.name, sum(m.revenue) as total_revenue
from directors d
join movies m on m.director_id = d.id
group by d.name
order by total_revenue desc
limit 1;