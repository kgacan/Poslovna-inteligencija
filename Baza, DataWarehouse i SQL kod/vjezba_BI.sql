USE prihodi



ALTER TABLE dbo.polisa_osiguranja 
ADD klasa_rate AS CAST 
(CASE
WHEN iznos_rate <=50 THEN 1
WHEN iznos_rate >50 AND iznos_rate <=70 THEN 2
ELSE 3
END AS INT) 

ALTER TABLE dbo.red_prihodi 
ADD klasa_red_prihodi AS CAST
(CASE 
WHEN neto <=1000 THEN 1
WHEN neto >1000 AND neto <=1500 THEN 2
ELSE 3
END AS INT
)

ALTER TABLE dbo.vanr_prihodi
ADD klase_iznos AS CAST
(CASE
WHEN iznos<400 THEN 1
WHEN iznos>=400 THEN 2
END AS INT
)

SELECT * FROM view_neki2

CREATE VIEW view_neki AS
SELECT O.osobaID, SUM(VP.iznos) AS 'vanr_prihodi_zbirno'
FROM dbo.osoba AS O JOIN dbo.vanr_prihodi AS VP 
	ON O.osobaID=VP.osobaID
GROUP BY O.osobaID

CREATE VIEW view_neki2 AS
SELECT RP.osobaID,
		RP.neto AS 'red_prihodi',
		vn.vanr_prihodi_zbirno,
		(RP.neto + vn.vanr_prihodi_zbirno) AS 'Ukupno'
FROM dbo.red_prihodi AS RP JOIN view_neki AS vn 
	ON RP.osobaID = vn.OsobaID