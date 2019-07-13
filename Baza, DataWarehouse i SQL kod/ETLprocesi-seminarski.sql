SELECT 0 AS PoslovnicaID,'Nepoznato' AS Poslovnica, 'Nepoznato' AS Grad,'Nepoznato' AS Drzava
UNION
SELECT P.PoslovnicaID,P.Naziv,G.Naziv,D.Naziv
FROM Poslovnica AS P JOIN Grad AS G
	ON P.GradID = G.GradID JOIN Drzava AS D
	ON G.DrzavaID = D.DrzavaID


SELECT Z.ZaposlenikID, Z.Ime+' '+Z.Prezime AS 'ImePrezime', Z.RadniStaz,TZ.Naziv
FROM dbo.Zaposlenik AS Z JOIN dbo.TipZaposlenika AS TZ
	ON Z.TipZaposlenikaID=TZ.TipZaposlenikaID



SELECT N.Datum AS 'Datum', CONVERT(INT,YEAR(N.Datum)) AS 'Godina',CONVERT(INT,MONTH(N.Datum)) AS 'Mjesec',CONVERT(INT,DAY(N.Datum)) AS 'Dan'
FROM Narudzba AS N



SELECT K.KupacID,K.Ime+' '+K.Prezime AS 'NazivKupca', K.GodinaRodjenja AS 'Godiste', V.Naziv AS 'VrstaKupca'
FROM dbo.Kupac AS K JOIN dbo.Vrsta AS V
	ON K.VrstaID=V.VrstaID




SELECT P.ProizvodID,P.Naziv,K.Naziv
FROM dbo.Proizvod AS P JOIN dbo.Kategorija AS K
	ON K.KategorijaID=P.KategorijaID



SELECT 0 AS NarudzbaID, 1/1/1900 AS Datum, 1/1/1900 AS DatumIsporuke, 0 AS DostupnaDostava,'Nepoznao' AS NacinPlacanja, 'Nepoznato' AS Status
UNION
SELECT N.NarudzbaID,ISNULL(D.DostupnaDostava,0) AS 'Dostupna',N.NacinPlacanja AS 'NacinPlacanja',ISNULL(N.Status,'Nepoznata') AS 'Status'
FROM dbo.Narudzba AS N JOIN dbo.Dostava AS D
	ON D.DostavaID=N.NarudzbaID




SELECT N.Datum,
	   PZP.PoslovnicaZaProdajuID,
	   Z.ZaposlenikID,
	   P.ProizvodID,
	   N.NarudzbaID,
	   K.KupacID,
	   NS.Kolicina,
	   P.Cijena,
	   NS.Popust
FROM Proizvod AS P JOIN PoslovnicaZaProdaju AS PZP
	ON P.PoslovnicaZaProdajuID=PZP.PoslovnicaZaProdajuID JOIN Zaposlenik AS Z
	ON PZP.PoslovnicaZaProdajuID = Z.PoslovnicaZaProdajuID JOIN Narudzba AS N
	ON Z.ZaposlenikID = N.ZaposlenikID JOIN Kupac AS K
	ON N.KupacID=K.KupacID JOIN NarudzbaStavke AS NS
	ON NS.NarudzbaID=N.NarudzbaID JOIN Ocjena AS O
	ON O.KupacID=K.KupacID
