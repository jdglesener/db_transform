CREATE TABLE for_sale_json AS
SELECT raw_json['data']['home_search']['results']['0'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['1'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['2'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['3'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['4'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['5'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['6'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['7'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['8'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['9'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['10'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['11'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['12'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['13'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['14'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['15'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['16'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['17'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['18'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['19'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['20'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['21'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['22'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['23'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['24'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['25'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['26'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['27'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['28'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['29'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['30'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['31'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['32'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['33'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['34'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['35'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['36'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['37'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['38'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['39'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['40'] AS house FROM for_sale
UNION ALL
SELECT raw_json['data']['home_search']['results']['41'] AS house FROM for_sale
;

INSERT INTO for_sale_editing
SELECT * from for_sale;

INSERT INTO for_sale_clean
	SELECT
	(house['description']['beds']::int) AS beds,
  CASE
  	WHEN (house['description']['baths']) = 'null' THEN null
   	ELSE (house['description']['baths']::int) 
  END AS baths,
  CASE
    WHEN house['description']['stories'] = 'null' THEN null
    ELSE (house['description']['stories']::text)::int
  END AS stories,
  CASE
    WHEN house['description']['garage'] = 'null' THEN null
    ELSE (house['description']['garage']::text)::int
  END AS garage,
  (house['description']['type']::text) AS type,
  CASE
  	WHEN house['description']['year_built'] = 'null' THEN null
  	ELSE (house['description']['year_built']::int) 
  END AS year_built,
  CASE
  	WHEN house['description']['sqft'] = 'null' THEN null
    ELSE (house['description']['sqft']::int) 
    END AS sqft,
  (house['description']['lot_sqft']::text) AS lot_sqft,
  (house['list_date']::text)::date AS list_date,
  (house['status']::text) AS sale_status,
  CASE
  	WHEN (house['list_price']) = 'null' THEN null
    ELSE (house['list_price']::int)
  END AS list_price,
  (house['property_id']::text) AS property_id,
  (house['location']['address']['coordinate']['lon']::float) AS longitude,
  (house['location']['address']['coordinate']['lat']::float) AS latitude,
  (house['location']['address']['state_code']::text) AS state,
  (house['location']['address']['city']::text) AS city,
  (house['location']['address']['line']::text) AS address,
  (house['location']['address']['postal_code']::text) AS zip
FROM for_sale_json
ON CONFLICT (property_id, address) DO NOTHING
;
DROP TABLE for_sale_json;
DELETE FROM for_sale;
