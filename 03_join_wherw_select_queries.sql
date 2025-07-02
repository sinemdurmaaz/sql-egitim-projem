/* GENEL SORGULAR */

-- 1) Öğrencilerin kayıt yaptırdıkları kurs sayısını hesaplayan sorguyu yazın.--
--(KAYDI OLMAYAN ÖĞRENCİLER DE GÖRÜNSÜN)--

SELECT o.isim, o.soyisim, COUNT(k.*) AS kayitli_olunan_kurs_sayisi FROM ogrenciler o LEFT JOIN kayitlar k 
ON o.id=k.ogrenci_id GROUP BY o.isim, o.soyisim ORDER BY kayitli_olunan_kurs_sayisi ASC;

-- 2) Her kategorideki ortalama kurs fiyatı nedir? Kategoriler ve ortalama fiyatları listele.--

SELECT k.id AS kategori_id, AVG(ku.fiyat) AS ortalama_fiyat FROM kategoriler k 
INNER JOIN kurslar ku ON ku.kategori_id = k.id
GROUP BY k.id 
ORDER BY k.id ASC;

-- 3) En yüksek puan ortalamasına sahip 3 eğitmeni bul.--

SELECT e.isim, e.soyisim, AVG(d.puan) AS ortalama_puan  FROM egitmenler e 
INNER JOIN kurslar ku ON e.id = ku.egitmen_id
INNER JOIN degerlendirme d ON ku.id = d.kurs_id
GROUP BY
    e.isim, e.soyisim
LIMIT 3;

-- 4) Belirli bir tarihten sonra en çok ödeme yapan öğrencilerin isimleri ve toplam ödemeleri göster.--

SELECT o.isim, o.soyisim, SUM(od.tutar) AS toplam_odeme FROM ogrenciler o 
INNER JOIN odemeler od ON od.ogrenci_id=o.id 
WHERE tarih >= '2024-01-01' 
GROUP BY o.isim, o.soyisim 
ORDER BY toplam_odeme DESC;

-- 5) Sisteme 2024 yılında kayıt olan tüm öğrencilerin ad, soyad ve e-posta bilgilerini listele.--

SELECT o.isim, o.soyisim, o.eposta, o.kayittarihi FROM ogrenciler o
WHERE kayittarihi BETWEEN '2024-01-01' AND '2024-12-31';

-- 6) Tüm eğitmenlerin uzmanlık alanlarını alfabetik olarak sırala.--

SELECT e.isim, e.soyisim, e.uzmanlik FROM egitmenler e
ORDER BY e.uzmanlik;

-- 7) Kurs fiyatı 3000 TL'den fazla olan kursların isimlerini, eğitmen isimlerini ve fiyatlarını listele.--

SELECT e.isim, e.soyisim, k.isim, k.fiyat FROM kurslar k INNER JOIN egitmenler e ON e.id=k.egitmen_id
WHERE k.fiyat > 3000;


--ÖĞRENCİ ODAKLI SORGULAR--

-- 8) Adı "Ayşe" olan öğrencinin kayıtlı olduğu kursların adlarını getir.--

SELECT o.isim, o.soyisim, ku.isim AS kurs_isim FROM ogrenciler o INNER JOIN kayitlar k ON o.id=k.ogrenci_id
INNER JOIN kurslar ku ON ku.id=k.kurs_id
WHERE o.isim='Ayşe';

-- 9) Hiç değerlendirme yapmamış öğrencilerin isim ve soyisimlerini listele.--

SELECT o.isim, o.soyisim, d.puan FROM ogrenciler o LEFT JOIN degerlendirme d ON o.id=d.ogrenci_id
WHERE d.puan IS NULL;


-- EĞİTMEN VE KURS SORGULARI--

-- 10) En pahalı kursu veren eğitmenin adını ve soyadını getir.--

SELECT e.isim, e.soyisim, k.isim, k.fiyat FROM kurslar k INNER JOIN egitmenler e ON e.id=k.egitmen_id
ORDER BY k.fiyat DESC
LIMIT 1;

-- 11) Her eğitmenin kaç farklı kurs verdiğini göster.

