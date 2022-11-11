-- ---------------
-- MySQL Script
-- Workshop Basis Data
-- Praktikum Minggu 10
-- Politeknik Negeri Jember 2022
-- ------------------
-- By @irsyadulibad
-- ---------------

USE mahasiswa;
-- ---------------
-- Acara 33
-- ---------------

-- Menampilkan mahasiswa pada setiap alamat
SELECT alamat, COUNT(*) AS jml_mhs
FROM mhs
GROUP BY alamat;

-- Menampilkan mahasiswa pada tiap prodi
SELECT kode_prodi, COUNT(*) AS jml_mhs
FROM mhs
GROUP BY kode_prodi;

-- Jumlah dosen pada setiap alamat
SELECT alamat_dosen, COUNT(*) AS jml_dosen
FROM dosen
GROUP BY alamat_dosen;

-- Jumlah SKS pada setiap prodi
SELECT kode_prodi, SUM(jumlah_sks) AS jml_sks
FROM mata_kuliah
GROUP BY kode_prodi;

-- Jumlah prodi pada alamat tertentu
SELECT alamat, COUNT(*) AS jml_prodi
FROM mhs
WHERE alamat = 'Jember'
GROUP BY alamat;

-- Jumlah prodi yang SKS = 2
SELECT jumlah_sks, COUNT(*) AS jumlah_prodi
FROM mata_kuliah
WHERE jumlah_sks = 2;

-- ---------------
-- Acara 34
-- ---------------

-- Jumlah mahasiswa pada setiap alamat yang jumlahya > 3
SELECT alamat, COUNT(*) AS jumlah_mhs
FROM mhs
GROUP BY alamat
HAVING jumlah_mhs > 3;

-- Jumlah mahasiswa pada setiap prodi yang jumlah < 3 dan jumlah > 4
-- Jumlah < 3
SELECT kode_prodi, COUNT(*) AS jumlah_mhs
FROM mhs
GROUP BY kode_prodi
HAVING jumlah_mhs < 3;

-- Jumlah > 4
SELECT kode_prodi, COUNT(*) AS jml_mhs
FROM mhs
GROUP BY kode_prodi
HAVING jml_mhs > 4;

-- Jumlah dosen pada tiap alamat yang jumlah = 1 atau jumlah = 3
SELECT alamat_dosen, COUNT(*) AS jml_dosen
FROM dosen
GROUP BY alamat_dosen
HAVING jml_dosen = 1 OR jml_dosen = 3;

-- Jumlah sks pada setiap prodi yang jumlah SKS diantara 5 dan 10
SELECT kode_prodi, SUM(jumlah_sks) AS jml_sks
FROM mata_kuliah
GROUP BY kode_prodi
HAVING jml_sks BETWEEN 5 AND 10;

-- Jumlah prodi pada setiap alamat yang jumlah alamat > 5
SELECT alamat, COUNT(*) AS jml_alamat, COUNT(DISTINCT(kode_prodi)) AS total_prodi
FROM mhs
GROUP BY alamat
HAVING jml_alamat > 5;

-- ---------------
-- Acara 35
-- ---------------

-- Menampilkan jumlah mahasiswa pada setiap alamat yang jumlahnya > 3 dan dari nilai tertinggi
SELECT alamat, COUNT(*) AS jml_mhs
FROM mhs
GROUP BY alamat
HAVING jml_mhs > 3
ORDER BY jml_mhs DESC;

-- Jumlah mahasiswa pada setiap prodi yang jumlah < 3 dan jumlah > 4 diurutkan berdasarkan nama prodi terakhir
-- Jumlah < 3
SELECT kode_prodi, COUNT(*) AS jml_mhs
FROM mhs
GROUP BY kode_prodi
HAVING jml_mhs < 3
ORDER BY kdoe_prodi DESC;

-- Jumlah > 4
SELECT kode_prodi, COUNT(*) AS jml_mhs
FROM mhs
GROUP BY kode_prodi
HAVING jml_mhs > 4
ORDER BY kdoe_prodi DESC;

-- Jumlah dosen pada setiap alamat yang jumlah = 1 atau jumlah = 3 diurutkan dari nilai terendah
SELECT alamat_dosen, COUNT(*) AS jml_dosen
FROM dosen
GROUP BY alamat_dosen
HAVING jml_dosen = 1 OR jml_dosen = 3
ORDER BY jml_dosen ASC;

-- Jumlah SKS pada setiap prodi yang jumlah SKS diantara 5 dan 10 diurutkan berdasarkan jumlah SKS terendah
SELECT kode_prodi, SUM(jumlah_sks) AS jml_sks
FROM mata_kuliah
GROUP BY kode_prodi
HAVING jml_sks BETWEEN 5 AND 10
ORDER BY jml_sks ASC;

-- Jumlah prodi pada setiap alamat yang jumlah alamat > 5  dan diurutkan berdasarkan alamat terakhir
SELECT alamat, COUNT(alamat) AS jml_alamat, COUNT(kode_prodi) AS jml_prodi
FROM mhs
GROUP BY alamat
HAVING jml_alamat > 5;
