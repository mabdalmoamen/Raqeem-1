ALTER TABLE `raqeem`.`types`
ADD
    COLUMN `is_print` TINYINT(1) NULL DEFAULT 0 AFTER `calc_count`;

ALTER TABLE `raqeem`.`bills`
ADD
    COLUMN `table_id` INT(11) NULL AFTER `bill_no`;

CREATE TABLE
    `raqeem`.`notes` (
        `id` INT NOT NULL AUTO_INCREMENT,
        `types_id` BIGINT(20) NOT NULL,
        `note` TEXT NULL,
        PRIMARY KEY (`id`),
        INDEX `tpe_id_note_idx` (`types_id` ASC),
        CONSTRAINT `tpe_id_note` FOREIGN KEY (`types_id`) REFERENCES `raqeem`.`types` (`type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
    );

DELETE FROM `raqeem`.`sales_type` WHERE (`id` = '1');

ALTER TABLE `raqeem`.`bills`
ADD
    COLUMN `return_sum` DOUBLE NULL DEFAULT 0 AFTER `offer_discount`,
ADD
    COLUMN `return_vat` DOUBLE NULL DEFAULT 0 AFTER `return_sum`;

ALTER TABLE
    `raqeem`.`mixins_info`
ADD
    COLUMN `codies_type` TINYINT(1) NULL DEFAULT 1 AFTER `weight`,
ADD
    COLUMN `country` TINYINT(2) NULL DEFAULT 2 AFTER `codies_type`;

ALTER TABLE
    `raqeem`.`tables` CHANGE COLUMN `table_no` `table_no` VARCHAR(255) NULL DEFAULT NULL;

ALTER TABLE
    `raqeem`.`tables_bill`
ADD
    COLUMN `bill_date` DATETIME NULL AFTER `user_id`;

ALTER TABLE `raqeem`.`users`
ADD
    COLUMN `status` TINYINT(1) NULL DEFAULT 0 AFTER `delete_main_type`,
ADD
    COLUMN `pin_code` VARCHAR(255) NULL AFTER `status`;

use codies;

CREATE TABLE
    `attendances` (
        `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
        `uid` int(11) NOT NULL DEFAULT '0',
        `created_at` timestamp NULL DEFAULT NULL,
        `updated_at` timestamp NULL DEFAULT NULL,
        `status` tinyint(1) DEFAULT '0',
        `leave_date` timestamp NULL DEFAULT NULL,
        `late_over` double DEFAULT '0',
        PRIMARY KEY (`id`),
        KEY `uid2s_idx` (`uid`),
        CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
    ) ENGINE = InnoDB AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8;

use codies;

CREATE TABLE
    `leaves` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `uid` int(11) NOT NULL DEFAULT '0',
        `status` tinyint(1) NOT NULL DEFAULT '1',
        `created_at` timestamp NULL DEFAULT NULL,
        `updated_at` timestamp NULL DEFAULT NULL,
        PRIMARY KEY (`id`),
        KEY `uid_idx` (`uid`),
        CONSTRAINT `uid2` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
    ) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT INTO
    `raqeem`.`barcodes` (
        `id`,
        `format`,
        `width`,
        `height`,
        `displayValue`,
        `text`,
        `fontOptions`,
        `font`,
        `textAlign`,
        `textPosition`,
        `textMargin`,
        `fontSize`,
        `background`,
        `lineColor`,
        `margin`,
        `flat`
    )
VALUES (
        '2',
        'CODE128',
        '2',
        '100',
        '1',
        '123451',
        'normal',
        'monospace',
        'center',
        'bottom',
        '2',
        '20',
        '#ffffff',
        '#000000',
        '9',
        '0'
    );

ALTER TABLE
    `raqeem`.`mixins_info`
ADD
    COLUMN `sale_type` INT(11) NULL AFTER `country`,
ADD
    INDEX `salType_idx` (`sale_type` ASC);

;

ALTER TABLE
    `raqeem`.`mixins_info`
ADD
    CONSTRAINT `salType` FOREIGN KEY (`sale_type`) REFERENCES `raqeem`.`sales_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `raqeem`.`bills`
ADD
    COLUMN `sale_type` INT(11) NULL AFTER `return_vat`,
ADD
    INDEX `stype_idx` (`sale_type` ASC);

;

ALTER TABLE `raqeem`.`bills`
ADD
    CONSTRAINT `stype` FOREIGN KEY (`sale_type`) REFERENCES `raqeem`.`sales_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

INSERT INTO
    `raqeem`.`sales_type` (`id`, `sill_type_discount`)
VALUES ('1', '0');

UPDATE `raqeem`.`sales_type`
SET `sill_type_name` = 'تجزئة'
WHERE (`id` = '1');

UPDATE `raqeem`.`mixins_info`
SET `sale_type` = '1'
WHERE (`id` = '1');

ALTER TABLE `raqeem`.`bills`
ADD
    COLUMN `sale_discount` DOUBLE NULL DEFAULT 0 AFTER `sale_type`;

ALTER TABLE
    `raqeem`.`types` CHANGE COLUMN `sell_unit` `sell_unit` INT(11) NULL DEFAULT NULL;

ALTER TABLE
    `raqeem`.`customers` CHANGE COLUMN `cust_balance` `cust_balance` DOUBLE NULL DEFAULT 0;

ALTER TABLE `raqeem`.`bills`
ADD
    COLUMN `sum_after_discount` DOUBLE NULL DEFAULT 0.0 AFTER `sale_discount`;

ALTER TABLE `raqeem`.`bills`
ADD
    COLUMN `is_included` TINYINT(1) NULL DEFAULT 0 AFTER `sum_after_discount`,
ADD
    COLUMN `vat` DOUBLE NULL DEFAULT 0 AFTER `is_included`;

ALTER TABLE
    `raqeem`.`customers`
ADD
    COLUMN `notes` VARCHAR(255) NULL AFTER `cust_vat_num`;

ALTER TABLE
    `raqeem`.`customers`
ADD
    COLUMN `notes` VARCHAR(255) NULL AFTER `cust_vat_num`;

ALTER TABLE
    `raqeem`.`customers`
ADD
    COLUMN `identity` VARCHAR(45) NULL AFTER `notes`;

ALTER TABLE `raqeem`.`mixins_info`
ADD COLUMN `show_side_menu` TINYINT(1) NULL DEFAULT 1 AFTER `sale_type`,
ADD COLUMN `as_card` TINYINT(1) NULL DEFAULT 0 AFTER `show_side_menu`;

ALTER TABLE
    `raqeem`.`tables` CHANGE COLUMN `is_resrved` `is_resrved` TINYINT(1) NULL DEFAULT '0';

ALTER TABLE `raqeem`.`tables`
ADD
    COLUMN `total` DOUBLE NULL AFTER `mini_charge`;


ALTER TABLE
    `raqeem`.`mixins_info`
ADD
    COLUMN `count_in_row_bill` VARCHAR(45) NULL DEFAULT 'col-4' AFTER `as_card`,
ADD
    COLUMN `count_in_row_main` VARCHAR(45) NULL DEFAULT 'col-4' AFTER `count_in_row_bill`;


ALTER TABLE
    `raqeem`.`mixins_info`
ADD
    COLUMN `printer_count` INT(11) NULL DEFAULT 1 AFTER `count_in_row_main`;

    ALTER TABLE
    `raqeem`.`mixins_info`
ADD
    COLUMN `pretty` TINYINT(1) NULL DEFAULT 1 AFTER `printer_count`;
