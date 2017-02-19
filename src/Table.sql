DROP TABLE heberge;
DROP TABLE possede;
DROP TABLE reservations;
DROP TABLE jeux;
DROP TABLE clients;
DROP TABLE types;
DROP TABLE productions;
DROP TABLE plateformes;
DROP TABLE machines;

CREATE TABLE clients(
	c_id INT NOT NULL,
	c_nom VARCHAR(32),
	c_prenom VARCHAR(32),
	c_pseudo VARCHAR(32),
	c_email VARCHAR(64) UNIQUE,
	CHECK(c_email LIKE '%@%'),
	PRIMARY KEY(c_id)
);

CREATE TABLE types(
	t_id INT NOT NULL,
	t_genre VARCHAR(32),
	PRIMARY KEY(t_id)
);

CREATE TABLE productions(
	pr_id INT NOT NULL,
	pr_developpeur VARCHAR(32),
	pr_editeur VARCHAR(32),
	PRIMARY KEY(pr_id)
);

CREATE TABLE plateformes(
	pl_id INT NOT NULL,
	pl_nom VARCHAR(32),
	pl_popularite INT,
	PRIMARY KEY(pl_id)
);

CREATE TABLE jeux(
	j_id INT NOT NULL,
	t_id INT NOT NULL,
	pr_id INT NOT NULL,
	pl_id INT NOT NULL,
	j_titre VARCHAR(64),
	j_sous_titre VARCHAR(64),
	j_date_sortie DATE,
	j_nbr_joueur INT,
	j_note INT,
	PRIMARY KEY(j_id),
	FOREIGN KEY(t_id) REFERENCES types(t_id),
	FOREIGN KEY(pr_id) REFERENCES productions(pr_id),
	FOREIGN KEY(pl_id) REFERENCES plateformes(pl_id)
);

CREATE TABLE machines(
	m_id INT NOT NULL,
	m_os VARCHAR(32),
	m_version VARCHAR(32),
	PRIMARY KEY(m_id)
);

CREATE TABLE heberge(
	pl_id INT NOT NULL,
	m_id INT NOT NULL,
	PRIMARY KEY(pl_id, m_id),
	FOREIGN KEY(pl_id) REFERENCES plateformes(pl_id),
	FOREIGN KEY(m_id) REFERENCES machines(m_id)
);

CREATE TABLE possede(
	c_id INT NOT NULL,
	m_id INT NOT NULL,
	PRIMARY KEY(c_id, m_id),
	FOREIGN KEY(c_id) REFERENCES clients(c_id),
	FOREIGN KEY(m_id) REFERENCES machines(m_id)
);

CREATE TABLE reservations(
	c_id INT NOT NULL,
	j_id INT NOT NULL,
	r_date_debut DATE NOT NULL,
	r_duree_jours INT,
	r_date_resa DATE,
	r_prix float,
	PRIMARY KEY(j_id, r_date_debut),
	FOREIGN KEY(c_id) REFERENCES clients(c_id),
	FOREIGN KEY(j_id) REFERENCES jeux(j_id)
);

