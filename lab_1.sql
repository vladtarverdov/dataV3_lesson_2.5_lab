-- lab 1 morning
use sakila;
-- 1. Select all the actors with the first name ‘Scarlett’.
select * from actor
where first_name = 'SCARLETT';

-- 2. How many films (movies) are available for rent and how many films have been rented?
select count(film_id) as count_movies_available from film;
select distinct(count(film_id)) as count_rented_movies from inventory;

-- 3.What are the shortest and longest movie duration? Name the values max_duration and min_duration.
-- 3.1 select min(length) as shortest_movie, max(length) as long_movie from film;
-- 3.2 select min(cast(length as time) / 60) as min_duration,
	   max(cast(length as time) / 60) as max_duration from film;

       
-- 4.What's the average movie duration expressed in format (hours, minutes)?
SELECT FLOOR(AVG(length) / 60) as Hours, (FLOOR(AVG(length)) % 60) as Minutes
FROM sakila.film;

-- 5. How many distinct (different) actors' last names are there?
select count(distinct(last_name)) from actor;

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?
select DATEDIFF(max(rental_date),min(rental_date)) from rental;

-- 7. Show rental info with additional columns month and weekday. Get 20 results.
select * from rental;
select *, dayofweek(rental_date), monthname(rental_date)
from rental
limit 20;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
select * from rental;
select *, dayofweek(rental_date), monthname(rental_date),
case
	when dayofweek(rental_date) = 1 then "weekend"
    when dayofweek(rental_date) = 7 then "weekend"
    else "weekday"
end as "day of the week"
from rental;

-- 9. How many rentals were in the last month of activity?
select max(rental_date), date_sub(max(rental_date), interval 1 month) from rental;

select COUNT(rental_date)
from rental
where month(rental_date) = (select month(max(rental_date)) from rental);
