/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

with bacall_n1 as (
    select distinct(first_name || ' ' || last_name) as "actor_name", film_id
    from film
    join film_actor using(film_id)
    join actor using(actor_id)
    where film_id in (
        select film_id
        from film_actor
        join actor using(actor_id)
        where first_name || ' ' || last_name='RUSSELL BACALL'
    ) and first_name || ' ' || last_name!='RUSSELL BACALL'
    order by "actor_name"
)

select distinct(first_name || ' ' || last_name) as "Actor Name"
from film_actor as fa
join actor as a1 using(actor_id)
join bacall_n1 as b1 using(film_id)
where  a1.first_name || ' ' || a1.last_name != b1.actor_name
order by "Actor Name";
