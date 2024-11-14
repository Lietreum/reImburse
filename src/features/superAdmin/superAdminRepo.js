import prisma from '../../prismaClient.js'; // Ensure you're using ES Modules

export const createAccount = async (data) => {
  return prisma.account.create({ data });
};

export const findAccountByUsername = async (username) => {
  return prisma.account.findUnique({ where: { username } });
};

export const findAccountById = async (userId) => {
  return prisma.account.findUnique({ where: { userId } });
};

export const updateAccount = async (userId, data) => {
  return prisma.account.update({ where: { userId }, data });
};

export const deleteAccount = async (userId) => {
  return prisma.account.delete({ where: { userId } });
};
