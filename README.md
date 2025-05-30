This project demonstrates how to set up logical replication between two PostgreSQL instances (pg_master and pg_replica) using Docker Compose. 

Technologies Used

Docker & Docker Compose
PostgreSQL 15
Logical Replication (Publication / Subscription)

Project Structure

sunny/
│
├── docker-compose.yml              # Sets up pg_master and pg_replica
├── master-init/
│   └── init.sql                    # Creates testDB, orders table, inserts sample data
├── master-config/
│   └── postgresql.conf             # Enables logical replication on pg_master
└── README.md

Setup Instructions

1. Clone and Navigate
   
git clone <your-repo-url>
cd sunny

2. Start PostgreSQL Instances
   
docker-compose up -d

This creates:
pg_master on port 5432
pg_replica on port 5433

3. Validate Master Setup

connect to pg_master:

docker exec -it pg_master psql -U postgres -d testDB

Verify that orders table exists and contains sample data:

SELECT * FROM orders;

4. Set Up Replication

On pg_master, run:

CREATE PUBLICATION orders_pub FOR TABLE orders;
On pg_replica, ensure the orders table exists:

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  product_name TEXT,
  quantity INT,
  order_date DATE
);

Then run the subscription:

CREATE SUBSCRIPTION orders_sub
CONNECTION 'host=pg_master port=5432 user=postgres password=password dbname=testDB'
PUBLICATION orders_pub;

Replication Test

Insert a row into pg_master:

INSERT INTO orders (product_name, quantity, order_date)
VALUES ('Monitor', 5, '2025-05-29');

Query from pg_replica:

SELECT * FROM orders;

You should see the new row replicated.


docker-compose down -v


