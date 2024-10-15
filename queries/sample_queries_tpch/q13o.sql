-- using 1728955147 as a seed to the RNG


select
	c_orders.c_count,
	count(*) as custdist
from
	(
		select
			c.c_custkey,
			count(o.o_orderkey) as c_count
		from
			customer as c left outer join orders as o on
				c.c_custkey = o.o_custkey
				and o.o_comment not like '%pending%packages%'
		group by
			c.c_custkey
	) as c_orders
group by
	c_orders.c_count
order by
	custdist desc,
	c_orders.c_count desc;
