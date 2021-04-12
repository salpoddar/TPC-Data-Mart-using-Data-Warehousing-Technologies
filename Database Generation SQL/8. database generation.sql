-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SalesOrders_6_2191
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SalesOrders_6_2191
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SalesOrders_6_2191` ;
USE `SalesOrders_6_2191` ;

-- -----------------------------------------------------
-- Table `SalesOrders_6_2191`.`Product_Dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalesOrders_6_2191`.`Product_Dim` (
  `Product_SK` INT NOT NULL AUTO_INCREMENT,
  `ProductID` INT NOT NULL,
  `ProductDescription` VARCHAR(45) NULL,
  `ProductTypeID` INT NULL,
  `ProductTypeDescription` VARCHAR(45) NULL,
  `BUID` CHAR(1) NULL,
  `BusinessUnitName` VARCHAR(45) NULL,
  `BusinessUnitAbbrev` VARCHAR(45) NULL,
  `Price1` DECIMAL(10,2) NULL,
  `Price2` DECIMAL(10,2) NULL,
  `UnitCost` DECIMAL(10,2) NULL,
  `SupplierID` INT NULL,
  `SupplierName` VARCHAR(45) NULL,
  `SupplierAddr1` VARCHAR(45) NULL,
  `SupplierAddr2` VARCHAR(45) NULL,
  `SupplierCity` VARCHAR(45) NULL,
  `SupplierState` VARCHAR(45) NULL,
  `SupplierZip` INT NULL,
  `Divison` INT NULL,
  PRIMARY KEY (`Product_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalesOrders_6_2191`.`PECJunk_Dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalesOrders_6_2191`.`PECJunk_Dim` (
  `Junk_SK` INT NOT NULL AUTO_INCREMENT,
  `OrderingMethod` VARCHAR(45) NULL,
  `ShippingMethod` VARCHAR(45) NULL,
  `PaymentMethod` VARCHAR(45) NULL,
  PRIMARY KEY (`Junk_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalesOrders_6_2191`.`OrderDate_Dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalesOrders_6_2191`.`OrderDate_Dim` (
  `OrderDate_SK` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NULL,
  `OrderDateYear` YEAR NULL,
  `OrderDateQuarter` INT NULL,
  `OrderDateMonth` INT NULL,
  `OrderDateDay` INT NULL,
  `FiscalOrderDate` DATE NULL,
  `FiscalOrderYear` YEAR NULL,
  `FiscalOrderQuarter` INT NULL,
  `FiscalOrderMonth` INT NULL,
  `FiscalOrderDay` INT NULL,
  PRIMARY KEY (`OrderDate_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalesOrders_6_2191`.`SalesDate_Dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalesOrders_6_2191`.`SalesDate_Dim` (
  `SalesDate_SK` INT NOT NULL AUTO_INCREMENT,
  `SalesDate` DATE NULL,
  `SalesDateYear` YEAR NULL,
  `SalesDateQuarter` INT NULL,
  `SalesDateMonth` INT NULL,
  `SalesDateDay` INT NULL,
  `FiscalDate` DATE NULL,
  `FiscalSalesYear` YEAR NULL,
  `FiscalSalesQuarter` INT NULL,
  `FiscalSalesMonth` INT NULL,
  `FiscalSalesDay` INT NULL,
  PRIMARY KEY (`SalesDate_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalesOrders_6_2191`.`Customer_Dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalesOrders_6_2191`.`Customer_Dim` (
  `Customer_SK` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NULL,
  `CustomerName` VARCHAR(100) NULL,
  `CustomerTypeID` CHAR(1) NULL,
  `CustomerTypeName` VARCHAR(45) NULL,
  `CustomerAddr1` VARCHAR(45) NULL,
  `CustomerAddr2` VARCHAR(45) NULL,
  `CustomerState` VARCHAR(45) NULL,
  `CustomerCity` VARCHAR(45) NULL,
  `CustomerZip` INT(20) NULL,
  `Division` INT NULL,
  PRIMARY KEY (`Customer_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalesOrders_6_2191`.`Division_Dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalesOrders_6_2191`.`Division_Dim` (
  `Divison_SK` INT NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(45) NULL,
  PRIMARY KEY (`Divison_SK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SalesOrders_6_2191`.`Sales_Fact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SalesOrders_6_2191`.`Sales_Fact` (
  `InvoiceId` INT NOT NULL,
  `Product_SK` INT NOT NULL,
  `OrderDate_SK` INT NOT NULL,
  `PECJunk_SK` INT NOT NULL,
  `SalesDate_SK` INT NOT NULL,
  `Customer_SK` INT NOT NULL,
  `Division_SK` INT NOT NULL,
  `Quantity` INT(20) NULL,
  `DaysToFullfill` INT(30) NULL,
  `Discounted` TINYINT(1) NULL,
  `TotalCost` INT NULL,
  `TotalSales` INT NULL,
  `Profit` INT NULL,
  PRIMARY KEY (`Product_SK`, `OrderDate_SK`, `PECJunk_SK`, `SalesDate_SK`, `Customer_SK`, `Division_SK`, `InvoiceId`),
  INDEX `fk_Sales_Fact_OrderDate_Dim1_idx` (`OrderDate_SK` ASC) VISIBLE,
  INDEX `fk_Sales_Fact_PEC_JUNK_Dim1_idx` (`PECJunk_SK` ASC) VISIBLE,
  INDEX `fk_Sales_Fact_SalesDate_Dim1_idx` (`SalesDate_SK` ASC) VISIBLE,
  INDEX `fk_Sales_Fact_Customer_Dim1_idx` (`Customer_SK` ASC) VISIBLE,
  INDEX `fk_Division_idx` (`Division_SK` ASC) VISIBLE,
  CONSTRAINT `fk_Product`
    FOREIGN KEY (`Product_SK`)
    REFERENCES `SalesOrders_6_2191`.`Product_Dim` (`Product_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderDate`
    FOREIGN KEY (`OrderDate_SK`)
    REFERENCES `SalesOrders_6_2191`.`OrderDate_Dim` (`OrderDate_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Junk`
    FOREIGN KEY (`PECJunk_SK`)
    REFERENCES `SalesOrders_6_2191`.`PECJunk_Dim` (`Junk_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SalesDate`
    FOREIGN KEY (`SalesDate_SK`)
    REFERENCES `SalesOrders_6_2191`.`SalesDate_Dim` (`SalesDate_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer`
    FOREIGN KEY (`Customer_SK`)
    REFERENCES `SalesOrders_6_2191`.`Customer_Dim` (`Customer_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Division`
    FOREIGN KEY (`Division_SK`)
    REFERENCES `SalesOrders_6_2191`.`Division_Dim` (`Divison_SK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
