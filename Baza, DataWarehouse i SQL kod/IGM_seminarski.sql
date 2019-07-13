CREATE DATABASE IGM ON PRIMARY
(NAME='IGM',FILENAME = 'C:\BI\Data\IGM.mdf',SIZE = 100MB, MAXSIZE= UNLIMITED, FILEGROWTH = 10%)
LOG ON
(NAME='IGM_log',FILENAME = 'C:\BI\Log\IGM.ldf',SIZE = 2MB, MAXSIZE= UNLIMITED, FILEGROWTH = 5%)


USE IGM



CREATE TABLE Poslovnica
(
	PoslovnicaID INT NOT NULL CONSTRAINT PK_Poslovnica PRIMARY KEY IDENTITY(1,1),
	Naziv NVARCHAR(50) NOT NULL,
	Lokacija NVARCHAR(50) NOT NULL
)




CREATE TABLE PoslovnicaZaProizvodnju
(
	PoslovnicaZaProizvodnjuID INT NOT NULL CONSTRAINT FK_PoslovnicaZaProizvodnju_Poslovnica FOREIGN KEY REFERENCES Poslovnica(PoslovnicaID),
	CONSTRAINT PK_PoslovnicaZaProizvodnju PRIMARY KEY (PoslovnicaZaProizvodnjuID),
	OpisProizvodnje NVARCHAR(300) NOT NULL
)




CREATE TABLE PoslovnicaZaProdaju
(
	PoslovnicaZaProdajuID INT NOT NULL CONSTRAINT FK_PoslovnicaZaProdaju_Poslovnica FOREIGN KEY REFERENCES Poslovnica(PoslovnicaID),
	CONSTRAINT PK_PoslovnicaZaProdaju PRIMARY KEY (PoslovnicaZaProdajuID),
	DatumPopusta DATETIME NULL,
	Lokacija NVARCHAR(50) NULL
)


CREATE TABLE Kategorija
(
	KategorijaID INT NOT NULL CONSTRAINT PK_Kategorija PRIMARY KEY IDENTITY(1,1),
	Naziv NVARCHAR(50) NOT NULL,
)


CREATE TABLE Proizvod
(
	ProizvodID INT NOT NULL CONSTRAINT PK_ProizvodID PRIMARY KEY IDENTITY(1,1),
	Naziv NVARCHAR(50) NOT NULL,
	Opis NVARCHAR(300) NULL,
	Sifra NVARCHAR(50) NULL,
	Cijena DECIMAL(18,2) NOT NULL,
	JedMjere NVARCHAR(50),
	Tezina DECIMAL(18,2),
	PoslovnicaZaProizvodnjuID INT NOT NULL CONSTRAINT FK_Proizvod_PoslovnicaZaProizvodnju FOREIGN KEY REFERENCES PoslovnicaZaProizvodnju(PoslovnicaZaProizvodnjuID),
	KategorijaID INT NOT NULL CONSTRAINT FK_Proizvod_Kategorija FOREIGN KEY REFERENCES Kategorija(KategorijaID)
)

CREATE TABLE TipZaposlenika
(
	TipZaposlenikaID INT NOT NULL CONSTRAINT PK_tipZaposlenika PRIMARY KEY IDENTITY(1,1),
	Naziv NVARCHAR(50),
	Opis NVARCHAR(100),
)

CREATE TABLE Zaposlenik 
(
	ZaposlenikID INT NOT NULL CONSTRAINT PK_zaposlenik PRIMARY KEY IDENTITY(1,1),
	Ime NVARCHAR(50) NOT NULL,
	PREZIME NVARCHAR(50) NOT NULL,
	RadniStaz INT,
	Telefon NUMERIC,
	Opis NVARCHAR(100),
	PoslovnicaZaProdajuID INT NOT NULL CONSTRAINT FK_Zaposlenik_PoslovnicaZaProdaju FOREIGN KEY REFERENCES PoslovnicaZaProdaju(PoslovnicaZaProdajuID),
	TipZaposlenikaID INT NOT NULL CONSTRAINT FK_Zaposlenik_TipZaposlenika FOREIGN KEY REFERENCES TipZaposlenika(TipZaposlenikaID)
)



CREATE TABLE Narudzba
(
	NarudzbaID INT NOT NULL CONSTRAINT PK_NarudzbaID PRIMARY KEY IDENTITY(1,1),
	Kolicina INT NOT NULL,
	Datum DATETIME NOT NULL,
	Teret DECIMAL(18,2),
	NacinPlacanja NVARCHAR(50),
	Status NVARCHAR(50),
	ZaposlenikID INT NOT NULL CONSTRAINT FK_Narudzba_Zaposlenik FOREIGN KEY REFERENCES dbo.Zaposlenik(ZaposlenikID),
	
)



CREATE TABLE Drzava
(
	DrzavaID INT NOT NULL CONSTRAINT PK_Drzava PRIMARY KEY IDENTITY(1,1),
	Naziv NVARCHAR(50) NOT NULL
)





