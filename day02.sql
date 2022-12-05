CREATE TABLE ogrenciler5
(
ogrenci_no char(7), --uzunlugunu bildigimiz stringler icin char kullanilir
isim varchar(20), --uzunlugunu bilmedigimiz stringler icin varchar kullanilir.
soyisim varchar(25),  
not_ort real,  --ondalikli sayilar icin kullanilir. double gibi
kayit_tarih date);


-- varolan bir tablodan yeni bir tablo olusturma 
create table NOTLAR
as 
select isim,not_ort from ogrenciler5;


-- tum verileri alma
select * from ogrenciler5;


--insert ile tablo icine veri ekleme
insert into notlar values ('Orhan',95.5);
insert into notlar values ('Ali',75.5);
insert into notlar values ('Musa',45.5);
insert into notlar values ('Hakan',65.5);
insert into notlar values ('Adem',75.5);
insert into notlar values ('Sumeyye',85.5);

select * from notlar;


--yeni bir table olusturduk
create table talebeler
(
isim varchar(10),
notlar real
);


insert into talebeler values ('Orhan',95.5);
insert into talebeler values ('Ali',75.5);
insert into talebeler values ('Musa',45.5);
insert into talebeler values ('Hakan',65.5);
insert into talebeler values ('Adem',75.5);
insert into talebeler values ('Sumeyye',85.5);

select * from talebeler;


--notlar tablosundan sadece ismi alma:
select isim from notlar;


--constraint:
--hangi datanin unique olmasini istiyorsak ondan sonra unique yazariz.
--bir datanin null olmasini istemiyorsak ondan sonra not null yazariz.
--unique null olabilir ve null degerleri birden fazla olabilir 
CREATE TABLE ogrenciler7
(
ogrenci_no char(7) unique, 
isim varchar(20) not null, 
soyisim varchar(25),  
not_ort real,  
kayit_tarih date
);

select * from ogrenciler7;

insert into ogrenciler7 values ('1234567','Ebrar','Ilhan',75.5,now());
insert into ogrenciler7 values ('1234568','Said','Ilhan',75.5,now());
insert into ogrenciler7 (ogrenci_no,soyisim,not_ort) values ('1234569','Evren',85.5);
--sonuncu eklemede not null kisitlamasi oldugu icin hata verdi. 
--cunku isim kismi null olamayacagi icin bos gecemeyiz.


--primary key olusturma:
--bunlar null olamazlar ve ayni degeri alamazlar
CREATE TABLE ogrenciler8
(ogrenci_no char(7) primary key,
isim varchar(20),
soyisim varchar(25),  
not_ort real,  
kayit_tarih date);

--primary key atamasi 2. yol:
-- eger constraint ismini kendimiz vermek istersek bu yolu kullanabiliriz.
--bu ornekte ogr yaptik
CREATE TABLE ogrenciler9
(
ogrenci_no char(7), 
isim varchar(20), 
soyisim varchar(25),  
not_ort real,  
kayit_tarih date,
constraint ogr primary key(ogrenci_no)	
);

--primary key atamasi 3. yol:
CREATE TABLE ogrenciler10
(
ogrenci_no char(7), 
isim varchar(20), 
soyisim varchar(25),  
not_ort real,  
kayit_tarih date,
primary key(ogrenci_no)	
);


--foreign key nasil olusturulur?
--iki tablo arasinda iliski kurmak icin kullanilir.
/*
Practice 4:
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin
*/
CREATE TABLE tedarikciler3
(tedarikci_id char(10) primary key, 
tedarikci_ismi varchar(50), 
iletisim_isim varchar(50)  
);

create table urunler 
(
tedarikci_id char(10),
urun_id char(10),
foreign key (tedarikci_id) references tedarikciler3 (tedarikci_id)
);

--constraint ismini kendimiz olusturmak istersek:
create table urunler 
(
tedarikci_id char(10),
urun_id char(10),
constraint urn_fk foreign key (tedarikci_id) references tedarikciler3 (tedarikci_id)
);

select * from tedarikciler3;
select * from urunler;


/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, 
“maas”, “ise_baslama” field’lari olsun. “id” yi Primary Key yapin,
“isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”,
“sokak”, “cadde” ve “sehir” fieldlari olsun. “adres_id” field‘i 
ile Foreign Key oluşturun.
*/
create table calisanlar
(
calisan_id varchar(15) primary key,
isim varchar(30) unique,
maas int not null,
ise_baslama date
);

create table adresler
(
adres_id varchar(30),
sokak varchar(30),
cadde varchar(30),
sehir varchar(30),
foreign key (adres_id) references calisanlar (calisan_id)	
)

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); --unique cons oldugu icin kabul etmedi
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- maas not null oldugu icin nulli kabul etmedi
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- calisanlar isim unique oldugu icin can kabul etmedi
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --syntax hatasi int old icin parantez olmaz
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');  -- primary key yani calisanlar unique old icin ikinci kez hiclik kabul etmez.
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- ayni primary key old icin kabul etmedi
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); --id primary old icin null kabul etmez cunku primary keydir
INSERT INTO calisanlar VALUES('56', null, 2005, '2018-04-14');

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz hata verir
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');

-- FK'ye null değeri atanabilir. bunlari kabul eder.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

select * from calisanlar;
select * from adresler;



--check ile sinirlandirma (constraints) yapma:
create table calisanlar2
(
calisan_id varchar(15) primary key,
isim varchar(30) unique,
maas int check (maas>10000), --10000den buyuk olmali diye sinirladik
ise_baslama date
);

INSERT INTO calisanlar2 VALUES('12345', 'filiz ' ,19000, '2018-04-14');

select * from calisanlar2;


--DQL --Where kullanimi:
select * from calisanlar;
select isim from calisanlar;

-- calisanlar tablosundan maasi 5 binden buyuk olanlari listeleyin.
select isim,maas from calisanlar where maas>5000;

--calisanlar tablosundan ismi veli han olan tum verileri listeleyiniz.
select * from calisanlar where isim='Veli Han';

-- calisanlar tablosundan maasi 5 bin olan tum verileri listeleyin.
select * from calisanlar where maas=5000;


--DML --delete komutu
delete from calisanlar; -- eger parent table baska bir child tablo ile iliskili 
--ise once child tablo silinmelidir. yani calisanlari silmez.
--once child silinmelidir.
delete from adresler;
select * from adresler;

--adresler tablosundan sehri antep olan verileri silelim
delete from adresler where sehir='Antep';



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
select * from ogrenciler3;




