INSERT INTO clients VALUES(1, 'Downey', 'Jordan', 'Jordown', 'jordown@email.fr');
INSERT INTO clients VALUES(2, 'Escandell', 'Esteban', 'Elziniel', 'elziniel@email.fr');
INSERT INTO clients VALUES(3, 'Annecy', 'Alphonse', 'Alistar', 'aa@email.fr');
INSERT INTO clients VALUES(4, 'Bordeaux', 'Bernard', 'Braum', 'bb@email.fr');
INSERT INTO clients VALUES(5, 'Cergy', 'Camille', 'Caitlyn', 'cc@email.fr');
INSERT INTO clients VALUES(6, 'Dijon', 'Daniel', 'Darius', 'dd@email.fr');
INSERT INTO clients VALUES(7, 'Evry', 'Ellie', 'Evelynn', 'ee@email.fr');
INSERT INTO clients VALUES(8, 'Ferdinand', 'Franz', 'Fizz', 'ff@email.fr');
INSERT INTO clients VALUES(9, 'Grenoble', 'Gerard', 'Garen', 'gg@email.fr');
INSERT INTO clients VALUES(10, 'Hyeres', 'Hubert', 'Hecarim', 'hh@email.fr');
INSERT INTO clients VALUES(11, 'Ivry', 'Irene', 'Irelia', 'ii@email.fr');
INSERT INTO clients VALUES(12, 'Jullouville', 'Jacques', 'Jax', 'jj@email.fr');
INSERT INTO clients VALUES(13, 'Kervignac', 'Katy', 'Katarina', 'kk@email.fr');
INSERT INTO clients VALUES(14, 'Lyon', 'Leah', 'Leona', 'll@email.fr');
INSERT INTO clients VALUES(15, 'Marseille', 'Maurice', 'Malphite', 'mm@email.fr');
INSERT INTO clients VALUES(16, 'Nice', 'Natalie', 'Nidalee', 'nn@email.fr');
INSERT INTO clients VALUES(17, 'Orleans', 'Ophelie', 'Orianna', 'oo@email.fr');
INSERT INTO clients VALUES(18, 'Paris', 'Pauline', 'Poppy', 'pp@email.fr');
INSERT INTO clients VALUES(19, 'Quimper', 'Quentin', 'Quinn', 'qq@email.fr');
INSERT INTO clients VALUES(20, 'Rennes', 'Rosalina', 'Riven', 'rr@email.fr');
INSERT INTO clients VALUES(21, 'Strasbourg', 'Solene', 'Sona', 'ss@email.fr');
INSERT INTO clients VALUES(22, 'Toulon', 'Tierry', 'Teemo', 'tt@email.fr');
INSERT INTO clients VALUES(23, 'Utelle', 'Ursanne', 'Urgot', 'uu@email.fr');
INSERT INTO clients VALUES(24, 'Venissieux', 'Valerie', 'Vayne', 'vv@email.fr');
INSERT INTO clients VALUES(25, 'Wallers', 'William', 'Wukong', 'ww@email.fr');
INSERT INTO clients VALUES(26, 'Xures', 'Xavier', 'Xerath', 'xx@email.fr');
INSERT INTO clients VALUES(27, 'Yenne', 'Yves', 'Yasuo', 'yy@email.fr');
INSERT INTO clients VALUES(28, 'Zuani', 'Zoe', 'Ziggs', 'zz@email.fr');

INSERT INTO types VALUES(1, 'Action');
INSERT INTO types VALUES(2, 'Aventure');
INSERT INTO types VALUES(3, 'MMO');
INSERT INTO types VALUES(4, 'FPS');
INSERT INTO types VALUES(5, 'Plateforme');
INSERT INTO types VALUES(6, 'Puzzle');
INSERT INTO types VALUES(7, 'Course');
INSERT INTO types VALUES(8, 'Sport');
INSERT INTO types VALUES(9, 'STG');
INSERT INTO types VALUES(10, 'MOBA');
INSERT INTO types VALUES(11, 'Simulation');
INSERT INTO types VALUES(12, 'Cartes');
INSERT INTO types VALUES(13, 'Horreur');
INSERT INTO types VALUES(14, 'Combat');

INSERT INTO productions VALUES(1, 'Blizzard', 'Blizzard');
INSERT INTO productions VALUES(2, 'Edmund McMillen, Florian Himsl', 'Edmund McMillen');
INSERT INTO productions VALUES(3, 'Team Meat', 'Headup Games');
INSERT INTO productions VALUES(4, 'Arkane Studios', 'Bethesda Softwork');
INSERT INTO productions VALUES(5, 'Valve', 'Valve');
INSERT INTO productions VALUES(6, 'Ubisoft Montreal', 'Ubisoft');
INSERT INTO productions VALUES(7, 'Blue Mammoth Games', 'Xaviant Games');
INSERT INTO productions VALUES(8, 'DoubleDutch Games', 'tinyBuild');
INSERT INTO productions VALUES(9, 'Berserk Games', 'Berserk Games');
INSERT INTO productions VALUES(10, 'Riot Games', 'Riot Games');
INSERT INTO productions VALUES(11, 'Reloaded Production', 'Reloaded Games');
INSERT INTO productions VALUES(12, 'Cryptic Studios', 'Perfect World Entertainment');
INSERT INTO productions VALUES(13, 'Runic Games', 'Perfect World Entertainment');
INSERT INTO productions VALUES(14, 'Rockstar North', 'Rockstar Games');
INSERT INTO productions VALUES(15, 'Nintendo EAD', 'Nintendo');
INSERT INTO productions VALUES(16, 'Bandai Namco Games', 'Nintendo');
INSERT INTO productions VALUES(17, 'Game Freak', 'The Pokemon Company');
INSERT INTO productions VALUES(18, 'SCS Software', 'SCS Software');
INSERT INTO productions VALUES(19, 'Squad', 'Squad');
INSERT INTO productions VALUES(20, 'Giants Software', 'Focus Home Interactive');
INSERT INTO productions VALUES(21, 'Coffee Stain Studios', 'Coffee Stain Studios');

