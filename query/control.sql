-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 04, 2023 at 07:08 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `control`
--

-- --------------------------------------------------------

--
-- Table structure for table `configs`
--

CREATE TABLE `configs` (
  `id` bigint(20) NOT NULL,
  `name_file` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `date_lottert` date NOT NULL DEFAULT current_timestamp(),
  `location` varchar(255) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `flag` int(11) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT '',
  `path_detail` varchar(255) DEFAULT NULL,
  `create_by` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `configs`
--

INSERT INTO `configs` (`id`, `name_file`, `description`, `date_lottert`, `location`, `created_at`, `updated_at`, `flag`, `status`, `path_detail`, `create_by`) VALUES
(1, 'Kien_Giang', 'XSKT Kien Giang', '2024-12-01', 'D:\\HOC\\WH\\DATA2', NULL, NULL, 1, 'ERROR', 'D:\\HOC\\WH\\DATA2\\Kien_Giang-03-12-2023.csv', ''),
(2, 'Phu_Yen', 'XSKT Phu Yen', '2023-11-10', 'D:\\HOC\\WH\\DATA', NULL, NULL, 1, 'ERROR', 'D:\\HOC\\WH\\DATA\\Phu_Yen-10-11-2023.csv', ''),
(3, 'Ho_Chi_Minh', 'XSKT Ho Chi Minh', '2023-12-02', 'D:\\HOC\\WH\\DATA', NULL, NULL, 1, 'DONE', 'D:\\HOC\\WH\\DATA\\Ho_Chi_Minh-02-12-2023.csv', ''),
(4, 'Vung_Tau', 'XSKT Vung Tau', '2023-11-22', 'D:\\HOC\\WH\\DATA', NULL, NULL, 1, 'DONE', 'D:\\HOC\\WH\\DATA\\Vung_Tau-22-11-2023.csv', ''),
(5, 'Vinh_Long', 'XSKT Vinh Long', '2023-11-26', 'D:\\HOC\\WH\\DATA', NULL, NULL, 1, 'DONE', 'D:\\HOC\\WH\\DATA\\Vinh_Long-26-11-2023.csv', ''),
(6, 'Long_An', 'XSKT Long An', '2023-10-18', 'D:\\HOC\\WH\\DATA', NULL, NULL, 1, 'DONE', 'D:\\HOC\\WH\\DATA\\Long_An-18-10-2023.csv', ''),
(7, 'Dong_Nai', 'XSKT Dong Nai', '2023-10-25', 'D:\\HOC\\WH\\DATA', NULL, NULL, 1, 'DONE', 'D:\\HOC\\WH\\DATA\\Dong_Nai-25-10-2023.csv', ''),
(8, 'Binh_Duong', 'XSKT Binh Duong', '2023-10-11', 'D:\\HOC\\WH\\DATA', NULL, NULL, 1, 'DONE', 'D:\\HOC\\WH\\DATA\\Binh_Duong-11-10-2023.csv', ''),
(9, 'Hau_Giang', 'XSKT Hau Giang', '2023-09-13', 'D:\\HOC\\WH\\DATA', NULL, NULL, 1, 'DONE', 'D:\\HOC\\WH\\DATA\\Hau_Giang-13-09-2023.csv', ''),
(10, 'Soc_Trang', 'XSKT Soc Trang', '2023-08-15', 'D:\\HOC\\WH\\DATA', NULL, NULL, 1, 'DONE', 'D:\\HOC\\WH\\DATA\\Soc_Trang-15-08-2023.csv', ''),
(11, 'Tien_Giang', 'XSKT Tien Giang', '2023-07-11', 'D:\\HOC\\WH\\DATA', NULL, NULL, 1, 'DONE', 'D:\\HOC\\WH\\DATA\\Tien_Giang-11-07-2023.csv', ''),
(12, 'Du_Lieu_Ngay_Moi', 'Cào dữ liệu tới ngày date_lottery', '2023-12-15', 'D:\\HOC\\WH\\DATA2', NULL, NULL, 1, 'DONE', 'D:\\HOC\\WH\\DATA2\\Du_Lieu_Ngay_Moi-03-12-2023.csv', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `id_process` bigint(20) NOT NULL,
  `status` varchar(266) NOT NULL,
  `note` text NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `id_process`, `status`, `note`, `create_date`) VALUES
(8, 1701663884218, 'END', 'Có một process khác đang chạy', '2023-12-04 11:24:44'),
(9, 1701663928663, 'END', 'Có một process khác đang chạy', '2023-12-04 11:25:28'),
(11, 1701664070501, 'END', 'Có một process khác đang chạy', '2023-12-04 11:27:50'),
(13, 1701664136245, 'END', 'Có một process khác đang chạy', '2023-12-04 11:28:56'),
(15, 1701664261333, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 11:31:01 AM - Đã thực thi xong: Dec 4, 2023, 11:31:08 AM', '2023-12-04 11:31:01'),
(16, 1701664267719, 'END', 'Có một process khác đang chạy', '2023-12-04 11:31:07'),
(17, 1701664280962, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 11:31:21 AM - Đã thực thi xong: Dec 4, 2023, 11:31:28 AM', '2023-12-04 11:31:21'),
(18, 1701664283691, 'END', 'Có một process khác đang chạy', '2023-12-04 11:31:23'),
(19, 1701664284742, 'END', 'Có một process khác đang chạy', '2023-12-04 11:31:24'),
(20, 1701664443020, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 11:34:03 AM - Đã thực thi xong: Dec 4, 2023, 11:34:10 AM', '2023-12-04 11:34:03'),
(21, 1701664456612, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 11:34:16 AM - Đã thực thi xong: Dec 4, 2023, 11:34:28 AM', '2023-12-04 11:34:16'),
(22, 1701664516859, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 11:35:16 AM - Đã thực thi xong: Dec 4, 2023, 11:35:24 AM', '2023-12-04 11:35:16'),
(23, 1701664531951, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 11:35:32 AM - Đã thực thi xong: Dec 4, 2023, 11:35:40 AM', '2023-12-04 11:35:32'),
(24, 1701664627436, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 11:37:07 AM - Đã thực thi xong: Dec 4, 2023, 11:37:15 AM', '2023-12-04 11:37:07'),
(25, 1701664743090, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 11:39:03 AM - Đã thực thi xong: Dec 4, 2023, 11:39:15 AM', '2023-12-04 11:39:03'),
(26, 1701664927001, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 11:42:07 AM - Đã thực thi xong: Dec 4, 2023, 11:42:17 AM', '2023-12-04 11:42:07'),
(27, 1701664955525, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 11:42:35 AM - Đã thực thi xong: Dec 4, 2023, 11:42:44 AM', '2023-12-04 11:42:35'),
(28, 1701665270876, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 11:47:50 AM - Đã thực thi xong: Dec 4, 2023, 11:48:02 AM', '2023-12-04 11:47:50'),
(29, 1701666079311, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 12:01:19 PM - Đã thực thi xong: Dec 4, 2023, 12:01:24 PM', '2023-12-04 12:01:19'),
(30, 1701666080681, 'END', 'Có một process khác đang chạy', '2023-12-04 12:01:20'),
(31, 1701666123088, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 12:02:03 PM - Đã thực thi xong: Dec 4, 2023, 12:02:09 PM', '2023-12-04 12:02:03'),
(32, 1701666123719, 'END', 'Có một process khác đang chạy', '2023-12-04 12:02:03'),
(33, 1701666152075, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 12:02:33 PM - Đã thực thi xong: Dec 4, 2023, 12:02:38 PM', '2023-12-04 12:02:33'),
(34, 1701666153612, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 12:02:38 PM - Đã thực thi xong: Dec 4, 2023, 12:02:44 PM', '2023-12-04 12:02:38'),
(35, 1701666854231, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 12:14:24 PM - Đã thực thi xong: Dec 4, 2023, 12:14:28 PM', '2023-12-04 12:14:24'),
(36, 1701666918047, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 12:15:18 PM - Đã thực thi xong: Dec 4, 2023, 12:15:24 PM', '2023-12-04 12:15:18'),
(37, 1701667008056, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 12:16:48 PM - Đã thực thi xong: Dec 4, 2023, 12:16:53 PM', '2023-12-04 12:16:48'),
(38, 1701667184672, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 12:19:44 PM - Đã thực thi xong: Dec 4, 2023, 12:19:51 PM', '2023-12-04 12:19:44'),
(39, 1701669467940, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 12:57:47 PM - Đã thực thi xong: Dec 4, 2023, 12:58:28 PM', '2023-12-04 12:57:47'),
(41, 1701669582155, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 1:00:02 PM - Đã thực thi xong: Dec 4, 2023, 1:00:07 PM', '2023-12-04 13:00:02'),
(42, 1701669832619, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 1:03:52 PM - Đã thực thi xong: Dec 4, 2023, 1:03:57 PM', '2023-12-04 13:03:52'),
(43, 1701669865934, 'PROCESSED', 'Bắt đầu thực thi: Dec 4, 2023, 1:04:25 PM - Đã thực thi xong: Dec 4, 2023, 1:04:31 PM', '2023-12-04 13:04:25');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `configs`
--
ALTER TABLE `configs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `configs`
--
ALTER TABLE `configs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
