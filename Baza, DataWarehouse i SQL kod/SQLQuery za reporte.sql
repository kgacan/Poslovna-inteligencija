
SELECT  TOP 10 DL.Grad, DP.Kategorija, AVG(FP.Popust) AS 'Prosjecan popust'
FROM FactProdaja AS FP JOIN DimProizvod AS DP
	 ON FP.ProizvodKey = DP.ProizvodKey JOIN DimLokacija AS DL
	 ON FP.LokacijaKey = DL.LokacijaKey
GROUP BY DP.Kategorija, DL.Grad
ORDER BY 'Prosjecan popust' DESC





SELECT K.KategorijaID,
	   K.Naziv AS Kategorija,
	   P.Naziv AS Proizvod,
	   O.Ocjena,
	   CONVERT(varchar, O.Datum, 4) AS 'Datum ocjenivanja',
	   KU.Ime+' '+KU.Prezime AS Kupac,
	   G.Naziv AS Grad,
	   D.Naziv AS Drzava
FROM Kategorija AS K JOIN Proizvod AS P
	ON K.KategorijaID=P.KategorijaID JOIN Ocjena AS O
	ON O.ProizvodID=P.ProizvodID JOIN Kupac AS KU
	ON KU.KupacID=O.KupacID JOIN Grad AS G
	ON G.GradID=KU.GradID JOIN Drzava AS D
	ON D.DrzavaID=G.DrzavaID
WHERE O.Ocjena=10


	SELECT Naziv FROM Grad

	SELECT * FROM Kategorija



SELECT P.JedMjere,
	   D.Naziv AS Drzava,
	   G.Naziv AS Grad,
	   P.Naziv AS Proizvod,
	   SUM(NS.Kolicina) AS 'Ukupo komada prodano',
	   K.KategorijaID
FROM Proizvod AS P JOIN NarudzbaStavke AS NS
	ON P.ProizvodID=NS.ProizvodID JOIN PoslovnicaZaProizvodnju AS PSP
	ON PSP.PoslovnicaZaProizvodnjuID= P.PoslovnicaZaProizvodnjuID JOIN Poslovnica AS PO
	ON PO.PoslovnicaID=PSP.PoslovnicaZaProizvodnjuID JOIN Grad AS G
	ON PO.GradID=G.GradID JOIN Drzava AS D
	ON G.DrzavaID= D.DrzavaID JOIN Kategorija AS K
	ON K.KategorijaID=P.KategorijaID JOIN Narudzba AS N
	ON N.NarudzbaID=NS.NarudzbaID
GROUP BY P.JedMjere,D.Naziv,G.Naziv, P.Naziv, K.KategorijaID



SELECT NULL AS KategorijaID, 'Odaberite' AS Naziv
UNION
SELECT KategorijaID,Naziv
FROM Kategorija






