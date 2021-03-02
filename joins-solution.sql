-- 1. Get all customers and their addresses.
SELECT
	"customers".first_name,
	"customers".last_name,
	"addresses".street,
	"addresses".city,
	"addresses".state,
	"addresses".zip,
	"addresses".address_type
FROM "customers"
JOIN "addresses" on "addresses".customer_id = "customers".id;


-- 2. Get all orders and their line items (orders, quantity and product).
SELECT
	"orders".order_date,
	"products".description,
	"line_items".quantity
FROM "orders"
JOIN "line_items" ON "line_items".order_id = "orders".id
JOIN "products" ON "products".id = "line_items".product_id;


-- 3. Which warehouses have cheetos?
SELECT
	"warehouse".warehouse,
	"products".description
FROM "warehouse"
JOIN "warehouse_product" ON "warehouse_product".warehouse_id = "warehouse".id
JOIN "products" ON "products".id = "warehouse_product".product_id
WHERE "products".description = 'cheetos'
ORDER BY "warehouse".id ASC;


-- 4. Which warehouses have diet pepsi?
SELECT
	"warehouse".warehouse,
	"products".description
FROM "warehouse"
JOIN "warehouse_product" ON "warehouse_product".warehouse_id = "warehouse".id
JOIN "products" ON "products".id = "warehouse_product".product_id
WHERE "products".description = 'diet pepsi'
ORDER BY "warehouse".id ASC;


-- 5. Get the number of orders for each customer.
SELECT
	"customers".first_name,
	count("orders".id)
FROM "customers"
JOIN "addresses" ON "addresses".customer_id = "customers".id
JOIN "orders" ON "orders".address_id = "addresses".id
GROUP BY "customers".first_name 
ORDER BY "customers".first_name ASC;


-- 6. How many customers do we have?
SELECT count("customers".id) as "total_number_customers" FROM "customers";


-- 7. How many products do we carry?
SELECT count("products".id) as "total_number_products" from "products";


-- 8. What is the total available on-hand quanitity of diet pepsi?
SELECT
	"products".description,
	SUM("warehouse_product".on_hand) as "total_on_hand"
FROM "products"
JOIN "warehouse_product" ON "warehouse_product".product_id = "products".id
WHERE "products".description = 'diet pepsi'
GROUP BY "products".description;


--- 9. How much was the total cost for each order?
SELECT
	"orders".order_date,
	SUM("line_items".quantity * "products".unit_price) as "total_order_cost"
FROM "orders"
JOIN "line_items" ON "line_items".order_id = "orders".id
JOIN "products" ON "products".id = "line_items".product_id
GROUP BY "orders".id
ORDER BY "orders".id ASC;


--- 10. How much has each customer spent in total?
SELECT
	"customers".first_name,
	SUM("line_items".quantity * "products".unit_price) as "total_customer_cost"
FROM "customers"
JOIN "addresses" ON "addresses".customer_id = "customers".id
JOIN "orders" ON "orders".address_id = "addresses".id
JOIN "line_items" ON "line_items".order_id = "orders".id
JOIN "products" ON "products".id = "line_items".product_id
GROUP BY "customers".first_name
ORDER BY "total_customer_cost" DESC;


--- 11. How much has each customer spent in total? (not NULL)