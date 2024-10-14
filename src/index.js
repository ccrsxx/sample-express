import express from 'express';
import accounts from './routes/accounts.js';
import { createServer } from 'http';

async function main() {
  const app = express();
  const server = createServer(app);

  accounts(app);

  server.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
  });
}

main();
