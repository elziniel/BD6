/*
1. Effectuer une recherche de disponibilite selon certains criteres
*/
PREPARE f1(VARCHAR, DATE, INT) AS
SELECT j_id, j_titre, j_sous_titre
FROM jeux
WHERE j_titre = $1
AND j_id NOT IN (
	SELECT j_id
	FROM reservations
	WHERE ($2 < r_date_debut AND $2 + $3 >= r_date_debut)
	OR ($2 > r_date_debut AND $2 < r_date_debut + r_duree_jours)
)
GROUP BY j_titre;


/*
2. Effectuer la reservation d'un creneau libre
*/
PREPARE f2(VARCHAR, INT, DATE, INT) AS
INSERT INTO reservations VALUES (
	(
		SELECT c_id
		FROM clients
		WHERE c_email = $1
	),
	$2,
	$3,
	$4,
	current_date,
	log($4 * 4) * 10
);


/*
3. Obtenir des reductions a partir d'un certain nombre
de reservations effectuees en moins d'un an
*/
PREPARE f3(VARCHAR, INT, DATE, INT) AS
INSERT INTO reservations (
	c_id,
	j_id,
	r_date_debut,
	r_duree_jours,
	r_date_resa,
	r_prix
) VALUES (
	(
		SELECT c_id
		FROM clients
		WHERE c_email = $1
	),
	$2,
	$3,
	$4,
	current_date,
	(
		SELECT log($4 * 4) *10 - (count(c_id) * 0.25)
		FROM reservations
		WHERE c_id IN (
			SELECT c_id
			FROM clients
			WHERE c_email = $1
		)
		AND r_date_resa >= current_date - 365
	)
);


/*
4. Annuler si la reservation est suffisamment eloignee dans le temps
*/
CREATE OR REPLACE FUNCTION f4(email VARCHAR, jid INT)
RETURNS void AS $$
BEGIN
	IF (
		SELECT r_date_resa
		FROM reservations
		WHERE c_id IN (
			SELECT c_id
			FROM clients
			WHERE c_email = email
		)
		AND j_id = jid
		ORDER BY r_date_resa DESC LIMIT 1
	) < current_date - 14 THEN
		DELETE
		FROM reservations
		WHERE c_id IN (
			SELECT c_id
			FROM clients
			WHERE c_email = email
		)
		AND j_id = jid
		AND r_date_resa = (
			SELECT max(r_date_resa)
			FROM reservations
			WHERE c_id IN(
				SELECT c_id
				FROM clients
				WHERE c_email = email
			)
			AND j_id = jid
		);
	END IF;
END;
$$ LANGUAGE plpgsql;


/*
5. Effectuer des statistiques sur l'occupation du lieu
*/
PREPARE f5(VARCHAR) AS
SELECT (sum(r_duree_jours)::float / (
	SELECT sum(r_duree_jours)
	FROM reservations
))::float4 AS taux
FROM reservations
NATURAL JOIN jeux
WHERE pl_id IN (
	SELECT pl_id
	FROM plateformes
	WHERE pl_nom = $1
);


/*
6. visualiser les recettes
*/
PREPARE f6(VARCHAR) AS
SELECT sum(r_prix) AS recettes
FROM reservations
NATURAL JOIN jeux
WHERE pl_id IN (
	SELECT pl_id
	FROM plateformes
	WHERE pl_nom = $1
)
GROUP BY pl_id;


/*
7. supprimer un utilisateur
*/
PREPARE f7(INT) AS
DELETE
FROM clients
WHERE c_id = $1;


/*
8. supprimer une reservation
*/
PREPARE f8(INT, DATE) AS
DELETE
FROM reservations
WHERE j_id = $1
AND r_date_debut = $2;