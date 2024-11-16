import bcrypt from 'bcryptjs';
import * as superAdminRepo from './superAdminRepo.js';

export const registerAccount = async (accountData) => {
  accountData.password = await bcrypt.hash(accountData.password, 10);
  return superAdminRepo.createAccount(accountData);
};

export const editAccount = async (userId, updatedData) => {
  return superAdminRepo.updateAccount(userId, updatedData);
};

export const deleteAccount = async (userId) => {
  return superAdminRepo.deleteAccount(userId);
};


