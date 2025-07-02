-- FONKSİYONLAR--

-- 1) Öğrencinin Tamamladığı Kurs Sayısını Döndüren Fonksiyon --

CREATE OR REPLACE FUNCTION ogrenci_tamamlanan_kurs_sayisi (p_ogrenci_id INT)
RETURNS INT AS $$
DECLARE
	kurs_sayisi INT;
BEGIN
	SELECT COUNT(*) INTO kurs_sayisi
	FROM kayitlar
	WHERE ogrenci_id=p_ogrenci_id AND durum= 'tamamlandi';

     RETURN COALESCE(kurs_sayisi,0);
END;
$$ LANGUAGE plpgsql;

SELECT ogrenci_tamamlanan_kurs_sayisi(3);

-- 2) Kursun Ortalama Puanını Döndüren Fonksiyon--

CREATE OR REPLACE FUNCTION kurs_ortalaması(p_kurs_id INT)
RETURNS INT AS $$
DECLARE
    ort_puan INT;
BEGIN
    SELECT AVG(puan) INTO ort_puan
    FROM degerlendirme
    WHERE kurs_id = p_kurs_id;

    RETURN COALESCE(ort_puan, 0);
END;
$$ LANGUAGE plpgsql;

SELECT kurs_ortalaması(1)

