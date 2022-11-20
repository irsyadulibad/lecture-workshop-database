-- ---------------
-- MySQL Script
-- Workshop Basis Data
-- Praktikum Minggu 11
-- Politeknik Negeri Jember 2022
-- ------------------
-- By @irsyadulibad
-- ---------------

-- ---------------
-- Acara 37
-- ---------------

-- Membuat tabel Persons dan Orders
CREATE TABLE Persons(
    `P_Id` int(11) NOT NULL AUTO_INCREMENT,
    `LastName` varchar(20) NOT NULL,
    `FirstName` varchar(20) NOT NULL,
    `Address` text NOT NULL,
    `City` varchar(20) NOT NULL,
    PRIMARY KEY (`P_Id`)
);

CREATE TABLE Orders(
    `O_Id` int(11) NOT NULL AUTO_INCREMENT,
    `OrderNo` varchar(5) NOT NULL,
    `P_Id` int(11) NOT NULL,
    PRIMARY KEY (`O_Id`),
    FOREIGN KEY (`P_Id`) REFERENCES `Persons` (`P_id`)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Menampilkan data pada kedua tabel tersebut dengan WHERE
SELECT `Persons`.`LastName`, `Persons`.`FirstName`, `Orders`.`OrderNo`
FROM Persons, Orders
WHERE `Persons`.`P_id` = `Orders`.`P_id`;


-- ---------------
-- Acara 38
-- ---------------

-- Menampilkan kode mata kuliah, nama mata kuliah, dan nama jurusan
SELECT `kode_mk`, `nama_mk`, `nama_jur`
FROM tbl_matkul, tbl_jurusan
WHERE `tbl_matkul`.`kode_jur` = `tbl_jurusan`.`kode_jur`;

-- Menampilkan kode mata kuliah, nama mata kuliah, nama dosen pengampu, dan diurutkan berdasar nama dosen yang paling awal
SELECT `kode_mk`, `nama_mk`, `nama_dosen`
FROM tbl_matkul, tbl_dosen
WHERE `tbl_matkul`.`nip` = `tbl_dosen`.`nip`;

-- Menampilkan nim, nama mahasiswa, alamat, nama jurusan, dan diurutkan dari nama jurusan terakhir
SELECT `nim`, `nama_mhs`, `alamat`, `nama_jur`
FROM tbl_mhs, tbl_jurusan
WHERE `tbl_mhs`.`kode_jur` = `tbl_jurusan`.`kode_jur`
ORDER BY `nama_jur` DESC;

-- Menampilkan nim, nama mahasiswa, alamat, dan nama dosen
SELECT `nama_mhs`, `tbl_mhs`.`alamat`, `nama_dosen`
FROM tbl_mhs, tbl_dosen
WHERE `tbl_mhs`.`nip` = `tbl_dosen`.`nip`;

-- Menampilkan nama jurusan dan jumlah mahasiswa pada setiap jurusan dan diurutkan dari nama jurusan yang paling awal
SELECT `nama_jur`, COUNT(`nama_mhs`) AS `jumlah_mhs`
FROM tbl_mhs, tbl_jurusan
WHERE `tbl_mhs`.`kode_jur` = `tbl_jurusan`.`kode_jur`
GROUP BY `nama_jur`
ORDER BY `nama_jur` ASC;

-- Menampilkan nama dosen dan jumlah mahasiswa setiap dosen, dimana jumlah mahasiswa > 1 dan diurutkan dari jumlah mahasiswa paling sedikit
SELECT `nama_dosen`, COUNT(`nama_mhs`) AS `jumlah_mhs`
FROM tbl_dosen, tbl_mhs
WHERE `tbl_dosen`.`nip` = `tbl_mhs`.`nip`
GROUP BY `nama_dosen`
HAVING `jumlah_mhs` > 1
ORDER BY `jumlah_mhs` ASC;

-- Menampilkan kode jurusan, nama jurusan, dan jumlah mahasiswa pada setiap jurusan, dimana jumlah mahasiswa > 2 dan diurutkan dari jumlah mahasiswa paling banyak
SELECT `tbl_jurusan`.`kode_jur`, `nama_jur`, COUNT(`nama_mhs`) AS `jml_mhs`
FROM tbl_jurusan, tbl_mhs
WHERE `tbl_jurusan`.`kode_jur` = `tbl_mhs`.`kode_jur`
GROUP BY `kode_jur`
HAVING `jml_mhs` > 2
ORDER BY jml_mhs DESC;

-- Menampilkan nama dosen dan jumlah total sks yang didapatkan setiap dosen, dan diurutkan dari jumlah sks paling banyak
SELECT `nama_dosen`, SUM(`sks`) AS `total_sks`
FROM tbl_matkul, tbl_dosen
WHERE `tbl_matkul`.`nip` = `tbl_dosen`.`nip`
GROUP BY `nama_dosen`
ORDER BY `total_sks` DESC;

-- Menampilkan nip, nama dosen, dan jumlah mahasiswa setiap dosen, dimana jumlah mahasiswa > 1 atau dengan nip 198012122005011001
SELECT `tbl_dosen`.`nip`, `nama_dosen`, COUNT(`nama_mhs`) AS `jml_mhs`
FROM tbl_mhs, tbl_dosen
WHERE `tbl_mhs`.`nip` = `tbl_dosen`.`nip`
GROUP BY `nama_dosen`
HAVING `jml_mhs` > 1 OR `tbl_dosen`.`nip` = '198012122005011001';

-- Menampilkan nip, nama dosen, dan jumlah total sks yang didapatkan setiap dosen, dimana akan menampilkan jumlah sks antara 5 dan 12, serta diurutkan dari jumlah sks paling banyak
SELECT `tbl_dosen`.`nip`, `nama_dosen`, SUM(`sks`) AS `total_sks`
FROM tbl_dosen, tbl_matkul
WHERE `tbl_dosen`.`nip` = `tbl_matkul`.`nip`
GROUP BY `nama_dosen`
HAVING `total_sks` BETWEEN 5 AND 12
ORDER BY `total_sks` DESC;

-- ---------------
-- Acara 39
-- ---------------

-- Menampilkan data pada kedua tabel tersebut dengan JOIN
SELECT `LastName`, `FirstName`, `OrderNo`
FROM Persons
JOIN Orders
ON `Persons`.`P_Id` = `Orders`.`P_Id`;


-- ---------------
-- Acara 40
-- ---------------

-- Menampilkan kode krs, tanggal krs, dan nama jurusan
SELECT `kode_krs`, `tanggal_krs`, `nama_jur`
FROM tbl_krs
JOIN tbl_jurusan
ON `tbl_krs`.`kode_jur` = `tbl_jurusan`.`kode_jur`;

-- Menampilkan kode krs, tanggal krs, nim, nama mahasiswa, dan jumlah sks
SELECT `kode_krs`, `tanggal_krs`, `tbl_mhs`.`nim`, `nama_mhs`, `jumlah_sks`
FROM tbl_krs
JOIN tbl_mhs
ON `tbl_krs`.`nim` = `tbl_mhs`.`nim`;

-- Menampilkan kode krs, tanggal krs, hari dan jam
SELECT `tbl_krs`.`kode_krs`, `tanggal_krs`, `hari`, `jam`
FROM tbl_detail_krs
JOIN tbl_krs
ON `tbl_detail_krs`.`kode_krs` = `tbl_krs`.`kode_krs`;

-- Menampilkan hari, jam, kode mk, dan nama mk
SELECT `hari`, `jam`, `tbl_matkul`.`kode_mk`, `nama_mk`
FROM tbl_detail_krs
JOIN tbl_matkul
ON `tbl_detail_krs`.`kode_mk` = `tbl_matkul`.`kode_mk`;

-- Menampilkan tanggal krs, jumlah mahasiswa yang melakukan krs pada setiap tanggal
SELECT `tanggal_krs`, COUNT(`nama_mhs`) AS `jml_mhs`
FROM tbl_krs
JOIN tbl_mhs
ON `tbl_krs`.`nim` = `tbl_mhs`.`nim`
GROUP BY `tanggal_krs`;

-- Menampilkan tanggal krs, kode jurusan, nama jurusan, jumlah total sks pada setiap jurusan dan diurutkan dari total sks paling besar
SELECT `tanggal_krs`, `tbl_jurusan`.`kode_jur`, `nama_jur`, SUM(`jumlah_sks`) AS `total_sks`
FROM tbl_krs
JOIN tbl_jurusan
ON `tbl_krs`.`kode_jur` = `tbl_jurusan`.`kode_jur`
GROUP BY `nama_jur`
ORDER BY `total_sks` DESC;

-- Menampilkan tanggal krs, kode jurusan, nama jurusan, jumlah total sks pada setiap jurusan dan menampilkan jumlah sks di antara 30 dan 50
SELECT `tanggal_krs`, `tbl_jurusan`.`kode_jur`, `nama_jur`, SUM(`jumlah_sks`) AS `total_sks`
FROM tbl_krs
JOIN tbl_jurusan
ON `tbl_krs`.`kode_jur` = `tbl_jurusan`.`kode_jur`
GROUP BY `nama_jur`
HAVING `total_sks` BETWEEN 30 AND 50;

-- Menampilkan kode krs, nim, dan nama mahasiswa dimana hanya menampilkan pada rentang tanggal tertentu
SELECT `kode_krs`, `tbl_mhs`.`nim`, `nama_mhs`
FROM tbl_krs
JOIN tbl_mhs
ON `tbl_krs`.`nim` = `tbl_mhs`.`nim`
WHERE `tanggal_krs` BETWEEN '2022/11/02' AND '2022/11/03';

-- Menampilkan hari dan jumlah mata kuliah pada setiap hari
SELECT `hari`, COUNT(`kode_mk`) AS `total_mk`
FROM tbl_detail_krs
GROUP BY `hari`;

-- Menampilkan jam dan jumlah mata kuliah pada setiap jam
SELECT DATE_FORMAT(`jam`, '%H') AS `hour`, COUNT(`kode_mk`) AS jml_matkul
FROM tbl_detail_krs
GROUP BY `hour`;
