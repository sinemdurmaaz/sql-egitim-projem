CREATE TABLE ogrenciler(
	id SERIAL PRIMARY KEY,
	isim VARCHAR(50),
	soyisim VARCHAR(50),
	dogum_tarihi DATE,
	eposta VARCHAR(100) UNIQUE,
	telefon VARCHAR(15),
	sifre TEXT,
	kayittarihi DATE
);

CREATE TABLE egitmenler(
	id SERIAL PRIMARY KEY,
	isim VARCHAR(50),
	soyisim VARCHAR(50),
	dogum_tarihi DATE,
	uzmanlik VARCHAR(100),
	eposta VARCHAR(100) UNIQUE,
	telefon VARCHAR(15),
	biyografi TEXT,
	sifre TEXT,
	kayit_tarihi DATE
);


CREATE TABLE kategoriler(
	id SERIAL PRIMARY KEY,
	isim VARCHAR(50)
);


CREATE TABLE kurslar(
	id SERIAL PRIMARY KEY,
	isim VARCHAR(100),
	egitmen_id INT REFERENCES egitmenler(id),
	kategori_id INT REFERENCES kategoriler(id),
	fiyat DECIMAL(8,2) DEFAULT 0,
	yayintarihi DATE,
	aciklama TEXT,
	aktif BOOLEAN DEFAULT TRUE
);

CREATE TABLE kayitlar(
	id SERIAL PRIMARY KEY,
	ogrenci_id INT REFERENCES ogrenciler(id),
	kurs_id INT REFERENCES kurslar(id),
	kayit_tarihi DATE,
	durum VARCHAR(20) DEFAULT 'aktif'
);

CREATE TABLE degerlendirme(
    	id SERIAL PRIMARY KEY,
    	ogrenci_id INT REFERENCES ogrenciler(id),
    	kurs_id INT REFERENCES kurslar(id),
    	puan INT CHECK (puan >= 1 AND puan <= 5),
    	yorum TEXT,
    	tarih DATE
);

CREATE TABLE odemeler(
	id SERIAL PRIMARY KEY,
	ogrenci_id INT REFERENCES ogrenciler(id),
	kurs_id INT REFERENCES kurslar(id),
	tutar DECIMAL(8,2),
	tarih DATE,
	odeme_yontemi VARCHAR(30),
	durum VARCHAR(20) DEFAULT 'tamamlandi'
);

SELECT * FROM öğrenciler;
SELECT * FROM egitmenler;
SELECT * FROM kategoriler;
SELECT * FROM kurslar;
SELECT * FROM degerlendirme;
SELECT * FROM odemeler;


/* VERİ GİRİŞLERİ*/

