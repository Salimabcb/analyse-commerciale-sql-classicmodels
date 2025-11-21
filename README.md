
# Analyse SQL des performances commerciales – ClassicModels

## 1. Présentation du projet

Ce projet propose une analyse complète et structurée de la base **ClassicModels**, une base de données relationnelle utilisée pour l’apprentissage SQL.
L’objectif est d’examiner les performances commerciales d’une entreprise internationale fictive à travers quatre dimensions clés :

* Ventes
* Clients
* Produits
* Employés

Ce projet s’inscrit dans une démarche d’analyse décisionnelle visant à identifier les axes de performance, les opportunités de croissance et les zones d’amélioration.

L’ensemble des requêtes se trouve dans le fichier SQL fourni, accompagné d’un PDF d’insights synthétisant les principaux résultats.



## 2. Objectifs de l’analyse

### a. Analyse des ventes

* Calcul du chiffre d’affaires total
* Identification des catégories générant le plus de revenus
* Analyse géographique des performances (points forts et faibles)
* Suivi de l’évolution annuelle dans les meilleures et pires zones
* Analyse des ventes par trimestre
* Identification des segments présentant le plus faible chiffre d’affaires

### b. Analyse des clients

* Classement des clients les plus rentables
* Analyse du panier moyen
* Classement par nombre de commandes
* Évaluation du potentiel par pays (revenu moyen par client)

### c. Analyse des produits

* Identification des produits les plus rentables (marge unitaire et totale)
* Détection des produits les moins performants
* Top des produits en chiffre d’affaires et en volume
* Analyse du rapport ventes/stock
* Détection des risques de rupture et des surstocks
* Analyse croisée : produits les plus achetés par les meilleurs clients

### d. Analyse des employés

* Classement des employés par volume de commandes gérées
* Analyse du chiffre d’affaires généré par employé
* Nombre de clients gérés par employé



## 3. Méthodologie

Les analyses reposent exclusivement sur des requêtes SQL avancées, notamment :

* Jointures (INNER JOIN, LEFT JOIN)
* Agrégations (SUM, AVG, COUNT)
* Fonctions de classement (RANK, PARTITION BY)
* Fonctions temporelles (YEAR, QUARTER)
* Requêtes imbriquées et CTE (WITH)
* Analyse multitable pour vente/clients/produits/employés

L’ensemble du code SQL est structuré en sections thématiques pour faciliter la lecture et la reproduction.


## 4. Technologies utilisées

* SQL (MySQL)
* Base ClassicModels
* Outils d’exécution recommandés :

  * MySQL Workbench
  * DBeaver
  * phpMyAdmin
  * VS Code + extension SQL



## 6. Conclusion

Cette analyse SQL met en évidence les leviers de performance commerciale de ClassicModels grâce à une exploration approfondie des ventes, produits, clients et employés.
Elle constitue un projet professionnel complet, illustrant la capacité à :

* manipuler et interroger des bases relationnelles complexes
* structurer une analyse business
* synthétiser des insights opérationnels
* produire un livrable SQL reproductible et clair





Souhaites-tu que je le reformule dans un style **encore plus académique**, ou **plus orienté recruteur** ?
