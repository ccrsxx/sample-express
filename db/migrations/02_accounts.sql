-- Create table
CREATE TABLE IF NOT EXISTS accounts (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    balance NUMERIC(18, 2) NOT NULL DEFAULT 0,
    customer_id BIGINT NOT NULL REFERENCES customers (id)
);

-- Alternative foreign key with ALTER TABLE
-- Remove the foreign key constraint on the customer_id column to use this
-- ALTER TABLE accounts
-- ADD CONSTRAINT fk_accounts_customer_id FOREIGN KEY (customer_id) REFERENCES customers (id);

-- Drop table
-- DROP TABLE IF EXISTS accounts;
