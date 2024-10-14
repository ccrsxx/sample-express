CREATE
OR REPLACE PROCEDURE get_balance (p_account_id BIGINT) LANGUAGE plpgsql AS $$
DECLARE
    account_balance NUMERIC(18, 2);
BEGIN
    IF NOT EXISTS (SELECT 1 FROM accounts WHERE id = p_account_id) THEN
        RAISE EXCEPTION 'Account with ID % does not exist', p_account_id;
    END IF;

    SELECT balance INTO account_balance
    FROM accounts
    WHERE id = p_account_id;

    RAISE NOTICE 'Balance for account ID % is: %', p_account_id, account_balance;
END;
$$;

-- Get the balance based on the account ID
CALL get_balance (1);

CALL get_balance (3);

-- Get the balance based on the account ID manually
SELECT
    balance
FROM
    accounts
WHERE
    id = 1;

SELECT
    balance
FROM
    accounts
WHERE
    id = 3;
