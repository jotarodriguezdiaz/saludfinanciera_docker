CREATE DATABASE IF NOT EXISTS `finance`;
USE `finance`;

CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) NOT NULL,
    `ProductVersion` varchar(32) NOT NULL,
    PRIMARY KEY (`MigrationId`)
);

START TRANSACTION;

CREATE TABLE `Users` (
    `UserId` char(36) NOT NULL,
    `CreatedDate` datetime(6) NULL,
    `CreatedBy` longtext NULL,
    `LastModifiedDate` datetime(6) NULL,
    `LastModifiedBy` longtext NULL,
    PRIMARY KEY (`UserId`)
);

CREATE TABLE `Boards` (
    `BoardId` int NOT NULL AUTO_INCREMENT,
    `Name` varchar(100) NOT NULL,
    `Description` varchar(500) NULL,
    `DateDeleted` datetime(6) NULL,
    `PercentageSimulatedAvailable` decimal(18,2) NOT NULL,
    `UserId` char(36) NOT NULL,
    `CreatedDate` datetime(6) NULL,
    `CreatedBy` longtext NULL,
    `LastModifiedDate` datetime(6) NULL,
    `LastModifiedBy` longtext NULL,
    PRIMARY KEY (`BoardId`),
    CONSTRAINT `FK_Boards_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `Users` (`UserId`) ON DELETE CASCADE
);

CREATE TABLE `Categories` (
    `CategoryId` int NOT NULL AUTO_INCREMENT,
    `Name` varchar(100) NOT NULL,
    `Description` varchar(500) NULL,
    `Position` int NOT NULL,
    `BoardId` int NOT NULL,
    `UserId` char(36) NOT NULL,
    `CreatedDate` datetime(6) NULL,
    `CreatedBy` longtext NULL,
    `LastModifiedDate` datetime(6) NULL,
    `LastModifiedBy` longtext NULL,
    PRIMARY KEY (`CategoryId`),
    CONSTRAINT `FK_Categories_Boards_BoardId` FOREIGN KEY (`BoardId`) REFERENCES `Boards` (`BoardId`) ON DELETE CASCADE,
    CONSTRAINT `FK_Categories_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `Users` (`UserId`) ON DELETE CASCADE
);

CREATE TABLE `Goals` (
    `GoalId` int NOT NULL AUTO_INCREMENT,
    `Description` longtext NOT NULL,
    `Cost` decimal(18,2) NOT NULL,
    `PercentageAssigned` decimal(18,2) NOT NULL,
    `DateEstimated` datetime(6) NOT NULL,
    `AmountReserved` decimal(18,2) NOT NULL,
    `Message` longtext NOT NULL,
    `MumMonths` decimal(18,2) NOT NULL,
    `BoardId` int NOT NULL,
    `CreatedDate` datetime(6) NULL,
    `CreatedBy` longtext NULL,
    `LastModifiedDate` datetime(6) NULL,
    `LastModifiedBy` longtext NULL,
    PRIMARY KEY (`GoalId`),
    CONSTRAINT `FK_Goals_Boards_BoardId` FOREIGN KEY (`BoardId`) REFERENCES `Boards` (`BoardId`) ON DELETE CASCADE
);

CREATE TABLE `Months` (
    `MonthId` int NOT NULL AUTO_INCREMENT,
    `Year` int NOT NULL,
    `NumMonth` int NOT NULL,
    `IsCorrected` tinyint(1) NOT NULL,
    `ErrorMargin` decimal(18,2) NULL,
    `Amount` decimal(18,2) NULL,
    `Suspended` tinyint(1) NOT NULL,
    `Active` tinyint(1) NOT NULL,
    `BoardId` int NOT NULL,
    `CreatedDate` datetime(6) NULL,
    `CreatedBy` longtext NULL,
    `LastModifiedDate` datetime(6) NULL,
    `LastModifiedBy` longtext NULL,
    PRIMARY KEY (`MonthId`),
    CONSTRAINT `FK_Months_Boards_BoardId` FOREIGN KEY (`BoardId`) REFERENCES `Boards` (`BoardId`) ON DELETE CASCADE
);

CREATE TABLE `Tags` (
    `TagId` int NOT NULL AUTO_INCREMENT,
    `Name` longtext NOT NULL,
    `BoardId` int NOT NULL,
    `CreatedDate` datetime(6) NULL,
    `CreatedBy` longtext NULL,
    `LastModifiedDate` datetime(6) NULL,
    `LastModifiedBy` longtext NULL,
    PRIMARY KEY (`TagId`),
    CONSTRAINT `FK_Tags_Boards_BoardId` FOREIGN KEY (`BoardId`) REFERENCES `Boards` (`BoardId`) ON DELETE CASCADE
);

CREATE TABLE `Expenses` (
    `ExpenseId` int NOT NULL AUTO_INCREMENT,
    `Expendable` tinyint(1) NOT NULL,
    `Variable` tinyint(1) NOT NULL,
    `Relevance` int NOT NULL,
    `CreatedDate` datetime(6) NULL,
    `CreatedBy` longtext NULL,
    `LastModifiedDate` datetime(6) NULL,
    `LastModifiedBy` longtext NULL,
    `Position` int NOT NULL,
    `Name` longtext NOT NULL,
    `Description` longtext NOT NULL,
    `Amount` decimal(18,2) NOT NULL,
    `DateDeleted` datetime(6) NULL,
    `Period` int NOT NULL,
    `CategoryId` int NOT NULL,
    PRIMARY KEY (`ExpenseId`),
    CONSTRAINT `FK_Expenses_Categories_CategoryId` FOREIGN KEY (`CategoryId`) REFERENCES `Categories` (`CategoryId`) ON DELETE CASCADE
);

