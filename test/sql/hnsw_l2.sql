SET enable_seqscan = off;

CREATE TABLE t (val vector(3));
INSERT INTO t (val) VALUES ('[0,0,0]'), ('[1,2,3]'), ('[1,1,1]'), (NULL);
CREATE INDEX ON t USING hnsw (val vector_l2_ops);

INSERT INTO t (val) VALUES ('[1,2,4]');

SELECT * FROM t ORDER BY val <-> '[3,3,3]';
-- this sql will convert to ‘order by ctid’ clause, but the result is not stable on MPP architecture.
-- SELECT * FROM t ORDER BY val <-> (SELECT NULL::vector);
SELECT * FROM t ORDER BY val;
SELECT COUNT(*) FROM t;

TRUNCATE t;
SELECT * FROM t ORDER BY val <-> '[3,3,3]';

DROP TABLE t;
