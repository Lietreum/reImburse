import prisma from '../../prismaClient.js';

export const createAccount = async (data) => {
  return prisma.account.create({ data });
};

export const updateAccount = async (userId, data) => {
  return prisma.account.update({ where: { userId }, data });
};

export const deleteAccount = async (userId) => {
  return prisma.account.delete({ where: { userId } });
};

// Supervisor Operations
export const updateSupervisor = async (userId, supervisorId) => prisma.account.update({
  where: { userId },
  data: { supervisorId },
});

export const findUserWithHierarchy = async (userId) => prisma.account.findUnique({
  where: { userId },
  include: { supervisor: true, subordinates: true },
});

// Report Operations
export const getAllFormReports = async () => prisma.f3Form.findMany({
  include: {
    user: true,
    approvals: true,
    project: true,
  },
});