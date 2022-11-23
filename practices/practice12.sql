-- ---------------
-- MySQL Script
-- Workshop Basis Data
-- Praktikum Minggu 11
-- Politeknik Negeri Jember 2022
-- ------------------
-- By @irsyadulibad
-- ---------------

CREATE DATABASE karyawan;
USE karyawan;

-- ---------------
-- Acara 41
-- ---------------

-- Membuat tabel karyawan
CREATE TABLE karyawan(
    `idkrywn` char(5) NOT NULL,
    `namakrywn` varchar(20) NOT NULL,
    `alamat` varchar(20) NOT NULL,
    PRIMARY KEY (`idkrywn`)
);

-- Membuat tabel bagian
CREATE TABLE bagian(
    `idbagian` char(5) NOT NULL,
    `namabagian` varchar(20) NOT NULL,
    PRIMARY KEY (`idbagian`)
);

-- membuat tabel gaji
CREATE TABLE gaji(
    `idkrywn` char(5) NOT NULL,
    `idbagian` char(5) NOT NULL,
    `totalgaji` int(11) NOT NULL,
    FOREIGN KEY (`idkrywn`) REFERENCES karyawan(`idkrywn`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`idbagian`) REFERENCES bagian(`idbagian`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Menambahkan data pada ketiga tabel di atas
INSERT INTO karyawan (`idkrywn`, `namakrywn`, `alamat`) VALUES
('KY001', 'Ucok', 'Pasar Senen'),
('KY002', 'Suleman', 'Mumbulsari'),
('KY003', 'A. Bidin', 'Kencong');

INSERT INTO bagian (`idbagian`, `namabagian`) VALUES
('KBG01', 'Instalasi'),
('KBG02', 'Gudang'),
('KBG03', 'Marketing');

INSERT INTO gaji (`idkrywn`, `idbagian`, `totalgaji`) VALUES
('KY001', 'KBG01', 1000000),
('KY002', 'KBG02', 21000),
('KY003', 'KBG03', 34000);

-- Query join 3 tabel
SELECT `namakrywn`, `alamat`, `namabagian`, `totalgaji`
FROM karyawan, bagian, gaji
WHERE `karyawan`.`idkrywn` = `gaji`.`idkrywn`
    AND `bagian`.`idbagian` = `gaji`.`idbagian`;

-- ---------------
-- Acara 42
-- ---------------

-- Menampilkan kode mata kuliah, nama mata kuliah, nama jurusan, nama dosen. Diurutkan berdasarkan nama dosen yang paling awal
SELECT `tbl_matkul`.`kode_mk`, `nama_mk`, `nama_jur`, `nama_dosen`
FROM tbl_matkul, tbl_jurusan, tbl_dosen
WHERE `tbl_matkul`.`nip` = `tbl_dosen`.`nip`
    AND `tbl_matkul`.`kode_jur` = `tbl_jurusan`.`kode_jur`
ORDER BY `nama_dosen` ASC;

-- Menampilkan nim, nama mahasiswa, alamat, nama jurusan, nama dosen. Diurutkan dari nama jurusan terakhir
SELECT `nim`, `nama_mhs`, `tbl_mhs`.`alamat`, `nama_jur`, `nama_dosen`
FROM tbl_mhs, tbl_jurusan, tbl_dosen
WHERE `tbl_mhs`.`kode_jur` = `tbl_jurusan`.`kode_jur`
    AND `tbl_mhs`.`nip` = `tbl_dosen`.`nip`
ORDER BY `nama_jur` DESC;

-- Menampilkan nama jurusan, nama dosen, jumlah mahasiswa dari setiap dosen pada masing-masing jurusan
SELECT `nama_jur`, `nama_dosen`, COUNT(`nama_mhs`) AS `jml_mhs`
FROM tbl_mhs, tbl_jurusan, tbl_dosen
WHERE `tbl_mhs`.`kode_jur` = `tbl_jurusan`.`kode_jur`
    AND `tbl_mhs`.`nip` = `tbl_dosen`.`nip`
GROUP BY `nama_dosen`;

-- Menampilkan nama dosen, nama jurusan, jumlah mata kuliah dari masing-masing dosen pada setiap jurusan
SELECT `nama_dosen`, `nama_jur`, COUNT(`nama_mk`) AS `jml_mk`
FROM tbl_matkul, tbl_jurusan, tbl_dosen
WHERE `tbl_matkul`.`kode_jur` = `tbl_jurusan`.`kode_jur`
    AND `tbl_matkul`.`nip` = `tbl_dosen`.`nip`
GROUP BY `nama_dosen`;

-- Menampilkan nama dosen, nama jurusan, jumlah total sks dari masing-masing dosen pada setiap jurusan
SELECT `nama_dosen`, `nama_jur`, SUM(`sks`) AS `total_sks`
FROM tbl_matkul, tbl_jurusan, tbl_dosen
WHERE `tbl_matkul`.`kode_jur` = `tbl_jurusan`.`kode_jur`
    AND `tbl_matkul`.`nip` = `tbl_dosen`.`nip`
GROUP BY `nama_dosen`;

-- Menampilkan nama dosen, nama jurusan, jumlah total sks dari masing-masing dosen pada setiap jurusan. Dimana akan menampilkan jumlah total sks antara 5 dan 12, serta diurutkan dari jumlah sks paling banyak
SELECT `nama_dosen`, `nama_jur`, SUM(`sks`) AS `total_sks`
FROM tbl_matkul, tbl_jurusan, tbl_dosen
WHERE `tbl_matkul`.`kode_jur` = `tbl_jurusan`.`kode_jur`
    AND `tbl_matkul`.`nip` = `tbl_dosen`.`nip`
GROUP BY `nama_dosen`
HAVING `total_sks` BETWEEN 3 AND 4
ORDER BY `total_sks` DESC;


-- ---------------
-- Acara 44
-- ---------------

-- Menampilkan nama karyawan, alamat karyawan, nama bagian, dan total gaji menggunakan query JOIN
SELECT `namakrywn`, `alamat`, `namabagian`, `totalgaji`
FROM karyawan
JOIN gaji
    ON `karyawan`.`idkrywn` = `gaji`.`idkrywn`
JOIN bagian
    ON `bagian`.`idbagian` = `gaji`.`idbagian`;


-- ---------------
-- Acara 44
-- ---------------

-- Menampilkan kode krs, tanggal krs, nama jurusan, nama mahasiswa, jumlah sks dan diurutkan berdasarkan jumlah terbesar
SELECT `tbl_krs`.`kode_krs`, `tanggal_krs`, `nama_jur`, `nama_mhs`, `jumlah_sks`
FROM tbl_krs
JOIN tbl_jurusan
    ON `tbl_krs`.`kode_jur` = `tbl_jurusan`.`kode_jur`
JOIN tbl_mhs
    ON `tbl_krs`.`nim` = `tbl_mhs`.`nim`
ORDER BY `jumlah_sks` DESC;

-- Menampilkan kode krs, tanggal krs, hari, jam, nama mata kuliah. Diurutkan berdasarkan hari yang paling awal
SELECT `tbl_krs`.`kode_krs`, `tanggal_krs`, `hari`, `jam`, `nama_mk`
FROM tbl_detail_krs
JOIN tbl_krs
    ON `tbl_detail_krs`.`kode_krs` = `tbl_krs`.`kode_krs`
JOIN tbl_matkul
    ON `tbl_detail_krs`.`kode_mk` = `tbl_matkul`.`kode_mk`
ORDER BY `hari` DESC;

-- Menampilkan tanggal krs, nama jurusan, jumlah mahasiswa dari masing-masing jurusan
SELECT `tanggal_krs`, `nama_jur`, COUNT(`nama_mhs`) AS `jml_mhs`
FROM tbl_krs
JOIN tbl_jurusan
    ON `tbl_krs`.`kode_jur` = `tbl_jurusan`.`kode_jur`
JOIN tbl_mhs
    ON `tbl_krs`.`nim` = `tbl_mhs`.`nim`
GROUP BY `nama_jur`;

-- Menampilkan nim, nama mahasiswa, kode krs, jumlah hari dari masing-masing mahasiswa dan urutkan berdasarkan kode krs yang paling awal
SELECT `tbl_mhs`.`nim`, `nama_mhs`, `tbl_krs`.`kode_krs`, COUNT(`hari`) AS `jml_hari`
FROM tbl_krs
JOIN tbl_detail_krs
    ON `tbl_krs`.`kode_krs` = `tbl_detail_krs`.`kode_krs`
JOIN tbl_mhs
    ON `tbl_krs`.`nim` = `tbl_mhs`.`nim`
GROUP BY `nim`
ORDER BY `kode_krs` ASC;

-- Menampilkan nim, nama mahasiswa, kode krs, jumlah mata kuliah dan diurutkan berdasarkan jumlah mata kuliah terbanyak
SELECT `tbl_mhs`.`nim`, `nama_mhs`, `tbl_krs`.`kode_krs`, COUNT(`kode_mk`) AS `jml_mk`
FROM tbl_krs
JOIN tbl_detail_krs
    ON `tbl_krs`.`kode_krs` = `tbl_detail_krs`.`kode_krs`
JOIN tbl_mhs
    ON `tbl_krs`.`nim` = `tbl_mhs`.`nim`
GROUP BY `kode_mk`
ORDER BY `jml_mk` DESC;

-- Menampilkan nim, kode krs, jumlah total sks dari mata kuliah yang ditempuh untuk setiap nim dan menampilkan yang total sks antara 10 sampai 20. Diurutkan dari dari nilai terkecil
SELECT `nim`, `tbl_krs`.`kode_krs`, SUM(`sks`) AS `total_sks`
FROM tbl_detail_krs
JOIN tbl_krs
    ON `tbl_detail_krs`.`kode_krs` = `tbl_krs`.`kode_krs`
JOIN tbl_matkul
    ON `tbl_detail_krs`.`kode_mk` = `tbl_matkul`.`kode_mk`
GROUP BY `nim`
HAVING `total_sks` BETWEEN 8 AND 20
ORDER BY `total_sks` ASC;
