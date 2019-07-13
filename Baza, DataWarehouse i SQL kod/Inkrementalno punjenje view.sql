USE IGM

CREATE VIEW dodaj_izmijeni_view  AS
SELECT P.PoslovnicaID,P.Naziv AS 'Naziv poslovnice',G.Naziv AS 'Naziv grada',D.Naziv AS 'Naziv drzave'
FROM Poslovnica AS P JOIN Grad AS G
	ON P.GradID = G.GradID JOIN Drzava AS D
	ON G.DrzavaID = D.DrzavaID


select * from dodaj_izmijeni_view


UPDATE DimLokacija
SET Market = ?
WHERE LokacijaAltKey = ?



DELETE FROM DimLokacija
WHERE LokacijaKey=?