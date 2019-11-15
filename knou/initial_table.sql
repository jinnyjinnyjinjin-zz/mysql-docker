-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema 영화광
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema 영화광
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `영화광` ;
USE `영화광` ;

-- -----------------------------------------------------
-- Table `영화광`.`영화`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `영화광`.`영화` ;

CREATE TABLE IF NOT EXISTS `영화광`.`영화` (
  `코드번호` INT NOT NULL AUTO_INCREMENT,
  `제목` VARCHAR(45) NOT NULL,
  `제작년도` YEAR NOT NULL,
  `제작국가` VARCHAR(45) NOT NULL,
  `상영시간` INT NOT NULL,
  `개봉일자` DATE NOT NULL,
  `제작사` VARCHAR(45) NOT NULL,
  `배급사` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`코드번호`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `영화광`.`감독`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `영화광`.`감독` ;

CREATE TABLE IF NOT EXISTS `영화광`.`감독` (
  `등록번호` INT NOT NULL AUTO_INCREMENT,
  `이름` VARCHAR(45) NOT NULL,
  `성별` ENUM('남', '여') NOT NULL,
  `출생일` DATE NOT NULL,
  `출생지` VARCHAR(45) NOT NULL,
  `학력사항` VARCHAR(45) NULL,
  PRIMARY KEY (`등록번호`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `영화광`.`배우`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `영화광`.`배우` ;

CREATE TABLE IF NOT EXISTS `영화광`.`배우` (
  `번호` INT NOT NULL AUTO_INCREMENT,
  `생년월일` DATE NOT NULL,
  `이름` VARCHAR(45) NOT NULL,
  `성별` ENUM('남', '여') NOT NULL,
  `출생지` VARCHAR(45) NOT NULL,
  `키` FLOAT NULL,
  `몸무게` FLOAT NULL,
  `혈액형` ENUM('A', 'B', 'AB', 'O') NULL,
  PRIMARY KEY (`번호`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `영화광`.`장르`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `영화광`.`장르` ;

CREATE TABLE IF NOT EXISTS `영화광`.`장르` (
  `코드` INT NOT NULL AUTO_INCREMENT,
  `장르명` VARCHAR(45) NOT NULL,
  `영화_코드번호` INT NOT NULL,
  PRIMARY KEY (`코드`, `영화_코드번호`),
  UNIQUE INDEX `장르명_UNIQUE` (`장르명` ASC) VISIBLE,
  INDEX `fk_장르_영화1_idx` (`영화_코드번호` ASC) VISIBLE,
  CONSTRAINT `fk_장르_영화1`
    FOREIGN KEY (`영화_코드번호`)
    REFERENCES `영화광`.`영화` (`코드번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `영화광`.`디렉팅`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `영화광`.`디렉팅` ;

CREATE TABLE IF NOT EXISTS `영화광`.`디렉팅` (
  `영화_코드번호` INT NOT NULL,
  `감독_등록번호` INT NOT NULL,
  PRIMARY KEY (`영화_코드번호`, `감독_등록번호`),
  INDEX `fk_영화_has_감독_감독1_idx` (`감독_등록번호` ASC) VISIBLE,
  INDEX `fk_영화_has_감독_영화_idx` (`영화_코드번호` ASC) VISIBLE,
  CONSTRAINT `fk_영화_has_감독_영화`
    FOREIGN KEY (`영화_코드번호`)
    REFERENCES `영화광`.`영화` (`코드번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_영화_has_감독_감독1`
    FOREIGN KEY (`감독_등록번호`)
    REFERENCES `영화광`.`감독` (`등록번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `영화광`.`출연`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `영화광`.`출연` ;

CREATE TABLE IF NOT EXISTS `영화광`.`출연` (
  `영화_코드번호` INT NOT NULL,
  `배우_번호` INT NOT NULL,
  PRIMARY KEY (`영화_코드번호`, `배우_번호`),
  INDEX `fk_영화_has_배우_배우1_idx` (`배우_번호` ASC) VISIBLE,
  INDEX `fk_영화_has_배우_영화1_idx` (`영화_코드번호` ASC) VISIBLE,
  CONSTRAINT `fk_영화_has_배우_영화1`
    FOREIGN KEY (`영화_코드번호`)
    REFERENCES `영화광`.`영화` (`코드번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_영화_has_배우_배우1`
    FOREIGN KEY (`배우_번호`)
    REFERENCES `영화광`.`배우` (`번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
