/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

with bacall_n1 as (
    select distinct actor_id, film_id
    from film_actor
    join actor using(actor_id)
    where film_id in (
        select film_id
        from film_actor
        join actor using(actor_id)
        where first_name || ' ' || last_name='RUSSELL BACALL'
    )
    order by actor_id
),
actor_ids_n2 as (
    select fat.actor_id
    from film_actor as fat
    join bacall_n1 as b1t using(film_id) 
    where fat.actor_id!=b1t.actor_id
)
select distinct(first_name || ' ' || last_name) as "Actor Name"
from actor
join actor_ids_n2 using(actor_id)
order by "Actor Name";
