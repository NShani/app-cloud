-- MySQL Script generated by MySQL Workbench
-- Mon Feb  1 17:54:10 2016
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema AppCloudDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema AppCloudDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `AppCloudDB` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `AppCloudDB` ;

-- -----------------------------------------------------
-- Table `AppCloudDB`.`ApplicationType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AppCloudDB`.`ApplicationType` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `app_type_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(1000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Populate Data to `AppCloudDB`.`ApplicationType`
-- -----------------------------------------------------
INSERT INTO `ApplicationType` (`id`, `app_type_name`, `description`) VALUES
(1, 'war', 'Allows you to create dynamic websites using Servlets and JSPs, instead of the static HTML webpages and JAX-RS/JAX-WS services.'),
(2, 'mss', 'WSO2 Microservices Framework for Java (WSO2 MSF4J) offers the best option to create microservices in Java using annotation-based programming model.'),
(3, 'car', 'A Carbon Application (C-App) is a collection of artifacts deployable on WSO2 ESB.');



-- -----------------------------------------------------
-- Table `AppCloudDB`.`ApplicationRuntime`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AppCloudDB`.`ApplicationRuntime` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `runtime_name` VARCHAR(45) NOT NULL,
  `repo_url` VARCHAR(45) NULL,
  `image_name` VARCHAR(45) NULL,
  `tag` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Populate Data to `AppCloudDB`.`ApplicationRuntime`
-- -----------------------------------------------------

INSERT INTO `ApplicationRuntime` (`id`, `runtime_name`, `repo_url`, `image_name`, `tag`) VALUES
(1, 'tomcat', 'https://github.com/', 'tomcat', '7-jre7');


-- -----------------------------------------------------
-- Table `AppCloudDB`.`Application`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AppCloudDB`.`Application` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `application_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(1000) NULL,
  `tenant_id` INT NOT NULL,
  `revision` VARCHAR(45) NOT NULL,
  `application_runtime_id` INT NULL,
  `application_type_id` INT NULL,
  `endpoint_url` VARCHAR(1000) NULL,
  `status` VARCHAR(45) NULL,
  `number_of_replica` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Application_ApplicationRuntime`
    FOREIGN KEY (`application_runtime_id`)
    REFERENCES `AppCloudDB`.`ApplicationRuntime` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Application_ApplicationType1`
    FOREIGN KEY (`application_type_id`)
    REFERENCES `AppCloudDB`.`ApplicationType` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AppCloudDB`.`Label`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AppCloudDB`.`Label` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label_name` VARCHAR(45) NOT NULL,
  `label_value` VARCHAR(45) NULL,
  `application_id` INT NOT NULL,
  `description` VARCHAR(1000) NULL,
  `tenant_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Label_Application1`
    FOREIGN KEY (`application_id`)
    REFERENCES `AppCloudDB`.`Application` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AppCloudDB`.`RuntimeProperties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AppCloudDB`.`RuntimeProperties` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `property_name` VARCHAR(45) NOT NULL,
  `property_value` VARCHAR(45) NULL,
  `application_id` INT NOT NULL,
  `description` VARCHAR(1000) NULL,
  `tenant_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_RuntimeProperties_Application1`
    FOREIGN KEY (`application_id`)
    REFERENCES `AppCloudDB`.`Application` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AppCloudDB`.`EndpointURL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AppCloudDB`.`EndpointURL` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `url_value` VARCHAR(1000) NULL,
  `Application_id` INT NOT NULL,
  `description` VARCHAR(1000) NULL,
  `tenant_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_EndpointURL_Application1`
    FOREIGN KEY (`Application_id`)
    REFERENCES `AppCloudDB`.`Application` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AppCloudDB`.`TenantAppType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AppCloudDB`.`TenantAppType` (
  `tenant_id` INT NOT NULL,
  `application_type_id` INT NOT NULL,
  CONSTRAINT `fk_TenantAppType_ApplicationType1`
    FOREIGN KEY (`application_type_id`)
    REFERENCES `AppCloudDB`.`ApplicationType` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AppCloudDB`.`ApplicationTypeRuntime`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AppCloudDB`.`ApplicationTypeRuntime` (
  `application_type_id` INT NOT NULL,
  `application_runtime_id` INT NOT NULL,
  CONSTRAINT `fk_ApplicationType_has_ApplicationRuntime_ApplicationType1`
    FOREIGN KEY (`application_type_id`)
    REFERENCES `AppCloudDB`.`ApplicationType` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ApplicationType_has_ApplicationRuntime_ApplicationRuntime1`
    FOREIGN KEY (`application_runtime_id`)
    REFERENCES `AppCloudDB`.`ApplicationRuntime` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Populate Data to `AppCloudDB`.`ApplicationTypeRuntime`
-- -----------------------------------------------------
INSERT INTO `ApplicationTypeRuntime` (`application_type_id`, `application_runtime_id`) VALUES
(1, 1);


-- -----------------------------------------------------
-- Table `AppCloudDB`.`TenanntRuntime`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AppCloudDB`.`TenanntRuntime` (
  `tenant_id` INT NOT NULL,
  `application_runtime_id` INT NOT NULL,
  CONSTRAINT `fk_TenanntRuntime_ApplicationRuntime1`
    FOREIGN KEY (`application_runtime_id`)
    REFERENCES `AppCloudDB`.`ApplicationRuntime` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AppCloudDB`.`ApplicationEvents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AppCloudDB`.`ApplicationEvents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `application_id` INT NOT NULL,
  `event_name` VARCHAR(45) NOT NULL,
  `event_status` VARCHAR(45) NULL,
  `timestamp` TIMESTAMP NOT NULL,
  `event_desc` VARCHAR(1000) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ApplicationEvents_Application1`
    FOREIGN KEY (`application_id`)
    REFERENCES `AppCloudDB`.`Application` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
