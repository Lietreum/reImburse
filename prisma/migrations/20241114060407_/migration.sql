-- CreateTable
CREATE TABLE `Role` (
    `roleId` INTEGER NOT NULL AUTO_INCREMENT,
    `roleName` ENUM('USER', 'SUPERVISOR', 'ADMIN_KEUANGAN', 'MANAJER_KEUANGAN', 'SUPER_ADMIN') NOT NULL,

    PRIMARY KEY (`roleId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Account` (
    `userId` INTEGER NOT NULL AUTO_INCREMENT,
    `roleId` INTEGER NOT NULL,
    `username` VARCHAR(100) NOT NULL,
    `password` VARCHAR(100) NOT NULL,
    `divisionName` ENUM('HC', 'GA', 'LEGAL', 'ENGINEER', 'FINANCE', 'MARKETING', 'SALES', 'PROJECT', 'C_LEVEL', 'PRODUCT', 'CORSE') NOT NULL,

    PRIMARY KEY (`userId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UniqueCode` (
    `uniqueCode` INTEGER NOT NULL AUTO_INCREMENT,

    PRIMARY KEY (`uniqueCode`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `F3Form` (
    `f3Id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `uniqueCode` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,
    `projectCode` INTEGER NOT NULL,
    `bankAccountId` INTEGER NOT NULL,
    `itemListId` INTEGER NOT NULL,
    `activity` VARCHAR(100) NOT NULL,
    `date` DATETIME(3) NOT NULL,
    `description` VARCHAR(100) NOT NULL,
    `evidence` LONGBLOB NOT NULL,
    `budgetCode` ENUM('PERSONALIA', 'PERJALANAN_DINAS_DN', 'PERJALANAN_DINAS_LN', 'BEBAN_BAHAN', 'BEBAN_IMPOR_PAJAK', 'BEBAN_BAHAN_PENDUKUNG', 'BEBAN_SUBKONTRAKTOR', 'BEBAN_EKSPEDISI', 'BEBAN_PRODUKSI_LANGSUNG', 'BEBAN_ALIH_DAYA', 'BEBAN_BANGUNAN_PRASARANA', 'BEBAN_PERALATAN_MESIN', 'BEBAN_KANTOR', 'BEBAN_FASILITAS', 'BEBAN_PENYUSUTAN', 'BEBAN_TAK_LANGSUNG', 'ALOKASI_PPH_FINAL', 'CASH_IN') NOT NULL,
    `transactionStatus` ENUM('CASH_IN', 'CASH_OUT', 'HUTANG', 'PIUTANG', 'PENGAJUAN', 'PERTANGGUNGJAWABAN') NOT NULL,

    PRIMARY KEY (`f3Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `F4Form` (
    `f4Id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `uniqueCode` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,
    `projectCode` INTEGER NOT NULL,
    `bankAccountId` INTEGER NOT NULL,
    `itemListId` INTEGER NOT NULL,
    `proposedAmount` DECIMAL(65, 30) NOT NULL,
    `activity` VARCHAR(100) NOT NULL,
    `date` DATETIME(3) NOT NULL,
    `description` VARCHAR(100) NOT NULL,
    `evidence` LONGBLOB NOT NULL,
    `budgetCode` ENUM('PERSONALIA', 'PERJALANAN_DINAS_DN', 'PERJALANAN_DINAS_LN', 'BEBAN_BAHAN', 'BEBAN_IMPOR_PAJAK', 'BEBAN_BAHAN_PENDUKUNG', 'BEBAN_SUBKONTRAKTOR', 'BEBAN_EKSPEDISI', 'BEBAN_PRODUKSI_LANGSUNG', 'BEBAN_ALIH_DAYA', 'BEBAN_BANGUNAN_PRASARANA', 'BEBAN_PERALATAN_MESIN', 'BEBAN_KANTOR', 'BEBAN_FASILITAS', 'BEBAN_PENYUSUTAN', 'BEBAN_TAK_LANGSUNG', 'ALOKASI_PPH_FINAL', 'CASH_IN') NOT NULL,
    `transactionStatus` ENUM('CASH_IN', 'CASH_OUT', 'HUTANG', 'PIUTANG', 'PENGAJUAN', 'PERTANGGUNGJAWABAN') NOT NULL,

    PRIMARY KEY (`f4Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `F5Form` (
    `f5Id` INTEGER NOT NULL AUTO_INCREMENT,
    `f5Number` VARCHAR(100) NOT NULL,
    `uniqueCode` INTEGER NOT NULL,
    `date` DATETIME(3) NOT NULL,
    `userId` INTEGER NOT NULL,
    `f4Id` INTEGER NOT NULL,
    `activity` VARCHAR(100) NOT NULL,
    `projectCode` INTEGER NOT NULL,
    `description` VARCHAR(100) NOT NULL,
    `f4Amount` DECIMAL(65, 30) NOT NULL,
    `bankAccountId` INTEGER NOT NULL,
    `transactionStatus` ENUM('CASH_IN', 'CASH_OUT', 'HUTANG', 'PIUTANG', 'PENGAJUAN', 'PERTANGGUNGJAWABAN') NOT NULL,
    `evidence` LONGBLOB NOT NULL,
    `totalAccountability` DECIMAL(65, 30) NOT NULL,
    `status` ENUM('PENDING', 'SUPERVISOR_REVISED', 'SUPERVISOR_APPROVED', 'SUPERVISOR_REJECTED', 'ADMIN_REVISED', 'ADMIN_APPROVED', 'ADMIN_REJECTED', 'MANAGER_APPROVED', 'MANAGER_REJECTED') NOT NULL DEFAULT 'PENDING',
    `debtListId` INTEGER NULL,

    UNIQUE INDEX `F5Form_f5Number_key`(`f5Number`),
    UNIQUE INDEX `F5Form_debtListId_key`(`debtListId`),
    PRIMARY KEY (`f5Id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `DebtList` (
    `debtListId` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `f5Id` INTEGER NULL,
    `amount` DECIMAL(65, 30) NOT NULL,
    `evidence` LONGBLOB NOT NULL,
    `dateCreated` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `status` VARCHAR(100) NOT NULL,
    `f5FormF5Id` INTEGER NULL,

    UNIQUE INDEX `DebtList_f5FormF5Id_key`(`f5FormF5Id`),
    PRIMARY KEY (`debtListId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Approval` (
    `approvalId` INTEGER NOT NULL AUTO_INCREMENT,
    `f3FormId` INTEGER NOT NULL,
    `supervisorId` INTEGER NULL,
    `financeAdminId` INTEGER NULL,
    `financeManagerId` INTEGER NULL,
    `status` ENUM('PENDING', 'SUPERVISOR_REVISED', 'SUPERVISOR_APPROVED', 'SUPERVISOR_REJECTED', 'ADMIN_REVISED', 'ADMIN_APPROVED', 'ADMIN_REJECTED', 'MANAGER_APPROVED', 'MANAGER_REJECTED') NOT NULL DEFAULT 'PENDING',
    `revisionNote` VARCHAR(191) NULL,
    `rejectionReason` VARCHAR(191) NULL,
    `dateSubmitted` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `f4FormF4Id` INTEGER NULL,
    `f5FormF5Id` INTEGER NULL,

    PRIMARY KEY (`approvalId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Notification` (
    `notificationId` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `approvalId` INTEGER NOT NULL,
    `message` VARCHAR(255) NOT NULL,
    `dateSent` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `isRead` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`notificationId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Bank` (
    `bankAccountId` INTEGER NOT NULL AUTO_INCREMENT,
    `bankAccount` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`bankAccountId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TProjectCode` (
    `projectCode` INTEGER NOT NULL AUTO_INCREMENT,
    `projectName` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`projectCode`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ItemList` (
    `itemListId` INTEGER NOT NULL AUTO_INCREMENT,
    `reimbursementSummaryId` INTEGER NOT NULL,
    `category` VARCHAR(100) NOT NULL,
    `expense` DOUBLE NOT NULL,
    `quantity` INTEGER NOT NULL,
    `amount` DOUBLE NOT NULL,
    `total` DECIMAL(65, 30) NOT NULL,
    `accountUserId` INTEGER NULL,
    `f5FormF5Id` INTEGER NULL,

    PRIMARY KEY (`itemListId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ReimbursementSummary` (
    `reimbursementSummaryId` INTEGER NOT NULL AUTO_INCREMENT,
    `totalReimburse` DECIMAL(65, 30) NOT NULL,
    `date` DATETIME(3) NOT NULL,
    `userId` INTEGER NOT NULL,

    PRIMARY KEY (`reimbursementSummaryId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Account` ADD CONSTRAINT `Account_roleId_fkey` FOREIGN KEY (`roleId`) REFERENCES `Role`(`roleId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F3Form` ADD CONSTRAINT `F3Form_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Account`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F3Form` ADD CONSTRAINT `F3Form_projectCode_fkey` FOREIGN KEY (`projectCode`) REFERENCES `TProjectCode`(`projectCode`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F3Form` ADD CONSTRAINT `F3Form_bankAccountId_fkey` FOREIGN KEY (`bankAccountId`) REFERENCES `Bank`(`bankAccountId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F3Form` ADD CONSTRAINT `F3Form_uniqueCode_fkey` FOREIGN KEY (`uniqueCode`) REFERENCES `UniqueCode`(`uniqueCode`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F3Form` ADD CONSTRAINT `F3Form_itemListId_fkey` FOREIGN KEY (`itemListId`) REFERENCES `ItemList`(`itemListId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F4Form` ADD CONSTRAINT `F4Form_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Account`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F4Form` ADD CONSTRAINT `F4Form_projectCode_fkey` FOREIGN KEY (`projectCode`) REFERENCES `TProjectCode`(`projectCode`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F4Form` ADD CONSTRAINT `F4Form_bankAccountId_fkey` FOREIGN KEY (`bankAccountId`) REFERENCES `Bank`(`bankAccountId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F4Form` ADD CONSTRAINT `F4Form_itemListId_fkey` FOREIGN KEY (`itemListId`) REFERENCES `ItemList`(`itemListId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F4Form` ADD CONSTRAINT `F4Form_uniqueCode_fkey` FOREIGN KEY (`uniqueCode`) REFERENCES `UniqueCode`(`uniqueCode`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F5Form` ADD CONSTRAINT `F5Form_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Account`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F5Form` ADD CONSTRAINT `F5Form_projectCode_fkey` FOREIGN KEY (`projectCode`) REFERENCES `TProjectCode`(`projectCode`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F5Form` ADD CONSTRAINT `F5Form_bankAccountId_fkey` FOREIGN KEY (`bankAccountId`) REFERENCES `Bank`(`bankAccountId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F5Form` ADD CONSTRAINT `F5Form_f4Id_fkey` FOREIGN KEY (`f4Id`) REFERENCES `F4Form`(`f4Id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `F5Form` ADD CONSTRAINT `F5Form_uniqueCode_fkey` FOREIGN KEY (`uniqueCode`) REFERENCES `UniqueCode`(`uniqueCode`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DebtList` ADD CONSTRAINT `DebtList_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Account`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DebtList` ADD CONSTRAINT `DebtList_f5FormF5Id_fkey` FOREIGN KEY (`f5FormF5Id`) REFERENCES `F5Form`(`f5Id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Approval` ADD CONSTRAINT `Approval_f3FormId_fkey` FOREIGN KEY (`f3FormId`) REFERENCES `F3Form`(`f3Id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Approval` ADD CONSTRAINT `Approval_supervisorId_fkey` FOREIGN KEY (`supervisorId`) REFERENCES `Account`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Approval` ADD CONSTRAINT `Approval_financeAdminId_fkey` FOREIGN KEY (`financeAdminId`) REFERENCES `Account`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Approval` ADD CONSTRAINT `Approval_financeManagerId_fkey` FOREIGN KEY (`financeManagerId`) REFERENCES `Account`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Approval` ADD CONSTRAINT `Approval_f4FormF4Id_fkey` FOREIGN KEY (`f4FormF4Id`) REFERENCES `F4Form`(`f4Id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Approval` ADD CONSTRAINT `Approval_f5FormF5Id_fkey` FOREIGN KEY (`f5FormF5Id`) REFERENCES `F5Form`(`f5Id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notification` ADD CONSTRAINT `Notification_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Account`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notification` ADD CONSTRAINT `Notification_approvalId_fkey` FOREIGN KEY (`approvalId`) REFERENCES `Approval`(`approvalId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ItemList` ADD CONSTRAINT `ItemList_reimbursementSummaryId_fkey` FOREIGN KEY (`reimbursementSummaryId`) REFERENCES `ReimbursementSummary`(`reimbursementSummaryId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ItemList` ADD CONSTRAINT `ItemList_accountUserId_fkey` FOREIGN KEY (`accountUserId`) REFERENCES `Account`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ItemList` ADD CONSTRAINT `ItemList_f5FormF5Id_fkey` FOREIGN KEY (`f5FormF5Id`) REFERENCES `F5Form`(`f5Id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReimbursementSummary` ADD CONSTRAINT `ReimbursementSummary_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Account`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;
