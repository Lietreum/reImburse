import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import * as superAdminRepo from './superAdminRepo.js';

export const registerAccount = async (accountData, requesterRole) => {
  // if (requesterRole !== 'SUPER_ADMIN') {
  //   throw new Error('Unauthorized action');
  // }

  const hashedPassword = await bcrypt.hash(accountData.password, 10);
  accountData.password = hashedPassword;
  return superAdminRepo.createAccount(accountData);
};

export const loginAccount = async (username, password) => {
  const account = await superAdminRepo.findAccountByUsername(username);
  if (!account) {
    throw new Error('Invalid credentials');
  }

  const passwordMatch = await bcrypt.compare(password, account.password);
  if (!passwordMatch) {
    throw new Error('Invalid credentials');
  }

  const token = jwt.sign(
    { userId: account.userId, role: account.role.roleName },
    process.env.JWT_SECRET,
    { expiresIn: '1h' }
  );
  return { token, account };
};

export const editAccount = async (userId, data, requesterRole) => {
  if (requesterRole !== 'SUPER_ADMIN') {
    throw new Error('Unauthorized action');
  }

  return superAdminRepo.updateAccount(userId, data);
};

export const deleteAccount = async (userId, requesterRole) => {
  if (requesterRole !== 'SUPER_ADMIN') {
    throw new Error('Unauthorized action');
  }

  return superAdminRepo.deleteAccount(userId);
};


export const assignSupervisor = async (userId, supervisorId) => {
  try {
      const user = await superAdminrepo.updateSupervisor(userId, supervisorId);
      return { message: "Supervisor assigned successfully", user };
  } catch (error) {
      throw new Error("Failed to assign supervisor");
  }
};

export const getHierarchy = async (userId) => {
  try {
      const hierarchy = await superAdminRepo.findUserWithHierarchy(userId);
      return hierarchy;
  } catch (error) {
      throw new Error("Failed to retrieve hierarchy");
  }
};