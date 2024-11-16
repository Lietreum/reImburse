import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import * as superAdminService from './superAdminService.js';

const { hash } = bcrypt;

// Register Account
export const createAccount = async (req, res) => {
  try {
    if (req.user.role !== 'SUPER_ADMIN') {
      return res.status(403).json({ message: 'Access denied' });
    }

    const { username, password, roleId, divisionName } = req.body;
    const newAccount = await superAdminService.registerAccount({
      username,
      password,
      roleId,
      divisionName,
    });

    res.status(201).json(newAccount);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Update Account
export const updateAccountHandler = async (req, res) => {
  try {
    if (req.user.role !== 'SUPER_ADMIN') {
      return res.status(403).json({ message: 'Access denied' });
    }

    const { userId } = req.params;
    const updatedData = req.body;

    if (updatedData.password) {
      updatedData.password = await hash(updatedData.password, 10);
    }

    const updatedAccount = await superAdminService.editAccount(userId, updatedData);
    res.status(200).json(updatedAccount);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Delete Account 
export const deleteAccountHandler = async (req, res) => {
  try {
    if (req.user.role !== 'SUPER_ADMIN') {
      return res.status(403).json({ message: 'Access denied' });
    }

    const { userId } = req.params;

    const parsedUserId = parseInt(userId, 10);

    if (isNaN(parsedUserId)) {
      return res.status(400).json({ message: 'Invalid user ID format' });
    }

    await superAdminService.deleteAccount(parsedUserId);

    res.status(200).json({ message: 'Account deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};




