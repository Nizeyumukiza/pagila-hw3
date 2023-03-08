/*
 * Compute the number of customers who live outside of the US.
 */

with t_usa as (
    select customer_id
    from customer
    join address using(address_id)
    join city using(city_id)
    join country using(country_id)
    where country='United States'
)

select count(*)
from customer
left join t_usa using(customer_id)
where t_usa.customer_id is null;