INSERT INTO plateformes VALUES(1, 'Battle.net', 18);
INSERT INTO plateformes VALUES(2, 'Steam', 19);
INSERT INTO plateformes VALUES(3, 'Arc', 16);
INSERT INTO plateformes VALUES(4, 'Origin', 17);
INSERT INTO plateformes VALUES(5, 'Mojang', 17);
INSERT INTO plateformes VALUES(6, 'Uplay', 16);
INSERT INTO plateformes VALUES(7, 'PSNetwork', 18);
INSERT INTO plateformes VALUES(8, 'Xbox Live Marketplace', 18);
INSERT INTO plateformes VALUES(9, 'Nintendo eShop', 17);

INSERT INTO jeux VALUES(1, 2, 1, 1, 'Diablo III', NULL, '2012-05-15', 4, 17);
INSERT INTO jeux VALUES(2, 2, 1, 1, 'Diablo III', 'Reaper of Souls', '2014-03-25', 4, 17);
INSERT INTO jeux VALUES(3, 10, 1, 1, 'Heroes of the Storm', NULL, '2012-03-15', 0, 17);
INSERT INTO jeux VALUES(4, 12, 1, 1, 'Heartstone', 'Heroes of Warcraft', '2015-06-02', 2, 16);
INSERT INTO jeux VALUES(5, 3, 1, 1, 'World of Warcraft', NULL, '2004-11-22', 0, 18);
INSERT INTO jeux VALUES(6, 9, 1, 1, 'Starcraft 2', NULL, '2010-07-27', 2, 18);
INSERT INTO jeux VALUES(7, 9, 1, 1, 'Starcraft 2', 'Heart of the Swarm', '2013-03-12', 2, 18);
INSERT INTO jeux VALUES(8, 1, 2, 2, 'The Binding of Isaac', NULL, '2011-09-28', 1, 17);
INSERT INTO jeux VALUES(9, 5, 3, 2, 'Super Meat Boy', NULL, '2010-11-30', 1, 18);
INSERT INTO jeux VALUES(10, 1, 4, 2, 'Dishonored', NULL, '2012-10-08', 1, 18);
INSERT INTO jeux VALUES(11, 4, 5, 2, 'Half-Life 2', NULL, '2004-11-16', 1, 19);
INSERT INTO jeux VALUES(12, 4, 5, 2, 'Half-Life 2', 'Episode One', '2006-06-01', 1, 17);
INSERT INTO jeux VALUES(13, 4, 5, 2, 'Half-Life 2', 'Episode Two', '2007-10-10', 1, 18);
INSERT INTO jeux VALUES(14, 4, 5, 2, 'Half-Life 2', 'Lost Coast', '2005-10-17', 1, 18);
INSERT INTO jeux VALUES(15, 4, 5, 2, 'Half-Life 2', 'Deathmatch', '2004-11-01', 0, 17);
INSERT INTO jeux VALUES(16, 4, 5, 2, 'Counter-Strike', '1.6', '2000-11-01', 0, 18);
INSERT INTO jeux VALUES(17, 4, 5, 2, 'Counter-Strike', 'Source', '2004-11-01', 0, 18);
INSERT INTO jeux VALUES(18, 4, 5, 2, 'Counter-Strike', 'Global Offensive', '2012-08-12', 0, 17);
INSERT INTO jeux VALUES(19, 4, 5, 2, 'Team Fortress 2', NULL, '2007-10-10', 0, 19);
INSERT INTO jeux VALUES(20, 6, 5, 2, 'Portal', NULL, '2007-10-10', 1, 18);
INSERT INTO jeux VALUES(21, 6, 5, 2, 'Portal 2', NULL, '2011-04-18', 2, 19);
INSERT INTO jeux VALUES(22, 6, 5, 7, 'Portal 2', NULL, '2011-04-18', 2, 19);
INSERT INTO jeux VALUES(23, 6, 5, 8, 'Portal 2', NULL, '2011-04-18', 2, 19);
INSERT INTO jeux VALUES(24, 13, 5, 2, 'Left 4 Dead', NULL, '2008-11-17', 4, 18);
INSERT INTO jeux VALUES(25, 13, 5, 2, 'Left 4 Dead 2', NULL, '2009-11-16', 4, 18);
INSERT INTO jeux VALUES(26, 2, 6, 2, 'Assassins Creed', NULL, '2007-11-15', 1, 18);
INSERT INTO jeux VALUES(27, 2, 6, 6, 'Assassins Creed', NULL, '2007-11-15', 1, 18);
INSERT INTO jeux VALUES(28, 2, 6, 2, 'Assassins Creed II', NULL, '2009-11-19', 1, 18);
INSERT INTO jeux VALUES(29, 2, 6, 6, 'Assassins Creed II', NULL, '2009-11-19', 1, 18);
INSERT INTO jeux VALUES(30, 2, 6, 6, 'Assassins Creed', 'Revelation', '2011-11-15', 1, 17);
INSERT INTO jeux VALUES(31, 2, 6, 6, 'Assassins Creed', 'Brotherhood', '2010-11-17', 1, 15);
INSERT INTO jeux VALUES(32, 2, 6, 2, 'Assassins Creed III', NULL, '2012-10-31', 1, 18);
INSERT INTO jeux VALUES(33, 2, 6, 6, 'Assassins Creed III', NULL, '2012-10-31', 1, 18);
INSERT INTO jeux VALUES(34, 2, 6, 2, 'Assassins Creed IV', 'Black Flag', '2013-10-29', 1, 16);
INSERT INTO jeux VALUES(35, 2, 6, 6, 'Assassins Creed IV', 'Black Flag', '2013-10-29', 1, 16);
INSERT INTO jeux VALUES(36, 2, 6, 6, 'Assassins Creed', 'Rogue', '2014-11-13', 2, 14);
INSERT INTO jeux VALUES(37, 2, 6, 6, 'Assassins Creed', 'Unity', '2014-11-13', 2, 17);
INSERT INTO jeux VALUES(38, 14, 7, 2, 'Brawlhalla', NULL, '2014-04-30', 4, 16);
INSERT INTO jeux VALUES(39, 7, 8, 2, 'Speedrunners', NULL, '2013-08-26', 4, 17);
INSERT INTO jeux VALUES(40, 11, 9, 2, 'Tabletop Simulator', NULL, '2014-04-18', 6, 17);
INSERT INTO jeux VALUES(41, 10, 5, 2, 'Dota 2', NULL, '2013-07-09', 0, 18);
INSERT INTO jeux VALUES(42, 4, 11, 2, 'APB Reloaded', NULL, '2011-12-06', 0, 13);
INSERT INTO jeux VALUES(43, 4, 11, 3, 'APB Reloaded', NULL, '2011-12-06', 0, 13);
INSERT INTO jeux VALUES(44, 3, 12, 2, 'Neverwinter', NULL, '2013-06-20', 0, 15);
INSERT INTO jeux VALUES(45, 3, 12, 3, 'Neverwinter', NULL, '2013-06-20', 0, 15);
INSERT INTO jeux VALUES(46, 2, 13, 2, 'Torchlight', NULL, '2009-10-27', 1, 16);
INSERT INTO jeux VALUES(47, 2, 13, 3, 'Torchlight', NULL, '2009-10-27', 1, 16);
INSERT INTO jeux VALUES(48, 2, 13, 2, 'Torchlight II', NULL, '2012-09-20', 0, 16);
INSERT INTO jeux VALUES(49, 2, 13, 3, 'Torchlight II', NULL, '2012-09-20', 0, 16);
INSERT INTO jeux VALUES(50, 1, 14, 7, 'GTA IV', NULL, '2008-04-29', 1, 19);
INSERT INTO jeux VALUES(51, 1, 14, 8, 'GTA IV', NULL, '2008-04-29', 1, 19);
INSERT INTO jeux VALUES(52, 1, 14, 2, 'GTA IV', NULL, '2008-12-03', 1, 19);
INSERT INTO jeux VALUES(53, 1, 14, 7, 'GTA V', NULL, '2013-09-17', 1, 19);
INSERT INTO jeux VALUES(54, 1, 14, 8, 'GTA V', NULL, '2013-09-17', 1, 19);
INSERT INTO jeux VALUES(55, 1, 14, 2, 'GTA V', NULL, '2015-04-14', 1, 19);
INSERT INTO jeux VALUES(56, 11, 15, 9, 'Animal Crossing', 'New Leaf', '2013-06-14', 4, 18);
INSERT INTO jeux VALUES(57, 14, 16, 9, 'Super Smash Bros', 'for Nintendo 3DS', '2014-09-13', 4, 17);
INSERT INTO jeux VALUES(58, 14, 16, 9, 'Super Smash Bros', 'for Wii U', '2014-11-28', 8, 18);
INSERT INTO jeux VALUES(59, 2, 17, 9, 'Pokemon', 'X', '2013-10-12', 1, 18);
INSERT INTO jeux VALUES(60, 2, 17, 9, 'Pokemon', 'Y', '2013-10-12', 1, 18);
INSERT INTO jeux VALUES(61, 7, 15, 9, 'Mario Kart 7', NULL, '2011-12-2', 8, 19);
INSERT INTO jeux VALUES(62, 11, 18, 2, 'Euro Truck Simulator 2', NULL, '2012-11-19', 1, 16);
INSERT INTO jeux VALUES(63, 11, 19, 2, 'Kerbal Space Program', NULL, '2015-04-27', 1, 18);
INSERT INTO jeux VALUES(64, 11, 20, 2, 'Farming Simulator', NULL, '2012-10-25', 1, 13);
INSERT INTO jeux VALUES(65, 11, 21, 2, 'Goat Simulator', NULL, '2014-04-01', 1, 13);

