DEALLOCATE PREPARE q1;
DEALLOCATE PREPARE q2;
DEALLOCATE PREPARE q3;
DEALLOCATE PREPARE q4;
DEALLOCATE PREPARE q5;
DEALLOCATE PREPARE q6;
DEALLOCATE PREPARE q7;
DEALLOCATE PREPARE q8;
DEALLOCATE PREPARE q9;
DEALLOCATE PREPARE q10;
DEALLOCATE PREPARE p1;
DEALLOCATE PREPARE p2;
DEALLOCATE PREPARE p3;
DEALLOCATE PREPARE p4;
DEALLOCATE PREPARE p5;
DEALLOCATE PREPARE p6;
DEALLOCATE PREPARE p7;
DEALLOCATE PREPARE p8;
DEALLOCATE PREPARE p9;
DEALLOCATE PREPARE p10;

/*
1. Taux de reservation d'une plateforme
Duree de reservation d'une plateforme divise par la
duree de reservation de toutes les plateformes
*/
PREPARE q1(VARCHAR, INT) AS
SELECT (sum(r_duree_jours)::float / (
	SELECT sum(r_duree_jours)
	FROM reservations
	WHERE extract(year FROM r_date_debut) = $2
	AND extract(year FROM (r_date_debut + r_duree_jours)) = $2
))::float4 AS Taux
FROM reservations
NATURAL JOIN jeux
WHERE pl_id IN (
	SELECT pl_id
	FROM plateformes
	WHERE pl_nom = $1
)
AND extract(year FROM r_date_debut) = $2
AND extract(year FROM (r_date_debut + r_duree_jours)) = $2;


/*
2. Recettes par type de jeu
Somme des prix des reservations classe par type de jeu
*/
PREPARE q2(INT, INT) AS
SELECT t_id AS Type, sum(r_prix) AS Recettes
FROM reservations
NATURAL JOIN jeux
WHERE extract(year FROM r_date_resa) = $1
AND extract(month FROM r_date_resa) = $2
GROUP BY t_id
ORDER BY recettes ASC;


/*
3. Liste des jeux sans reservation
*/
PREPARE q3(INT, INT, INT) AS
SELECT j_id, j_titre, j_sous_titre
FROM jeux
WHERE j_id NOT IN (
	SELECT j_id
	FROM reservations
	WHERE extract(year FROM r_date_resa) != $1
	AND extract(month FROM r_date_resa) != $2
)
ORDER BY j_id LIMIT $3;


/*
4. Journee la plus occupee de chaque semaine
*/
PREPARE q4(INT) AS
SELECT r_date_debut, resaduree
FROM (
	SELECT r_date_debut, sum(r_duree_jours) AS resaduree
	FROM reservations
	WHERE r_date_debut >= current_date - 7 * $1
	AND r_date_debut < current_date
	GROUP BY r_date_debut
) AS Test
INNER JOIN (
	SELECT EXTRACT(week FROM r_date_debut),max(resaduree) AS max
	FROM (
		SELECT r_date_debut, sum(r_duree_jours) AS resaduree
		FROM reservations
		WHERE r_date_debut >= current_date - 7 * $1
		AND r_date_debut < current_date
		GROUP BY r_date_debut
	) AS TAB
	GROUP BY EXTRACT(week FROM r_date_debut)
) AS Max
ON Max.max = Test.resaduree
AND Max.date_part = EXTRACT(week FROM r_date_debut);


/*
5. Moyenne du nombre de jours a l'avance des reservations
*/
PREPARE q5 AS
SELECT avg(r_date_debut - r_date_resa)::float4 AS moyenne
FROM reservations;


/*
6. Client ayant le plus depense sur le site
*/
PREPARE q6(INT) AS
SELECT extract(month FROM alpha) AS mois, bravo.client, max(bravo.prix) AS depense
FROM generate_series(
	concat($1::varchar, '-01-01')::date,
	concat($1::varchar, '-12-31')::date,
	'1 day'::interval
) AS alpha
LEFT JOIN (
	SELECT extract(month FROM r_date_resa) AS mois2, c_id AS client, sum(r_prix) AS prix
	FROM reservations
	WHERE extract(year FROM r_date_resa) = $1
	GROUP BY mois2, client
	ORDER BY sum(r_prix)
) AS bravo
ON mois2 = extract(month FROM alpha)
WHERE bravo.client IN (
	SELECT c_id
	FROM reservations
	WHERE extract(month FROM r_date_resa) = mois2
	AND extract(year FROM r_date_resa) = $1
	GROUP BY c_id
	ORDER BY sum(r_prix) DESC LIMIT 1
)
GROUP BY mois, bravo.client
ORDER BY mois;


