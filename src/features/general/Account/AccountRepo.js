import prisma from '../../../prismaClient.js';

export const getAccountByUsername = async (username) => {
    return prisma.account.findUnique({ where: { username } });
};