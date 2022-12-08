-- DISTINCT
-- DISTINCT clause, çağrılan terimlerden tekrarlı olanların sadece birincisini alır.


CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);

INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

select * from musteri_urun;

--musteri urun tablosundan urun isimlerini tekrarsiz(grup) listeleyiniz.
-- gruop by ile:
select urun_isim from musteri_urun
group by urun_isim;

--distinct ile:
select DISTINCT (urun_isim) from musteri_urun;

--tabloda kac farkli meyve vardir.
select urun_isim, count(DISTINCT urun_isim) from musteri_urun
group by urun_isim; --tekrarsiz olarak sayisini verir. soruda kac farkli diyor kac tane demiyor.




-- FETCH NEXT (SAYI) ROW ONLY- OFFSET -LIMIT:

-- musteri urun tablosundan ilk 3 kaydi listeleyin
select * from musteri_urun order by urun_id 
fetch next 3 row only;

--limit ile:
select * from musteri_urun order by urun_id limit 3;

--musteri urun tablosundan ilk kaydi listeleyiniz.
select * from musteri_urun order by urun_id 
fetch next 1 row only;
--veya
select * from musteri_urun order by urun_id limit 1;

--musteri urun tablosundan son uc kaydi listeleyiniz.
select * from musteri_urun order by urun_id desc
limit 3;



CREATE TABLE maas 
(
id int, 
musteri_isim varchar(50),
maas int 
);

INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

select * from maas;

--en yuksek maasi alan musteriyi listeleyiniz
select * from maas order by maas desc limit 1;

--maas tablosundan en yuksek ikinci maasi listeleyin
select * from maas order by maas desc limit 1 offset 1; --limit ile offset yer degisince de oluyor.

/*
OFFSET:
satir atlamak istedigimizde offset komutunu kullaniriz.
*/

--2. yol:
select * from maas order by maas desc 
offset 1
fetch next 1 row only;

--maas tablosundan en dusuk dorduncu maasi listeleyiniz.
select * from maas order by maas
offset 3 limit 1; --ilk ucunu atla birincisini ver demek.




/*
					ALTER TABLE STATEMENT
					
	ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns
	islemleri icin kullanilir.
	ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.
 */

CREATE TABLE personel  (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from personel;

--1) ADD default deger ile tabloya birkac field ekleme
alter table personel 
add ulke varchar(30);

alter table personel
add adres varchar(50) default 'Turkiye'; --default yazarsak olusturdugumuz sutuna belirttigiiz veriyi tum satirlara girer.

alter table personel 
add zipcode varchar(30);


-- 2) DROP tablodan sutun silme
ALTER TABLE personel3
DROP COLUMN zipcode;

ALTER TABLE personel
DROP adres, drop sirket -- Iki sutunu birden sildik

-- 3) RENAME COLUMN sutun adi degistirme
ALTER TABLE personel
RENAME COLUMN sehir TO il;

-- 4) RENAME tablonun ismini degistirme
ALTER TABLE personel
RENAME TO isci

-- 5) TYPE/SET sutunlarin ozelliklerini degistirme
alter table isci 
alter column il type varchar(30),
alter column maas set not null;
--eger numeric data turune sahip bir sutunun data turune string bir data turu
--atamak istersek type varchar(30) using (maas::varchar(30)); bu formati kullaniriz.
alter column maas 
type varchar(30) using (maas::varchar(30));




/*
			TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT
	Transaction veritabani sistemlerinde bir islem basladiginda baslar ve bitince sona erer. Bu
	islemler veritabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir.
 */
 /*
 transaction baslatmak icin begin komutu kulanmamiz gerekir ve transactioni sonlandirmak icin
 commit komutunu calistirmaliyiz.
 */


CREATE TABLE ogrenciler2
(
id serial, -- Serial data turu otomatik olarak birden baslayarak sirali olarak sayi atamasi yapar
		   -- INSERT INTO ile tabloya veri eklerken serial data turunu kullandigim veri degeri yerine DEFAULT yazariz
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);


BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to x;
COMMIT;

select * from ogrenciler2;


/*
	Transaction kullaniminda SERIAL data turu kullanimi tercih edilmez. Save pointten sonra ekledigimiz
	veride sayac mantigi ile calistigi icin sayacta en son hangi sayida kaldiysa ordan devam eder.
	NOT :PostgreSQL de Transaction kullanımı için «Begin;» komutuyla başlarız sonrasında tekrar
	yanlış bir veriyi düzelmek veya bizim için önemli olan verilerden
	sonra ekleme yapabilmek için "SAVEPOINT savepointismi" komutunu
	kullanırız ve bu savepointe dönebilmek için "ROLLBACK TO savepointismi" komutunu
	kullanırız ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki
	verileri tabloda bize verir ve son olarak Transaction'ı sonlandırmak için mutlaka
	"COMMIT" komutu kullanılır.
 */













































