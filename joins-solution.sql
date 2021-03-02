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