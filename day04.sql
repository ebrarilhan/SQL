--ALIASES
CREATE TABLE calisanlar4 (
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);

INSERT INTO calisanlar4 VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO calisanlar4 VALUES(234567890, 'Veli Cem', 'Ankara'); 
INSERT INTO calisanlar4 VALUES(345678901, 'Mine Bulut', 'Izmir');


select * from calisanlar4;

--eger iki sutunun verilerini bitlestirmek istersek concat sembolunu || kullaniriz.
--javadaki concat gibi birlestirmeye yarar.
select calisan_id as id, calisan_isim || ' ' || calisan_dogdugu_sehir as calisan_bilgisi from calisanlar4;

--2. yol:
select calisan_id as id, concat (calisan_isim,' ',calisan_dogdugu_sehir) as calisan_bilgisi from calisanlar4;



--										IS NULL CONDITION
-- Arama yapilan field’da NULL degeri almis kayitlari getirir.

CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');  
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

select * from insanlar;

-- name sutununda null olan degerleri listeleyelim.
select name from insanlar where name is null;

--insanlar tablosunda isimlerin sadece null olmayan degerlerini listeleyin.
select name from insanlar where name is not null;

--insanlar tablosunda null deger almis isimleri no name olarak degistiriniz.
update insanlar
set name='No Name'
where name is null;



-- 								ORDER BY CLAUSE
/*
	ORDER BY komutu belli bir field’a gore NATURAL ORDER olarak siralama
	yapmak icin kullanilir
	ORDER BY komutu sadece SELECT komutu Ile kullanilir
	
	tablodaki verileri siralamak icin kullaniriz. 
	buyukten kucuge ya da kucukten buyuge siralama yapabiliriz. 
	default olarak kucukten buyuge siralama yapar.
	eger buyukten kucuge siralamak istersek order by komutundan sonra DESC komutunu kullaniriz.
*/

CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

select * from insanlar;

--Insanlar tablosundaki datalari adres’e gore siralayin
select * from insanlar order by adres;

--insanlar tablosundaki soyisimleri alfabetik siralayiniz.
select * from insanlar order by soyisim;

--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
select * from insanlar where isim='Mine' order by ssn;

--NOT : Order By komutundan sonra field(sutun) ismi yerine field(sutun) numarasi da kullanilabilir

--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin
select * from insanlar where soyisim='Bulut' order by 2; --ismin field sirasi 2 old icin

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select * from insanlar order by ssn desc;

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
select * from insanlar order by isim asc, soyisim desc; --asc yazmayinca da oluyor

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
/*
eger sutun uzunluguna gore siralamak istersek length komutunu kullaniriz.
ve yine uzunlugu buyukten kucuge siralamak istersek sonuna desc komutunu ekleriz.
*/
select isim, soyisim from insanlar order by length (soyisim) desc;

--tum isim ve soyisim degerlerini ayni sutunda cagirarak her bir sutun degerini uzunluguna gore 
--siralayiniz.
select isim ||' '|| soyisim as isim_soyisim from insanlar 
order by length (isim||soyisim);

--2. yol:
select isim ||' '|| soyisim as isim_soyisim from insanlar 
order by length (isim) + length(soyisim);

--3. yol: concat acisindan 
select concat (isim,' ',soyisim) as isim_soyisim from insanlar 
order by length (isim) + length(soyisim);

--4. yol:
SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar 
ORDER BY LENGTH (concat(isim,soyisim))



--GROUP BY CLAUSE
/*
Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
komutuyla birlikte kullanılır.
*/

CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

select * from manav;

--isme gore alinan toplam urunleri bulun.
select isim,sum(urun_miktar) as aldigi_toplam_urun from manav
group by isim;

--isme gore alinan toplam urunleri bulun ve urunleri buyukten kucuge siralayiniz.
select isim,sum(urun_miktar) as aldigi_toplam_urun from manav
group by isim
order by aldigi_toplam_urun desc;

-- Urun ismine gore urunu alan toplam kisi sayisi
select urun_adi,count(isim) from manav
group by urun_adi;

--bir baska ornek:
select isim,count(urun_adi) from manav
group by isim;
















