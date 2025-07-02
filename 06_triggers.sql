
-- TRIGGER--

-- 1) Bir kursa yeni öğrenci kaydı eklendiğinde, bu kaydın bilgilerini başka bir log tablosuna otomatik kaydeden bir trigger fonksiyonu oluştur.--

CREATE TABLE ogrenci_listesi_logu (
    	id SERIAL PRIMARY KEY,
    	ogrenci_id INT,
    	isim TEXT,
    	soyisim TEXT,
	dogum_tarihi DATE,
	eposta TEXT,
	telefon TEXT,
	sifre TEXT,
	kayittarihi DATE,
    	ekleme_tarihi DATE DEFAULT NOW()
);

CREATE OR REPLACE FUNCTION log_ogrenci_ekleme()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO ogrenci_listesi_logu (
        ogrenci_id,
        isim,
        soyisim,
        dogum_tarihi,
        eposta,
        telefon,
        sifre,
        kayittarihi,
        silinme_tarihi
    ) VALUES (
        NEW.id,
        NEW.isim,
        NEW.soyisim,
        NEW.dogum_tarihi,
        NEW.eposta,
        NEW.telefon,
        NEW.sifre,
        NEW.kayittarihi,
        NOW()
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ogrenci_kayit_logu_trg
AFTER INSERT ON ogrenciler
FOR EACH ROW
EXECUTE FUNCTION log_ogrenci_ekleme();

INSERT INTO ogrenciler (isim, soyisim, dogum_tarihi, eposta, telefon, sifre, kayittarihi) VALUES
('Begüm', 'Yılmaz', '1995-02-15', 'begum.yilmaz@example.com', '05551234567', 'BegumYilmaz23', '2023-04-10');

INSERT INTO ogrenciler (isim, soyisim, dogum_tarihi, eposta, telefon, sifre, kayittarihi) VALUES
('Sinem', 'Yıldırım', '1992-08-17', 'sinem.yildirim@example.com', '05559876543', 'YildirimSinem42', '2023-07-11');

INSERT INTO ogrenciler (isim, soyisim, dogum_tarihi, eposta, telefon, sifre, kayittarihi) VALUES
('Sinem', 'Aydın', '1994-04-09', 'sinem.aydin@example.com', '05551239876', 'AydinSinem88', '2024-03-22');

INSERT INTO ogrenciler (isim, soyisim, dogum_tarihi, eposta, telefon, sifre, kayittarihi) VALUES
('Sinem', 'Çelik', '1991-12-01', 'sinem.celik@example.com', '05553412987', 'Celiksinem12', '2022-11-30');


SELECT * FROM ogrenci_listesi_logu;


-- 2) Bir öğrenci silindiğinde bilgilerini loglayan bir trigger fonksiyonu oluştur.--

CREATE TABLE ogrenci_silme_logu (
    	id SERIAL PRIMARY KEY,
    	ogrenci_id INT,
    	isim TEXT,
    	soyisim TEXT,
	dogum_tarihi DATE,
	eposta TEXT,
	telefon TEXT,
	sifre TEXT,
	kayittarihi DATE,
    	silinme_tarihi DATE DEFAULT NOW()
);

CREATE OR REPLACE FUNCTION log_ogrenci_silme()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO ogrenci_silme_logu (
        ogrenci_id,
        isim,
        soyisim,
        dogum_tarihi,
        eposta,
        telefon,
        sifre,
        kayittarihi,
        silinme_tarihi
    ) VALUES (
        OLD.id,
        OLD.isim,
        OLD.soyisim,
        OLD.dogum_tarihi,
        OLD.eposta,
        OLD.telefon,
        OLD.sifre,
        OLD.kayittarihi,
        NOW()
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_ogrenci_silme
AFTER DELETE ON ogrenciler
FOR EACH ROW
EXECUTE FUNCTION log_ogrenci_silme();

DELETE FROM ogrenciler WHERE isim='Begüm';
DELETE FROM ogrenciler WHERE isim='Sinem';

SELECT * FROM ogrenci_silme_logu;