SELECT e.isim, e.soyisim, COUNT(k.*) AS egitmenin_verdigi_kurs_sayisi FROM egitmenler e 
INNER JOIN kurslar k ON e.id=k.egitmen_id
GROUP BY e.isim, e.soyisim;


-- ÖDEME VE GELİR ANALİZİ

-- 12) Her kurs için toplam ödeme tutarını ve yapılan ödeme adedini göster.--

SELECT k.isim, SUM(o.tutar) AS toplam_tutar, COUNT(o.*) AS odeme_adedi FROM kurslar k INNER JOIN odemeler o ON k.id=o.kurs_id
WHERE o.durum='tamamlandi'
GROUP BY k.isim
ORDER BY toplam_tutar DESC;

-- 13) "Kredi Kartı" ile yapılan ödemelerin toplam tutarını getir.--

SELECT o.odeme_yontemi, SUM(o.tutar) AS toplam_tutar FROM odemeler o
WHERE o.odeme_yontemi='Kredi Kartı' AND durum = 'tamamlandi'
GROUP BY o.odeme_yontemi;

-- 14) 2024 yılında yapılan ve iptal edilen ödemeleri listele.--

SELECT o.tarih, o.durum FROM odemeler o
WHERE tarih BETWEEN '2024-01-01' AND '2024-12-31' AND o.durum='iptal';


-- DEĞERLENDİRME VE KURS KALİTESİ ANALİZİ

-- 15) Ortalama puanı 3.5 ve üzeri olan kursların adlarını getir.--

SELECT k.isim, AVG(d.puan) AS ortalama FROM kurslar k INNER JOIN degerlendirme d ON k.id=d.kurs_id
GROUP BY k.isim
HAVING AVG(d.puan) > 3.5;

-- 16) En fazla değerlendirme alan 5 kursu listele.--

SELECT k.isim, COUNT(d.*) AS degerlendirme_sayisi FROM kurslar k INNER JOIN degerlendirme d ON k.id=d.kurs_id
GROUP BY k.isim
ORDER BY degerlendirme_sayisi DESC
LIMIT 5;


--ZAMAN VE TREND SORGULARI--

-- 17) Son 6 ayda (bugünden geriye doğru) kayıt olan öğrencileri getir.--

SELECT o.isim, o.soyisim, o.kayittarihi FROM ogrenciler o 
WHERE o.kayittarihi >= CURRENT_DATE - INTERVAL '6 months';

-- 18) Her ay kaç yeni öğrenci kayıt olmuş? (Yıl-bazlı grup)

SELECT TO_CHAR(kayittarihi, 'YYYY-MM') AS ay, COUNT(*) AS kayit_sayisi
FROM ogrenciler
GROUP BY TO_CHAR(kayittarihi, 'YYYY-MM')
ORDER BY ay;


--ÖZEL VE KARMA SORGULAR--

-- 19) Hem kayıt olup hem de ödeme yapmamış öğrencileri tespit et.--

SELECT o.isim, o.soyisim, k.durum AS kayit_durumu, od.durum AS odeme_durumu FROM ogrenciler o
RIGHT JOIN kayitlar k ON o.id = k.ogrenci_id
RIGHT JOIN odemeler od ON k.kurs_id=od.kurs_id AND k.ogrenci_id = od.ogrenci_id
WHERE od.durum='iptal' AND (k.durum='aktif' OR k.durum='tamamlandi');

-- 20) En çok öğrenciye sahip kursu ve öğrenci sayısını getir.--

SELECT k.isim, count(kayit.*) AS kayitli_ogr_sayisi FROM kurslar k INNER JOIN kayitlar kayit ON k.id=kayit.kurs_id
GROUP BY k.isim
ORDER BY kayitli_ogr_sayisi DESC
LIMIT 1;

-- 21) En az bir öğrencisi olan eğitmenleri ve kaç öğrenciye eğitim verdiklerini göster.--

SELECT e.isim, e.soyisim, COUNT(ka.*) AS ogrenci_sayisi FROM egitmenler e 
INNER JOIN kurslar k ON e.id=k.egitmen_id
INNER JOIN kayitlar ka ON k.id= ka.kurs_id
GROUP BY e.isim, e.soyisim
HAVING COUNT(ka.*) > 0
ORDER BY ogrenci_sayisi ASC;