INSERT INTO machines VALUES(1, 'Windows', '8.1');
INSERT INTO machines VALUES(2, 'Ubuntu', '14.10');
INSERT INTO machines VALUES(3, 'Mac OS X', '10.10.3');
INSERT INTO machines VALUES(4, 'Playstation', '3');
INSERT INTO machines VALUES(5, 'Playstation', '4');
INSERT INTO machines VALUES(6, 'Xbox', '360');
INSERT INTO machines VALUES(7, 'Xbox', 'One');
INSERT INTO machines VALUES(8, 'Nintendo', '3DS');
INSERT INTO machines VALUES(9, 'Nintendo', 'Wii U');

INSERT INTO heberge VALUES(1, 1);
INSERT INTO heberge VALUES(1, 3);
INSERT INTO heberge VALUES(2, 1);
INSERT INTO heberge VALUES(2, 2);
INSERT INTO heberge VALUES(2, 3);
INSERT INTO heberge VALUES(3, 1);
INSERT INTO heberge VALUES(4, 1);
INSERT INTO heberge VALUES(4, 3);
INSERT INTO heberge VALUES(5, 1);
INSERT INTO heberge VALUES(5, 2);
INSERT INTO heberge VALUES(5, 3);
INSERT INTO heberge VALUES(6, 1);
INSERT INTO heberge VALUES(7, 4);
INSERT INTO heberge VALUES(7, 5);
INSERT INTO heberge VALUES(8, 6);
INSERT INTO heberge VALUES(8, 7);
INSERT INTO heberge VALUES(9, 8);
INSERT INTO heberge VALUES(9, 9);

