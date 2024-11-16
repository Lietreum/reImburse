import bcrypt from 'bcryptjs';
import * as accountRepo from './AccountRepo.js'

export const verifyAccount = async (username, password) => {
    const account = await accountRepo.getAccountByUsername(username);
    if (!account) return null;
  
    const isPasswordValid = await bcrypt.compare(password, account.password);
    if (!isPasswordValid) return null;
  
    return account;
  };