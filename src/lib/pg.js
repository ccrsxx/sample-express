import pg from 'pg';

const { Client } = pg;

export const client = new Client({
  host: 'localhost',
  port: 5432,
  user: 'postgres',
  database: 'aminr',
  password: 'Emilia-tan'
});

await client.connect();