/*
7. Pourcentage represente par les recettes generees par type de jeu
*/
PREPARE q7(INT) AS
SELECT t_id, Mess.trimestre, (Chiffre / CATri * 100)::float4 as Pourcentage
FROM (
	SELECT trimestre, sum(Chiffre) AS CATri
	FROM (
		WITH RECURSIVE t(trimestre) AS (
			VALUES(1)
			UNION ALL SELECT trimestre + 1
			FROM t
			WHERE trimestre < 4
		)
		SELECT id.t_id, trimestre, coalesce(chiffre, 0) AS Chiffre
		FROM t
		CROSS JOIN (
			SELECT t_id
			FROM types
		) AS id
		LEFT OUTER JOIN (
			SELECT t_id, EXTRACT(quarter FROM r_date_resa) AS tri, sum(r_prix) AS chiffre
			FROM jeux
			JOIN reservations
			ON reservations.j_id = jeux.j_id
			WHERE EXTRACT(year FROM r_date_resa) = $1
			GROUP BY t_id, tri
		) AS CA
		ON id.t_id = CA.t_id
		AND t.trimestre = CA.tri
	) AS Ugh
	GROUP BY trimestre
) AS Mess
LEFT OUTER JOIN (
	WITH RECURSIVE t(trimestre) AS (
		VALUES(1)
		UNION ALL SELECT trimestre + 1
		FROM t
		WHERE trimestre < 4
	)
	SELECT id.t_id, trimestre, coalesce(chiffre, 0) AS Chiffre
	FROM t
	CROSS JOIN (
		SELECT t_id
		FROM types
	) AS id
	LEFT OUTER JOIN (
		SELECT t_id, EXTRACT(quarter FROM r_date_resa) AS tri, sum(r_prix) AS chiffre
		FROM jeux
		JOIN reservations
		ON reservations.j_id = jeux.j_id
		WHERE EXTRACT(year FROM r_date_resa) = $1
		GROUP BY t_id, tri
	) AS CA
	ON id.t_id = CA.t_id
	AND t.trimestre = CA.tri
) AS Ohgod
ON Mess.trimestre = Ohgod.trimestre;


/*
8. Clients ayant reserve au moins une fois par semaine
*/
PREPARE q8(INT) AS
SELECT c_id
FROM (
	SELECT *
	FROM generate_series(
		(current_date - $1 * 30)::timestamp,
		(current_date + 7)::timestamp,
		'1 week'::interval
	) ww
	INNER JOIN (
		SELECT c_id, (extract(week FROM r_date_debut)) AS semaine
		FROM reservations
		WHERE r_date_debut >= current_date - $1 * 30
		AND r_date_debut <= current_date
		GROUP BY c_id, semaine
	) AS tab2
	ON extract(week FROM ww) = tab2.semaine
) AS TAB3
GROUP BY c_id
HAVING count(c_id) >= ((EXTRACT(week FROM current_date - $1 * 30)) - (EXTRACT(week FROM current_date)));


/*
9. Paires de prestations
Jeux ayant ete reserves les memes jours
*/
PREPARE q9 AS
SELECT tab1.j_id AS jeu1, tab2.j_id AS jeu2
FROM reservations AS tab1
JOIN reservations AS tab2
ON tab1.c_id = tab2.c_id
AND tab1.r_date_debut = tab2.r_date_debut
AND tab1.j_id < tab2.j_id;


/*
10. Clients venant les memes jours qu’un autre client
*/
PREPARE q10 AS
SELECT tab1.c_id AS Client1, tab2.c_id AS Client2, tab1.r_date_debut 
FROM reservations AS tab1
JOIN reservations AS tab2
ON tab1.r_date_debut = tab2.r_date_debut
AND tab1.c_id != tab2.c_id
AND tab1.c_id < tab2.c_id
WHERE (
	SELECT count(r_date_debut)
	FROM reservations
	WHERE c_id = tab1.c_id
) = (
	SELECT count(r_date_debut)
	FROM reservations
	WHERE c_id = tab2.c_id
) AND (
	SELECT count(r_date_debut)
	FROM (
		SELECT tab3.c_id AS Client1, tab4.c_id AS Client2, tab1.r_date_debut
		FROM reservations AS tab3
		JOIN reservations AS tab4
		ON tab3.r_date_debut = tab4.r_date_debut
		AND tab1.c_id != tab2.c_id
		AND tab1.c_id < tab2.c_id
	) AS tab5
	WHERE Client1 = tab1.c_id AND Client2 = tab2.c_id
) = (
	SELECT count(r_date_debut)
	FROM reservations
	WHERE c_id = tab2.c_id
);


