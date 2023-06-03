CREATE DATABASE IF NOT EXISTS `debts`;
USE `debts`;

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

CREATE TABLE `Simulations` (
    `SimulationId` int NOT NULL AUTO_INCREMENT,
    `Import` decimal(18,2) NOT NULL,
    `TypeInterest` decimal(18,2) NOT NULL,
    `Time` int NOT NULL,
    `AnnualProfitability` decimal(18,2) NOT NULL,
    `Taxes` decimal(18,2) NOT NULL,
    `MonthlySaving` decimal(18,2) NOT NULL,
    `UserId` char(36) NOT NULL,
    `CreatedDate` datetime(6) NULL,
    `CreatedBy` longtext NULL,
    `LastModifiedDate` datetime(6) NULL,
    `LastModifiedBy` longtext NULL,
    PRIMARY KEY (`SimulationId`),
    CONSTRAINT `FK_Simulations_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `Users` (`UserId`) ON DELETE CASCADE
);

INSERT INTO `Users` (`UserId`, `CreatedBy`, `CreatedDate`, `LastModifiedBy`, `LastModifiedDate`)
VALUES ('c5ce74fb-0e50-4c9f-9ed0-03ddcd4159e2', NULL, NULL, NULL, NULL);

CREATE INDEX `IX_Simulations_UserId` ON `Simulations` (`UserId`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20230601135719_first-migration-simulation', '7.0.0-preview.5.22302.2');

COMMIT;

