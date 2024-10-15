-- using 1728955332 as a seed to the RNG


select
	l_orderkey,
	sum(l_extendedprice * (1 - l_discount)) as revenue,
	o_orderdate,
	o_shippriority
from
	customer as c,
	orders as o,
	lineitem as l
where
	c.c_mktsegment = 'AUTOMOBILE'
	and c.c_custkey = o.o_custkey
	and l.l_orderkey = o.o_orderkey
	and o.o_orderdate < date '1995-03-26'
	and l.l_shipdate > date '1995-03-26'
group by
	l.l_orderkey,
	o.o_orderdate,
	o.o_shippriority
order by
	revenue desc,
	o.o_orderdate;

