-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 13, 2022 at 05:09 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `z_penjualan_komputer`
--

CREATE DATABASE IF NOT EXISTS z_penjualan_komputer;
USE z_penjualan_komputer;

DELIMITER $$
--
-- Procedures
--
$$

--
-- Functions
--
$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `d_customer`
--

CREATE TABLE `d_customer` (
  `id_customer` int(11) NOT NULL,
  `nama_depan` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `nama_belakang` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `alamat` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `nama_lengkap` char(41) GENERATED ALWAYS AS (concat(`nama_depan`,_utf8' ',`nama_belakang`)) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `d_customer`
--

INSERT INTO `d_customer` (`id_customer`, `nama_depan`, `nama_belakang`, `alamat`, `email`) VALUES
(1, 'Budi', 'Santoso', 'Yogyakarta', 'budi@mail.com'),
(2, 'Rudi', 'Santoso', 'Yogyakarta', 'rudi@mail.com'),
(5, 'Ahmad', 'Hasyim', 'Yogyakarta', 'af@mail.com');

-- --------------------------------------------------------

--
-- Table structure for table `ref_produk`
--

CREATE TABLE `ref_produk` (
  `id_produk` int(11) NOT NULL,
  `nama_produk` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `ref_produk`
--

INSERT INTO `ref_produk` (`id_produk`, `nama_produk`, `harga`) VALUES
(1, 'mouse', 300000),
(2, 'keyboard', 200000),
(3, 'Laptop Asus', 10000000),
(4, 'Laptop Dell', 12000000),
(5, 'Laptop Acer', 9500000),
(6, 'SSD 1TB', 2000000),
(7, 'HDD 2TB', 1000000);

-- --------------------------------------------------------

--
-- Table structure for table `s_penjualan`
--

CREATE TABLE `s_penjualan` (
  `id_penjualan` int(11) NOT NULL,
  `id_customer` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `jumlah_produk` int(11) NOT NULL,
  `total_produk` int(11) NOT NULL,
  `tanggal` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `s_penjualan`
--

INSERT INTO `s_penjualan` (`id_penjualan`, `id_customer`, `id_produk`, `jumlah_produk`, `total_produk`, `tanggal`) VALUES
(1, 1, 1, 2, 200000, '2022-02-09'),
(2, 2, 2, 2, 400000, '2022-02-08');

-- --------------------------------------------------------

--
-- Table structure for table `s_stock`
--

CREATE TABLE `s_stock` (
  `id_stock` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `s_stock`
--

INSERT INTO `s_stock` (`id_stock`, `id_produk`, `jumlah`) VALUES
(1, 1, 8);

-- --------------------------------------------------------

--
-- Table structure for table `s_stock_in`
--

CREATE TABLE `s_stock_in` (
  `id_stock_in` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `s_stock_in`
--

INSERT INTO `s_stock_in` (`id_stock_in`, `id_produk`, `jumlah`, `tanggal`) VALUES
(1, 1, 5, '2022-02-01'),
(2, 3, 4, '2022-01-02');

--
-- Triggers `s_stock_in`
--
DELIMITER $$
CREATE TRIGGER `delete stok masuk` AFTER DELETE ON `s_stock_in` FOR EACH ROW UPDATE s_stock SET jumlah = jumlah - OLD.jumlah WHERE id_produk = s_stock.id_produk
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update stok masuk` AFTER INSERT ON `s_stock_in` FOR EACH ROW UPDATE s_stock SET jumlah = jumlah + NEW.jumlah WHERE id_produk = s_stock.id_produk
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `s_stock_out`
--

CREATE TABLE `s_stock_out` (
  `id_stock_out` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `s_stock_out`
--

INSERT INTO `s_stock_out` (`id_stock_out`, `id_produk`, `jumlah`, `tanggal`) VALUES
(1, 1, 3, '2022-02-02');

--
-- Triggers `s_stock_out`
--
DELIMITER $$
CREATE TRIGGER `delete_stok_keluar` AFTER DELETE ON `s_stock_out` FOR EACH ROW UPDATE s_stock SET jumlah = jumlah + OLD.jumlah WHERE id_produk = s_stock.id_produk
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update stok keluar` AFTER INSERT ON `s_stock_out` FOR EACH ROW UPDATE s_stock SET jumlah = jumlah - NEW.jumlah WHERE id_produk = s_stock.id_produk
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_jumlah_pendapatan`
-- (See below for the actual view)
--
CREATE TABLE `v_jumlah_pendapatan` (
`nama_produk` varchar(20)
,`jumlah_produk` int(11)
,`total_produk` int(11)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `v_jumlah_pendapatan`
--
DROP TABLE IF EXISTS `v_jumlah_pendapatan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_jumlah_pendapatan`  AS SELECT `ref_produk`.`nama_produk` AS `nama_produk`, `s_penjualan`.`jumlah_produk` AS `jumlah_produk`, `s_penjualan`.`total_produk` AS `total_produk` FROM (`ref_produk` join `s_penjualan` on((`s_penjualan`.`id_produk` = `ref_produk`.`id_produk`)))  ;


--
-- Indexes for dumped tables
--

--
-- Indexes for table `d_customer`
--
ALTER TABLE `d_customer`
  ADD PRIMARY KEY (`id_customer`);

--
-- Indexes for table `ref_produk`
--
ALTER TABLE `ref_produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- Indexes for table `s_penjualan`
--
ALTER TABLE `s_penjualan`
  ADD PRIMARY KEY (`id_penjualan`),
  ADD KEY `id_customer` (`id_customer`) USING BTREE,
  ADD KEY `id_produk` (`id_produk`) USING BTREE;

--
-- Indexes for table `s_stock`
--
ALTER TABLE `s_stock`
  ADD PRIMARY KEY (`id_stock`),
  ADD UNIQUE KEY `id_produk_2` (`id_produk`);

--
-- Indexes for table `s_stock_in`
--
ALTER TABLE `s_stock_in`
  ADD PRIMARY KEY (`id_stock_in`),
  ADD UNIQUE KEY `id_produk` (`id_produk`);

--
-- Indexes for table `s_stock_out`
--
ALTER TABLE `s_stock_out`
  ADD PRIMARY KEY (`id_stock_out`),
  ADD UNIQUE KEY `id_produk` (`id_produk`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `d_customer`
--
ALTER TABLE `d_customer`
  MODIFY `id_customer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ref_produk`
--
ALTER TABLE `ref_produk`
  MODIFY `id_produk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `s_penjualan`
--
ALTER TABLE `s_penjualan`
  MODIFY `id_penjualan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `s_stock`
--
ALTER TABLE `s_stock`
  MODIFY `id_stock` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `s_stock_in`
--
ALTER TABLE `s_stock_in`
  MODIFY `id_stock_in` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `s_stock_out`
--
ALTER TABLE `s_stock_out`
  MODIFY `id_stock_out` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `s_penjualan`
--
ALTER TABLE `s_penjualan`
  ADD CONSTRAINT `s_penjualan_FK` FOREIGN KEY (`id_customer`) REFERENCES `d_customer` (`id_customer`) ON DELETE CASCADE,
  ADD CONSTRAINT `s_penjualan_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `ref_produk` (`id_produk`) ON DELETE CASCADE;

--
-- Constraints for table `s_stock`
--
ALTER TABLE `s_stock`
  ADD CONSTRAINT `s_stock` FOREIGN KEY (`id_produk`) REFERENCES `s_stock_in` (`id_produk`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `s_stock_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `s_stock_out` (`id_produk`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
