/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */

with in_children as (
    select first_name, last_name
    from category
    join film_category using(category_id)
    join film_actor using(film_id)
    join actor using(actor_id)
    where category.name='Children'
    group by first_name, last_name
    having count(*) >= 1
), in_horror as (
    select first_name, last_name
    from category
    join film_category using(category_id)
    join film_actor using(film_id)
    join actor using(actor_id)
    where category.name='Horror'
    group by first_name, last_name
    having count(*) >= 1 
)

select *
from in_children
left join in_horror using(first_name, last_name)
where in_horror.first_name is null and in_horror.last_name is null
order by last_name, first_name;
