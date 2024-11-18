import bcrypt from 'bcryptjs';
import * as superAdminService from './superAdminService.js';

const { hash } = bcrypt;

// Register Account
export const createAccount = async (req, res) => {
  try {
    if (req.user.role !== 'SUPER_ADMIN') {
      return res.status(403).json({ message: 'Access denied' });
    }

    const { username, password, role, divisionName } = req.body;
    const newAccount = await superAdminService.registerAccount({
      username,
      password,
      role,
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

export const assignHierarchy = async (req, res) => {
  try {
    if (req.user.role !== 'SUPER_ADMIN') {
      return res.status(403).json({ message: 'Access denied' });
    }

    const { userId, supervisorId, financeAdminId, financeManagerId } = req.body;

    const result = await superAdminService.setHierarchy({
      userId,
      supervisorId,
      financeAdminId,
      financeManagerId,
    });

    res.status(200).json({ message: 'Hierarchy updated successfully', data: result });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export const getHierarchyByUserId = async (req, res) => {
  try {
    const { userId } = req.params; // Dapatkan userId dari parameter URL
    const hierarchy = await superAdminService.getHierarchy(userId);

    if (!hierarchy) {
      return res.status(404).json({ message: 'Hierarchy not found' });
    }

    res.status(200).json({ message: 'Hierarchy retrieved successfully', data: hierarchy });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};


// Get All Reports
export const getAllReports = async (req, res) => {
  try {
    if (req.user.role !== 'SUPER_ADMIN') {
      return res.status(403).json({ message: 'Access denied' });
    }

    const reports = await superAdminService.getAllReports();
    res.status(200).json(reports);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

