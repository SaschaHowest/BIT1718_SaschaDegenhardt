-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Gene` (
  `Gene_id` INT(55) NOT NULL,
  `Gene_name` VARCHAR(45) NOT NULL,
  `Gene_description` TEXT(255) NULL,
  PRIMARY KEY (`Gene_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mutation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mutation` (
  `Mutation_id` INT(55) NOT NULL,
  `Gene_id` INT(55) NOT NULL,
  `Mutation_start` INT(20) NOT NULL,
  `Mutation_end` INT(20) NOT NULL,
  `Chromosome` CHAR(2) NOT NULL,
  PRIMARY KEY (`Mutation_id`),
  UNIQUE INDEX `Mutation_id_UNIQUE` (`Mutation_id` ASC),
  INDEX `link to gene_idx` (`Gene_id` ASC),
  CONSTRAINT `link to gene`
    FOREIGN KEY (`Gene_id`)
    REFERENCES `mydb`.`Gene` (`Gene_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Syndrom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Syndrom` (
  `Syndrom_id` INT(25) NOT NULL,
  `Syndrom_name` VARCHAR(100) NULL,
  `Syndrom_description` TEXT(255) NULL,
  PRIMARY KEY (`Syndrom_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `Patient_id` INT(25) NOT NULL,
  `Patient_name` VARCHAR(45) NOT NULL,
  `Patient_gender` ENUM('M', 'F') NOT NULL,
  `Age_of_diagnosis` INT(3) NULL,
  `Syndrom_id` INT(25) NOT NULL,
  PRIMARY KEY (`Patient_id`),
  UNIQUE INDEX `Patient_id_UNIQUE` (`Patient_id` ASC),
  INDEX `link to syndrom_idx` (`Syndrom_id` ASC),
  CONSTRAINT `link to syndrom`
    FOREIGN KEY (`Syndrom_id`)
    REFERENCES `mydb`.`Syndrom` (`Syndrom_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mutation_has_Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mutation_has_Patient` (
  `ID` INT(25) NOT NULL,
  `Mutation_id` INT(55) NOT NULL,
  `Patient_ID` INT(25) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Mutation_has_Patient_Patient1_idx` (`Patient_ID` ASC),
  INDEX `fk_Mutation_has_Patient_Mutation1_idx` (`Mutation_id` ASC),
  UNIQUE INDEX `Mutation_Mutation_id_UNIQUE` (`Mutation_id` ASC),
  UNIQUE INDEX `ID_UNIQUE` (`Patient_ID` ASC),
  CONSTRAINT `fk_Mutation_has_Patient_Mutation1`
    FOREIGN KEY (`Mutation_id`)
    REFERENCES `mydb`.`Mutation` (`Mutation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mutation_has_Patient_Patient1`
    FOREIGN KEY (`Patient_ID`)
    REFERENCES `mydb`.`Patient` (`Patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
