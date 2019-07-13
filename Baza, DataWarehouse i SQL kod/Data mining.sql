USE IGM

CREATE TABLE Zadovoljstvo
(
	GradID INT NOT NULL PRIMARY KEY,
	NazivGrada NVARCHAR(50),
	UupnoNarudzbi INT,
	SumaOcjena INT,
	ZadovoljstvoPoGradu NVARCHAR(15)
)

INSERT INTO Zadovoljstvo
--Slabo zadovoljstvo uslugama po gradu
SELECT G.GradID,
	   G.Naziv AS Grad,
	   COUNT(N.NarudzbaID) AS 'Ukupno narudzbi',
	   SUM(O.Ocjena) AS 'Suma ocjena',
	   'Slabo' AS Zadovoljstvo
FROM Kupac AS K JOIN Grad AS G
	ON K.GradID=G.GradID JOIN Narudzba AS N
	ON K.KupacID= N.KupacID JOIN Ocjena AS O
	ON K.KupacID = O.KupacID
GROUP BY G.Naziv,G.GradID
HAVING COUNT(N.NarudzbaID) < 60 AND SUM(O.Ocjena) < 350

UNION
--Osrednje zadovoljstvo uslugama po gradu
SELECT G.GradID,
	   G.Naziv AS Grad,
	   COUNT(N.NarudzbaID) AS 'Ukupno narudzbi',
	   SUM(O.Ocjena) AS 'Suma ocjena',
	   'Osrednje' AS Zadovoljstvo
FROM Kupac AS K JOIN Grad AS G
	ON K.GradID=G.GradID JOIN Narudzba AS N
	ON K.KupacID= N.KupacID JOIN Ocjena AS O
	ON K.KupacID = O.KupacID
GROUP BY G.Naziv,G.GradID
HAVING (COUNT(N.NarudzbaID) >= 60 AND COUNT(N.NarudzbaID) < 80) OR (SUM(O.Ocjena) >= 350 AND SUM(O.Ocjena) < 500)

UNION
--Dobro zadovoljstvo uslugama po gradu
SELECT G.GradID,
	   G.Naziv AS Grad,
	   COUNT(N.NarudzbaID) AS 'Ukupno narudzbi',
	   SUM(O.Ocjena) AS 'Suma ocjena',
	   'Dobro' AS Zadovoljstvo
FROM Kupac AS K JOIN Grad AS G
	ON K.GradID=G.GradID JOIN Narudzba AS N
	ON K.KupacID= N.KupacID JOIN Ocjena AS O
	ON K.KupacID = O.KupacID
GROUP BY G.Naziv,G.GradID
HAVING COUNT(N.NarudzbaID) >= 80 AND SUM(O.Ocjena) >= 500

-------------------------------------------------------------




CREATE TABLE ProcjenaProdaje
(
	PoslovnicaID INT NOT NULL PRIMARY KEY,
	NazivPoslovnice NVARCHAR(50),
	UkpnoNarudzbi INT,
	SumaProdatihProizvoda INT,
	Procjena NVARCHAR(15)
)

INSERT INTO ProcjenaProdaje
SELECT  P.PoslovnicaID,
		P.Naziv,
		SUM(NS.Kolicina) AS 'Ukupno prodatih proizvoda',
		COUNT(N.NarudzbaID) AS 'Ukupno naruzdbi',
		'Malo' AS Prodano
FROM Poslovnica AS P JOIN PoslovnicaZaProdaju AS PSP
	ON P.PoslovnicaID=PSP.PoslovnicaZaProdajuID JOIN Proizvod AS PR
	ON PSP.PoslovnicaZaProdajuID = PR.PoslovnicaZaProdajuID JOIN NarudzbaStavke AS NS
	ON NS.ProizvodID=PR.ProizvodID JOIN Narudzba AS N
	ON N.NarudzbaID=NS.NarudzbaID
GROUP BY P.PoslovnicaID,P.Naziv
HAVING COUNT(N.NarudzbaID) < 380 AND SUM(NS.Kolicina) < 3800

UNION

SELECT  P.PoslovnicaID,
		P.Naziv,
		SUM(NS.Kolicina) AS 'Ukupno prodatih proizvoda',
		COUNT(N.NarudzbaID) AS 'Ukupno naruzdbi',
		'Srednje' AS Prodano
FROM Poslovnica AS P JOIN PoslovnicaZaProdaju AS PSP
	ON P.PoslovnicaID=PSP.PoslovnicaZaProdajuID JOIN Proizvod AS PR
	ON PSP.PoslovnicaZaProdajuID = PR.PoslovnicaZaProdajuID JOIN NarudzbaStavke AS NS
	ON NS.ProizvodID=PR.ProizvodID JOIN Narudzba AS N
	ON N.NarudzbaID=NS.NarudzbaID