/*
1. Noms des clients ayant debute la reservation
d'un jeu le jour de sa sortie (trois tables)
*/
PREPARE p1 AS
SELECT c_id, c_prenom, c_nom
FROM clients
NATURAL JOIN reservations
NATURAL JOIN jeux
WHERE r_date_debut = j_date_sortie
GROUP BY c_id;


/*
2. Nom des clients possedant au moins 2 machines (GROUP BY / HAVING)
*/
PREPARE p2(INT) AS
SELECT c_id, c_prenom, c_nom
FROM clients
NATURAL JOIN possede
GROUP BY c_id
HAVING count(m_id) >= $1;


/*
3. Nombre de plateformes hebergees par une
machine, classe par machine
*/
PREPARE p3 AS
SELECT m_os, count(pl_id)
FROM machines
NATURAL JOIN heberge
GROUP BY m_id
ORDER BY count(pl_id) DESC;


/*
4. Prix moyen des jeux par plateforme par rapport
a une plateforme (sous-requete dans le SELECT)
*/
PREPARE p4(VARCHAR) AS
SELECT pl_nom, avg(r_prix) - (
	SELECT avg(r_prix)
	FROM reservations
	NATURAL JOIN jeux
	WHERE pl_id IN (
		SELECT pl_id
		FROM plateformes
		WHERE pl_nom = $1
	)
) AS moyenne
FROM reservations
NATURAL JOIN plateformes
NATURAL JOIN jeux
GROUP BY pl_nom;


/*
5. Clients ayant reserve leur jeux sur la
meme plateforme (sous-requete WHERE)
*/
PREPARE p5(INT) AS
SELECT tab1.c_id AS client1, tab2.c_id AS Client2
FROM reservations AS tab1
JOIN reservations AS tab2
ON tab1.c_id < tab2.c_id
WHERE (
	SELECT pl_id
	FROM jeux
	WHERE j_id = tab1.j_id
) = (
	SELECT pl_id
	FROM jeux
	WHERE j_id = tab2.j_id
)
GROUP BY tab1.c_id, tab2.c_id
ORDER BY tab1.c_id LIMIT $1;


/*
6. Nom du jeu ayant la meilleure note pour une
certaine plateforme (sous-requete correlee)
*/
PREPARE p6(VARCHAR) AS
SELECT j_titre, j_note
FROM jeux
WHERE pl_id
IN (
	SELECT pl_id
	FROM plateformes
	WHERE pl_nom = $1
)
ORDER BY j_note DESC LIMIT 1;


/*
7. Moyenne des notes des jeux pour chaque plateforme (RIGHT JOIN)
*/
PREPARE p7 AS
SELECT pl_nom, avg(j_note)::float4
FROM plateformes AS tab1
RIGHT JOIN jeux AS tab2
ON tab1.pl_id = tab2.pl_id
GROUP BY pl_nom;


/*
8. Prix total des reservations pour une machine
chaque mois d'une annee (sous-requete FROM)
*/
PREPARE p8(VARCHAR, INT) AS
SELECT extract(month FROM mike) AS mois, papa.somme AS prix
FROM generate_series(
	concat($2::varchar, '-01-01')::date,
	concat($2::varchar, '-12-31')::date,
	'1 day'::interval
) AS mike
LEFT JOIN (
	SELECT extract(month FROM r_date_resa) AS mois2, sum(r_prix) AS somme
	FROM reservations
	WHERE extract(year FROM r_date_resa) = $2
	AND j_id IN (
		SELECT j_id
		FROM jeux
		WHERE pl_id IN (
			SELECT pl_id
			FROM plateformes
			WHERE pl_id IN (
				SELECT pl_id
				FROM heberge
				WHERE m_id IN (
					SELECT m_id
					FROM machines
					WHERE m_os = $1
				)
			)
		)
	)
	GROUP BY mois2
) AS papa
ON mois2 = extract(month FROM mike)
GROUP BY mois, prix
ORDER BY mois;


/*
9. Nombre de reservations par plateforme par client
*/
PREPARE p9(INT) AS
SELECT c_id AS client, pl_id AS plateforme, count(*) AS nombre
FROM reservations
NATURAL JOIN jeux
GROUP BY c_id, pl_id
ORDER BY c_id DESC LIMIT $1;


/*
10. Liste des clients ayant reserve un jeu a X joueur(s)
*/
PREPARE p10(INT) AS
SELECT c_prenom AS client
FROM clients
WHERE c_id IN (
	SELECT c_id
	FROM reservations
	WHERE j_id IN (
		SELECT j_id
		FROM jeux
		WHERE j_nbr_joueur = $1
	)
)
GROUP BY c_prenom;