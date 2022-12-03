CREATE TABLE ogrenciler3
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler3 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler3 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler3 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler3 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Ali', 99);
-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim

delete from ogrenciler3 where isim='Nesibe Yilmaz' or isim = 'Mustafa Bak';
select * from ogrenciler3

--veli ismi hasan olan datayi silelim
delete from ogrenciler3 where veli_isim='Hasan';

--truncate ile tablodaki tum verileri geri alinamaz sekilde silme
truncate table ogrenciler3;



--on delete cascade
drop table if exists talebeler; --eger talebeler tablosu varsa onu silecek
drop table if exists notlar; --eger notlar tablosu varsa onu silecek

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade  --bu bize parent table dan data silme imkani verir. normalde once child silinmeliydi
);                 --aksi halde bu ifade olmasaydi error alirdik silemezdik

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from talebeler;
select * from notlar;

--notlar tablosundan telebe idsi 123 olan dtayi silelim
delete from notlar where talebe_id='123'; --siler, herhangi sorun yok child old icin

--talebeler tablosundan id si 126 olan datayi silelim
delete from talebeler where id='126'; --bunu da siler cunku on delete komutunu ekledik
--ayrica 126 yi child tablosundan da siler yani her ikisinden de siler.
/*
    Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliği ile
parent tablo dan da veri silebiliriz. Yanlız ON DELETE CASCADE komutu kullanımında parent tablodan sildiğimiz
data child tablo dan da silinir
*/



