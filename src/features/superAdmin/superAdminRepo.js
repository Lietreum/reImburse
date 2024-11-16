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
