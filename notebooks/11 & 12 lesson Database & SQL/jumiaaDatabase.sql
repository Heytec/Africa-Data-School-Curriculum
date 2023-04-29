DROP DATABASE IF EXISTS `jumiaa_invoicing`;
CREATE DATABASE `jumiaa_invoicing`; 
USE `jumiaa_invoicing`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE `payment_methods` (
  `payment_method_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `payment_methods` VALUES (1,'Mpesa');
INSERT INTO `payment_methods` VALUES (2,'Cash');
INSERT INTO `payment_methods` VALUES (3,'paystack');
INSERT INTO `payment_methods` VALUES (4,'Wire Transfer');

CREATE TABLE `clients` (
  `client_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `code` char(2) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `clients` VALUES (1,'Sindu','3 South Africa','Cape town','NY','315-252-7305');
INSERT INTO `clients` VALUES (2,'Myworks','Kenya','Nairobi','WV','304-659-1170');
INSERT INTO `clients` VALUES (3,'Yadel','Zambia','Lusaka','CA','415-144-6037');
INSERT INTO `clients` VALUES (4,'Kwideo','Ethiopia','Addis','TX','254-750-0784');
INSERT INTO `clients` VALUES (5,'Topiclounge','Sudan','Khartoum','OR','971-888-9129');

CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL,
  `number` varchar(50) NOT NULL,
  `client_id` int(11) NOT NULL,
  `invoice_total` decimal(9,2) NOT NULL,
  `payment_total` decimal(9,2) NOT NULL DEFAULT '0.00',
  `invoice_date` date NOT NULL,
  `due_date` date NOT NULL,
  `payment_date` date DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `FK_client_id` (`client_id`),
  CONSTRAINT `FK_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `invoices` VALUES (1,'91-953-3396',2,101.79,0.00,'2019-03-09','2019-03-29',NULL);
INSERT INTO `invoices` VALUES (2,'03-898-6735',5,175.32,8.18,'2019-06-11','2019-07-01','2019-02-12');
INSERT INTO `invoices` VALUES (3,'20-228-0335',5,147.99,0.00,'2019-07-31','2019-08-20',NULL);
INSERT INTO `invoices` VALUES (4,'56-934-0748',3,152.21,0.00,'2019-03-08','2019-03-28',NULL);
INSERT INTO `invoices` VALUES (5,'87-052-3121',5,169.36,0.00,'2019-07-18','2019-08-07',NULL);
INSERT INTO `invoices` VALUES (6,'75-587-6626',1,157.78,74.55,'2019-01-29','2019-02-18','2019-01-03');
INSERT INTO `invoices` VALUES (7,'68-093-9863',3,133.87,0.00,'2019-09-04','2019-09-24',NULL);
INSERT INTO `invoices` VALUES (8,'78-145-1093',1,189.12,0.00,'2019-05-20','2019-06-09',NULL);
INSERT INTO `invoices` VALUES (9,'77-593-0081',5,172.17,0.00,'2019-07-09','2019-07-29',NULL);
INSERT INTO `invoices` VALUES (10,'48-266-1517',1,159.50,0.00,'2019-06-30','2019-07-20',NULL);
INSERT INTO `invoices` VALUES (11,'20-848-0181',3,126.15,0.03,'2019-01-07','2019-01-27','2019-01-11');
INSERT INTO `invoices` VALUES (13,'41-666-1035',5,135.01,87.44,'2019-06-25','2019-07-15','2019-01-26');
INSERT INTO `invoices` VALUES (15,'55-105-9605',3,167.29,80.31,'2019-11-25','2019-12-15','2019-01-15');
INSERT INTO `invoices` VALUES (16,'10-451-8824',1,162.02,0.00,'2019-03-30','2019-04-19',NULL);
INSERT INTO `invoices` VALUES (17,'33-615-4694',3,126.38,68.10,'2019-07-30','2019-08-19','2019-01-15');
INSERT INTO `invoices` VALUES (18,'52-269-9803',5,180.17,42.77,'2019-05-23','2019-06-12','2019-01-08');
INSERT INTO `invoices` VALUES (19,'83-559-4105',1,134.47,0.00,'2019-11-23','2019-12-13',NULL);

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(9,2) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `fk_client_id_idx` (`client_id`),
  KEY `fk_invoice_id_idx` (`invoice_id`),
  KEY `fk_payment_payment_method_idx` (`payment_method`),
  CONSTRAINT `fk_payment_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_payment_method` FOREIGN KEY (`payment_method`) REFERENCES `payment_methods` (`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `payments` VALUES (1,5,2,'2019-02-12',8.18,1);
INSERT INTO `payments` VALUES (2,1,6,'2019-01-03',74.55,1);
INSERT INTO `payments` VALUES (3,3,11,'2019-01-11',0.03,1);
INSERT INTO `payments` VALUES (4,5,13,'2019-01-26',87.44,1);
INSERT INTO `payments` VALUES (5,3,15,'2019-01-15',80.31,1);
INSERT INTO `payments` VALUES (6,3,17,'2019-01-15',68.10,1);
INSERT INTO `payments` VALUES (7,5,18,'2019-01-08',32.77,1);
INSERT INTO `payments` VALUES (8,5,18,'2019-01-08',10.00,2);


DROP DATABASE IF EXISTS `jumiaa_store`;
CREATE DATABASE `jumiaa_store`;
USE `jumiaa_store`;

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `quantity_in_stock` int(11) NOT NULL,
  `unit_price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `products` VALUES (1,'Ugali',70,1.21);
INSERT INTO `products` VALUES (2,'Pork ',49,4.65);
INSERT INTO `products` VALUES (3,'Fufu',38,3.35);
INSERT INTO `products` VALUES (4,'Brocolinni ',90,4.53);
INSERT INTO `products` VALUES (5,'Pepe-Sauce',94,1.63);
INSERT INTO `products` VALUES (6,'Chapati',14,2.39);
INSERT INTO `products` VALUES (7,'Mukimo',98,3.29);
INSERT INTO `products` VALUES (8,'Kenkey',26,0.74);
INSERT INTO `products` VALUES (9,'Ghana jollof',67,2.26);
INSERT INTO `products` VALUES (10,'Nigeria jollof',6,1.09);


CREATE TABLE `shippers` (
  `shipper_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`shipper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `shippers` VALUES (1,'DHH');
INSERT INTO `shippers` VALUES (2,'SENDY');
INSERT INTO `shippers` VALUES (3,'g4s');
INSERT INTO `shippers` VALUES (4,'fedex');
INSERT INTO `shippers` VALUES (5,'Ads');


CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` char(2) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `customers` VALUES (1,'Joe','Mutale','1986-03-28','781-932-9754','0 Saace','Nairobi','MA',2273);
INSERT INTO `customers` VALUES (2,'Fred','Vilakati ','1986-04-13','804-427-9456',' Coml','Cape','VA',947);
INSERT INTO `customers` VALUES (3,'Brian','Muyuda','1985-02-07','719-724-7869',' Junction','Dodoma','CO',2967);
INSERT INTO `customers` VALUES (4,'John','Muchiri','1974-04-14','407-231-8017',' Terrace','Mombasa','FL',457);
INSERT INTO `customers` VALUES (5,'Clemmie','Banda','1973-11-07',NULL,'5 Spohn','Kisumu','Ks',3675);
INSERT INTO `customers` VALUES (6,'Elka','Nyambura','1991-09-04','312-480-8498','14Drive','Kampala','IL',3073);
INSERT INTO `customers` VALUES (7,'Ilene','Otile','1964-08-30','615-641-4759',' Crossing','Lusaka','TN',1672);
INSERT INTO `customers` VALUES (8,'Chirs','Brown','1993-07-17','941-527-3977',' Center','Abuja','FL',205);
INSERT INTO `customers` VALUES (9,'Mutula','Kilonzo','1992-05-23','559-181-3744',' Trail','Addis','CA',1486);
INSERT INTO `customers` VALUES (10,'Uhuru','Corupt','1969-10-13','404-246-3370',' Avenue','Lagos','GA',796);


CREATE TABLE `order_statuses` (
  `order_status_id` tinyint(4) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`order_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `order_statuses` VALUES (1,'Processed');
INSERT INTO `order_statuses` VALUES (2,'Shipped');
INSERT INTO `order_statuses` VALUES (3,'Delivered');


CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `comments` varchar(2000) DEFAULT NULL,
  `shipped_date` date DEFAULT NULL,
  `shipper_id` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_orders_customers_idx` (`customer_id`),
  KEY `fk_orders_shippers_idx` (`shipper_id`),
  KEY `fk_orders_order_statuses_idx` (`status`),
  CONSTRAINT `fk_orders_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_order_statuses` FOREIGN KEY (`status`) REFERENCES `order_statuses` (`order_status_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_shippers` FOREIGN KEY (`shipper_id`) REFERENCES `shippers` (`shipper_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `orders` VALUES (1,6,'2019-01-30',1,NULL,NULL,NULL);
INSERT INTO `orders` VALUES (2,7,'2018-08-02',2,NULL,'2018-08-03',4);
INSERT INTO `orders` VALUES (3,8,'2017-12-01',1,NULL,NULL,NULL);
INSERT INTO `orders` VALUES (4,2,'2017-01-22',1,NULL,NULL,NULL);
INSERT INTO `orders` VALUES (5,5,'2017-08-25',2,'','2017-08-26',3);
INSERT INTO `orders` VALUES (6,10,'2018-11-18',1,'nIAJE BRO.',NULL,NULL);
INSERT INTO `orders` VALUES (7,2,'2018-09-22',2,NULL,'2018-09-23',4);
INSERT INTO `orders` VALUES (8,5,'2018-06-08',1,'uKO AJE.',NULL,NULL);
INSERT INTO `orders` VALUES (9,10,'2017-07-05',2,'saa ngapi.','2017-07-06',1);
INSERT INTO `orders` VALUES (10,6,'2018-04-22',2,NULL,'2018-04-23',2);


CREATE TABLE `order_items` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_order_items_products_idx` (`product_id`),
  CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `order_items` VALUES (1,4,4,3.74);
INSERT INTO `order_items` VALUES (2,1,2,9.10);
INSERT INTO `order_items` VALUES (2,4,4,1.66);
INSERT INTO `order_items` VALUES (2,6,2,2.94);
INSERT INTO `order_items` VALUES (3,3,10,9.12);
INSERT INTO `order_items` VALUES (4,3,7,6.99);
INSERT INTO `order_items` VALUES (4,10,7,6.40);
INSERT INTO `order_items` VALUES (5,2,3,9.89);
INSERT INTO `order_items` VALUES (6,1,4,8.65);
INSERT INTO `order_items` VALUES (6,2,4,3.28);
INSERT INTO `order_items` VALUES (6,3,4,7.46);
INSERT INTO `order_items` VALUES (6,5,1,3.45);
INSERT INTO `order_items` VALUES (7,3,7,9.17);
INSERT INTO `order_items` VALUES (8,5,2,6.94);
INSERT INTO `order_items` VALUES (8,8,2,8.59);
INSERT INTO `order_items` VALUES (9,6,5,7.28);
INSERT INTO `order_items` VALUES (10,1,10,6.01);
INSERT INTO `order_items` VALUES (10,9,9,4.28);

CREATE TABLE `jumiaa_store`.`order_item_notes` (
  `note_id` INT NOT NULL,
  `order_Id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `note` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`note_id`));

INSERT INTO `order_item_notes` (`note_id`, `order_Id`, `product_id`, `note`) VALUES ('1', '1', '2', 'first note');
INSERT INTO `order_item_notes` (`note_id`, `order_Id`, `product_id`, `note`) VALUES ('2', '1', '2', 'second note');


DROP DATABASE IF EXISTS `jumiaa_hr`;
CREATE DATABASE `jumiaa_hr`;
USE `jumiaa_hr`;


CREATE TABLE `offices` (
  `office_id` int(11) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  PRIMARY KEY (`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `offices` VALUES (1,'03 Davido','Abuja','OH');
INSERT INTO `offices` VALUES (2,'55 Nameless',' City','NY');
INSERT INTO `offices` VALUES (3,'54 Burna','Lagos','VA');
INSERT INTO `offices` VALUES (4,'08 Eazy','concity','OH');
INSERT INTO `offices` VALUES (5,'553 Maple ','trex','MN');
INSERT INTO `offices` VALUES (6,'23 Maberc','Aurora','CO');
INSERT INTO `offices` VALUES (7,'9658  Court','Boise','ID');
INSERT INTO `offices` VALUES (8,'9  Trail','New York City','NY');
INSERT INTO `offices` VALUES (9,' Hill','Knoxville','TN');
INSERT INTO `offices` VALUES (10,'4  Parkway','Savannah','GA');



CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `job_title` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `reports_to` int(11) DEFAULT NULL,
  `office_id` int(11) NOT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `fk_employees_offices_idx` (`office_id`),
  KEY `fk_employees_employees_idx` (`reports_to`),
  CONSTRAINT `fk_employees_managers` FOREIGN KEY (`reports_to`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_employees_offices` FOREIGN KEY (`office_id`) REFERENCES `offices` (`office_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `employees` VALUES (37270,'Felix','Muriuki','Executive ',63996,NULL,10);
INSERT INTO `employees` VALUES (33391,'Fred','Mureithi','Account ',62871,37270,1);
INSERT INTO `employees` VALUES (37851,'Paul','Pogba','Football',98926,37270,1);
INSERT INTO `employees` VALUES (40448,'Fred','Machokaa','Staff ',94860,37270,1);
INSERT INTO `employees` VALUES (56274,'Keriann','Mbapee',' Marketing',110150,37270,1);
INSERT INTO `employees` VALUES (63196,'Danson','Njiru','Assistant',32179,37270,2);
INSERT INTO `employees` VALUES (67009,'Mark','Nderitu','Product ',114257,37270,2);
INSERT INTO `employees` VALUES (67370,'Frank','Kinyua','Worker',96767,37270,2);
INSERT INTO `employees` VALUES (68249,'sse','Vo','Financial Advisor',52832,37270,2);
INSERT INTO `employees` VALUES (72540,'threy','petti',' Assistant I',117690,37270,3);
INSERT INTO `employees` VALUES (72913,'Kass','Hefferan',' Analyst ',96401,37270,3);
INSERT INTO `employees` VALUES (75900,'Hamza','Goodrum','Manager',54578,37270,3);
INSERT INTO `employees` VALUES (76196,'illa','Janowski','Accountant',119241,37270,3);
INSERT INTO `employees` VALUES (80529,'Lyndia','Nyambura','Junior ',77182,37270,4);
INSERT INTO `employees` VALUES (80679,'Beracort','Sokale','Geolo',67987,37270,4);
INSERT INTO `employees` VALUES (84791,'Hazel','Apondi','Manager',93760,37270,4);
INSERT INTO `employees` VALUES (95213,'Fela','Kuti','Pharmacist',86119,37270,4);
INSERT INTO `employees` VALUES (96513,'Theresa','Otieno',' Chemist',47354,37270,5);
INSERT INTO `employees` VALUES (98374,'Adam','Kibaki','Staff Accountant ',70187,37270,5);
INSERT INTO `employees` VALUES (115357,'Fiona','Kiruja',' Engineer',92710,37270,5);


DROP DATABASE IF EXISTS `jumiaa_inventory`;
CREATE DATABASE `jumiaa_inventory`;
USE `jumiaa_inventory`;


CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `quantity_in_stock` int(11) NOT NULL,
  `unit_price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `products` VALUES (1,'Ugali',70,1.21);
INSERT INTO `products` VALUES (2,'Pork - Bacon,back Peameal',49,4.65);
INSERT INTO `products` VALUES (3,'Fufu',38,3.35);
INSERT INTO `products` VALUES (4,'Brocolinni',90,4.53);
INSERT INTO `products` VALUES (5,'Pepe Sauce ',94,1.63);
INSERT INTO `products` VALUES (6,'Chapati',14,2.39);
INSERT INTO `products` VALUES (7,'Mukimo',98,3.29);
INSERT INTO `products` VALUES (8,'Kenkey',26,0.74);
INSERT INTO `products` VALUES (9,'Ghana jollof',67,2.26);
INSERT INTO `products` VALUES (10,'Nigeria jollof',6,1.09);