CREATE TABLE `Incomes` (
    `IncomeId` int NOT NULL AUTO_INCREMENT,
    `CreatedDate` datetime(6) NULL,
    `CreatedBy` longtext NULL,
    `LastModifiedDate` datetime(6) NULL,
    `LastModifiedBy` longtext NULL,
    `Position` int NOT NULL,
    `Name` longtext NOT NULL,
    `Description` longtext NOT NULL,
    `Amount` decimal(18,2) NOT NULL,
    `DateDeleted` datetime(6) NULL,
    `Period` int NOT NULL,
    `CategoryId` int NOT NULL,
    PRIMARY KEY (`IncomeId`),
    CONSTRAINT `FK_Incomes_Categories_CategoryId` FOREIGN KEY (`CategoryId`) REFERENCES `Categories` (`CategoryId`) ON DELETE CASCADE
);

CREATE TABLE `ExpenseTag` (
    `ExpensesExpenseId` int NOT NULL,
    `TagsTagId` int NOT NULL,
    PRIMARY KEY (`ExpensesExpenseId`, `TagsTagId`),
    CONSTRAINT `FK_ExpenseTag_Expenses_ExpensesExpenseId` FOREIGN KEY (`ExpensesExpenseId`) REFERENCES `Expenses` (`ExpenseId`) ON DELETE CASCADE,
    CONSTRAINT `FK_ExpenseTag_Tags_TagsTagId` FOREIGN KEY (`TagsTagId`) REFERENCES `Tags` (`TagId`) ON DELETE CASCADE
);

CREATE TABLE `IncomeTag` (
    `IncomesIncomeId` int NOT NULL,
    `TagsTagId` int NOT NULL,
    PRIMARY KEY (`IncomesIncomeId`, `TagsTagId`),
    CONSTRAINT `FK_IncomeTag_Incomes_IncomesIncomeId` FOREIGN KEY (`IncomesIncomeId`) REFERENCES `Incomes` (`IncomeId`) ON DELETE CASCADE,
    CONSTRAINT `FK_IncomeTag_Tags_TagsTagId` FOREIGN KEY (`TagsTagId`) REFERENCES `Tags` (`TagId`) ON DELETE CASCADE
);

INSERT INTO `Users` (`UserId`, `CreatedBy`, `CreatedDate`, `LastModifiedBy`, `LastModifiedDate`)
VALUES ('c5ce74fb-0e50-4c9f-9ed0-03ddcd4159e2', NULL, NULL, NULL, NULL);

INSERT INTO `Boards` (`BoardId`, `CreatedBy`, `CreatedDate`, `DateDeleted`, `Description`, `LastModifiedBy`, `LastModifiedDate`, `Name`, `PercentageSimulatedAvailable`, `UserId`)
VALUES (1, NULL, NULL, NULL, 'Familia', NULL, NULL, 'Board de pruebas', 100.0, 'c5ce74fb-0e50-4c9f-9ed0-03ddcd4159e2');

INSERT INTO `Categories` (`CategoryId`, `BoardId`, `CreatedBy`, `CreatedDate`, `Description`, `LastModifiedBy`, `LastModifiedDate`, `Name`, `Position`, `UserId`)
VALUES (2, 1, 'Default', NULL, 'Gimnasio, proteinas...', NULL, NULL, 'Deporte', 0, 'c5ce74fb-0e50-4c9f-9ed0-03ddcd4159e2');
INSERT INTO `Categories` (`CategoryId`, `BoardId`, `CreatedBy`, `CreatedDate`, `Description`, `LastModifiedBy`, `LastModifiedDate`, `Name`, `Position`, `UserId`)
VALUES (3, 1, 'Default', NULL, 'Certificaciones, cursos, grados...', NULL, NULL, 'Educación', 0, 'c5ce74fb-0e50-4c9f-9ed0-03ddcd4159e2');
INSERT INTO `Categories` (`CategoryId`, `BoardId`, `CreatedBy`, `CreatedDate`, `Description`, `LastModifiedBy`, `LastModifiedDate`, `Name`, `Position`, `UserId`)
VALUES (4, 1, 'Default', NULL, 'Colegio, extraescolares, ropa, alimentación...', NULL, NULL, 'Hijos', 0, 'c5ce74fb-0e50-4c9f-9ed0-03ddcd4159e2');

CREATE INDEX `IX_Boards_UserId` ON `Boards` (`UserId`);

CREATE INDEX `IX_Categories_BoardId` ON `Categories` (`BoardId`);

CREATE INDEX `IX_Categories_UserId` ON `Categories` (`UserId`);

CREATE INDEX `IX_Expenses_CategoryId` ON `Expenses` (`CategoryId`);

CREATE INDEX `IX_ExpenseTag_TagsTagId` ON `ExpenseTag` (`TagsTagId`);

CREATE INDEX `IX_Goals_BoardId` ON `Goals` (`BoardId`);

CREATE INDEX `IX_Incomes_CategoryId` ON `Incomes` (`CategoryId`);

CREATE INDEX `IX_IncomeTag_TagsTagId` ON `IncomeTag` (`TagsTagId`);

CREATE INDEX `IX_Months_BoardId` ON `Months` (`BoardId`);

CREATE INDEX `IX_Tags_BoardId` ON `Tags` (`BoardId`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20230529174534_mvp', '7.0.0-preview.5.22302.2');

COMMIT;

