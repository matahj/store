-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema store
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `store` ;
USE `store` ;

-- -----------------------------------------------------
-- Table `store`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store`.`users` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `created_at` TIMESTAMP NOT NULL,
  `updated_at` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `store`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store`.`categories` (
  `id_category` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `slug` VARCHAR(45) NOT NULL COMMENT 'nombre de categoría, adaptado para url única.',
  `id_parent_category` INT NOT NULL,
  PRIMARY KEY (`id_category`),
  INDEX `fk_categories_categories1_idx` (`id_parent_category` ASC) VISIBLE,
  UNIQUE INDEX `slug_UNIQUE` (`slug` ASC) VISIBLE,
  CONSTRAINT `fk_categories_categories1`
    FOREIGN KEY (`id_parent_category`)
    REFERENCES `store`.`categories` (`id_category`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `store`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store`.`products` (
  `id_product` INT NOT NULL,
  `id_category` INT NOT NULL,
  `sku` VARCHAR(45) NOT NULL COMMENT 'Identificador interno único',
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `price` DOUBLE NOT NULL,
  `stock` INT NOT NULL,
  `is_active` TINYINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL,
  `updated_at` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_product`),
  UNIQUE INDEX `sku_UNIQUE` (`sku` ASC) VISIBLE,
  INDEX `fk_products_categories1_idx` (`id_category` ASC) VISIBLE,
  CONSTRAINT `fk_products_categories1`
    FOREIGN KEY (`id_category`)
    REFERENCES `store`.`categories` (`id_category`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `store`.`carts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store`.`carts` (
  `id_cart` INT NOT NULL,
  `id_user` INT NOT NULL COMMENT 'Cada usuario puede tener un solo carro de compras mientras compra',
  `updated_at` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cart`),
  INDEX `fk_carts_users_idx` (`id_user` ASC) VISIBLE,
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_carts_users`
    FOREIGN KEY (`id_user`)
    REFERENCES `store`.`users` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Cada carro existe mientas se hace la compra, cada cliente unicamente pude tener un carrito.';


-- -----------------------------------------------------
-- Table `store`.`cart_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store`.`cart_items` (
  `id_cart_item` INT NOT NULL,
  `id_cart` INT NOT NULL,
  `id_product` INT NOT NULL COMMENT 'En cada carrito los productos no se repiten, pero se puede modificar la cantidad.',
  `quantity` INT NOT NULL,
  PRIMARY KEY (`id_cart_item`),
  INDEX `fk_cart_items_carts1_idx` (`id_cart` ASC) VISIBLE,
  INDEX `fk_cart_items_products1_idx` (`id_product` ASC) VISIBLE,
  UNIQUE INDEX `id_product_UNIQUE` (`id_product` ASC) VISIBLE,
  CONSTRAINT `fk_cart_items_carts1`
    FOREIGN KEY (`id_cart`)
    REFERENCES `store`.`carts` (`id_cart`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_items_products1`
    FOREIGN KEY (`id_product`)
    REFERENCES `store`.`products` (`id_product`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Tabla dinámica, existe mientras see está haciendo la compra, cada carro tiene diferentes productos cada uno con su cantidad.';


-- -----------------------------------------------------
-- Table `store`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store`.`orders` (
  `id_order` INT NOT NULL,
  `id_user` INT NOT NULL,
  `status` ENUM('pending', 'paid', 'shipped', 'cancelled') NOT NULL,
  `subtotal` DOUBLE NOT NULL,
  `tax` DOUBLE NOT NULL,
  `shipment` DOUBLE NOT NULL,
  `total` DOUBLE NOT NULL,
  `created_at` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_order`),
  INDEX `fk_orders_users1_idx` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_orders_users1`
    FOREIGN KEY (`id_user`)
    REFERENCES `store`.`users` (`id_user`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `store`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store`.`order_items` (
  `id_order_item` INT NOT NULL,
  `id_order` INT NOT NULL,
  `id_product` INT NOT NULL,
  `quantity` INT NOT NULL,
  `unit_price` DOUBLE NOT NULL,
  PRIMARY KEY (`id_order_item`),
  INDEX `fk_order_items_orders1_idx` (`id_order` ASC) VISIBLE,
  INDEX `fk_order_items_products1_idx` (`id_product` ASC) VISIBLE,
  CONSTRAINT `fk_order_items_orders1`
    FOREIGN KEY (`id_order`)
    REFERENCES `store`.`orders` (`id_order`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products1`
    FOREIGN KEY (`id_product`)
    REFERENCES `store`.`products` (`id_product`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `store`.`invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store`.`invoices` (
  `id_invoice` INT NOT NULL,
  `invoice_number` VARCHAR(45) NOT NULL,
  `id_order` INT NOT NULL,
  `tax_id` VARCHAR(45) NOT NULL,
  `billing_address` TEXT NOT NULL,
  `issued_at` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_invoice`),
  INDEX `fk_invoices_orders1_idx` (`id_order` ASC) VISIBLE,
  UNIQUE INDEX `invoice_number_UNIQUE` (`invoice_number` ASC) VISIBLE,
  UNIQUE INDEX `id_order_UNIQUE` (`id_order` ASC) VISIBLE,
  CONSTRAINT `fk_invoices_orders1`
    FOREIGN KEY (`id_order`)
    REFERENCES `store`.`orders` (`id_order`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