INSERT INTO possede VALUES(1, 3);
INSERT INTO possede VALUES(1, 8);
INSERT INTO possede VALUES(2, 1);
INSERT INTO possede VALUES(2, 2);
INSERT INTO possede VALUES(2, 4);
INSERT INTO possede VALUES(2, 8);
INSERT INTO possede VALUES(3, 4);
INSERT INTO possede VALUES(3, 1);
INSERT INTO possede VALUES(3, 6);
INSERT INTO possede VALUES(4, 2);
INSERT INTO possede VALUES(4, 5);
INSERT INTO possede VALUES(4, 1);
INSERT INTO possede VALUES(4, 9);
INSERT INTO possede VALUES(5, 2);
INSERT INTO possede VALUES(5, 6);
INSERT INTO possede VALUES(5, 8);
INSERT INTO possede VALUES(5, 4);
INSERT INTO possede VALUES(5, 9);
INSERT INTO possede VALUES(5, 1);
INSERT INTO possede VALUES(5, 3);
INSERT INTO possede VALUES(6, 7);
INSERT INTO possede VALUES(6, 8);
INSERT INTO possede VALUES(6, 6);
INSERT INTO possede VALUES(7, 4);
INSERT INTO possede VALUES(7, 2);
INSERT INTO possede VALUES(7, 6);
INSERT INTO possede VALUES(7, 3);
INSERT INTO possede VALUES(7, 8);
INSERT INTO possede VALUES(8, 1);
INSERT INTO possede VALUES(8, 5);
INSERT INTO possede VALUES(8, 8);
INSERT INTO possede VALUES(8, 6);
INSERT INTO possede VALUES(9, 6);
INSERT INTO possede VALUES(9, 7);
INSERT INTO possede VALUES(9, 2);
INSERT INTO possede VALUES(9, 1);
INSERT INTO possede VALUES(9, 9);
INSERT INTO possede VALUES(9, 4);
INSERT INTO possede VALUES(10, 4);
INSERT INTO possede VALUES(10, 3);
INSERT INTO possede VALUES(10, 6);
INSERT INTO possede VALUES(10, 7);
INSERT INTO possede VALUES(10, 9);
INSERT INTO possede VALUES(11, 9);
INSERT INTO possede VALUES(11, 1);
INSERT INTO possede VALUES(11, 5);
INSERT INTO possede VALUES(11, 4);
INSERT INTO possede VALUES(11, 6);
INSERT INTO possede VALUES(12, 6);
INSERT INTO possede VALUES(12, 7);
INSERT INTO possede VALUES(12, 9);
INSERT INTO possede VALUES(12, 4);
INSERT INTO possede VALUES(13, 9);
INSERT INTO possede VALUES(13, 1);
INSERT INTO possede VALUES(14, 4);
INSERT INTO possede VALUES(14, 8);
INSERT INTO possede VALUES(14, 5);
INSERT INTO possede VALUES(14, 2);
INSERT INTO possede VALUES(14, 3);
INSERT INTO possede VALUES(16, 9);
INSERT INTO possede VALUES(16, 6);
INSERT INTO possede VALUES(16, 7);
INSERT INTO possede VALUES(16, 1);
INSERT INTO possede VALUES(16, 2);
INSERT INTO possede VALUES(17, 2);
INSERT INTO possede VALUES(17, 1);
INSERT INTO possede VALUES(17, 6);
INSERT INTO possede VALUES(17, 7);
INSERT INTO possede VALUES(17, 3);
INSERT INTO possede VALUES(17, 4);
INSERT INTO possede VALUES(18, 9);
INSERT INTO possede VALUES(18, 3);
INSERT INTO possede VALUES(18, 1);
INSERT INTO possede VALUES(18, 2);
INSERT INTO possede VALUES(19, 5);
INSERT INTO possede VALUES(20, 1);
INSERT INTO possede VALUES(21, 9);
INSERT INTO possede VALUES(21, 5);
INSERT INTO possede VALUES(21, 4);
INSERT INTO possede VALUES(23, 2);
INSERT INTO possede VALUES(23, 9);
INSERT INTO possede VALUES(23, 4);
INSERT INTO possede VALUES(23, 6);
INSERT INTO possede VALUES(23, 8);
INSERT INTO possede VALUES(23, 5);
INSERT INTO possede VALUES(24, 5);
INSERT INTO possede VALUES(24, 3);
INSERT INTO possede VALUES(24, 9);
INSERT INTO possede VALUES(27, 8);
INSERT INTO possede VALUES(27, 7);
INSERT INTO possede VALUES(27, 3);
INSERT INTO possede VALUES(27, 1);
INSERT INTO possede VALUES(27, 2);
INSERT INTO possede VALUES(28, 7);
INSERT INTO possede VALUES(28, 3);
INSERT INTO possede VALUES(28, 4);
INSERT INTO possede VALUES(28, 2);
INSERT INTO possede VALUES(28, 8);
INSERT INTO possede VALUES(28, 1);
INSERT INTO possede VALUES(28, 6);

