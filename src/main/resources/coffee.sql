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
CREATE TABLE `user_order_list` (
  `id` integer PRIMARY KEY,
  `user_id` varchar(255),
  `amount` integer,
  `price` integer,
  `createdAt` timestamp
);
CREATE TABLE `unuser_order_list` (
  `email` varchar(255),
  `id` integer PRIMARY KEY,
  `amount` integer,
  `price` integer,
  `address` varchar(255),
  `address_number` varchar(255),
  `createdAt` timestamp
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
-- user_order_list.user_id -> users.id
ALTER TABLE `user_order_list` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
-- order_product.product_id -> product.id
ALTER TABLE `order_product` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);
-- order_product.order_id -> user_order_list.id
ALTER TABLE `order_product` ADD FOREIGN KEY (`order_id`) REFERENCES `user_order_list` (`id`);
-- order_product.order_id -> unuser_order_list.id
ALTER TABLE `order_product` ADD FOREIGN KEY (`order_id`) REFERENCES `unuser_order_list` (`id`);
-- product_image.file_id -> file.file_id
ALTER TABLE `product_image` ADD FOREIGN KEY (`file_id`) REFERENCES `file` (`file_id`);