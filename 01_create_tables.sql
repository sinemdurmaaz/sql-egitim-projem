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

