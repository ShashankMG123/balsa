-- using 1728954974 as a seed to the RNG


select
	all_nations.o_year,
	sum(case
		when all_nations.nation = 'PERU' then all_nations.volume
		else 0
	end) / sum(all_nations.volume) as mkt_share
from
	(
		select
			extract(year from o.o_orderdate) as o_year,
			l.l_extendedprice * (1 - l.l_discount) as volume,
			n2.n_name as nation
		from
			part as p,
			supplier as s,
			lineitem as l,
			orders as o,
			customer as c,
			nation as n1,
			nation as n2,
			region as r
		where
			p.p_partkey = l.l_partkey
			and s.s_suppkey = l.l_suppkey
			and l.l_orderkey = o.o_orderkey
			and o.o_custkey = c.c_custkey
			and c.c_nationkey = n1.n_nationkey
			and n1.n_regionkey = r.r_regionkey
			and r.r_name = 'AMERICA'
			and s.s_nationkey = n2.n_nationkey
			and o.o_orderdate between date '1995-01-01' and date '1996-12-31'
			and p.p_type = 'LARGE PLATED COPPER'
	) as all_nations
group by
	all_nations.o_year
order by
	all_nations.o_year;

