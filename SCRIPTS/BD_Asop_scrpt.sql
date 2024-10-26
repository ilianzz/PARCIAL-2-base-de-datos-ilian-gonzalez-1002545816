-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema asopros_ventas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema asopros_ventas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `asopros_ventas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `asopros_ventas` ;

-- -----------------------------------------------------
-- Table `asopros_ventas`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asopros_ventas`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  `direccion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `asopros_ventas`.`ordenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asopros_ventas`.`ordenes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NULL DEFAULT NULL,
  `fecha_orden` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `total` DECIMAL(10,2) NULL DEFAULT NULL,
  `estado` VARCHAR(20) NULL DEFAULT 'Pendiente',
  PRIMARY KEY (`id`),
  INDEX `cliente_id` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `ordenes_ibfk_1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `asopros_ventas`.`clientes` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `asopros_ventas`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asopros_ventas`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `descripcion` VARCHAR(100) NULL DEFAULT NULL,
  `imagen_url` VARCHAR(255) NULL DEFAULT NULL,
  `precio` DECIMAL(10,3) NULL DEFAULT NULL,
  `stock` INT NULL DEFAULT '0',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `asopros_ventas`.`detalles_orden`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asopros_ventas`.`detalles_orden` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `orden_id` INT NULL DEFAULT NULL,
  `producto_id` INT NULL DEFAULT NULL,
  `cantidad` INT NULL DEFAULT NULL,
  `precio` DECIMAL(10,2) NULL DEFAULT NULL,
  `subtotal` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `orden_id` (`orden_id` ASC) VISIBLE,
  INDEX `producto_id` (`producto_id` ASC) VISIBLE,
  CONSTRAINT `detalles_orden_ibfk_1`
    FOREIGN KEY (`orden_id`)
    REFERENCES `asopros_ventas`.`ordenes` (`id`),
  CONSTRAINT `detalles_orden_ibfk_2`
    FOREIGN KEY (`producto_id`)
    REFERENCES `asopros_ventas`.`productos` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `asopros_ventas`.`pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asopros_ventas`.`pagos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `orden_id` INT NULL DEFAULT NULL,
  `fecha_pago` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `metodo_pago` VARCHAR(50) NULL DEFAULT NULL,
  `cantidad_pagada` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `orden_id` (`orden_id` ASC) VISIBLE,
  CONSTRAINT `pagos_ibfk_1`
    FOREIGN KEY (`orden_id`)
    REFERENCES `asopros_ventas`.`ordenes` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
