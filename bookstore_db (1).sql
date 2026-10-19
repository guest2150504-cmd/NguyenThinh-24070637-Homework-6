-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 19, 2026 at 02:22 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookstore_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

CREATE TABLE `authors` (
  `author_id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `biography` text DEFAULT NULL,
  `nationality` varchar(60) NOT NULL,
  `birth_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`author_id`, `full_name`, `biography`, `nationality`, `birth_date`) VALUES
(1, 'Nguyen Minh Anh', 'A fictional educator who writes practical database and web guides.', 'Vietnamese', '1980-04-12'),
(2, 'Tran Quoc Bao', 'A fictional software trainer focused on beginner programming.', 'Vietnamese', '1985-07-09'),
(3, 'Le Thu Ha', 'A fictional food writer sharing everyday Vietnamese recipes.', 'Vietnamese', '1978-11-23'),
(4, 'Emily Carter', 'A fictional writer interested in technology, habits, and personal finance.', 'American', '1986-03-18'),
(5, 'David Wilson', 'A fictional business educator who writes for small business owners.', 'British', '1975-09-05'),
(6, 'Pham Ngoc Linh', 'A fictional novelist writing stories about family and community.', 'Vietnamese', '1990-01-27');

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `book_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `isbn` char(13) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `publication_date` date NOT NULL,
  `publisher_id` int(10) UNSIGNED NOT NULL
) ;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_id`, `title`, `isbn`, `description`, `price`, `stock`, `publication_date`, `publisher_id`) VALUES
(1, 'Practical SQL for Beginners', '9781390000016', 'Learn relational databases through practical SQL examples.', 24.90, 30, '2023-03-15', 1),
(2, 'Learning Python Step by Step', '9781390000023', 'A gradual introduction to Python programming.', 29.50, 25, '2023-09-10', 1),
(3, 'Modern Web Development', '9781390000030', 'Build websites using frontend and server-side fundamentals.', 34.00, 20, '2024-02-20', 2),
(4, 'Small Business Essentials', '9781390000047', 'Practical planning and management for a small business.', 21.75, 15, '2022-06-05', 2),
(5, 'Everyday Vietnamese Cooking', '9781390000054', 'Simple Vietnamese recipes for home cooks.', 18.50, 0, '2021-11-12', 3),
(6, 'The River at Dawn', '9781390000061', 'A novel about family, change, and a riverside community.', 15.90, 18, '2020-08-22', 3),
(7, 'Personal Finance Made Simple', '9781390000078', 'An introduction to budgeting, saving, and financial planning.', 22.00, 22, '2024-04-08', 4),
(8, 'Building Better Habits', '9781390000085', 'Small routines for more consistent everyday progress.', 19.95, 12, '2025-01-15', 4);

-- --------------------------------------------------------

--
-- Table structure for table `book_authors`
--

