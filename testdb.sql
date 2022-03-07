-- MySQL dump 10.13  Distrib 8.0.28, for Linux (x86_64)
--
-- Host: localhost    Database: shop
-- ------------------------------------------------------
-- Server version	8.0.28-0ubuntu0.20.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_880E0D76E7927C74` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tree_root` int DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `lft` int NOT NULL,
  `lvl` int NOT NULL,
  `rgt` int NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3AF34668A977936C` (`tree_root`),
  KEY `IDX_3AF34668727ACA70` (`parent_id`),
  CONSTRAINT `FK_3AF34668727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_3AF34668A977936C` FOREIGN KEY (`tree_root`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,NULL,NULL,'Малая бытовая техника','2022-03-06 15:00:00','2022-03-06 15:00:00',1,0,8,1),(2,NULL,1,'Электрочайники','2022-03-06 15:00:00','2022-03-06 15:00:00',2,1,3,1),(3,NULL,1,'Блендеры','2022-03-06 15:00:00','2022-03-06 15:00:00',4,1,5,1),(4,NULL,1,'Мультиварки','2022-03-06 15:00:00','2022-03-06 15:00:00',6,1,7,1),(5,NULL,NULL,'Крупная бытовая техника','2022-03-06 15:00:00','2022-03-06 15:00:00',9,0,16,1),(6,NULL,5,'Стиральные машины','2022-03-06 15:00:00','2022-03-06 15:00:00',10,1,11,1),(7,NULL,5,'Посудомоечные машины','2022-03-06 15:00:00','2022-03-06 15:00:00',12,1,13,1),(8,NULL,5,'Холодильники','2022-03-06 15:00:00','2022-03-06 15:00:00',14,1,15,1),(9,NULL,NULL,'ТВ и Аудио','2022-03-06 15:00:00','2022-03-06 15:00:00',17,0,22,1),(10,NULL,9,'Холодильники','2022-03-06 15:00:00','2022-03-06 15:00:00',18,1,19,1),(11,NULL,9,'Звуковые системы для ТВ','2022-03-06 15:00:00','2022-03-06 15:00:00',20,1,21,1);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messenger_messages`
--