INSERT INTO ogrenciler (isim, soyisim, dogum_tarihi, eposta, telefon, sifre, kayittarihi) VALUES
('Ayşe', 'Yılmaz', '1995-02-15', 'ayse.yilmaz@example.com', '05551234567', 'AyseYilmaz2023', '2023-01-10'),
('Mehmet', 'Demir', '1990-06-21', 'mehmet.demir@example.com', '05559876543', 'MehmetDemir1990', '2023-02-05'),
('Elif', 'Kaya', '1998-11-30', 'elif.kaya@example.com', '05552345678', 'EliKay1998', '2023-03-12'),
('Ahmet', 'Çelik', '1985-08-09', 'ahmet.celik@example.com', '05553456789', 'AhmCel1985', '2023-01-25'),
('Zeynep', 'Şahin', '1997-04-17', 'zeynep.sahin@example.com', '05554567890', 'ZeySah1997', '2023-02-28'),
('Hasan', 'Kurt', '1992-09-14', 'hasan.kurt@example.com', '05555678901', 'HasKur1992', '2023-04-01'),
('Fatma', 'Öztürk', '1993-03-22', 'fatma.ozturk@example.com', '05556789012', 'FatOzt1993', '2023-05-05'),
('Emre', 'Aydın', '1989-12-02', 'emre.aydin@example.com', '05557890123', 'EmrAyd1989', '2023-06-15'),
('Seda', 'Yılmaz', '1996-07-08', 'seda.yilmaz@example.com', '05558901234', 'SedYil1996', '2023-07-20'),
('Murat', 'Demirtaş', '1991-10-10', 'murat.demirtas@example.com', '05559012345', 'MurDem1991', '2023-08-11'),
('Selin', 'Öz', '1994-01-05', 'selin.oz@example.com', '05550123456', 'SelOz1994', '2023-09-19'),
('Deniz', 'Acar', '1999-05-25', 'deniz.acar@example.com', '05551234560', 'DenAca1999', '2023-10-02'),
('Berk', 'Arslan', '1997-08-30', 'berk.arslan@example.com', '05552345661', 'BerArs1997', '2023-11-07'),
('Derya', 'Kılıç', '1988-11-11', 'derya.kilic@example.com', '05553456762', 'DerKil1988', '2023-12-14'),
('Gökhan', 'Turan', '1995-03-17', 'gokhan.turan@example.com', '05554567863', 'GokTur1995', '2024-01-21'),
('Ebru', 'Çetin', '1993-06-20', 'ebru.cetin@example.com', '05555678964', 'EbrCet1993', '2024-02-28'),
('Barış', 'Erdoğan', '1990-12-29', 'baris.erdogan@example.com', '05556789065', 'BarErd1990', '2024-03-15'),
('Hande', 'Güler', '1992-01-12', 'hande.guler@example.com', '05557890166', 'HanGul1992', '2024-04-08'),
('Ozan', 'Kara', '1987-09-03', 'ozan.kara@example.com', '05558901267', 'OzaKar1987', '2024-05-19'),
('Selma', 'Doğan', '1996-10-25', 'selma.dogan@example.com', '05559012368', 'SelDog1996', '2024-06-23'),
('Serkan', 'Şimşek', '1994-07-14', 'serkan.simsek@example.com', '05550123469', 'SerSim1994', '2024-07-30'),
('Nihan', 'Yıldız', '1991-05-05', 'nihan.yildiz@example.com', '05551234570', 'NihYil1991', '2024-08-25'),
('Kemal', 'Polat', '1989-02-28', 'kemal.polat@example.com', '05552345671', 'KemPol1989', '2024-09-10'),
('İrem', 'Şen', '1998-03-19', 'irem.sen@example.com', '05553456772', 'IreSen1998', '2024-10-15'),
('Volkan', 'Aslan', '1995-12-05', 'volkan.aslan@example.com', '05554567873', 'VolAsl1995', '2024-11-20'),
('Merve', 'Kaya', '1997-04-12', 'merve.kaya@example.com', '05555678974', 'MerKay1997', '2024-12-30'),
('Onur', 'Yılmaz', '1993-09-08', 'onur.yilmaz@example.com', '05556789075', 'OnuYil1993', '2025-01-10'),
('Funda', 'Güneş', '1990-11-11', 'funda.gunes@example.com', '05557890176', 'FunGun1990', '2025-02-14'),
('Tuna', 'Özdemir', '1988-08-16', 'tuna.ozdemir@example.com', '05558901277', 'TunOzd1988', '2025-03-25');


