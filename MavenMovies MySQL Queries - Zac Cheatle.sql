
# Methodology-  I have created 5 custom tables from the database below, 4 lookup tables and 1 payments table and exported them individually as CSV files into Power Query. 

    
    
USE mavenmovies;

# Product lookup query: contains product description data
SELECT
	film.film_id as product_id,
    inventory.inventory_id,
    inventory.store_id,
    rental.rental_id as transaction_id,
    film.title as film_title,
    film.description as film_description,
    film.special_features,
    category.name as film_category,
    language.name as film_language,
    film.rating as rating,
    film.length as length_of_film,
    film.rental_duration as number_of_days_rented,
    film.rental_rate,
    film.replacement_cost
FROM film
	LEFT JOIN inventory
		on film.film_id = inventory.film_id
	LEFT JOIN language
		on film.language_id = language.language_id
	LEFT JOIN rental
		on inventory.inventory_id = rental.inventory_id
	LEFT JOIN film_category
		on film.film_id = film_category.film_id
	LEFT JOIN category
		on film_category.category_id = category.category_id
GROUP BY
	film.film_id;
    
    
    
# Customer Lookup Query: contains customer description data
 SELECT 
	customer.customer_id,
	customer.active,
	customer.store_id,
    rental.rental_id as transaction_id,
    customer.first_name,
    customer.last_name,
    customer.create_date as account_creation_date,
    customer.email as email_address,
    address.address as street_address,
    address.district,
    city.city,
    country.country
FROM customer
LEFT JOIN rental
	on customer.customer_id = rental.customer_id
LEFT JOIN address
	on customer.address_id = address.address_id
LEFT JOIN city
	on address.city_id = city.city_id
LEFT JOIN country
	on city.country_id = country.country_id
GROUP BY customer_id;


# Staff Lookup table: contains staff desctiption data

SELECT 
	staff_id,
    store_id,
    active,
    first_name,
    last_name,
    email as email_address
FROM staff;
	

# Rental Lookup Table; contains film rental data
SELECT *
FROM rental;


# Payment/Transaction Table: contains all payment data 
SELECT
	film.film_id as product_id,
    payment.rental_id as transaction_id,
	payment.payment_id,
    payment.customer_id,
    payment.staff_id, 
    payment.amount as revenue,
    payment.payment_date
FROM payment
	LEFT JOIN rental
		on payment.rental_id = rental.rental_id
	LEFT JOIN inventory
		on rental.inventory_id = inventory.inventory_id
	LEFT JOIN film
		on inventory.film_id = film.film_id;