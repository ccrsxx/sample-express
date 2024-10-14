DO $$
BEGIN
    -- if table already has 1 million records, skip seeding
    IF (SELECT COUNT(*) FROM transactions) >= 1000000 THEN
        RAISE NOTICE 'Transactions table already has 1 million records. Skipping seeding.';
        RETURN;
    END IF;

    INSERT INTO transactions (type, amount, account_id)
    SELECT 
        CASE 
            WHEN random() < 0.5 THEN 'WITHDRAW'
            ELSE 'DEPOSIT'
        END,
    
        -- Random amount between 1,000,000 and 10,000,000
        trunc(1000000 + random() * (10000000 - 1000000))::NUMERIC(18, 2),    
        -- Random account_id between 1 and 4
        trunc(1 + random() * 3)::BIGINT

    FROM generate_series(1, 1000000);

    RAISE NOTICE 'Seeded 1 million records into transactions table.';
END;
$$;

-- These tests are run on PC with AMD Ryzen 5 7600X and 32 GB of RAM, so the results may vary
-- Uncomment either the below DDL command without index or with index to test the performance

-- Testing without index
-- The average speed of the query without index is 43 ms based on the average of 10 sample runs
-- DROP INDEX IF EXISTS idx_transactions_type_amount_account_id;

-- Testing with indexes
-- The average speed of the query with index is 10 ms based on the average of 10 sample runs
-- CREATE INDEX IF NOT EXISTS idx_transactions_type_amount_account_id ON transactions (type, amount, account_id);

-- Perform the query where the type is 'DEPOSIT', amount is greater than 9,000,000, and account_id is 1
EXPLAIN
ANALYZE
SELECT
    *
FROM
    transactions
WHERE
    type = 'DEPOSIT'
    AND amount > 9000000
    AND account_id = 1;