CREATE TABLE `book_authors` (
  `book_id` int(10) UNSIGNED NOT NULL,
  `author_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `book_authors`
--

INSERT INTO `book_authors` (`book_id`, `author_id`) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 1),
(3, 4),
(4, 5),
(5, 3),
(6, 6),
(7, 4),
(7, 5),
(8, 4);

-- --------------------------------------------------------

--
-- Table structure for table `book_categories`
--

CREATE TABLE `book_categories` (
  `book_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `book_categories`
--

INSERT INTO `book_categories` (`book_id`, `category_id`) VALUES
(1, 1),
(1, 5),
(2, 1),
(2, 5),
(3, 1),
(3, 5),
(4, 2),
(5, 4),
(6, 3),
(7, 2),
(7, 4),
(8, 4);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(80) NOT NULL,
  `description` text DEFAULT NULL,
  `parent_category_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `description`, `parent_category_id`) VALUES
(1, 'Technology', 'Computing and digital technology.', NULL),
(2, 'Business', 'Management, business, and personal finance.', NULL),
(3, 'Fiction', 'Novels and imaginative stories.', NULL),
(4, 'Lifestyle', 'Cooking, habits, and everyday life.', NULL),
(5, 'Programming', 'Programming languages, databases, and web development.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `full_name`, `email`, `password_hash`, `phone`, `address`, `created_at`) VALUES
(1, 'Nguyen Van An', 'an.nguyen@example.com', '$2y$10$/j0.HOP0rBWyKBRYqzdtO./3eA2n1m84UnFmxLCkVT/zotifxIXLm', '+84-900-000-001', '15 Minh Khai Street, Hanoi, Vietnam', '2026-08-01 09:00:00'),
(2, 'Tran Thi Bich', 'bich.tran@example.com', '$2y$10$rjavhKfXPLjjZ4ilO/YVe.fAtF8Az/OsF5uCNHYM2hdOakDTV0yya', '+84-900-000-002', '22 Hoa Mai Street, Da Nang, Vietnam', '2026-08-02 09:15:00'),
(3, 'Le Minh Cuong', 'cuong.le@example.com', '$2y$10$8gFtFqnmG74VqmW6vTh.r.n8FHM1EEDCWPGO8ZH/wMYwCS0006yUi', '+84-900-000-003', '36 Dong Tam Street, Hanoi, Vietnam', '2026-08-03 10:00:00'),
(4, 'Pham Ngoc Dung', 'dung.pham@example.com', '$2y$10$Heom.lbvBH.iUpZClLHjp.V9/U99We/pPOWfEmR.pzQBQHB.LvBXe', '+84-900-000-004', '48 An Binh Street, Ho Chi Minh City, Vietnam', '2026-08-04 10:30:00'),
(5, 'Hoang Thu Ha', 'ha.hoang@example.com', '$2y$10$k5n2.4Kzv4VW6nF2c74U0.c26s.XJiRjUKtk3hS9eNT3DcJRlThAu', '+84-900-000-005', '60 Hoa Phuong Street, Hai Phong, Vietnam', '2026-08-05 11:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `order_date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','paid','shipped','completed','cancelled') NOT NULL DEFAULT 'pending',
  `shipping_address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `status`, `shipping_address`) VALUES
(1, 1, '2026-09-01 10:00:00', 'completed', '15 Minh Khai Street, Hanoi, Vietnam'),
(2, 2, '2026-09-03 14:20:00', 'completed', '22 Hoa Mai Street, Da Nang, Vietnam'),
(3, 3, '2026-09-06 08:45:00', 'completed', '36 Dong Tam Street, Hanoi, Vietnam'),
(4, 4, '2026-09-10 16:30:00', 'completed', '48 An Binh Street, Ho Chi Minh City, Vietnam'),
(5, 1, '2026-09-15 09:10:00', 'paid', '88 Office Lane, Hanoi, Vietnam'),
(6, 5, '2026-09-20 11:40:00', 'pending', '60 Hoa Phuong Street, Hai Phong, Vietnam');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_id` int(10) UNSIGNED NOT NULL,
  `book_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `unit_price` decimal(10,2) NOT NULL
) ;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_id`, `book_id`, `quantity`, `unit_price`) VALUES
(1, 1, 1, 23.90),
(1, 2, 1, 29.50),
(1, 3, 1, 32.00),
(2, 5, 2, 18.50),
(2, 6, 1, 15.90),
(3, 4, 1, 21.75),
(3, 7, 1, 22.00),
(4, 1, 2, 24.90),
(4, 6, 1, 15.90),
(4, 8, 1, 19.95),
(5, 2, 1, 29.50),
(5, 3, 1, 34.00),
(6, 7, 1, 22.00),
(6, 8, 2, 19.95);

-- --------------------------------------------------------

