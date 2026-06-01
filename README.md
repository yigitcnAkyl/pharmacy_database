Eczane Veritabanı Yönetim Sistemi (Pharmacy Database)

Bu proje, bir eczane ve hastane süreçlerinin arka planda nasıl yönetildiğini simüle eden, ilişkisel veritabanı (RDBMS) standartlarına uygun olarak tasarlanmış bir veritabanı yönetim sistemi projesidir.

Proje Yapısı

Proje içerisindeki SQL kodları iki temel aşamadan oluşmaktadır:

01_create_tables.sql: Veritabanı tablolarının, Primary Key (Birincil Anahtar) ve Foreign Key (Yabancı Anahtar) ilişkilerinin tanımlandığı şema kurulum dosyası.
02_insert_data.sql: İlişkisel bütünlük (Integrity Constraints) sıralaması gözetilerek veritabanına eklenen örnek veri setleri.
Veritabanı Tabloları (Şema)

Proje kapsamında aşağıdaki tablolar arası ilişkiler kurgulanmıştır:

Ana Tanımlama Tabloları: UZMANLIK_ALANI, DOKTOR, HASTA, ECZANE, ILAC_FIRMASI, ILAC_BILGISI
Süreç ve İlişki Tabloları: RECETE, MUAYENE, ILAC_STOK, BULUNDURMA, ILAC_SATIS, SATIŞ_DETAY, RECETE_DETAYI
Gelişmiş Sorgu Örnekleri

Proje raporunda ve sunumunda kullanılmak üzere aşağıdaki SQL yetkinliklerini içeren senaryolar test edilmiş ve başarılı sonuçlar alınmıştır:

JOIN: En az iki veya daha fazla tablonun mantıksal birleşimi.
GROUP BY & Kümeleme Fonksiyonları: SUM, COUNT, AVG, MAX, MIN kullanımı ile finansal ve stoksal raporlamalar.
HAVING: Gruplanmış veriler üzerinde dinamik filtreleme çözümleri.
Alt Sorgu (Subquery): İç içe geçmiş sorgu mimarileri.
Çok Koşullu Filtreleme: AND, OR, BETWEEN, LIKE mantıksal operatörlerinin günlük hayat senaryolarına uygulanması.
Kullanılan Teknolojiler

Database: Oracle SQL / PL-SQL (Sözdizimi uyumlu)
Editor: Visual Studio Code & Git Bash