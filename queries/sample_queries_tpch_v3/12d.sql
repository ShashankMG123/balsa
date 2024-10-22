SELECT
    l.l_shipmode,
    SUM(CASE
        WHEN o.o_orderpriority = '5-LOW'
            OR o.o_orderpriority = '3-MEDIUM'
            THEN 1
        ELSE 0
    END) AS high_line_count,
    SUM(CASE
        WHEN o.o_orderpriority <> '5-LOW'
            AND o.o_orderpriority <> '3-MEDIUM'
            THEN 1
        ELSE 0
    END) AS low_line_count
FROM
    orders AS o,
    lineitem AS l
WHERE
    o.o_orderkey = l.l_orderkey
    AND l.l_shipmode IN ('RAIL', 'AIR')
    AND l.l_commitdate < l.l_receiptdate
    AND l.l_shipdate < l.l_commitdate
    AND l.l_receiptdate >= DATE '1994-01-01'
    AND l.l_receiptdate < DATE '1994-01-01' + INTERVAL '3' YEAR
GROUP BY
    l.l_shipmode
ORDER BY
    l.l_shipmode;
