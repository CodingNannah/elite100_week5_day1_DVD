-- #1 How many actors with the last name "Wahlberg"?
SELECT COUNT(last_name)
FROM actor
WHERE last_name = 'Wahlberg';

-- *** ANSWER: 2 ***



-- #2 How many payments made between $3.99 and $5.99?
-- (interpreted as not inclusive):

SELECT COUNT(customer_id)
FROM payment
WHERE amount > '3.99' AND amount < '5.99';

-- *** ANSWER: 3,431 ***


-- (interpreted as inclusive):

SELECT COUNT(customer_id)
FROM payment
WHERE amount BETWEEN '3.99' AND '5.99';

-- *** ANSWER: 5,607 ***



-- #3 What film does the store have most of? Hint: search inventory

-- Was: have exactly 7 copies? 
-- Checking to see what column I need:

SELECT* 
FROM inventory;

SELECT inventory_id, film_id
FROM inventory
WHERE inventory_id = 7;
-- ANSWER: 1 film "Academy Dinosaur"

-- What film does the store have most of?

SELECT inventory_id, film_id
FROM inventory
WHERE inventory_id > 8
GROUP BY inventory_id
ORDER BY COUNT(inventory_id) DESC
-- Answer top inventory_id 1489 & film_id 326: 
SELECT film_id, title
FROM film
WHERE film_id = 326

-- *** ANSWER: The film is "Flying Hook".



-- #4 How many customers have the last name "William"?

-- Was: How many cusotmers have the first name "Willie"? 

SELECT COUNT(first_name)
FROM customer
WHERE first_name = 'Willie';
-- ANSWER: 2 
-- Curious: Who are they?
SELECT first_name, last_name
FROM customer
WHERE first_name = 'Willie';
-- ANSWER: Willie Howell and Willie Markham

-- How many customers have the last name "William"?

SELECT COUNT(last_name), first_name
FROM customer
WHERE last_name = "William";

-- *** ANSWER: None. Column "William" does not exist.***



-- #5 What store employee (get id) sold the most rentals (use rental table)?
-- Seeing the entire list first:

SELECT first_name, last_name
FROM staff;
-- Only two employees: Mike Hillyer and Jon Stephens	
-- Another way of saying this: Who is the top salesman, counting the most rentals?
SELECT COUNT(rental_id), staff_id
FROM rental
GROUP BY staff_id
ORDER BY COUNT(rental_id) DESC;

-- *** ANSWER:  ID 1 = Mike Hillyer sold the most at 8,040  ***




-- #6 How many unique district names are there? (in address table)?
-- Info gather first:

SELECT district
FROM address;
-- found DISTINCT in .txt file for class
SELECT COUNT(DISTINCT district)
FROM address;

-- *** ANSWER: 378 ***




-- #7 What film has most actors in it? (use film_actor table & get film_id)

SELECT film_id, COUNT(*)
FROM film_actor
GROUP BY film_id
ORDER BY COUNT(actor_id) DESC;

-- *** ANSWER: The film #508 "Lambs Cincinatti" has the most actors at 15.***



-- #8 From store_id 1 How many customers have a last name ending with 'es? (use customer table)
-- Challenge: how IN Alpha ORDER?

SELECT COUNT(customer_id)
FROM customer 
WHERE store_id = 1 AND last_name LIKE '%es'		
ORDER BY last_name; 

-- *** ANSWER: 13 ***



-- #9 How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers with ids between 380 and 430? 
-- Note to self: use GROUP BY and HAVING > 250 + which payment amounts, when counted, which are above 250 rentals and between the customers 380 & 430 have the most

SELECT amount, COUNT(amount)
FROM payment
WHERE customer_id BETWEEN 380 AND 430 
GROUP BY amount
HAVING COUNT(amount) > 250

-- *** ANSWER: 3 payment amounts of 0.99, 2.99, and 4.99.
	

	
-- #10 (Part A) Within the film table, how many rating categories are there? 
SELECT COUNT(DISTINCT rating)
FROM film;

-- *** ANSWER: 5 ratings categories***

-- #10 (Part B) What rating has the most movies total?
-- IN other words, which rating when counted has the most?

SELECT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY COUNT(rating);

-- *** ANSWER: PG-13 has the most at 223 ***