INSERT INTO reservations VALUES(8, 22, '2015-01-05', 7, '2015-01-01', 14.5);
INSERT INTO reservations VALUES(26, 24, '2014-01-14', 35, '2014-01-03', 21.5);
INSERT INTO reservations VALUES(12, 52, '2014-01-28', 35, '2014-01-22', 21.5);
INSERT INTO reservations VALUES(17, 40, '2014-11-12', 1, '2014-11-02', 6.0);
INSERT INTO reservations VALUES(8, 65, '2014-04-01', 23, '2014-03-25', 19.6);
INSERT INTO reservations VALUES(13, 23, '2014-02-10', 18, '2014-02-01', 18.6);
INSERT INTO reservations VALUES(14, 22, '2014-02-10', 31, '2014-02-01', 20.9);
INSERT INTO reservations VALUES(17, 11, '2014-03-12', 24, '2014-03-10', 19.8);
INSERT INTO reservations VALUES(17, 12, '2014-03-12', 24, '2014-03-10', 19.8);
INSERT INTO reservations VALUES(14, 56, '2014-08-08', 47, '2014-08-02', 22.7);
INSERT INTO reservations VALUES(19, 35, '2015-03-05', 15, '2015-03-05', 17.8);
INSERT INTO reservations VALUES(7, 40, '2014-05-21', 5, '2014-05-18', 13.0);
INSERT INTO reservations VALUES(4, 64, '2014-05-14', 28, '2014-05-04', 20.5);
INSERT INTO reservations VALUES(11, 43, '2014-04-10', 21, '2014-04-01', 19.2);
INSERT INTO reservations VALUES(2, 10, '2012-10-08', 27, '2012-10-01', 20.3);
INSERT INTO reservations VALUES(6, 65, '2015-04-25', 50, '2015-04-20', 23.0);
INSERT INTO reservations VALUES(3, 25, '2014-07-28', 51, '2014-07-20', 23.1);
INSERT INTO reservations VALUES(12, 5, '2014-11-20', 32, '2014-11-03', 21.1);
INSERT INTO reservations VALUES(11, 6, '2014-10-30', 13, '2014-10-17', 17.2);
INSERT INTO reservations VALUES(11, 7, '2014-10-30', 13, '2014-10-17', 17.2);
INSERT INTO reservations VALUES(2, 17, '2004-11-01', 51, '2004-11-01', 23.1);
INSERT INTO reservations VALUES(24, 46, '2015-04-20', 54, '2015-04-03', 23.3);
INSERT INTO reservations VALUES(12, 17, '2014-09-03', 38, '2014-09-01', 21.8);
INSERT INTO reservations VALUES(10, 47, '2014-09-03', 28, '2014-09-01', 20.5);
INSERT INTO reservations VALUES(23, 15, '2013-02-01', 16, '2013-01-29', 18.1);
INSERT INTO reservations VALUES(24, 50, '2008-04-29', 4, '2008-04-28', 12.0);
INSERT INTO reservations VALUES(3, 22, '2015-04-30', 12, '2015-04-29', 16.8);
INSERT INTO reservations VALUES(12, 17, '2014-06-03', 7, '2014-06-03', 14.5);
INSERT INTO reservations VALUES(1, 27, '2014-01-21', 30, '2014-01-02', 20.8);
INSERT INTO reservations VALUES(3, 27, '2014-03-14', 43, '2014-03-02', 22.4);
INSERT INTO reservations VALUES(19, 7, '2013-03-12', 48, '2013-03-12', 22.8);
INSERT INTO reservations VALUES(24, 65, '2015-04-01', 31, '2015-04-01', 20.9);
INSERT INTO reservations VALUES(5, 39, '2014-08-14', 50, '2014-08-02', 23.0);
INSERT INTO reservations VALUES(12, 58, '2014-12-25', 20, '2014-12-12', 19.0);
INSERT INTO reservations VALUES(13, 27, '2014-08-08', 16, '2014-08-02', 18.1);
INSERT INTO reservations VALUES(22, 1, '2014-03-25', 4, '2014-03-25', 12.0);
INSERT INTO reservations VALUES(22, 2, '2014-03-25', 4, '2014-03-25', 12.0);
INSERT INTO reservations VALUES(19, 4, '2015-06-02', 20, '2015-04-30', 19.0);
INSERT INTO reservations VALUES(13, 29, '2014-10-15', 8, '2014-10-09', 15.1);
INSERT INTO reservations VALUES(17, 5, '2014-12-12', 39, '2014-12-06', 21.9);
INSERT INTO reservations VALUES(11, 51, '2014-12-25', 2, '2014-12-24', 9.0);
INSERT INTO reservations VALUES(27, 34, '2013-10-29', 7, '2013-10-29', 14.5);
INSERT INTO reservations VALUES(10, 18, '2015-03-26', 34, '2015-03-20', 21.3);
INSERT INTO reservations VALUES(4, 33, '2014-11-27', 35, '2014-11-13', 21.5);
INSERT INTO reservations VALUES(4, 64, '2014-01-08', 43, '2014-01-06', 22.4);
INSERT INTO reservations VALUES(22, 59, '2013-12-25', 45, '2013-12-20', 22.6);
INSERT INTO reservations VALUES(4, 23, '2011-04-18', 30, '2011-04-01', 20.8);
INSERT INTO reservations VALUES(8, 5, '2015-02-28', 25, '2015-02-25', 20);
INSERT INTO reservations VALUES(14, 14, '2014-10-15', 4, '2014-10-09', 12.0);
INSERT INTO reservations VALUES(2, 49, '2014-04-04', 54, '2014-04-04', 23.3);
INSERT INTO reservations VALUES(3, 6, '2014-05-16', 17, '2014-05-10', 18.3);
INSERT INTO reservations VALUES(12, 29, '2009-11-19', 27, '2009-11-10', 20.3);
INSERT INTO reservations VALUES(12, 60, '2015-01-12', 51, '2015-01-10', 23.1);
INSERT INTO reservations VALUES(26, 25, '2014-10-09', 53, '2014-10-04', 23.3);
INSERT INTO reservations VALUES(8, 16, '2014-10-25', 24, '2014-10-22', 19.8);
INSERT INTO reservations VALUES(8, 12, '2014-11-01', 24, '2014-10-29', 19.8);
INSERT INTO reservations VALUES(8, 3, '2014-11-08', 39, '2014-11-05', 21.9);
INSERT INTO reservations VALUES(8, 47, '2014-11-15', 41, '2014-11-12', 22.1);
INSERT INTO reservations VALUES(8, 35, '2014-11-22', 41, '2014-11-19', 22.1);
INSERT INTO reservations VALUES(8, 20, '2014-11-29', 54, '2014-11-26', 23.3);
INSERT INTO reservations VALUES(8, 45, '2014-12-06', 23, '2014-12-03', 19.6);
INSERT INTO reservations VALUES(8, 55, '2014-12-13', 47, '2014-12-10', 22.7);
INSERT INTO reservations VALUES(8, 42, '2014-12-20', 16, '2014-12-17', 18.1);
INSERT INTO reservations VALUES(8, 23, '2014-12-27', 8, '2014-12-24', 15.1);
INSERT INTO reservations VALUES(8, 50, '2015-01-03', 14, '2014-12-31', 17.5);
INSERT INTO reservations VALUES(8, 46, '2015-01-10', 13, '2015-01-07', 17.2);
INSERT INTO reservations VALUES(8, 35, '2015-01-17', 6, '2015-01-14', 13.8);
INSERT INTO reservations VALUES(8, 4, '2015-01-24', 17, '2015-01-21', 18.3);
INSERT INTO reservations VALUES(8, 13, '2015-01-31', 7, '2015-01-28', 14.5);
INSERT INTO reservations VALUES(8, 40, '2015-02-07', 30, '2015-02-04', 20.8);
INSERT INTO reservations VALUES(8, 34, '2015-02-14', 24, '2015-02-11', 19.8);
INSERT INTO reservations VALUES(8, 55, '2015-02-21', 5, '2015-02-18', 13.0);
INSERT INTO reservations VALUES(8, 41, '2015-02-28', 31, '2015-02-25', 20.9);
INSERT INTO reservations VALUES(8, 30, '2015-03-07', 18, '2015-03-04', 18.6);
INSERT INTO reservations VALUES(8, 14, '2015-03-14', 36, '2015-03-11', 21.6);
INSERT INTO reservations VALUES(8, 13, '2015-03-21', 31, '2015-03-18', 20.9);
INSERT INTO reservations VALUES(8, 60, '2015-03-28', 14, '2015-03-25', 17.5);
INSERT INTO reservations VALUES(8, 62, '2015-04-04', 49, '2015-04-01', 22.9);
INSERT INTO reservations VALUES(8, 8, '2015-04-11', 52, '2015-04-08', 23.2);
INSERT INTO reservations VALUES(8, 47, '2015-04-18', 3, '2015-04-15', 10.8);
INSERT INTO reservations VALUES(8, 38, '2015-04-25', 25, '2015-04-22', 20.0);
INSERT INTO reservations VALUES(8, 14, '2015-05-01', 25, '2015-04-29', 20.0);
INSERT INTO reservations VALUES(10, 31, '2015-05-02', 54, '2015-05-01', 23.3);
INSERT INTO reservations VALUES(19, 47, '2015-05-02', 46, '2015-05-01', 22.6);
INSERT INTO reservations VALUES(10, 65, '2015-05-03', 37, '2015-05-02', 21.7);
INSERT INTO reservations VALUES(10, 26, '2015-05-04', 15, '2015-05-02', 17.8);
INSERT INTO reservations VALUES(25, 54, '2015-05-04', 53, '2015-05-03', 23.3);