SELECT * FROM customers
LIMIT 10;
SELECT * FROM orders
LIMIT 10;
SELECT * FROM books
LIMIT 10;

CREATE INDEX idx_last_name ON customers (last_name);

CREATE INDEX idx_customer_id ON orders (customer_id);

CREATE INDEX idx_book_id ON orders (book_id);

EXPLAIN ANALYZE
SELECT original_language, title, sales_in_millions
FROM books
WHERE original_language = 'French';

SELECT pg_size_pretty (pg_total_relation_size('books'));

CREATE INDEX idx_book_search ON books (original_language, title, sales_in_millions);

EXPLAIN ANALYZE
SELECT original_language, title, sales_in_millions
FROM books
WHERE original_language = 'French';

DROP INDEX IF EXISTS idx_book_search;

-- Before Bulk Load: Drop Indexes
DROP INDEX IF EXISTS idx_customer_id;
DROP INDEX IF EXISTS idx_book_id;
-- ... Repeat for other indexes ...

-- Capture timestamp before bulk load
SELECT clock_timestamp() AS start_timestamp;

-- Perform Bulk Load
\COPY orders FROM 'orders_add.txt' DELIMITER ',' CSV HEADER;

-- Capture timestamp after bulk load
SELECT clock_timestamp() AS end_timestamp;

-- After Bulk Load: Recreate Indexes
CREATE INDEX idx_customer_id ON orders (customer_id);
CREATE INDEX idx_book_id ON orders (book_id);
-- ... Repeat for other indexes ...

-- Capture timestamp after recreating indexes
SELECT clock_timestamp() AS recreate_end_timestamp;

CREATE INDEX idx_customer_contact ON customers (first_name, email_address);
 

 

 
