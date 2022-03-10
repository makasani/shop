-- phpMyAdmin SQL Dump
-- version 5.0.4deb2ubuntu5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 10, 2022 at 03:17 AM
-- Server version: 8.0.28-0ubuntu0.21.10.3
-- PHP Version: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `tree_root` int DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `lft` int NOT NULL,
  `lvl` int NOT NULL,
  `rgt` int NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `tree_root`, `parent_id`, `title`, `created_at`, `updated_at`, `lft`, `lvl`, `rgt`, `is_active`) VALUES
(1, 1, NULL, 'Малая бытовая техника', '2022-03-08 21:31:11', '2022-03-08 21:31:11', 1, 0, 8, 1),
(2, 1, 1, 'Электрочайники', '2022-03-08 21:31:19', '2022-03-08 21:31:19', 2, 1, 3, 1),
(3, 1, 1, 'Блендеры', '2022-03-08 21:31:26', '2022-03-08 21:31:26', 4, 1, 5, 1),
(4, 1, 1, 'Мультиварки', '2022-03-08 21:31:37', '2022-03-08 21:31:37', 6, 1, 7, 1),
(5, 5, NULL, 'Крупная бытовая техника', '2022-03-08 21:31:43', '2022-03-08 21:31:43', 1, 0, 8, 1),
(6, 5, 5, 'Стиральные машины', '2022-03-08 21:31:50', '2022-03-08 21:31:50', 2, 1, 3, 1),
(7, 5, 5, 'Посудомоечные машины', '2022-03-08 21:31:57', '2022-03-08 21:31:57', 4, 1, 5, 1),
(8, 5, 5, 'Холодильники', '2022-03-08 21:32:03', '2022-03-08 21:32:03', 6, 1, 7, 1),
(9, 9, NULL, 'ТВ и Аудио', '2022-03-08 21:32:09', '2022-03-08 21:32:09', 1, 0, 6, 1),
(10, 9, 9, 'Телевизоры', '2022-03-08 21:32:16', '2022-03-08 21:32:16', 2, 1, 3, 1),
(11, 9, 9, 'Звуковые системы для ТВ', '2022-03-08 21:32:24', '2022-03-08 21:32:24', 4, 1, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `order_products_id` int DEFAULT NULL,
  `status` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `rate` int DEFAULT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `category_id`, `title`, `description`, `created_at`, `updated_at`, `is_active`, `rate`, `price`) VALUES
