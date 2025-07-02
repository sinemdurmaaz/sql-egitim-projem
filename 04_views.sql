--VIEW--

-- 1) Öğrencilerin kayıt oldukları kursların bilgilerini gösteren bir görünüm oluştur. Görünümde öğrencinin adı, soyadı, kurs adı ve kayıt tarihi bulunsun.--

CREATE VIEW ogrenci_bilgileri AS
SELECT o.isim, o.soyisim, ku.isim AS kurs_ismi, k.kayit_tarihi FROM ogrenciler o
INNER JOIN kayitlar k ON o.id=k.ogrenci_id
INNER JOIN kurslar ku ON ku.id=k.kurs_id;

SELECT *  FROM ogrenci_bilgileri;

-- 2) Tüm kursların isimleri, fiyatları, yayın tarihleri ve ilgili eğitmenin adı, soyadı,uzmanlık alanı ile birlikte listelendiği bir görünüm oluştur.--

CREATE VIEW kurslar_listesi AS
SELECT k.isim AS kurs_ismi, k.fiyat, k.yayintarihi, e.isim AS egitmen_ismi, e.soyisim AS egitmen_soyismi, e.uzmanlik 
FROM kurslar k
INNER JOIN egitmenler e ON e.id=k.egitmen_id
ORDER BY k.fiyat ASC;

SELECT * FROM kurslar_listesi;

-- 3) Her kurs için kurs adı ve o kursa ait ortalama değerlendirme puanını içeren bir görünüm oluştur.--

CREATE VIEW kurs_degerlendirmeleri AS
SELECT k.isim AS kurs_ismi, AVG(d.puan) AS degerlendirme_ortalaması FROM kurslar k 
INNER JOIN degerlendirme d ON k.id=d.kurs_id
GROUP BY k.isim
ORDER BY degerlendirme_ortalaması DESC;

SELECT * FROM kurs_degerlendirmeleri
LIMIT 1;

-- 4) Sadece "tamamlandı" durumundaki ödemeleri ve kayıtları içeren bir görünüm oluştur. Görünümde öğrenci adı, kurs adı, ödeme tutarı ve ödeme tarihi yer alsın.--

CREATE VIEW odeme_kayit_listesi AS
SELECT o.isim AS ogrenci_isim, o.soyisim AS ogrenci_soyisim, k.isim AS kurs_isim, od.tutar, od.tarih 
FROM ogrenciler o INNER JOIN odemeler od ON o.id= od.ogrenci_id
INNER JOIN kurslar k ON k.id=od.kurs_id
INNER JOIN kayitlar ka ON k.id=ka.kurs_id
WHERE od.durum='tamamlandi' AND ka.durum='tamamlandi';

SELECT * FROM odeme_kayit_listesi;

-- 5) Her eğitmenin verdiği kurs sayısını gösteren bir görünüm oluştur. Görünümde eğitmen adı, soyadı ve toplam kurs sayısı yer alsın--

CREATE VIEW egitmen_kurs_sayisi AS
SELECT e.isim, e.soyisim, COUNT(k.*) AS toplam_kurs_sayisi FROM egitmenler e 
INNER JOIN kurslar k ON e.id=k.egitmen_id
GROUP BY e.isim, e.soyisim
ORDER BY toplam_kurs_sayisi DESC;

SELECT *  FROM egitmen_kurs_sayisi;
