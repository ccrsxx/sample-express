CREATE
OR REPLACE PROCEDURE withdraw (p_account_id BIGINT, p_amount NUMERIC(18, 2)) LANGUAGE plpgsql AS $$
DECLARE
    current_balance NUMERIC(18, 2);
BEGIN
    IF NOT EXISTS (SELECT 1 FROM accounts WHERE id = p_account_id) THEN
        RAISE EXCEPTION 'Account with ID % does not exist.', p_account_id;
    END IF;

    SELECT balance INTO current_balance
    FROM accounts
    WHERE id = p_account_id;

    IF current_balance < p_amount THEN
        RAISE EXCEPTION 'Insufficient funds. Current balance is %.', current_balance;
    END IF;

    UPDATE accounts
    SET balance = balance - p_amount
    WHERE id = p_account_id;

    INSERT INTO transactions (type, amount, account_id)
    VALUES ('WITHDRAW', -p_amount, p_account_id);

    RAISE NOTICE 'Withdrawn % from account %.', p_amount, p_account_id;
END;
$$;

-- Withdraw some money from the accounts
CALL withdraw (1, 500000);

CALL withdraw (3, 200000);

-- Check the account balance from each customer
SELECT
    c.name,
    c.address,
    sum(a.balance) AS total_balance
FROM
    accounts AS a
    JOIN customers AS c ON a.customer_id = c.id
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
    t.type = 'WITHDRAW';
