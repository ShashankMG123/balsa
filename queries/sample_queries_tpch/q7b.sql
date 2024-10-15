-- using 1728955333 as a seed to the RNG


select
	shipping.supp_nation,
	shipping.cust_nation,
	shipping.l_year,
	sum(shipping.volume) as revenue
from
	(
		select
			n1.n_name as supp_nation,
			n2.n_name as cust_nation,
			extract(year from l.l_shipdate) as l_year,
			l.l_extendedprice * (1 - l.l_discount) as volume
		from
			supplier as s,
			lineitem as l,
			orders as o,
			customer as c,
			nation n1,
			nation n2
		where
			s.s_suppkey = l.l_suppkey
			and o.o_orderkey = l.l_orderkey
			and c.c_custkey = o.o_custkey
			and s.s_nationkey = n1.n_nationkey
			and c.c_nationkey = n2.n_nationkey
			and (
				(n1.n_name = 'MOROCCO' and n2.n_name = 'JORDAN')
				or (n1.n_name = 'JORDAN' and n2.n_name = 'MOROCCO')
			)
			and l.l_shipdate between date '1995-01-01' and date '1996-12-31'
	) as shipping
group by
	shipping.supp_nation,
	shipping.cust_nation,
	shipping.l_year
order by
	shipping.supp_nation,
	shipping.cust_nation,
	shipping.l_year;