--
-- Stand-in structure for view `order_item_details`
-- (See below for the actual view)
--
CREATE TABLE `order_item_details` (
`order_id` int(10) unsigned
,`book_id` int(10) unsigned
,`quantity` int(11)
,`unit_price` decimal(10,2)
,`subtotal` decimal(12,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `order_summary`
-- (See below for the actual view)
--
CREATE TABLE `order_summary` (
`order_id` int(10) unsigned
,`customer_id` int(10) unsigned
,`order_date` datetime
,`status` enum('pending','paid','shipped','completed','cancelled')
,`shipping_address` varchar(255)
,`total` decimal(12,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `publishers`
--

CREATE TABLE `publishers` (
  `publisher_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `address` varchar(255) NOT NULL,
  `website` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `publishers`
--

INSERT INTO `publishers` (`publisher_id`, `name`, `address`, `website`) VALUES
(1, 'Lotus Learning Press', '12 Hoa Sen Street, Hanoi, Vietnam', 'https://lotuslearning.example'),
(2, 'Bright Path Publishing', '45 Maple Road, London, United Kingdom', 'https://brightpath.example'),
(3, 'Riverlight Books', '28 Song Xanh Street, Da Nang, Vietnam', 'https://riverlight.example'),
(4, 'Horizon Knowledge Press', '90 Oak Avenue, Boston, United States', 'https://horizonknowledge.example');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `book_id` int(10) UNSIGNED NOT NULL,
  `rating` tinyint(4) NOT NULL,
  `comment_text` text DEFAULT NULL,
  `review_date` datetime NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `customer_id`, `book_id`, `rating`, `comment_text`, `review_date`) VALUES
(1, 1, 1, 5, 'Clear SQL examples and useful practice tasks.', '2026-09-05 18:00:00'),
(2, 1, 2, 4, 'A helpful introduction with manageable exercises.', '2026-09-05 18:10:00'),
(3, 1, 3, 5, 'The website examples made the concepts easier to understand.', '2026-09-05 18:20:00'),
(4, 2, 5, 4, 'Easy recipes using familiar ingredients.', '2026-09-07 19:00:00'),
(5, 2, 6, 5, 'A warm story with memorable characters.', '2026-09-07 19:15:00'),
(6, 3, 4, 3, 'Useful basic advice, but I wanted more case studies.', '2026-09-10 17:00:00'),
(7, 3, 7, 4, 'Budgeting is explained in a practical way.', '2026-09-10 17:15:00'),
(8, 4, 1, 4, 'Good for beginners learning joins and constraints.', '2026-09-14 20:00:00'),
(9, 4, 6, 3, 'An enjoyable story with a slower middle section.', '2026-09-14 20:15:00'),
(10, 4, 8, 5, 'Simple ideas that are easy to apply every day.', '2026-09-14 20:30:00');

-- --------------------------------------------------------

--
-- Structure for view `order_item_details`
--
DROP TABLE IF EXISTS `order_item_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `order_item_details`  AS SELECT `order_items`.`order_id` AS `order_id`, `order_items`.`book_id` AS `book_id`, `order_items`.`quantity` AS `quantity`, `order_items`.`unit_price` AS `unit_price`, cast(`order_items`.`quantity` * `order_items`.`unit_price` as decimal(12,2)) AS `subtotal` FROM `order_items` ;

-- --------------------------------------------------------

--
-- Structure for view `order_summary`
--
DROP TABLE IF EXISTS `order_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `order_summary`  AS SELECT `o`.`order_id` AS `order_id`, `o`.`customer_id` AS `customer_id`, `o`.`order_date` AS `order_date`, `o`.`status` AS `status`, `o`.`shipping_address` AS `shipping_address`, cast(coalesce(sum(`oi`.`quantity` * `oi`.`unit_price`),0.00) as decimal(12,2)) AS `total` FROM (`orders` `o` left join `order_items` `oi` on(`oi`.`order_id` = `o`.`order_id`)) GROUP BY `o`.`order_id`, `o`.`customer_id`, `o`.`order_date`, `o`.`status`, `o`.`shipping_address` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`author_id`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`),
  ADD UNIQUE KEY `uq_books_isbn` (`isbn`),
  ADD KEY `fk_books_publisher` (`publisher_id`);

--
-- Indexes for table `book_authors`
--
ALTER TABLE `book_authors`
  ADD PRIMARY KEY (`book_id`,`author_id`),
  ADD KEY `fk_book_authors_author` (`author_id`);

--
-- Indexes for table `book_categories`
--
ALTER TABLE `book_categories`
  ADD PRIMARY KEY (`book_id`,`category_id`),
  ADD KEY `fk_book_categories_category` (`category_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `uq_categories_name` (`name`),
  ADD KEY `fk_categories_parent` (`parent_category_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `uq_customers_email` (`email`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_orders_customer` (`customer_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_id`,`book_id`),
  ADD KEY `fk_order_items_book` (`book_id`);

--
-- Indexes for table `publishers`
--
ALTER TABLE `publishers`
  ADD PRIMARY KEY (`publisher_id`),
  ADD UNIQUE KEY `uq_publishers_name` (`name`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD UNIQUE KEY `uq_reviews_customer_book` (`customer_id`,`book_id`),
  ADD KEY `fk_reviews_book` (`book_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `publishers`
--
ALTER TABLE `publishers`
  MODIFY `publisher_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `fk_books_publisher` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`publisher_id`) ON UPDATE CASCADE;

--
-- Constraints for table `book_authors`
--
ALTER TABLE `book_authors`
  ADD CONSTRAINT `fk_book_authors_author` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_book_authors_book` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `book_categories`
--
ALTER TABLE `book_categories`
  ADD CONSTRAINT `fk_book_categories_book` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_book_categories_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `fk_categories_parent` FOREIGN KEY (`parent_category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON UPDATE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_book` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_book` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reviews_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
