import bcrypt from 'bcryptjs';
import * as superAdminRepo from './superAdminRepo.js';
import prisma from '../../prismaClient.js';

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

export const setHierarchy = async ({ userId, supervisorId, financeAdminId, financeManagerId }) => {
  // Update supervisor relasi
  if (supervisorId) {
    await superAdminRepo.updateSupervisor(userId, supervisorId);
  }

  // Update finance admin relasi
  if (financeAdminId) {
    await superAdminRepo.updateSupervisor(supervisorId, financeAdminId);
  }

  // Update finance manager relasi
  if (financeManagerId) {
    await superAdminRepo.updateSupervisor(financeAdminId, financeManagerId);
  }

  return { userId, supervisorId, financeAdminId, financeManagerId };
};


export const getHierarchy = async (userId) => {
  // Dapatkan data user
  const user = await prisma.account.findUnique({
    where: { userId },
    include: {
      supervisor: true, // Supervisor langsung user
    },
  });

  if (!user) {
    throw new Error('User not found');
  }

  // Rekursif untuk mendapatkan seluruh hierarki ke atas
  const hierarchy = [];
  let current = user;

  while (current) {
    hierarchy.push({
      userId: current.userId,
      name: current.name,
      role: current.role,
      supervisorId: current.supervisorId,
    });

    if (current.supervisorId) {
      current = await prisma.account.findUnique({
        where: { userId: current.supervisorId },
      });
    } else {
      current = null;
    }
  }

  return hierarchy.reverse(); // Urutkan dari user ke manajer
};

// Get All Reports
export const getAllReports = async () => {
  return superAdminRepo.getAllFormReports();
};
