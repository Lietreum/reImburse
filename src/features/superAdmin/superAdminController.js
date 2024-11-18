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

// Assign Supervisor
export const assignSupervisor = async (req, res) => {
  try {
    if (req.user.role !== 'SUPER_ADMIN') {
      return res.status(403).json({ message: 'Access denied' });
    }

    const { userId, supervisorId } = req.body;
    const result = await superAdminService.assignSupervisor(userId, supervisorId);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get Hierarchy
export const getHierarchy = async (req, res) => {
  try {
    if (req.user.role !== 'SUPER_ADMIN') {
      return res.status(403).json({ message: 'Access denied' });
    }

    const { userId } = req.params;
    const hierarchy = await superAdminService.getHierarchy(userId);
    res.status(200).json(hierarchy);
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