CREATE TABLE Grad
(
	GradID INT NOT NULL CONSTRAINT PK_Grad PRIMARY KEY IDENTITY(1,1),
	Naziv NVARCHAR(50) NOT NULL,
	DrzavaID INT NOT NULL CONSTRAINT FK_Grad_Drzava FOREIGN KEY REFERENCES Drzava(DrzavaID)
)






CREATE TABLE Vrsta
(
	VrstaID INT NOT NULL CONSTRAINT PK_Vrsta PRIMARY KEY IDENTITY(1,1),
	Naziv NVARCHAR(50) NOT NULL
)






CREATE TABLE Kupac
(
	KupacID INT NOT NULL CONSTRAINT PK_Kupac PRIMARY KEY IDENTITY(1,1),
	Ime NVARCHAR(50) NOT NULL,
	Prezime NVARCHAR(50) NOT NULL,
	Email NVARCHAR(50) NOT NULL,
	Telefon NVARCHAR(50) NOT NULL,
	Adresa NVARCHAR(50) NOT NULL,
	GradID INT NOT NULL CONSTRAINT FK_Kupac_Grad FOREIGN KEY REFERENCES Grad(GradID),
	VrstaID INT NOT NULL CONSTRAINT FK_Kupac_Vrsta FOREIGN KEY REFERENCES Vrsta(VrstaID),	
)




CREATE TABLE NarudzbaStavke
(
	NarudzbaID INT NOT NULL CONSTRAINT FK_Stavke_Narudzba FOREIGN KEY REFERENCES Narudzba(NarudzbaID),
	ProizvodID INT NOT NULL CONSTRAINT FK_Stavke_Proizvod FOREIGN KEY REFERENCES Proizvod(ProizvodID),
	PRIMARY KEY (NarudzbaID,ProizvodID),
	Kolicina INT NOT NULL	
)


CREATE TABLE Dostava
(
	DostavaID INT NOT NULL CONSTRAINT FK_Dostava_Narudzba FOREIGN KEY REFERENCES Narudzba(NarudzbaID),
	CONSTRAINT PK_Dostava PRIMARY KEY (DostavaID),
	DatumIsporuke DATETIME NOT NULL,
	DostupnaDostava BIT NULL
)

CREATE TABLE Ocjena
(
	OcjenaID INT NOT NULL CONSTRAINT PK_Ocjena PRIMARY KEY IDENTITY(1,1),
	Datum DATETIME NOT NULL,
	Ocjena INT NOT NULL,
	KupacID INT NOT NULL CONSTRAINT FK_Ocjena_kupac FOREIGN KEY REFERENCES Kupac(KupacID),
	ProizvodID INT NOT NULL CONSTRAINT FK_Ocjena_Proizvod FOREIGN KEY REFERENCES Proizvod(ProizvodID)
)

ALTER TABLE [dbo].[NarudzbaStavke] ADD  ProizvodID INT NOT NULL CONSTRAINT FK_NarudzbaStavke_Proizvod FOREIGN KEY REFERENCES [dbo].[Proizvod]([ProizvodID])

ALTER TABLE Narudzba ADD KupacID INT NOT NULL CONSTRAINT FK_Stavke_Kupac FOREIGN KEY REFERENCES Kupac(KupacID)

ALTER TABLE Poslovnica ADD GradID INT NOT NULL CONSTRAINT FK_Poslovnica_Grad FOREIGN KEY REFERENCES Grad(GradID)

ALTER TABLE Proizvod ADD [PoslovnicaZaProdajuID]  INT NOT NULL CONSTRAINT FK_Proizvod_PoslovnicaZaProdaju FOREIGN KEY REFERENCES [dbo].[PoslovnicaZaProdaju]([PoslovnicaZaProdajuID])


--izmjena kupca. brisanje telefona. dodavanje godinerodjenja-- treba to izmijenit

--import podataka u neke tabele

INSERT INTO dbo.Drzava
(
    Naziv
)
VALUES
('BiH'),('Hrvatska'),('Srbija')


INSERT INTO dbo.Grad
(
    Naziv,
    DrzavaID
)
VALUES
( 'Mostar',1 ),('Sarajevo',1),('Banja Luka',1),('Tuzla',1),('Bihac',1),('Zenica',1),('Bijeljina',1),
('Beograd',3),('Novi Sad',3),('Nis',3),('Kragujevac',3),('Leskovac',3),
('Zagreb',2),('Split',2),('Rijeka',2),('Osijek',2),('Dubrovnik',2),('Zadar',2),('Pula',2)



INSERT INTO dbo.Vrsta
(
    Naziv
)
VALUES
('Fizicko lice'),('Pravno lice')


INSERT INTO dbo.Kategorija
(
    Naziv
)
VALUES
('Gradjevinski materijal'),('Elektricne masine'),('Kucanski aparati'),('Stolarija'),('Namjestaj'),('Kupatilo'),('Boje i lakovi')


INSERT INTO dbo.TipZaposlenika
(
    Naziv,
    Opis
)
VALUES
( 'Prodavac na salteru', 'Neki opis' ),
( 'Prodavac koji promovise', 'Neki opis' )