GROUP BY P.PoslovnicaID,P.Naziv
HAVING (COUNT(N.NarudzbaID) >= 380 AND COUNT(N.NarudzbaID) <650) OR (SUM(NS.Kolicina) >= 3800 AND SUM(NS.Kolicina)<6500)

UNION

SELECT  P.PoslovnicaID,
		P.Naziv,
		SUM(NS.Kolicina) AS 'Ukupno prodatih proizvoda',
		COUNT(N.NarudzbaID) AS 'Ukupno naruzdbi',
		'Dobro' AS Prodano
FROM Poslovnica AS P JOIN PoslovnicaZaProdaju AS PSP
	ON P.PoslovnicaID=PSP.PoslovnicaZaProdajuID JOIN Proizvod AS PR
	ON PSP.PoslovnicaZaProdajuID = PR.PoslovnicaZaProdajuID JOIN NarudzbaStavke AS NS
	ON NS.ProizvodID=PR.ProizvodID JOIN Narudzba AS N
	ON N.NarudzbaID=NS.NarudzbaID
GROUP BY P.PoslovnicaID,P.Naziv
HAVING COUNT(N.NarudzbaID) >= 650 AND SUM(NS.Kolicina)>=650





---------------------------------------------------


CREATE TABLE ProcjenaKupca
(
	KupacID INT NOT NULL PRIMARY KEY,
	Ime NVARCHAR(50),
	Prezime NVARCHAR(50),
	Adresa NVARCHAR(50),
	UkpnoNarudzbi INT,
	SumaProdatihProizvoda INT,
	Procjena NVARCHAR(15)
)

INSERT INTO ProcjenaKupca
SELECT K.KupacID,
	   K.Ime,
	   K.Prezime,
	   K.Adresa,
	   COUNT(N.NarudzbaID) AS 'Ukupno narudzbi',
	   SUM(NS.Kolicina) AS 'Ukupno proizvoda',
	   'Los' AS Kupac
FROM Kupac AS K JOIN Narudzba AS N
	ON K.KupacID=N.KupacID JOIN NarudzbaStavke AS NS
	ON N.NarudzbaID = NS.NarudzbaID
GROUP BY K.KupacID, K.Ime,K.Prezime,K.Adresa
HAVING COUNT(N.NarudzbaID) < 60 AND SUM(NS.Kolicina) < 800

UNION

SELECT K.KupacID,
	   K.Ime,
	   K.Prezime,
	   K.Adresa,
	   COUNT(N.NarudzbaID) AS 'Ukupno narudzbi',
	   SUM(NS.Kolicina) AS 'Ukupno proizvoda',
	   'Srednji' AS Kupac
FROM Kupac AS K JOIN Narudzba AS N
	ON K.KupacID=N.KupacID JOIN NarudzbaStavke AS NS
	ON N.NarudzbaID = NS.NarudzbaID
GROUP BY K.KupacID, K.Ime,K.Prezime,K.Adresa
HAVING (COUNT(N.NarudzbaID) >= 60 AND COUNT(N.NarudzbaID) <110) OR (SUM(NS.Kolicina) >= 800 AND SUM(NS.Kolicina)<1100)

UNION

SELECT K.KupacID,
	   K.Ime,
	   K.Prezime,
	   K.Adresa,
	   COUNT(N.NarudzbaID) AS 'Ukupno narudzbi',
	   SUM(NS.Kolicina) AS 'Ukupno proizvoda',
	   'Dobar' AS Kupac
FROM Kupac AS K JOIN Narudzba AS N
	ON K.KupacID=N.KupacID JOIN NarudzbaStavke AS NS
	ON N.NarudzbaID = NS.NarudzbaID
GROUP BY K.KupacID, K.Ime,K.Prezime,K.Adresa
HAVING COUNT(N.NarudzbaID) >= 110 AND SUM(NS.Kolicina)>=1100




----------------------------------------------------


--SELECT Z.ZaposlenikID,
--	   Z.Ime,
--	   Z.Prezime,
--	   Z.RadniStaz,
--	   COUNT(N.NarudzbaID) AS 'Ukupno narudzbi',
--	   SUM(NS.Kolicina) AS 'Ukupno proizvoda'
--FROM Zaposlenik AS Z JOIN Narudzba AS N 
--	ON Z.ZaposlenikID = N.ZaposlenikID JOIN NarudzbaStavke AS NS
--	ON NS.NarudzbaID=N.NarudzbaID
--GROUP BY Z.ZaposlenikID, Z.Ime, Z.Prezime,Z.RadniStaz