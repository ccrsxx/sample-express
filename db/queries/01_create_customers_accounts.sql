-- Seed the customers and accounts tables with some data
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM customers) THEN
        RAISE NOTICE 'Customers table is not empty. Skipping seeding.';
    ELSE
        INSERT INTO customers (name, address) VALUES
            ('Emilia', 'Tokyo'),
            ('Rem', 'Osaka');
    END IF;

    IF EXISTS (SELECT 1 FROM accounts) THEN
        RAISE NOTICE 'Accounts table is not empty. Skipping seeding.';
    ELSE
        INSERT INTO accounts (customer_id) VALUES
            (1),
            (1),
            (2),
            (2);
    END IF;
END;
$$;
