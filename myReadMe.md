# **Fix Pawn Moves (Salim TITOUCHE)**

## **Introduction**

Ce projet vise à corriger et à implémenter les mouvements légaux des pions dans un jeu d'échecs. Ces fonctionnalités nécessitent une compréhension approfondie des règles d'échecs, de la détection des erreurs et du développement incrémental.

---

## **Objectifs**

Les pions sont parmi les pièces les plus complexes à implémenter en raison des règles suivantes :
- Les pions se déplacent vers l'avant d'une case.
- Lors de leur premier mouvement, ils peuvent avancer de deux cases.
- Les pions capturent en diagonale, une case en avant.
- La règle spéciale "En passant" ajoute une complexité supplémentaire.

---

## **Méthodes Développées**

### **Mouvements de base des pions**
1. **`Pawn>>targetSquaresLegal`**
   - Retourne les cases vers lesquelles un pion peut légalement se déplacer.
   - Gère les mouvements simples, les doubles déplacements initiaux et les captures diagonales.

2. **`Pawn>>doubleStepSquare`**
   - Identifie la case cible pour un déplacement initial de deux cases.

3. **`Pawn>>canCapture:`**
   - Vérifie si un pion peut capturer une pièce donnée.

4. **`Pawn>>moveTo:`**
   - Déplace un pion vers une case donnée, en respectant les règles des mouvements légaux.

5. **`Pawn>>isFirstMove`**
   - Retourne vrai si le pion n’a pas encore été déplacé.

6. **`Pawn>>enPassantMove:`**
   - Implémente le mouvement spécial "En passant", permettant à un pion de capturer un pion adverse qui a effectué un double déplacement initial.

---

## **Tests Implémentés**

### **Tests pour les mouvements des pions**
1. **`testPawnFirstMoveTwoSquares_White`**
   - Vérifie qu’un pion blanc peut avancer de deux cases lors de son premier mouvement.

2. **`testPawnFirstMoveTwoSquares_Black`**
   - Vérifie qu’un pion noir peut avancer de deux cases lors de son premier mouvement.

3. **`testPawnCannotMoveTwoSquaresAfterFirstMove`**
   - Vérifie qu’un pion ne peut pas avancer de deux cases après son premier mouvement.

4. **`testPawnCannotCaptureStraightAhead`**
   - Vérifie qu’un pion ne peut pas capturer une pièce se trouvant directement devant lui.

5. **`testPawnDiagonalCapture`**
   - Vérifie qu’un pion peut capturer une pièce en diagonale.

6. **`testPawnEnPassant`**
   - Implémente et teste le mouvement spécial "En passant".

---

## **Approche Incrémentale**

