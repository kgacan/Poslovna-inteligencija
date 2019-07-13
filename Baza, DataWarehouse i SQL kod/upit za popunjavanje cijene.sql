

INSERT INTO NarudzbaStavke1([Kolicina],[Cijena],[Popust],[NarudzbaID],[ProizvodID])

SELECT 
	   NS.[Kolicina],
	   (P.Cijena*NS.Kolicina)-(P.Cijena*NS.Kolicina*PF.[Popust]) AS 'Cijena',
	   PF.Popust,
	   NS.[NarudzbaID],
	   NS.[ProizvodID]

FROM Proizvod AS P JOIN NarudzbaStavke AS NS
	ON P.ProizvodID=NS.ProizvodID JOIN [dbo].[Narudzba] AS N
	ON N.[NarudzbaID]=NS.[NarudzbaID] JOIN ProizvodF AS PF
	ON PF.ProizvodID=P.ProizvodID

ALTER TABLE [dbo].[NarudzbaStavke1] ADD ProizvodID INT NOT NULL CONSTRAINT FK_NarudzbaStavke_Proizvod2 FOREIGN KEY REFERENCES [dbo].[Proizvod]([ProizvodID])
ALTER TABLE [dbo].[NarudzbaStavke1] ADD NarudzbaID INT NOT NULL CONSTRAINT FK_NarudzbaStavke_Narudzba2 FOREIGN KEY REFERENCES [dbo].[Narudzba]([NarudzbaID])



SELECT NS.[NarudzbaID],
	   NS.[ProizvodID],
	   NS.[Kolicina],
	   P.Cijena*NS.Kolicina AS 'Cijena'
FROM Proizvod AS P JOIN NarudzbaStavke AS NS
	ON P.ProizvodID=NS.ProizvodID JOIN [dbo].[Narudzba] AS N
	ON N.[NarudzbaID]=NS.[NarudzbaID]


--WHERE NS.[NarudzbaID] IN (SELECT [NarudzbaID]
--		FROM [dbo].[NarudzbaStavke]
--		WHERE N.[NarudzbaID]=NS.[NarudzbaID]) 
		
--		AND 
		
--		NS.[ProizvodID] IN(SELECT [ProizvodID]
--		FROM [dbo].[NarudzbaStavke]
--		WHERE P.[ProizvodID]=NS.[ProizvodID])


INSERT INTO ProizvodF([ProizvodID],[Naziv],[Opis],[Sifra],[Cijena],[Popust],[JedMjere],[Tezina],[PoslovnicaZaProizvodnjuID],
		[KategorijaID],[PoslovnicaZaProdajuID])
SELECT P.ProizvodID,P.Naziv,P.Opis,P.Sifra,P.Cijena,P1.Popust,P.JedMjere,P.Tezina,P.[PoslovnicaZaProizvodnjuID],
		P.[KategorijaID],P.[PoslovnicaZaProdajuID]
FROM Proizvod AS P JOIN Proizvod1 AS P1
	ON P.ProizvodID = P1.ProizvodID

	
ALTER TABLE [dbo].[ProizvodF] ADD PoslovnicaZaProizvodnjuID INT NOT NULL FOREIGN KEY REFERENCES [dbo].[PoslovnicaZaProizvodnju]([PoslovnicaZaProizvodnjuID])
ALTER TABLE [dbo].[ProizvodF] ADD [KategorijaID] INT NOT NULL  FOREIGN KEY REFERENCES [dbo].[Kategorija]([KategorijaID])
ALTER TABLE [dbo].[ProizvodF] ADD PoslovnicaZaProdajuID INT NOT NULL  FOREIGN KEY REFERENCES [dbo].[PoslovnicaZaProdaju]([PoslovnicaZaProdajuID])