--in condition 
drop table if exists musteriler;
CREATE TABLE musteriler (
urun_id int,
musteri_isim varchar(50), 
	urun_isim varchar(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES (20, 'John', 'Apple'); 
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm'); 
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple'); 
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange'); 
INSERT INTO musteriler VALUES (40, 'John', 'Apricot'); 
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

select * from musteriler;

--musteriler tablosundan urun ismi orange, apple veya apricot olan tum datalari listeleyiniz.
select * from musteriler where urun_isim='Orange' or urun_isim='Apple' or urun_isim='Apricot'
--yukaridaki uzun yoldu
select * from musteriler where urun_isim='Orange' and urun_id=10;


--in condition
--kisa yoldan almamizi saglar 
SELECT * FROM musteriler WHERE urun_isim IN ('Orange','Apple','Apricot');

--not in yazdigimiz verilerin disindakileri getirir.\
SELECT * FROM musteriler WHERE urun_isim NOT IN ('Palm');



-- BETWEEN CONDITION
/*BETWEEN Condition iki mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutla
yazabilme imkani verir. Yazdigimiz 2 sinirda araliga dahildir */

--musteriler tablosundan id si 20 ile 40 arasinda olan tum verileri listeleyiniz.
select * from musteriler where urun_id>=20 and urun_id<=40; --bunu between ile de yapabiliriz.
select * from musteriler where urun_id between 20 and 40;
select * from musteriler where urun_id not between 20 and 40; --bu ise arasinda olmayanlari alir



--subqueries
--SUBQUERIES(ALT SORGU) Iki tablodan gecici olarak 
--tek bir tabloda sorgulama--> sorgu icinde sorgu
CREATE TABLE calisanlar3 (
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);

CREATE TABLE markalar (
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);

INSERT INTO calisanlar3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');
INSERT INTO calisanlar3 VALUES(123456710, 'Fatma Yasa', 'Bursa', null, 'Vakko');

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
INSERT INTO markalar VALUES(104, 'Nike', 19000);

select * from calisanlar3;
select * from markalar;

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada 
-- calisanlarin isimlerini ve maaşlarini listeleyin.
SELECT isim,maas,isyeri FROM calisanlar3
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000);


-- marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz
select isim , maas, sehir from calisanlar3
where isyeri in (Select marka_isim from markalar where marka_id>101);


--ÖDEV- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.




-- 							AGGREGATE METOT KULLANIMI
/*Aggregate Metotlari (SUM,COUNT, MIN, MAX, AVG) Subquery içinde
kullanilabilir.
Ancak, Sorgu tek bir değer döndürüyor olmalidir.
SYNTAX: sum() şeklinde olmalı sum ile () arasında boşluk olmamalı
*/
select max(maas) as maksimum_maas from calisanlar3;
/*
eger bir sutuna gecici olarak bir isim vermek istersek as komutunu yazdiktan sonra vermek istedigimiz ismi yazariz.
*/

-- calisanlar tablosundaki en dusuk maasi listeleyelim
select min(maas) as en_dusuk_maas from calisanlar3;

-- maaslarin toplami:
select sum(maas) from calisanlar3;

--maaslarin ortalamasi:
select avg(maas) from calisanlar3;
select round(avg(maas),2) from calisanlar3; --sayinin ondalik kismi icin sadece iki sayi verir

--maaslarin sayisi:
select count(maas) from calisanlar3; -- maasa null eklersek onu saymaz.

select count(*) from calisanlar3; --hepsini sayacagindan null olursa onu da sayar.

/*
eger count(*) kullanirsak tablodaki tum satirlarin sayisini verir.
sutun adi kullanirsak o sutundaki sayilari verir.
*/

-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz
select * from calisanlar3;
select * from markalar;

select marka_id,marka_isim,
(select count(sehir) as sehir_sayisi from calisanlar3 where marka_isim=isyeri) 
from markalar;
						   
-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin
--toplam maaşini listeleyiniz
select marka_isim, calisan_sayisi,
(select sum(maas) from calisanlar3 where isyeri=marka_isim) as toplam_maas
from markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve 
--minumum maaşini listeleyen bir Sorgu yaziniz.
select marka_isim, calisan_sayisi,
(select max(maas) from calisanlar3 where isyeri=marka_isim) as enyuksekmaas,
(select min(maas) from calisanlar3 where isyeri=marka_isim) as endusukmaas
from markalar;


--view kullanimi:
/*
yaptigimiz sorgulari HAFIZAYA ALIR. ve tekrar bizden istenen sorgulama yerine viewe atadigimiz
ismi select komutu ile cagiririz.
*/
--orn max min maaslari getirmek yerine kolay bir sekilde istedigimiz kaliplarda view olusturup
--istedigimiz zaman kullanabiliriz.
create view maxminmaas
as 
select marka_isim, calisan_sayisi,
(select max(maas) from calisanlar3 where isyeri=marka_isim) as enyuksekmaas,
(select min(maas) from calisanlar3 where isyeri=marka_isim) as endusukmaas
from markalar;

select * from maxminmaas;

--sum ornegindekini alalim view ile;
create view summaas
as
select marka_isim, calisan_sayisi,
(select sum(maas) from calisanlar3 where isyeri=marka_isim) as toplam_maas
from markalar;

select * from summaas;


-- 							EXISTS CONDITION
/*
EXISTS Condition subquery’ler ile kullanilir. IN ifadesinin kullanımına benzer
olarak, EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen değerlerin içerisinde
bir değerin olması veya olmaması durumunda işlem yapılmasını sağlar
*/

CREATE TABLE mart
(   
urun_id int,    
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(   
urun_id int ,
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart;
select * from nisan;

--MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
--URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
--MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.
select urun_id, musteri_isim from mart
where exists (select urun_id from nisan where mart.urun_id=nisan.urun_id);

--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
select urun_isim, musteri_isim from nisan
where exists (select urun_isim from mart where mart.urun_isim=nisan.urun_isim);
--exists kullanirken digerlerinden farkli olarak mart. deyip neyi istiyorsak onun adini yazdik
--cunku her iki tabloda da ayni sutun isimleri yer aldigi icin orn hangi tablodaki
--urun ismi oldugunu anlayabilmemiz gerekir. bu nedenle mart ve nisan yazip nokta koyuyoruz.


--ÖDEV 1)- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
--ODEV 2)Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve  bu ürünleri
 --NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.




--DML - UPDATE SET
--GUNCELLEME YAPMAK ICIN KULLANIRIZ. YANI DEGISIM YAPARIZ.
CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler -- child
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no)
on delete cascade
);    
INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

select * from tedarikciler;
select * from urunler;

-- vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
-- update tablo_adi
-- set sutun_ismi = 'istenen veri' where sutun_ismi = 'istenen veri';

update tedarikciler
set firma_ismi = 'Vestel' where vergi_no=102;

-- vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve 
--irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
update tedarikciler
set firma_ismi = 'Casper', irtibat_ismi='Ali Veli' where vergi_no=101;

-- urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
update urunler
set urun_isim='Telefon' where urun_isim='Phone';

-- urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.
update urunler 
set urun_id = urun_id+1 where urun_id>1004;

-- urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun 
--değerleri ile toplayarak güncelleyiniz.
update urunler
set urun_id = urun_id+ted_vergino;

--yeni soru icin tablo iceriklerini silip tekrar ekledik.
delete from tedarikciler;
delete from urunler;

-- urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda 
--irtibat_ismi 'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.
update urunler 
set urun_isim=(select firma_ismi from tedarikciler where irtibat_ismi='Adam Eve') 
where musteri_isim='Ali Bak';

-- Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi
--Apple’in irtibat_isim'i ile degistirin.
update urunler 
set musteri_isim=(select irtibat_ismi from tedarikciler where firma_ismi='Apple')
where urun_isim='Laptop';





















































