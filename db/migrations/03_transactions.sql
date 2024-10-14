-- Create table
CREATE TABLE IF NOT EXISTS transactions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    type TEXT NOT NULL CHECK (type IN ('DEPOSIT', 'WITHDRAW')),
    amount NUMERIC(18, 2) NOT NULL,
    account_id BIGINT NOT NULL REFERENCES accounts (id)
);

-- Alternative foreign key with ALTER TABLE
-- Remove the foreign key constraint on the account_id column to use this
-- ALTER TABLE transactions
-- ADD CONSTRAINT fk_transactions_account_id FOREIGN KEY (account_id) REFERENCES accounts (id);

-- Drop table
-- DROP TABLE IF EXISTS transactions;
