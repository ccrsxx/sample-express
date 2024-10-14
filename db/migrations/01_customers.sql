-- Create table
CREATE TABLE IF NOT EXISTS customers (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name TEXT NOT NULL,
    address TEXT NOT NULL
);

-- Drop table
-- DROP TABLE IF EXISTS customers;