(1, 2, 'Чайник Redmond SkyKettle', 'Дистанционное управление со смартфона через приложение Ready for Sky; блокировка панели управления', '2022-03-08 21:32:57', '2022-03-08 21:32:57', 1, 2, 7500),
(2, 2, 'Чайник Scarlett', 'Особенности двойные стенки, вращение на 360 градусов, индикатор уровня воды, отсек для хранения шнура', '2022-03-08 21:33:13', '2022-03-08 21:33:13', 1, 5, 5400),
(3, 2, 'Чайник Tefal', 'Производитель Tefal Серия Smart&Light Цвет Черный Гарантия 2 года', '2022-03-08 21:33:29', '2022-03-08 21:33:29', 1, 4, 2600),
(4, 3, 'Блендер Bosch', 'Работает без брызг благодаря специальной конструкции погружной части', '2022-03-08 21:33:44', '2022-03-08 21:33:44', 1, 5, 7000),
(5, 3, 'Блендер Scarlett', 'Поможет быстро и комфортно приготовить разнообразные блюда, требующие измельчения, перемалывания, взбивания или смешивания продуктов', '2022-03-08 21:34:01', '2022-03-08 21:34:01', 1, 3, 4700),
(6, 3, 'Блендер Redmond', 'Электродвигатель мощностью 800 Вт и закаленные лезвия из нержавеющей стали позволяют прибору с легкостью справляться с обработкой пищи различной твердости и консистенции.', '2022-03-08 21:34:19', '2022-03-08 21:34:19', 1, 5, 3800),
(7, 4, 'Мультиварка Moulinex', 'Мультиварка станет верным помощником в процессе приготовления супов, каш и тушеных блюд, выпечки и стерилизации', '2022-03-08 21:34:33', '2022-03-08 21:34:33', 1, 2, 3500),
(8, 4, 'Мультиварка Scarlett', 'Представлена в лаконичном серебристом корпусе с дисплеем и кнопочной панелью управления', '2022-03-08 21:34:47', '2022-03-08 21:34:47', 1, 4, 2900),
(9, 4, 'Мультиварка Redmond', 'Чаша вмещает 5 л и дополняется антипригарным покрытием. Оборудование поставляется вместе со съемным кабелем питания, чашей и контейнером для готовки на пару, ложкой и мерным стаканчиком', '2022-03-08 21:35:02', '2022-03-08 21:35:02', 1, 5, 6000),
(10, 6, 'Стиральная машина Indesit', 'Узкая стиральная машина Indesit  придётся по душе тем, кому нужно экономить место в квартире. Это современная модель с фронтальной загрузкой, обеспечивающая высокое качество стирки.', '2022-03-08 21:35:24', '2022-03-08 21:35:24', 1, 5, 45000),
(11, 6, 'Стиральная машина Candy', 'Стиральная машина Candy CSS4 1072DB1 рассчитана на загрузку 7 кг белья. Благодаря своей компактности она поместится в небольшую по площади комнату, а благодаря вместительности, подойдет для семьи из 2-3 человек.', '2022-03-08 21:35:36', '2022-03-08 21:35:36', 1, 1, 42000),
(12, 6, 'Стиральная машина Bosch', 'Стиральная машина Bosch с серебристым корпусом и фронтальной загрузкой до 9 кг белья стала обладательницей инновационной системы предварительного замачивания PreSoaking. Принцип ее действия заключается в часовом замачивании особо загрязненного белья устройством, при котором его барабан совершает бережные движения, имитируя ручное застирывание', '2022-03-08 21:35:50', '2022-03-08 21:35:50', 1, 5, 73000),
(13, 7, 'Машина посудомоечная  Indesit', 'Посудомоечная машина Indesit DSFC 3T117 S – это сочетание компактности (ширина всего 45 см) и большой вместительности – за один раз можно «загрузить» десять комплектов. Верхний короб полностью снимается, что позволяет найти место даже для высоких кастрюль, кувшинов и прочей утвари.', '2022-03-08 21:36:08', '2022-03-08 21:36:08', 1, 4, 32000),
(14, 7, 'Машина посудомоечная  Bosch', 'Узкая эффективная и долговечная посудомоечная машина Bosch Serie | 2 SPS2IKW1CRв стильном дизайне вмещает до 9 комплектов посуды, имеет электронный тип управления и текстовый дисплей для контроля работы.', '2022-03-08 21:36:29', '2022-03-08 21:36:29', 1, 4, 35000),
(15, 7, 'Машина посудомоечная Hotpoint-Ariston', 'Функция задержки до 24 часов запуска программы стирки, позволяющая запускать посудомоечную машину в любое время суток, даже когда вы находитесь вне дома.', '2022-03-08 21:36:47', '2022-03-08 21:36:47', 1, 3, 26000),
(16, 8, 'Холодильник Indesit', 'Технология FRESHConverter поддерживает оптимальное состояние мяса, рыбы и овощей, хранящихся в вашем холодильнике', '2022-03-08 21:37:04', '2022-03-08 21:37:04', 1, 4, 66000),
(17, 8, 'Холодильник Haier', 'Технология FRESHBalancer  надежно удерживает влагу, а подвижные контроллеры поддерживают оптимальную влажность фруктов и овощей для выбранного вами режима.', '2022-03-08 21:37:20', '2022-03-08 21:37:20', 1, 1, 76000),
(18, 8, 'Холодильник LG', 'Линейный компрессор LG с преобразователем частоты поддерживает более стабильную температуру, помогая поддерживать внешний вид и вкус свежих продуктов', '2022-03-08 21:37:33', '2022-03-08 21:37:33', 1, 4, 54000),
(19, 10, 'Телевизор Xiaomi Mi 55', 'Отличное качество изображения для игр. Малая задержка ввода 20 мс при подключении через HDMI. Играйте на максимум. Погрузитесь в игру. Оцените улучшенную видимость в темных областях изображения, а также более высокую частоту обновления', '2022-03-08 21:37:53', '2022-03-08 21:37:53', 1, 5, 85000),
(20, 10, 'Телевизор PHILIPS 32', 'Процессор Philips Pixel Plus HD оптимизирует качество изображения и обеспечивает кристальную четкость и великолепную контрастность. При потоковой передаче или при просмотре кабельных каналов вы всегда будете наслаждаться четким изображением с яркими оттенками белого и глубокими оттенками черного', '2022-03-08 21:38:11', '2022-03-08 21:38:11', 1, 2, 24000),
(21, 10, 'Телевизор SkyLine 58', 'HD LED TV. Благодаря LED-подсветке уровень энергопотребления снижается, а показатели яркости изображения, контрастности и цветопередачи улучшаются.', '2022-03-08 21:38:27', '2022-03-08 21:38:27', 1, 3, 55000),
(22, 11, 'Саундбар Philips', 'Подключите к телевизору при помощи всего лишь одного оптического или HDMI-кабеля или транслируйте музыку со своего телефона при помощи встроенного Bluetooth. Dolby Digital', '2022-03-08 21:38:42', '2022-03-08 21:38:42', 1, 3, 15000),
(23, 11, 'Саундбар LG', 'Престижный Британский звук, Meridian', '2022-03-08 21:38:54', '2022-03-08 21:38:54', 1, 4, 9000),
(24, 11, 'Саундбар JBL', 'C 1977 года Meridian создает инновационные и элегантные решения с уникальными характеристиками для высокого качества звука.', '2022-03-08 21:39:14', '2022-03-08 21:39:14', 1, 5, 22000);

-- --------------------------------------------------------

--
-- Table structure for table `products_comments`
--

CREATE TABLE `products_comments` (
  `id` int NOT NULL,
  `product_id` int NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `user_id` int NOT NULL,
  `rate` smallint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products_comments`
--

INSERT INTO `products_comments` (`id`, `product_id`, `description`, `created_at`, `user_id`, `rate`) VALUES
(1, 1, 'Комментарий несущий в себе глубокий смысл)', '2022-03-10 03:15:09', 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `email` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `name`) VALUES
(1, 'admin@test.loc', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$BD/p2GsGrpVjvvRsXfaKhg$OHBDU6E8JPKODLrbLxTYujWggwKSl1PKAAIwWclHRc4', 'Administrator');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_3AF34668A977936C` (`tree_root`),
  ADD KEY `IDX_3AF34668727ACA70` (`parent_id`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F5299398A76ED395` (`user_id`),
  ADD KEY `IDX_F52993987738FE2F` (`order_products_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D34A04AD12469DE2` (`category_id`);

--
-- Indexes for table `products_comments`
--
ALTER TABLE `products_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_4A9F86994584665A` (`product_id`),
  ADD KEY `IDX_4A9F8699A76ED395` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `products_comments`
--
ALTER TABLE `products_comments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `FK_3AF34668727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_3AF34668A977936C` FOREIGN KEY (`tree_root`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `FK_F52993987738FE2F` FOREIGN KEY (`order_products_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `products_comments`
--
ALTER TABLE `products_comments`
  ADD CONSTRAINT `FK_4A9F86994584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FK_4A9F8699A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
