-- UZMANLIK ALANI Tablosu
CREATE TABLE UZMANLIK_ALANI (
    uzmanId NUMBER PRIMARY KEY,
    isim VARCHAR2(100) NOT NULL
);

-- DOKTOR Tablosu
CREATE TABLE DOKTOR (
    sicilNo NUMBER PRIMARY KEY,
    ad VARCHAR2(50) NOT NULL,
    soyad VARCHAR2(50) NOT NULL,
    uzmanId NUMBER,
    CONSTRAINT fk_doktor_uzmanlik FOREIGN KEY (uzmanId) REFERENCES UZMANLIK_ALANI(uzmanId)
);

-- HASTA Tablosu
CREATE TABLE HASTA (
    tcNo CHAR(11) PRIMARY KEY,
    ad VARCHAR2(50) NOT NULL,
    soyad VARCHAR2(50) NOT NULL,
    dogumTarihi DATE,
    adres VARCHAR2(250),
    cinsiyet VARCHAR2(10)
);

-- ECZANE Tablosu
CREATE TABLE ECZANE (
    telNo VARCHAR2(15) PRIMARY KEY,
    eczaneAdi VARCHAR2(100) NOT NULL,
    eczaneAdres VARCHAR2(250)
);

-- İLAÇ FİRMASI Tablosu
CREATE TABLE ILAC_FIRMASI (
    vergiNo VARCHAR2(11) PRIMARY KEY,
    firmaAdi VARCHAR2(100) NOT NULL,
    merkezAdres VARCHAR2(250),
    eposta VARCHAR2(100)
);

-- İLAÇ BİLGİSİ Tablosu
CREATE TABLE ILAC_BILGISI (
    ilacId NUMBER PRIMARY KEY,
    ilacAdi VARCHAR2(100) NOT NULL,
    ilacFormu VARCHAR2(50),
    fiyat NUMBER(10,2),
    vergiNo VARCHAR2(11),
    CONSTRAINT fk_ilac_firmasi FOREIGN KEY (vergiNo) REFERENCES ILAC_FIRMASI(vergiNo)
);   
-- REÇETE Tablosu (Hasta ve Doktor ilişkili)
CREATE TABLE RECETE (
    receteKodu NUMBER PRIMARY KEY,
    receteTarihi DATE NOT NULL,
    receteTuru VARCHAR2(50),
    aciklama VARCHAR2(500),
    tcNo CHAR(11),
    sicilNo NUMBER,
    CONSTRAINT fk_recete_hasta FOREIGN KEY (tcNo) REFERENCES HASTA(tcNo),
    CONSTRAINT fk_recete_doktor FOREIGN KEY (sicilNo) REFERENCES DOKTOR(sicilNo)
);

-- MUAYENE İlişkisi (Hasta ve Doktor arasında Çoka-Çok [N:M] İlişki)
CREATE TABLE MUAYENE (
    tcNo CHAR(11),
    sicilNo NUMBER,
    muayeneTarihi DATE,
    PRIMARY KEY (tcNo, sicilNo, muayeneTarihi),
    CONSTRAINT fk_muayene_hasta FOREIGN KEY (tcNo) REFERENCES HASTA(tcNo),
    CONSTRAINT fk_muayene_doktor FOREIGN KEY (sicilNo) REFERENCES DOKTOR(sicilNo)
);

-- REÇETE DETAYI Tablosu (Zayıf Varlık / İlişki)
CREATE TABLE RECETE_DETAYI (
    receteKodu NUMBER,
    ilacId NUMBER,
    PRIMARY KEY (receteKodu, ilacId),
    CONSTRAINT fk_detay_recete FOREIGN KEY (receteKodu) REFERENCES RECETE(receteKodu),
    CONSTRAINT fk_detay_ilac FOREIGN KEY (ilacId) REFERENCES ILAC_BILGISI(ilacId)
);

-- İLAÇ STOK Tablosu
CREATE TABLE ILAC_STOK (
    barkodNo VARCHAR2(50) PRIMARY KEY,
    ilacId NUMBER,
    STT DATE, -- Son Tüketim Tarihi
    CONSTRAINT fk_stok_ilac FOREIGN KEY (ilacId) REFERENCES ILAC_BILGISI(ilacId)
);

-- BULUNDURMA İlişkisi (Eczane ve Stok Durumu - Stok miktarı niteliğiyle birlikte)
CREATE TABLE BULUNDURMA (
    telNo VARCHAR2(15),
    barkodNo VARCHAR2(50),
    stok NUMBER DEFAULT 0,
    PRIMARY KEY (telNo, barkodNo),
    CONSTRAINT fk_bulundurma_eczane FOREIGN KEY (telNo) REFERENCES ECZANE(telNo),
    CONSTRAINT fk_bulundurma_stok FOREIGN KEY (barkodNo) REFERENCES ILAC_STOK(barkodNo)
);

-- İLAÇ SATIŞ Tablosu
CREATE TABLE ILAC_SATIS (
    fisNo NUMBER PRIMARY KEY,
    satisTarihi DATE NOT NULL,
    tcNo CHAR(11),
    telNo VARCHAR2(15),
    CONSTRAINT fk_satis_hasta FOREIGN KEY (tcNo) REFERENCES HASTA(tcNo),
    CONSTRAINT fk_satis_eczane FOREIGN KEY (telNo) REFERENCES ECZANE(telNo)
);

-- SATIŞ DETAY Tablosu
CREATE TABLE SATIS_DETAY (
    fisNo NUMBER,
    barkodNo VARCHAR2(50),
    satisFiyati NUMBER(10,2) NOT NULL,
    satisAdeti NUMBER NOT NULL,
    PRIMARY KEY (fisNo, barkodNo),
    CONSTRAINT fk_satis_detay_fis FOREIGN KEY (fisNo) REFERENCES ILAC_SATIS(fisNo),
    CONSTRAINT fk_satis_detay_stok FOREIGN KEY (barkodNo) REFERENCES ILAC_STOK(barkodNo)
);