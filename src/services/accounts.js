import { client } from '../lib/pg.js';

export class BankAccount {
  constructor() {
    this.balance = 0;
  }

  /**
   * @param {string} accountId
   * @returns {Promise<number>}
   */
  async getCurrentBalance(accountId) {
    const query = `SELECT balance FROM accounts WHERE id = $1`;

    const data = await client.query(query, [accountId]);

    const balance = data.rows[0].balance;

    return balance;
  }

  /** @returns {Promise<void>} */
  resetBalance() {
    return new Promise((resolve) =>
      setTimeout(() => {
        this.balance = 0;
        resolve();
      }, 500)
    );
  }

  /**
   * @param {number} amount
   * @returns {Promise<void>}
   */
  deposit(amount) {
    return new Promise((resolve) =>
      setTimeout(() => {
        this.balance += amount;
        resolve();
      }, 500)
    );
  }

  /**
   * @param {number} amount
   * @returns {Promise<void>}
   */
  withdraw(amount) {
    return new Promise((resolve, reject) =>
      setTimeout(() => {
        if (this.balance < amount) {
          reject(new InsufficientBalanceError());
          return;
        }

        this.balance -= amount;

        resolve();
      }, 500)
    );
  }
}

export class InsufficientBalanceError extends Error {
  constructor() {
    super('Insufficient balance');
  }
}
