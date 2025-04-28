DROP TABLE IF EXISTS `order_product`;


CREATE TABLE `users` (
  `id` varchar(255) PRIMARY KEY,
  `password` varchar(255),
  `email` varchar(255),
  `tel` varchar(255),
  `address` varchar(255),
  `address_number` varchar(255),
  `role` varchar(255)
);
CREATE TABLE `product` (
  `id` integer PRIMARY KEY,
  `name` varchar(255),
  `price` integer,
  `amount` integer,
  `info` varchar(255)
);
CREATE TABLE `product_image` (
                                 `id` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
                                 `product_id` integer NOT NULL,
                                 `ORIGIN_FILE_NAME` varchar(255) NOT NULL,
                                 `RENAME_FILE_NAME` varchar(255) NOT NULL,
                                 `SAVE_PATH` varchar(255) NOT NULL,
                                 `CREATED_AT` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                 `ACTIVATED` tinyint(1) NOT NULL DEFAULT '1'
);

CREATE TABLE order_list (
                            `id` INT NOT NULL AUTO_INCREMENT,  -- order_id
                            `email` VARCHAR(255),
                            `address` VARCHAR(255),
                            `address_number` VARCHAR(255),
                            `total_amount` integer,
                            `total_price` integer,
                            `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            `is_member` BOOLEAN DEFAULT FALSE,         -- 회원 여부 (기본값은 비회원)
                            `user_id` varchar(255) DEFAULT NULL,       -- 회원일 경우 참조할 user 테이블 ID
                            PRIMARY KEY (id)
);
CREATE TABLE `order_product` (
                                 `id` integer PRIMARY KEY AUTO_INCREMENT,
                                 `order_id` integer,
                                 `product_id` integer,
                                 `amount` integer,
                                 `name` varchar(255)
);
CREATE TABLE `file` (
  `file_id` bigint PRIMARY KEY,
  `type` varchar(255),
  `name` varchar(255),
  `createdAt` timestamp
);
CREATE TABLE `product_image` (
  `file_id` bigint,
  `product_id` integer PRIMARY KEY
);
-- 외래키 추가 (product_image.product_id -> product.id)
ALTER TABLE `product_image` ADD CONSTRAINT `fk_product_image_product`
  FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

-- order_product.product_id -> product.id
ALTER TABLE `order_product` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);
-- product_image.file_id -> file.file_id
ALTER TABLE `product_image` ADD FOREIGN KEY (`file_id`) REFERENCES `file` (`file_id`);
