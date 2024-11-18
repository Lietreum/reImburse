/*
  Warnings:

  - The primary key for the `account` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `roleId` on the `account` table. All the data in the column will be lost.
  - You are about to drop the `role` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[username]` on the table `Account` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE `account` DROP FOREIGN KEY `Account_roleId_fkey`;

-- DropForeignKey
ALTER TABLE `approval` DROP FOREIGN KEY `Approval_financeAdminId_fkey`;

-- DropForeignKey
ALTER TABLE `approval` DROP FOREIGN KEY `Approval_financeManagerId_fkey`;

-- DropForeignKey
ALTER TABLE `approval` DROP FOREIGN KEY `Approval_supervisorId_fkey`;

-- DropForeignKey
ALTER TABLE `debtlist` DROP FOREIGN KEY `DebtList_userId_fkey`;

-- DropForeignKey
ALTER TABLE `f3form` DROP FOREIGN KEY `F3Form_userId_fkey`;

-- DropForeignKey
ALTER TABLE `f4form` DROP FOREIGN KEY `F4Form_userId_fkey`;

-- DropForeignKey
ALTER TABLE `f5form` DROP FOREIGN KEY `F5Form_userId_fkey`;

-- DropForeignKey
ALTER TABLE `itemlist` DROP FOREIGN KEY `ItemList_accountUserId_fkey`;

-- DropForeignKey
ALTER TABLE `notification` DROP FOREIGN KEY `Notification_userId_fkey`;

-- DropForeignKey
ALTER TABLE `reimbursementsummary` DROP FOREIGN KEY `ReimbursementSummary_userId_fkey`;

-- AlterTable
ALTER TABLE `account` DROP PRIMARY KEY,
    DROP COLUMN `roleId`,
    ADD COLUMN `role` ENUM('USER', 'SUPERVISOR', 'ADMIN_KEUANGAN', 'MANAJER_KEUANGAN', 'SUPER_ADMIN') NOT NULL DEFAULT 'SUPER_ADMIN',
    ADD COLUMN `supervisorId` VARCHAR(191) NULL,
    MODIFY `userId` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`userId`);

-- AlterTable
ALTER TABLE `approval` MODIFY `supervisorId` VARCHAR(191) NULL,
    MODIFY `financeAdminId` VARCHAR(191) NULL,
    MODIFY `financeManagerId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `debtlist` MODIFY `userId` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `f3form` MODIFY `userId` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `f4form` MODIFY `userId` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `f5form` MODIFY `userId` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `itemlist` MODIFY `accountUserId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `notification` MODIFY `userId` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `reimbursementsummary` MODIFY `userId` VARCHAR(191) NOT NULL;

-- DropTable
DROP TABLE `role`;

-- CreateIndex
CREATE UNIQUE INDEX `Account_username_key` ON `Account`(`username`);

-- AddForeignKey
ALTER TABLE `Account` ADD CONSTRAINT `Account_supervisorId_fkey` FOREIGN KEY (`supervisorId`) REFERENCES `Account`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F3Form` ADD CONSTRAINT `F3Form_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Account`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F4Form` ADD CONSTRAINT `F4Form_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Account`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F5Form` ADD CONSTRAINT `F5Form_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Account`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DebtList` ADD CONSTRAINT `DebtList_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Account`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Approval` ADD CONSTRAINT `Approval_supervisorId_fkey` FOREIGN KEY (`supervisorId`) REFERENCES `Account`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Approval` ADD CONSTRAINT `Approval_financeAdminId_fkey` FOREIGN KEY (`financeAdminId`) REFERENCES `Account`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Approval` ADD CONSTRAINT `Approval_financeManagerId_fkey` FOREIGN KEY (`financeManagerId`) REFERENCES `Account`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notification` ADD CONSTRAINT `Notification_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Account`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ItemList` ADD CONSTRAINT `ItemList_accountUserId_fkey` FOREIGN KEY (`accountUserId`) REFERENCES `Account`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReimbursementSummary` ADD CONSTRAINT `ReimbursementSummary_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Account`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;
