\echo '------------------ Requetes personnelles ------------------\n'
\echo '1. Reservation le jour de la sortie d\'un jeu'
EXECUTE p1;

\echo '2. Clients possedant au moins X machine(s)'
\prompt 'Nombre de machines -> ' nb
EXECUTE p2(:nb);

\echo '3. Nombre de plateformes hebergees par machine'
EXECUTE p3;

\echo '4. Prix moyen des jeux par rapport a une plateforme'
\prompt 'Plateforme -> ' pl
EXECUTE p4(:pl);

\echo '5. Clients ayant reserve leur jeux sur la meme plateforme'
\prompt 'Limite -> ' li
EXECUTE p5(:li);

\echo '6. Jeu ayant la meilleure note sur une plateforme'
\prompt 'Plateforme -> ' pl
EXECUTE p6(:pl);

\echo '7. Moyenne des notes des jeux par plateforme'
EXECUTE p7;

\echo '8. Prix des reservations pour une machine'
\prompt 'Machine -> ' ma
\prompt 'Annee -> ' an
EXECUTE p8(:ma, :an);

\echo '9. Nombre de reservations par plateforme par client'
\prompt 'Limite -> ' li
EXECUTE p9(:li);

\echo '10. Clients ayant reserve un jeu a X joueur(s)'
\prompt 'Nombre de joueur(s) -> ' nb
EXECUTE p10(:nb);