INSERT INTO egitmenler (isim, soyisim, dogum_tarihi, uzmanlik, eposta, teledon, biyografi, sifre, kayit_tarihi) VALUES
('Ali', 'Yıldız', '1980-04-05', 'Python, Veri Bilimi', 'ali.yildiz@example.com', '05551230001', 'Deneyimli veri bilimci.', 'Ali1980', '2023-01-15'),
('Ayça', 'Demir', '1985-06-10', 'Web Geliştirme', 'ayca.demir@example.com', '05551230002', 'Frontend uzmanı.', 'Ayca1985', '2023-02-20'),
('Bora', 'Çelik', '1979-11-21', 'Mobil Uygulama', 'bora.celik@example.com', '05551230003', 'Android ve iOS geliştiricisi.', 'Bora1979', '2023-03-10'),
('Ceren', 'Yılmaz', '1987-12-15', 'UX/UI Tasarım', 'ceren.yilmaz@example.com', '05551230004', 'Tasarım gurusu.', 'Ceren1987', '2023-04-18'),
('Deniz', 'Kara', '1990-07-08', 'Projeler Yönetimi', 'deniz.kara@example.com', '05551230005', 'Projeler uzmanı.', 'Deniz1990', '2023-05-22'),
('Ece', 'Şahin', '1983-02-28', 'Siber Güvenlik', 'ece.sahin@example.com', '05551230006', 'Siber güvenlik danışmanı.', 'Ece1983', '2023-06-14'),
('Fikret', 'Gül', '1975-09-30', 'Veri Tabanı', 'fikret.gul@example.com', '05551230007', 'Veri tabanı uzmanı.', 'Fikret1975', '2023-07-29'),
('Gamze', 'Aydın', '1982-03-11', 'Python', 'gamze.aydin@example.com', '05551230008', 'Python geliştiricisi.', 'Gamze1982', '2023-08-04'),
('Hakan', 'Yılmaz', '1986-10-19', 'Java', 'hakan.yilmaz@example.com', '05551230009', 'Java mühendisi.', 'Hakan1986', '2023-09-30'),
('İpek', 'Kurt', '1984-05-27', 'Ruby', 'ipek.kurt@example.com', '05551230010', 'Ruby uzmanı.', 'Ipek1984', '2023-10-21'),
('Jale', 'Polat', '1989-01-04', 'JavaScript', 'jale.polat@example.com', '05551230011', 'JS geliştiricisi.', 'Jale1989', '2023-11-15'),
('Kemal', 'Öztürk', '1978-08-22', 'C#', 'kemal.ozturk@example.com', '05551230012', 'C# uzmanı.', 'Kemal1978', '2023-12-05'),
('Lale', 'Demirtaş', '1981-12-30', 'Go', 'lale.demirtas@example.com', '05551230013', 'Go geliştiricisi.', 'Lale1981', '2024-01-10'),
('Mert', 'Çakır', '1983-06-18', 'PHP', 'mert.cakir@example.com', '05551230014', 'PHP uzmanı.', 'Mert1983', '2024-02-02'),
('Nazan', 'Şen', '1987-04-09', 'HTML/CSS', 'nazan.sen@example.com', '05551230015', 'Frontend tasarımcı.', 'Nazan1987', '2024-03-12'),
('Oğuz', 'Kaya', '1985-09-14', 'Veri Bilimi', 'oguz.kaya@example.com', '05551230016', 'Veri bilimci.', 'Oguz1985', '2024-04-19'),
('Pelin', 'Acar', '1982-11-20', 'Makine Öğrenimi', 'pelin.acar@example.com', '05551230017', 'Makine öğrenimi uzmanı.', 'Pelin1982', '2024-05-22'),
('Rıza', 'Kurt', '1980-07-07', 'Bulut Teknolojileri', 'riza.kurt@example.com', '05551230018', 'Bulut uzmanı.', 'Riza1980', '2024-06-25'),
('Seda', 'Arslan', '1986-01-28', 'Siber Güvenlik', 'seda.arslan@example.com', '05551230019', 'Siber güvenlik mühendisi.', 'Seda1986', '2024-07-28'),
('Tuna', 'Özdemir', '1983-03-03', 'JavaScript', 'tuna.ozdemir@example.com', '05551230020', 'JS geliştiricisi.', 'Tuna1983', '2024-08-15');


INSERT INTO kategoriler (isim) VALUES
('Programlama'),
('Veri Bilimi'),
('Web Geliştirme'),
('Mobil Uygulama'),
('Siber Güvenlik'),
('Tasarım'),
('Proje Yönetimi'),
('Bulut Teknolojileri'),
('Makine Öğrenimi'),
('Veri Tabanı'),
('Yapay Zeka'),
('Blockchain'),
('Oyun Geliştirme'),
('Sosyal Medya Pazarlama'),
('Fotoğrafçılık'),
('Video Düzenleme'),
('3D Modelleme'),
('Dil Öğrenme'),
('Kariyer Gelişimi'),
('Kişisel Finans');


INSERT INTO kurslar (isim, egitmen_id, kategori_id, fiyat, yayintarihi, aciklama, aktif) VALUES
('Python Başlangıç', 1, 1, 0, '2023-01-01', 'Python programlamaya giriş.', TRUE),
('İleri Python', 8, 1, 2500, '2023-03-15', 'Python ileri seviye.', TRUE),
('Veri Bilimine Giriş', 15, 2, 3000, '2023-05-01', 'Veri bilimine başlangıç.', TRUE),
('Makine Öğrenimi Temelleri', 16, 9, 3500, '2023-06-10', 'Makine öğrenimi temelleri.', TRUE),
('Web Tasarım 101', 11, 3, 1500, '2023-02-20', 'Temel web tasarım.', TRUE),
('JavaScript Başlangıç', 10, 3, 2000, '2023-04-25', 'JS programlamaya giriş.', TRUE),
('Mobil Uygulama Geliştirme', 3, 4, 2800, '2023-07-05', 'Mobil uygulama geliştirme.', TRUE),
('Siber Güvenlik Temelleri', 6, 5, 3200, '2023-08-01', 'Siber güvenliğe giriş.', TRUE),
('UI/UX Tasarım', 4, 6, 1800, '2023-09-12', 'Kullanıcı deneyimi tasarımı.', TRUE),
('Proje Yönetimi 101', 5, 7, 2200, '2023-10-20', 'Projeler nasıl yönetilir.', TRUE),
('Veri Tabanı Yönetimi', 7, 10, 2500, '2023-11-10', 'Veri tabanı temelleri.', TRUE),
('C# Programlama', 12, 1, 2300, '2023-12-05', 'C# programlama dili.', TRUE),
('Go ile Programlama', 13, 1, 2400, '2024-01-15', 'Go diliyle yazılım.', TRUE),
('PHP Geliştirme', 14, 1, 2100, '2024-02-10', 'PHP diliyle web geliştirme.', TRUE),
('HTML & CSS Temelleri', 15, 3, 1400, '2024-03-20', 'Web tasarım temelleri.', TRUE),
('Java İleri Seviye', 9, 1, 2700, '2024-04-25', 'Java programlama ileri seviye.', TRUE),
('Bulut Bilişim Temelleri', 18, 8, 3000, '2024-05-30', 'Bulut teknolojilerine giriş.', TRUE),
('Siber Güvenlik İleri', 19, 5, 3500, '2024-06-15', 'Siber güvenlikte ileri seviye.', TRUE),
('React ile Web Geliştirme', 20, 3, 2800, '2024-07-10', 'React.js öğrenin.', TRUE),
('Veri Analizi ve Raporlama', 1, 2, 2500, '2024-08-05', 'Veri analizi teknikleri.', TRUE);