LOCK TABLES `messenger_messages` WRITE;
/*!40000 ALTER TABLE `messenger_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messenger_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `products_id` int DEFAULT NULL,
  `is_delivered` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F5299398A76ED395` (`user_id`),
  KEY `IDX_F52993986C8A81A9` (`products_id`),
  CONSTRAINT `FK_F52993986C8A81A9` FOREIGN KEY (`products_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `rate` int DEFAULT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D34A04AD12469DE2` (`category_id`),
  CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,2,'Чайник Redmond SkyKettle','Дистанционное управление со смартфона через приложение Ready for Sky; блокировка панели управления','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,7500),(2,2,'Чайник Scarlett','Особенности двойные стенки, вращение на 360 градусов, индикатор уровня воды, отсек для хранения шнура','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,5400),(3,2,'Чайник Tefal','Производитель Tefal Серия Smart&Light Цвет Черный Гарантия 2 года','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,2600),(4,3,'Блендер Bosch','Работает без брызг благодаря специальной конструкции погружной части','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,7000),(5,3,'Блендер Scarlett','Поможет быстро и комфортно приготовить разнообразные блюда, требующие измельчения, перемалывания, взбивания или смешивания продуктов','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,4700),(6,3,'Блендер Redmond','Электродвигатель мощностью 800 Вт и закаленные лезвия из нержавеющей стали позволяют прибору с легкостью справляться с обработкой пищи различной твердости и консистенции.','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,3800),(7,4,'Мультиварка Moulinex','Мультиварка станет верным помощником в процессе приготовления супов, каш и тушеных блюд, выпечки и стерилизации','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,3500),(8,4,'Мультиварка Scarlett','Представлена в лаконичном серебристом корпусе с дисплеем и кнопочной панелью управления','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,2900),(9,4,'Мультиварка Redmond','Чаша вмещает 5 л и дополняется антипригарным покрытием. Оборудование поставляется вместе со съемным кабелем питания, чашей и контейнером для готовки на пару, ложкой и мерным стаканчиком','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,6000),(10,6,'Стиральная машина Indesit','Узкая стиральная машина Indesit  придётся по душе тем, кому нужно экономить место в квартире. Это современная модель с фронтальной загрузкой, обеспечивающая высокое качество стирки.','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,45000),(11,6,'Стиральная машина Candy','Стиральная машина Candy CSS4 1072DB1 рассчитана на загрузку 7 кг белья. Благодаря своей компактности она поместится в небольшую по площади комнату, а благодаря вместительности, подойдет для семьи из 2-3 человек. ','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,42000),(12,6,'Стиральная машина Bosch','Стиральная машина Bosch с серебристым корпусом и фронтальной загрузкой до 9 кг белья стала обладательницей инновационной системы предварительного замачивания PreSoaking. Принцип ее действия заключается в часовом замачивании особо загрязненного белья устройством, при котором его барабан совершает бережные движения, имитируя ручное застирывание','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,73000),(13,7,'Машина посудомоечная  Indesit','Посудомоечная машина Indesit DSFC 3T117 S – это сочетание компактности (ширина всего 45 см) и большой вместительности – за один раз можно «загрузить» десять комплектов. Верхний короб полностью снимается, что позволяет найти место даже для высоких кастрюль, кувшинов и прочей утвари.','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,32000),(14,7,'Машина посудомоечная  Bosch','Узкая эффективная и долговечная посудомоечная машина Bosch Serie | 2 SPS2IKW1CRв стильном дизайне вмещает до 9 комплектов посуды, имеет электронный тип управления и текстовый дисплей для контроля работы.','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,35000),(15,7,'Машина посудомоечная Hotpoint-Ariston','Функция задержки до 24 часов запуска программы стирки, позволяющая запускать посудомоечную машину в любое время суток, даже когда вы находитесь вне дома.','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,26000),(16,8,'Холодильник Indesit','Технология FRESHConverter поддерживает оптимальное состояние мяса, рыбы и овощей, хранящихся в вашем холодильнике','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,66000),(17,8,'Холодильник Haier','Технология FRESHBalancer  надежно удерживает влагу, а подвижные контроллеры поддерживают оптимальную влажность фруктов и овощей для выбранного вами режима.','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,76000),(18,8,'Холодильник LG','Линейный компрессор LG с преобразователем частоты поддерживает более стабильную температуру, помогая поддерживать внешний вид и вкус свежих продуктов','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,54000),(19,10,'Телевизор Xiaomi Mi 55','Отличное качество изображения для игр. Малая задержка ввода 20 мс при подключении через HDMI. Играйте на максимум. Погрузитесь в игру. Оцените улучшенную видимость в темных областях изображения, а также более высокую частоту обновления','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,85000),(20,10,'Телевизор PHILIPS 32','Процессор Philips Pixel Plus HD оптимизирует качество изображения и обеспечивает кристальную четкость и великолепную контрастность. При потоковой передаче или при просмотре кабельных каналов вы всегда будете наслаждаться четким изображением с яркими оттенками белого и глубокими оттенками черного','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,24000),(21,10,'Телевизор SkyLine 58','HD LED TV. Благодаря LED-подсветке уровень энергопотребления снижается, а показатели яркости изображения, контрастности и цветопередачи улучшаются.','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,55000),(22,11,'Саундбар Philips','Подключите к телевизору при помощи всего лишь одного оптического или HDMI-кабеля или транслируйте музыку со своего телефона при помощи встроенного Bluetooth. Dolby Digital','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,15000),(23,11,'Саундбар LG','Престижный Британский звук, Meridian','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,9000),(24,11,'Саундбар JBL','C 1977 года Meridian создает инновационные и элегантные решения с уникальными характеристиками для высокого качества звука.','2022-03-06 15:00:00','2022-03-06 15:00:00',1,NULL,22000);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_comments`
--

DROP TABLE IF EXISTS `products_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4A9F86994584665A` (`product_id`),
  CONSTRAINT `FK_4A9F86994584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_comments`
--

LOCK TABLES `products_comments` WRITE;
/*!40000 ALTER TABLE `products_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `products_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-06 23:13:13
