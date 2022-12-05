--database (veritabani) olusturma
create database ebrar;


--DDL - DATA DEFINITION LANGUAGE
-- CREATE - TABLO OLUSTUMA 
--buyuk kucuk harf fark etmiyor.

CREATE TABLE ogrenciler2
(
ogrenci_no char(7), 
isim varchar(20),
soyisim varchar(25),  
not_ort real,  --ondalikli sayilar icin kullanilir. double gibi
kayit_tarih date
)


--var olan tablodan yeni bir tablo olusturma:

create table ogrenci_notlari
AS --benzer tablodaki basliklarla ve data tipleriyle yeni bir tablo olusturmak icin 
--normal tablo olustururkenki parantezler yerine AS kullanip select komutuyla almak istedigimiz verileri aliriz.
select isim, soyisim, not_ort from ogrenciler2;


-- DML - DATA MANIPULATION LANGUAGE
-- INSERT database'e veri ekleme

INSERT INTO ogrenciler2 values ('1234567','Said','ILHAN',85.5,now());
INSERT INTO ogrenciler2 values ('1234567','Said','ILHAN',85.5,'2020-12-11');


--bir tabloya parcali veri eklemek istersek

insert into ogrenciler2 (isim,soyisim) values ('Erol','Evren');


-- DQL - DATA QUERY LANG.
--SELECT

select * from ogrenciler2; 




create table sakali_grup 
(
isimler varchar(30),
batch char(10),
bolum varchar(20),
puan int	
);


insert into sakali_grup values ('Ebrar','B103','Qa',6);

select * from sakali_grup;

insert into sakali_grup (isimler,batch,bolum) values ('Selmina','B103','Qa');