INSERT INTO kayitlar (ogrenci_id, kurs_id, kayit_tarihi, durum) VALUES
(1, 3, '2023-01-15', 'aktif'),
(3, 5, '2023-02-20', 'tamamlandi'),
(4, 1, '2023-03-10', 'aktif'),
(5, 7, '2023-04-05', 'iptal'),
(6, 4, '2023-05-01', 'aktif'),
(7, 6, '2023-06-12', 'aktif'),
(8, 2, '2023-07-20', 'tamamlandi'),
(10, 3, '2023-08-15', 'aktif'),
(11, 5, '2023-09-10', 'aktif'),
(12, 1, '2023-10-01', 'tamamlandi'),
(13, 4, '2023-11-12', 'iptal'),
(14, 6, '2023-12-05', 'aktif'),
(15, 7, '2024-01-20', 'aktif'),
(17, 3, '2024-02-15', 'tamamlandi'),
(18, 5, '2024-03-10', 'aktif'),
(19, 1, '2024-04-20', 'aktif'),
(20, 2, '2024-05-18', 'tamamlandi'),
(21, 4, '2024-06-22', 'aktif'),
(22, 6, '2024-07-19', 'iptal'),
(23, 7, '2024-08-14', 'aktif'),
(24, 3, '2024-09-11', 'aktif'),
(25, 5, '2024-10-10', 'tamamlandi'),
(26, 1, '2024-11-08', 'aktif'),
(28, 2, '2024-12-05', 'aktif'),
(29, 4, '2025-01-03', 'aktif');


INSERT INTO degerlendirme (ogrenci_id, kurs_id, puan, yorum, tarih) VALUES
(1, 3, 5, 'Harika bir kurs, çok faydalıydı!', '2023-02-01'),
(3, 5, 4, 'Gayet öğretici ve anlaşılır.', '2023-03-01'),
(4, 1, 5, 'Yeni başlayanlar için ideal.', '2023-04-15'),
(5, 7, 3, 'Biraz zorlayıcıydı ama iyiydi.', '2023-05-10'),
(6, 4, 4, 'İyi bir başlangıçtı.', '2023-06-05'),
(7, 6, 5, 'Mobil uygulama öğrenmek çok keyifliydi.', '2023-07-01'),
(8, 2, 4, 'Veri bilimi için güzel bir giriş.', '2023-08-01'),
(10, 3, 3, 'Daha fazla pratik olmalı.', '2023-09-10'),
(11, 5, 5, 'Anlatım çok iyiydi.', '2023-10-05'),
(12, 1, 4, 'Temel bilgiler netti.', '2023-11-20'),
(13, 4, 3, 'Karmaşık konulara değinilmiş.', '2023-12-10'),
(14, 6, 5, 'Tasarım çok güzel anlatılmış.', '2024-01-15'),
(15, 7, 4, 'İyi bir içerik sunuldu.', '2024-02-01'),
(17, 3, 5, 'Dersler çok anlaşılırdı.', '2024-03-01'),
(18, 5, 4, 'Konular yeterince kapsamlıydı.', '2024-04-10'),
(19, 1, 3, 'Daha fazla örnek beklerdim.', '2024-05-05'),
(20, 2, 5, 'Çok faydalı ve pratik.', '2024-06-01'),
(21, 4, 4, 'Temel bilgiler iyiydi.', '2024-07-01'),
(22, 6, 3, 'Bazı bölümler karmaşıktı.', '2024-08-15'),
(23, 7, 5, 'Uygulamalı çok güzeldi.', '2024-09-10'),
(24, 3, 4, 'Genel olarak iyiydi.', '2024-10-05'),
(25, 5, 5, 'Harika bir eğitim.', '2024-11-01'),
(26, 1, 4, 'Anlatım başarılıydı.', '2024-12-01'),
(28, 2, 3, 'Orta seviyede bir kurs.', '2025-01-10'),
(29, 4, 5, 'Oldukça faydalıydı.', '2025-02-01');


