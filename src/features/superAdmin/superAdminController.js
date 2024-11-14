
import bcrypt from 'bcryptjs';  // Correct import for bcryptjs
import jwt from 'jsonwebtoken';
import { updateAccount } from './superAdminRepo.js';
import * as superAdminService from './superAdminService.js';
import * as superAdminRepo from './superAdminRepo.js'

const { hash, compare } = bcrypt;

// Function to Register Account (Only SUPER_ADMIN)
export const createAccount = async (req, res) => {
  try {
    // if (req.user.roleName !== 'SUPER_ADMIN') {
    //   return res.status(403).json({ message: 'Access denied' });   Uncomment kalau sudah bikin super admin
    // }
    const { username, password, roleId, divisionName } = req.body;
    const hashedPassword = await hash(password, 10);

    const newAccount = await superAdminService.registerAccount(
      { username, password: hashedPassword, roleId, divisionName }
      // req.user.roleName
    );

    res.status(201).json(newAccount);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Function to Update Account (Only SUPER_ADMIN)
export const updateAccountHandler = async (req, res) => {
  try {
    if (req.user.roleName !== 'SUPER_ADMIN') {
      return res.status(403).json({ message: 'Access denied' });
    }

    const { userId } = req.params;
    const updatedData = req.body;

    if (updatedData.password) {
      updatedData.password = await hash(updatedData.password, 10);
    }

    const updatedAccount = await superAdminService.editAccount(userId, updatedData, req.user.roleName);

    res.status(200).json(updatedAccount);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Function to Delete Account (Only SUPER_ADMIN)
export const deleteAccountHandler = async (req, res) => {
  try {
    if (req.user.roleName !== 'SUPER_ADMIN') {
      return res.status(403).json({ message: 'Access denied' });
    }

    const { userId } = req.params;
    await superAdminService.deleteAccount(userId, req.user.roleName);

    res.status(200).json({ message: 'Account deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Function to Login Account
export const loginAccount = async (req, res) => {
  try {
    const { username, password } = req.body;

    const account = await superAdminRepo.findAccountByUsername(username);
    if (!account) {
      return res.status(404).json({ message: 'Account not found' });
    }

    const isPasswordValid = await compare(password, account.password);
    if (!isPasswordValid) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    const token = jwt.sign(
      { userId: account.userId, roleName: account.role.roleName },
      'secretKey',
      { expiresIn: '1h' }
    );

    res.status(200).json({ token });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};


export const assignSupervisor = async (req, res) => {
  const { userId, supervisorId } = req.body;

  try {
      const result = await accountService.assignSupervisor(userId, supervisorId);
      res.status(200).json(result);
  } catch (error) {
      res.status(500).json({ error: error.message });
  }
};

export const getHierarchy = async (req, res) => {
  const { userId } = req.params;

  try {
      const hierarchy = await accountService.getHierarchy(userId);
      res.status(200).json(hierarchy);
  } catch (error) {
      res.status(500).json({ error: error.message });
  }
};