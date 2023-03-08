/*
 * Compute the country with the most customers in it. 
 */

with country_customers as (
    select country, count(customer_id) as "num_customers"
    from customer
    join address using(address_id)
    join city using(city_id)
    join country using(country_id)
    group by country
    order by "num_customers" desc
 )

select country
from country_customers
limit 1;
