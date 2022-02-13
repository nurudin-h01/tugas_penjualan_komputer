-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 13 Feb 2022 pada 05.16
-- Versi server: 8.0.27
-- Versi PHP: 7.4.19

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
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_cari_penjualan` (IN `tgl` DATE)   BEGIN
SELECT ref_produk.nama_produk, s_penjualan.total_produk, ref_produk.harga, s_penjualan.jumlah_produk, d_customer.nama_depan FROM s_penjualan JOIN ref_produk ON s_penjualan.id_produk = ref_produk.id_produk JOIN d_customer ON d_customer.id_customer = s_penjualan.id_customer WHERE tanggal = tgl;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `f_hitung_diskon` (`harga` INT, `diskon` INT) RETURNS INT  return (harga - (harga * (diskon / 100)))$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_customer`
--

CREATE TABLE `d_customer` (
  `id_customer` int NOT NULL,
  `nama_depan` varchar(20) NOT NULL,
  `nama_belakang` varchar(20) NOT NULL,
  `alamat` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL,
  `nama_lengkap` char(41) GENERATED ALWAYS AS (concat(`nama_depan`,_utf8mb4' ',`nama_belakang`)) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `d_customer`
--

INSERT INTO `d_customer` (`id_customer`, `nama_depan`, `nama_belakang`, `alamat`, `email`) VALUES
(1, 'Budi', 'Santoso', 'Yogyakarta', 'budi@mail.com'),
(2, 'Rudi', 'Santoso', 'Yogyakarta', 'rudi@mail.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `ref_produk`
--

CREATE TABLE `ref_produk` (
  `id_produk` int NOT NULL,
  `nama_produk` varchar(20) NOT NULL,
  `harga` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `ref_produk`
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
-- Struktur dari tabel `s_penjualan`
--

CREATE TABLE `s_penjualan` (
  `id_penjualan` int NOT NULL,
  `id_customer` int NOT NULL,
  `id_produk` int NOT NULL,
  `jumlah_produk` int NOT NULL,
  `total_produk` int NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `s_penjualan`
--

INSERT INTO `s_penjualan` (`id_penjualan`, `id_customer`, `id_produk`, `jumlah_produk`, `total_produk`, `tanggal`) VALUES
(1, 1, 1, 2, 200000, '2022-02-09'),
(2, 2, 2, 2, 400000, '2022-02-08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `s_stock`
--

CREATE TABLE `s_stock` (
  `id_stock` int NOT NULL,
  `id_produk` int NOT NULL,
  `jumlah` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `s_stock`
--

INSERT INTO `s_stock` (`id_stock`, `id_produk`, `jumlah`) VALUES
(1, 1, 8);

-- --------------------------------------------------------

--
-- Struktur dari tabel `s_stock_in`
--

CREATE TABLE `s_stock_in` (
  `id_stock_in` int NOT NULL,
  `id_produk` int NOT NULL,
  `jumlah` int NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `s_stock_in`
--

INSERT INTO `s_stock_in` (`id_stock_in`, `id_produk`, `jumlah`, `tanggal`) VALUES
(1, 1, 5, '2022-02-01'),
(2, 3, 4, '2022-01-02');

--
-- Trigger `s_stock_in`
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
-- Struktur dari tabel `s_stock_out`
--

CREATE TABLE `s_stock_out` (
  `id_stock_out` int NOT NULL,
  `id_produk` int NOT NULL,
  `jumlah` int NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `s_stock_out`
--

INSERT INTO `s_stock_out` (`id_stock_out`, `id_produk`, `jumlah`, `tanggal`) VALUES
(1, 1, 3, '2022-02-02');

--
-- Trigger `s_stock_out`
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
-- Stand-in struktur untuk tampilan `v_jumlah_pendapatan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_jumlah_pendapatan` (
`jumlah_produk` int
,`nama_produk` varchar(20)
,`total_produk` int
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
-- Indeks untuk tabel `d_customer`
--
ALTER TABLE `d_customer`
  ADD PRIMARY KEY (`id_customer`);

--
-- Indeks untuk tabel `ref_produk`
--
ALTER TABLE `ref_produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- Indeks untuk tabel `s_penjualan`
--
ALTER TABLE `s_penjualan`
  ADD PRIMARY KEY (`id_penjualan`),
  ADD UNIQUE KEY `id_customer` (`id_customer`),
  ADD UNIQUE KEY `id_produk` (`id_produk`);

--
-- Indeks untuk tabel `s_stock`
--
ALTER TABLE `s_stock`
  ADD PRIMARY KEY (`id_stock`),
  ADD UNIQUE KEY `id_produk_2` (`id_produk`);

--
-- Indeks untuk tabel `s_stock_in`
--
ALTER TABLE `s_stock_in`
  ADD PRIMARY KEY (`id_stock_in`),
  ADD UNIQUE KEY `id_produk` (`id_produk`);

--
-- Indeks untuk tabel `s_stock_out`
--
ALTER TABLE `s_stock_out`
  ADD PRIMARY KEY (`id_stock_out`),
  ADD UNIQUE KEY `id_produk` (`id_produk`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `d_customer`
--
ALTER TABLE `d_customer`
  MODIFY `id_customer` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `ref_produk`
--
ALTER TABLE `ref_produk`
  MODIFY `id_produk` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `s_penjualan`
--
ALTER TABLE `s_penjualan`
  MODIFY `id_penjualan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `s_stock`
--
ALTER TABLE `s_stock`
  MODIFY `id_stock` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `s_stock_in`
--
ALTER TABLE `s_stock_in`
  MODIFY `id_stock_in` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `s_stock_out`
--
ALTER TABLE `s_stock_out`
  MODIFY `id_stock_out` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `s_penjualan`
--
ALTER TABLE `s_penjualan`
  ADD CONSTRAINT `s_penjualan_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `ref_produk` (`id_produk`);

--
-- Ketidakleluasaan untuk tabel `s_stock`
--
ALTER TABLE `s_stock`
  ADD CONSTRAINT `s_stock` FOREIGN KEY (`id_produk`) REFERENCES `s_stock_in` (`id_produk`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `s_stock_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `s_stock_out` (`id_produk`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