INSERT INTO odemeler (ogrenci_id, kurs_id, tutar, tarih, odeme_yontemi) VALUES
(1, 1, 250.00, '2025-06-01', 'Kredi Kartı'),
(2, 2, 300.00, '2025-06-02', 'Havale'),
(3, 3, 350.00, '2025-06-03', 'Paypal'),
(4, 4, 280.00, '2025-06-04', 'Kapıda Ödeme'),
(5, 5, 270.00, '2025-06-05', 'Kredi Kartı'),
(6, 6, 230.00, '2025-06-06', 'Havale'),
(7, 7, 210.00, '2025-06-07', 'Paypal'),
(8, 8, 260.00, '2025-06-08', 'Kapıda Ödeme'),
(9, 9, 220.00, '2025-06-09', 'Kredi Kartı'),
(10, 10, 240.00, '2025-06-10', 'Havale'),
(11, 11, 300.00, '2025-06-11', 'Paypal'),
(12, 12, 290.00, '2025-06-12', 'Kapıda Ödeme'),
(13, 13, 270.00, '2025-06-13', 'Kredi Kartı'),
(14, 14, 200.00, '2025-06-14', 'Havale'),
(15, 15, 350.00, '2025-06-15', 'Paypal');


INSERT INTO odemeler (ogrenci_id, kurs_id, tutar, tarih, odeme_yontemi, durum) VALUES
(1, 3, 1500, '2023-01-15', 'Kredi Kartı', 'tamamlandi'),
(3, 5, 3000, '2023-02-20', 'Havale', 'tamamlandi'),
(4, 1, 0, '2023-03-10', 'Ücretsiz', 'tamamlandi'),
(5, 7, 2800, '2023-04-05', 'Kredi Kartı', 'iptal'),
(6, 4, 2000, '2023-05-01', 'Banka Havalesi', 'tamamlandi'),
(7, 6, 3200, '2023-06-12', 'Kredi Kartı', 'tamamlandi'),
(8, 2, 2500, '2023-07-20', 'Havale', 'tamamlandi'),
(10, 3, 1500, '2023-08-15', 'Kredi Kartı', 'tamamlandi'),
(11, 5, 3000, '2023-09-10', 'Banka Havalesi', 'tamamlandi'),
(12, 1, 0, '2023-10-01', 'Ücretsiz', 'tamamlandi'),
(13, 4, 2000, '2023-11-12', 'Kredi Kartı', 'iptal'),
(14, 6, 3200, '2023-12-05', 'Havale', 'tamamlandi'),
(15, 7, 2800, '2024-01-20', 'Kredi Kartı', 'tamamlandi'),
(17, 3, 1500, '2024-02-15', 'Banka Havalesi', 'tamamlandi'),
(18, 5, 3000, '2024-03-10', 'Kredi Kartı', 'tamamlandi'),
(19, 1, 0, '2024-04-20', 'Ücretsiz', 'tamamlandi'),
(20, 2, 2500, '2024-05-18', 'Havale', 'tamamlandi'),
(21, 4, 2000, '2024-06-22', 'Kredi Kartı', 'tamamlandi'),
(22, 6, 3200, '2024-07-19', 'Banka Havalesi', 'iptal'),
(23, 7, 2800, '2024-08-14', 'Kredi Kartı', 'tamamlandi'),
(24, 3, 1500, '2024-09-11', 'Havale', 'tamamlandi'),
(25, 5, 3000, '2024-10-10', 'Kredi Kartı', 'tamamlandi'),
(26, 1, 0, '2024-11-08', 'Ücretsiz', 'tamamlandi'),
(28, 2, 2500, '2024-12-05', 'Havale', 'tamamlandi'),
(29, 4, 2000, '2025-01-03', 'Kredi Kartı', 'tamamlandi');
