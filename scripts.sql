-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema estoredb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema estoredb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `estoredb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `estoredb` ;

-- -----------------------------------------------------
-- Table `estoredb`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoredb`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `sobrenome` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `senha` VARCHAR(255) NULL DEFAULT NULL,
  `data_nascimento` DATE NULL DEFAULT NULL,
  `cpf` INT NULL DEFAULT NULL,
  `sexo` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `estoredb`.`cartoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoredb`.`cartoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `num` INT NULL DEFAULT NULL,
  `data_vencimento` DATE NULL DEFAULT NULL,
  `nome_proprietario` VARCHAR(255) NULL DEFAULT NULL,
  `cvv` INT NULL DEFAULT NULL,
  `cliente_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `cliente_id` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `cartoes_ibfk_1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `estoredb`.`clientes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `estoredb`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoredb`.`categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `estoredb`.`unidade_federativa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoredb`.`unidade_federativa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `estoredb`.`cidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoredb`.`cidades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `uf_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `uf_id` (`uf_id` ASC) VISIBLE,
  CONSTRAINT `cidades_ibfk_1`
    FOREIGN KEY (`uf_id`)
    REFERENCES `estoredb`.`unidade_federativa` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `estoredb`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoredb`.`endereco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(255) NULL DEFAULT NULL,
  `numero` INT NULL DEFAULT NULL,
  `tipo` ENUM('residencial', 'comercial') NULL DEFAULT NULL,
  `cep` INT NULL DEFAULT NULL,
  `cidade_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `cidade_id` (`cidade_id` ASC) VISIBLE,
  CONSTRAINT `cidade_id`
    FOREIGN KEY (`cidade_id`)
    REFERENCES `estoredb`.`cidades` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `estoredb`.`feedback_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoredb`.`feedback_cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NULL DEFAULT NULL,
  `descricao` VARCHAR(255) NULL DEFAULT NULL,
  `cliente_id` INT NULL DEFAULT NULL,
  `data_postagem` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `cliente_id` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `feedback_cliente_ibfk_1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `estoredb`.`clientes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `estoredb`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoredb`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NULL DEFAULT NULL,
  `data` DATE NULL DEFAULT NULL,
  `status` ENUM('pendente', 'enviado', 'entregue') NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `cliente_id` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `pedidos_ibfk_1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `estoredb`.`clientes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `estoredb`.`produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoredb`.`produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NULL DEFAULT NULL,
  `descricao` VARCHAR(255) NULL DEFAULT NULL,
  `preco` DECIMAL(12,2) NULL DEFAULT NULL,
  `qtd_estoque` INT NULL DEFAULT NULL,
  `sku` INT NULL DEFAULT NULL,
  `peso` DECIMAL(10,2) NULL DEFAULT NULL,
  `imagem` VARCHAR(455) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `estoredb`.`produto_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoredb`.`produto_categoria` (
  `fk_id_prod` INT NOT NULL,
  `fk_id_cat` INT NOT NULL,
  PRIMARY KEY (`fk_id_prod`, `fk_id_cat`),
  INDEX `fk_id_cat` (`fk_id_cat` ASC) VISIBLE,
  CONSTRAINT `produto_categoria_ibfk_1`
    FOREIGN KEY (`fk_id_prod`)
    REFERENCES `estoredb`.`produtos` (`id`),
  CONSTRAINT `produto_categoria_ibfk_2`
    FOREIGN KEY (`fk_id_cat`)
    REFERENCES `estoredb`.`categorias` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `estoredb`.`produtos_pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoredb`.`produtos_pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_produto` INT NULL DEFAULT NULL,
  `id_pedido` INT NULL DEFAULT NULL,
  `quantidade` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_produto` (`id_produto` ASC) VISIBLE,
  INDEX `id_pedido` (`id_pedido` ASC) VISIBLE,
  CONSTRAINT `produtos_pedidos_ibfk_1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `estoredb`.`produtos` (`id`),
  CONSTRAINT `produtos_pedidos_ibfk_2`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `estoredb`.`pedidos` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `estoredb`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estoredb`.`telefone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cell_1` INT NULL DEFAULT NULL,
  `cell_2` INT NULL DEFAULT NULL,
  `id_owner` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_owner` (`id_owner` ASC) VISIBLE,
  CONSTRAINT `telefone_ibfk_1`
    FOREIGN KEY (`id_owner`)
    REFERENCES `estoredb`.`clientes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
