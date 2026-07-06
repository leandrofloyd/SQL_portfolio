-- Loading the data from CSV to the SQL tables.
-- Run these commands from psql after creating the tables.
-- If you decide to run the script from sql_tables, do not forget to adjust the paths.

\copy customers FROM 'data/customers.csv' WITH CSV HEADER;
\copy products FROM 'data/products.csv' WITH CSV HEADER;
\copy orders FROM 'data/orders.csv' WITH CSV HEADER;
\copy order_items FROM 'data/order_items.csv' WITH CSV HEADER;
