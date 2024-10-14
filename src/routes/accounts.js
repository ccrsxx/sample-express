import { Router } from 'express';
import { BankAccount } from '../services/accounts.js';
import express from 'express';

/** @param {express.Application} app */
export default (app) => {
  const router = Router();

  const bankAccount = new BankAccount();

  app.use('/accounts', router);

  router.get('/', async (req, res) => {});

  router.get('/:id', async (req, res) => {
    const id = req.params.id;

    const balance = await bankAccount.getCurrentBalance(id);

    console.log({ balance });

    res.status(200).json({
      balance
    });
  });

  router.put('/:id/deposit', async (req, res) => {});

  router.put('/:id/withdraw', async (req, res) => {});
};
