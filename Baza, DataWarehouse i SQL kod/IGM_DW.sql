CREATE DATABASE IGMDW ON PRIMARY
(NAME='IGMDW',FILENAME = 'C:\BI\Data\IGMDW.mdf',SIZE = 100MB, MAXSIZE= UNLIMITED, FILEGROWTH = 10%)
LOG ON
(NAME='IGMlog_DW',FILENAME = 'C:\BI\Log\IGMDW.ldf',SIZE = 2MB, MAXSIZE= UNLIMITED, FILEGROWTH = 5%)


USE IGMDW


CREATE TABLE DimVrijeme
(
	VrijemeKey INT NOT NULL CONSTRAINT PK_DimVrijeme PRIMARY KEY IDENTITY(1,1),
	Datum DATE NOT NULL,
	Godina INT,
	Mjesec INT,
	Dan INT
)


CREATE TABLE DimLokacija
(
	LokacijaKey INT NOT NULL CONSTRAINT PK_DimLokacija PRIMARY KEY IDENTITY(1,1),
	LokacijaAltKey INT NOT NULL,
	Market NVARCHAR(50),
	Grad NVARCHAR(50),
	Drzava NVARCHAR(50)
)

CREATE TABLE DimZaposlenik
(
	ZaposlenikKey INT NOT NULL CONSTRAINT PK_DimZaposlenik PRIMARY KEY IDENTITY(1,1),
	ZaposlenikAltKey INT NOT NULL,
	ImePrezime NVARCHAR(50),
	RadniStaz NVARCHAR(50),
	VrstaPosla NVARCHAR(50)
)

CREATE TABLE DimProizvod
(
	ProizvodKey INT NOT NULL CONSTRAINT PK_DimProizvod PRIMARY KEY IDENTITY(1,1),
	ProizvodAltKey INT NOT NULL,
	Naziv NVARCHAR(50),
	Kategorija NVARCHAR(50),
)

CREATE TABLE DimNarudzba
(
	NarudzbaKey INT NOT NULL CONSTRAINT PK_DimNarudzba PRIMARY KEY IDENTITY(1,1),
	NarudzbaAltKey INT NOT NULL,
	/* DatumNarudzbe DATETIME, --DODANO */
	/* DatumDostave DATETIME, --DODANO */
	Dostava BIT,
	NacinPlacanja NVARCHAR(50),
	Status NVARCHAR(50)
)

CREATE TABLE DimKupac
(
	KupacKey INT NOT NULL CONSTRAINT PK_DimKupac PRIMARY KEY IDENTITY(1,1),
	KupacAltKey INT NOT NULL,
	Naziv NVARCHAR(50),
	VrstaKupca NVARCHAR(50),
	Godiste INT NOT NULL
)

CREATE TABLE FactProdaja
(
	ProdajaKey INT NOT NULL CONSTRAINT PK_DimProdaja PRIMARY KEY IDENTITY(1,1),
	VrijemeKey INT NOT NULL CONSTRAINT FK_Prodaja_Vrijeme FOREIGN KEY REFERENCES dbo.DimVrijeme(VrijemeKey),
	LokacijaKey INT NOT NULL CONSTRAINT FK_Prodaja_Lokacija FOREIGN KEY REFERENCES dbo.DimLokacija(LokacijaKey),
	ZaposlenikKey INT NOT NULL CONSTRAINT FK_Prodaja_Zaposlenik FOREIGN KEY REFERENCES dbo.DimZaposlenik(ZaposlenikKey),
	ProizvodKey INT NOT NULL CONSTRAINT FK_Prodaja_Proizvod FOREIGN KEY REFERENCES dbo.DimProizvod(ProizvodKey),
	NarudzbaKey INT NOT NULL CONSTRAINT FK_Prodaja_Narudzba FOREIGN KEY REFERENCES dbo.DimNarudzba(NarudzbaKey),
	KupacKey INT NOT NULL CONSTRAINT FK_Prodaja_Kupac FOREIGN KEY REFERENCES dbo.DimKupac(KupacKey),
	Kolicina INT,
	Cijena DECIMAL(18,2),
	Popust DECIMAL(18,2),
	Tezina DECIMAL(18,2),
	Ocjena INT,
	JedinicaMjere NVARCHAR(50)
)