### **1. Décomposition en sous-tâches**
Pour chaque fonctionnalité, le développement a été effectué par étapes :
1. Implémentation des mouvements simples (avant d'une case, double mouvement initial).
2. Gestion des captures diagonales.
3. Validation des tests pour les cas de base avant d'ajouter la règle "En passant".

### **2. Outils utilisés pour la détection des bugs**
- Tests unitaires pour valider chaque règle et cas particulier.
- Débogage incrémental pour vérifier les états intermédiaires du jeu.
- Utilisation d'une approche TDD (Test-Driven Development).

---

## **Résultats**

Tous les mouvements légaux des pions sont désormais conformes aux règles d'échecs, y compris :
   - Mouvements initiaux.
   - Captures diagonales.
   - Mouvement "En passant".

---

## **Conclusion**

Ce projet a permis d'explorer des techniques avancées de débogage et de validation des règles de jeu par le biais de tests unitaires. Grâce à une approche incrémentale, il a été possible de corriger les bugs existants, d'ajouter des fonctionnalités complexes et de garantir leur robustesse. Cette méthodologie peut être utilisée pour étendre le jeu à d'autres pièces à l'avenir.

# Rapport sur la Suppression des Vérifications de Nil dans le Jeu d'Échecs de Salas Merzouk

## Objectif du Projet

Le but principal de ce projet était d'éliminer les vérifications explicites de `nil` dans le code existant en utilisant des concepts de **polymorphisme** et de **design patterns**. Cette refactorisation visait à améliorer la lisibilité, la maintenabilité et la robustesse du code.

## Problème Initial

Dans le code original, les cases et les pièces pouvaient être `nil` pour représenter une absence. Par conséquent, plusieurs méthodes contenaient des vérifications explicites sur `nil`. Ces vérifications alourdissaient le code et violaient le principe **Tell, Don't Ask** en obligeant à tester des états au lieu d'utiliser des comportements définis par des objets.

## Solution Adoptée

Pour remplacer ces vérifications, j'ai adopté le **Null Object Pattern**, créant des objets spécifiques pour représenter l'absence de pièces et de cases.

### 1. Création de `MyNullPiece`

J'ai créé une classe `MyNullPiece` comme sous-classe de `MyPiece`. Cette classe représente une pièce inexistante et implémente des méthodes neutres.

### 2. Création de `MyNullChessSquare`

J'ai également créé une classe `MyNullChessSquare` comme sous-classe de `MyChessSquare` pour représenter les cases inexistantes (en dehors du plateau). Cette classe implémente des méthodes appropriées.

### 3. Remplacement des Vérifications de Nil

J'ai modifié les méthodes dans les différentes classes (par exemple, `MyPawn`, `MyMove`) pour remplacer les tests `isNil` par des appels aux méthodes `isNullPiece` et `isNullChessSquare`.

### 4. Adaptations dans les Classes Affectées

J'ai passé en revue toutes les classes impactées et adapté leurs méthodes :

-   `MyPawn` : Gestion des mouvements en passant et captures.
-   `MyPiece` : Gestion des déplacements des pieces.
-   `ChessBoard` : Initialisation des cases et gestion des limites du plateau.

### 5. Tests Unitaires

J'ai ajouté et adapté des tests pour valider ces modifications :

-   Test des comportements des objets nuls (mouvements, captures, validations).
-   Test des interactions entre pièces et cases.
-   Test des mouvements en dehors du plateau.

## Difficultés Rencontrées

*   **Propagation des changements :** Chaque vérification de `nil` pouvait impacter plusieurs méthodes dans différentes classes, nécessitant une refactorisation en profondeur.
*   **Gestion des erreurs :** Certaines erreurs survenaient après remplacement des tests, notamment lors d'appels à des méthodes sur des objets non initialisés. Ces erreurs ont été corrigées en ajoutant des valeurs par défaut comme des instances de `MyNullChessSquare`.
*   **Fusion avec les modifications des collègues :** Les changements apportés ont eu un impact significatif sur les autres branches du projet, rendant les fusions complexes. Il a fallu coordonner avec les collègues pour résoudre les conflits et aligner leurs modifications sur la nouvelle architecture basée sur des objets nuls.

## Résultats et Bénéfices

1.  Suppression complète des tests explicites sur `nil`.
2.  Utilisation de l'héritage et du polymorphisme pour simplifier la logique.
3.  Code plus clair, plus lisible et plus facile à déboguer.
4.  Tests assurant la robustesse du code après refactorisation.
5.  **Réduction des vérifications explicites de `nil` :** Le code est devenu plus lisible et maintenable.
6.  **Utilisation du polymorphisme :** Simplification des comportements spécifiques grâce aux classes d'objets nuls.
7.  **Robustesse accrue :** Moins de risques d'erreurs dues à des valeurs nulles inattendues.
8.  **Tests améliorés :** Des tests supplémentaires garantissent la stabilité des nouvelles implémentations.


## Conclusion

Ce projet a démontré l'importance de l'utilisation d'objets nuls et de polymorphisme pour améliorer la qualité du code. Les difficultés rencontrées, bien que significatives, ont été surmontées grâce à des efforts de collaboration et des tests rigoureux. Ce travail sert de base pour de futures améliorations du jeu d'échecs et d'autres projets nécessitant des pratiques de développement similaires.

---

**Auteur : Merzouk Salas**\
**Date : Janvier 2025**
