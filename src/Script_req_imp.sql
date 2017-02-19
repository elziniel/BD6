\echo '-------------------- Requetes imposees --------------------\n'
\echo '1. Taux de reservation d\'une plateforme'
\prompt 'Plateforme -> ' pl
\prompt 'Annee -> ' an
EXECUTE q1(:pl, :an);

\echo '2. Recettes par type de jeu'
\prompt 'Annee -> ' an
\prompt 'Mois -> ' mo
EXECUTE q2(:an, :mo);

\echo '3. Liste des jeux sans reservation'
\prompt 'Annee -> ' an
\prompt 'Mois -> ' mo
\prompt 'Limite -> ' li
EXECUTE q3(:an, :mo, :li);

\echo '4. Journee la plus occupee de chaque semaine'
\prompt 'Nombre de semaines -> ' nb
EXECUTE q4(:nb);

\echo '5. Moyenne du nombre de jours a l\'avance des reservations'
EXECUTE q5;

\echo '6. Client ayant le plus depense sur le site'
\prompt 'Annee -> ' an
EXECUTE q6(:an);

\echo '7. Pourcentage represente par les recettes generees par plateformes'
\prompt 'Annee -> ' an
EXECUTE q7(:an);

\echo '8. Clients ayant reserve au moins une fois par semaine'
\prompt 'Nombre de mois -> ' nb
EXECUTE q8(:nb);

\echo '9. Paires de prestations'
EXECUTE q9;

\echo '10. Clients venant les memes jours qu’un autre client'
EXECUTE q10;