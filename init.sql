CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    product_name TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO orders (product_name, quantity, order_date) VALUES
('Laptop', 2, '2024-05-01');
