CREATE
OR REPLACE PROCEDURE deposit (p_account_id BIGINT, p_amount NUMERIC(18, 2)) LANGUAGE plpgsql AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM accounts WHERE id = p_account_id) THEN
        RAISE EXCEPTION 'Account with id % not found', p_account_id;
    END IF;

    Update accounts
    SET balance = balance + p_amount
    WHERE id = p_account_id;

    INSERT INTO transactions (type, amount, account_id)
    VALUES ('DEPOSIT', p_amount, p_account_id);

    RAISE NOTICE 'Deposited % into account %', p_amount, p_account_id;
END;
$$;

-- Deposit some money into the accounts
CALL deposit (1, 1000000);

CALL deposit (3, 500000);

-- Check the account balance from each customer
SELECT
    c.name,
    c.address,
    sum(a.balance) AS total_balance
FROM
    accounts AS a
    JOIN customers as c ON a.customer_id = c.id
GROUP BY
    c.name,
    c.address;

-- Check the transaction history from each customer
SELECT
    c.name,
    t.type,
    t.amount
FROM
    transactions AS t
    JOIN accounts AS a ON t.account_id = a.id
    JOIN customers AS c ON a.customer_id = c.id
WHERE
    t.type = 'DEPOSIT';
