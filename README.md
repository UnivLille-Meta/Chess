# Myg Chess Game

Jeu d'échecs pour Pharo basé sur Bloc, Toplo et Myg.

## À propos du projet

Ce projet est conçu pour pratiquer les compétences suivantes:

- Tests 
- Lecture de code existant
- Refactorings
- Débogage

## Installation

### Charger le code

Ce code a été testé avec Pharo 13.0 64-bit. Pour l'installer, utilisez le baseline Metacello suivant :

```smalltalk
Metacello new
	repository: 'github://MWB21223/Chess:main';
	baseline: 'MygChess';
	onConflictUseLoaded;
	load.
```

## Démarrer une partie

Pour ouvrir le jeu d'échecs, utilisez l'expression suivante :

```smalltalk
board := MyChessGame freshGame.
board size: 800@600.
space := BlSpace new.
space root addChild: board.
space pulse.
space resizable: true.
space show.
```


## KATA : Correction des mouvements de pions

### Objectif

Corriger les mouvements des pions, incluant :

- Double pas initial (2 cases depuis la rangée de départ)
- Captures diagonales
- Prise en passant

### Implémentation réalisée

#### 1. Structure modulaire des mouvements de pions

Les mouvements des pions ont été décomposés en méthodes séparées pour une meilleure lisibilité et maintenabilité :

**`MyPawn >> forwardMoveSquares`**

- Gère l'avancée des pions (1 ou 2 cases)
- Vérifie que les cases sont libres
- Permet le double pas uniquement depuis la rangée initiale (rangée 2 pour blanc, rangée 7 pour noir)
- Détecte les blocages

**`MyPawn >> diagonalCaptureSquares`**

- Retourne les cases diagonales capturables
- Vérifie qu'une pièce adverse est présente
- Ne permet pas de capturer des alliés

**`MyPawn >> enPassantTargetSquares`**

- Retourne la/les case(s) de prise en passant disponibles
- Lit la case cible depuis `MyChessGame enPassantTargetSquare`
- Vérifie que la case EP est accessible en diagonale depuis la position du pion

**`MyPawn >> targetSquaresLegal:`**

- Compose les trois familles de mouvements : avancée, capture diagonale, en passant
- Méthode principale utilisée par l'UI pour afficher les mouvements possibles

#### 2. Gestion de la prise en passant

**Dans `MyChessGame` :**

- **`enPassantTargetSquare`** : Variable d'instance stockant la case cible en passant (ou `nil`)
- **`enPassantTargetSquare:`** : Accesseur pour définir la case EP
- **`move:piece to:square`** : Mis à jour pour :
  - Détecter un double pas de pion (écart de 2 rangées)
  - Définir la case EP comme la case franchie (milieu du double pas)
  - Réinitialiser la case EP à `nil` après tout autre coup

**Dans `MyChessGame >> initializeFromFENGame:` :**

- Initialise la case EP depuis la FEN si présente
- Convertit la notation FEN (ex: "e3") en case du plateau

**Dans `MyPawn >> moveTo:` :**

- Détecte si le mouvement est une prise en passant
- Retire le pion capturé de la case derrière la case EP (case franchie)
- Effectue le mouvement normal


### Tests implémentés

#### Tests d'avancée et blocages

- `testPawnAdvancesOneSquare` : Vérifie l'avancée d'une case
- `testPawnCanMakeInitialDoubleMove` : Vérifie le double pas initial
- `testPawnBlockedCannotMove` : Vérifie qu'un pion bloqué ne peut pas avancer
- `testPawnCannotJumpOverObstacleForDoubleMove` : Vérifie qu'on ne peut pas sauter pour le double pas
- `testPawnCannotDoubleMoveFromNonInitialRank` : Vérifie qu'on ne peut pas faire de double pas depuis une autre rangée

#### Tests de capture diagonale

- `testPawnCanCaptureDiagonallyLeft` : Vérifie la capture diagonale gauche
- `testPawnCanCaptureDiagonallyRight` : Vérifie la capture diagonale droite
- `testPawnCannotCaptureDiagonallyOnEmptySquare` : Vérifie qu'on ne peut pas capturer en diagonale sur une case vide

#### Tests de prise en passant

- `testEnPassantWhiteCapturesAfterBlackDoubleStep` : Vérifie qu'un pion blanc peut capturer en passant un pion noir qui vient de faire un double pas
- `testEnPassantExpiresAfterOtherMove` : Vérifie que la possibilité de prise en passant expire après un autre coup


## Difficultés rencontrées

### Compréhension du projet

La première difficulté a été de comprendre la structure globale du projet et son architecture. Il a fallu analyser les différentes classes, leurs responsabilités et leurs interactions. De plus, la compréhension des règles d'échecs de base, notamment la règle complexe de la **prise en passant**, n'était pas évidente au départ.

### Problèmes techniques

#### Installation et configuration (Rayane)

- Difficultés avec l'interface Pharo (installation projet)
- Problèmes de configuration des repositories
- Difficultés à importer le projet dans Pharo

**Solution** : Migration de certains fichiers depuis l'invite de commande pour contourner les problèmes d'interface.

#### Gestion de version avec Git (Ilyas)

- Problèmes pour pousser le code via Pharo (liaison avec Git)
- Divergences entre le code poussé sur GitHub et le code réellement présent dans Pharo
- Synchronisation difficile entre l'environnement local et le dépôt distant

**Solution** : Délégation des codes et push/commit à Rayane, qui pouvait effectuer ces opérations sans problèmes puis basculement sur le push via linux/vscode.

Ces problèmes techniques ont été résolus progressivement en trouvant des alternatives pour pouvoir avancer le plus rapidement possible dans le développement.

## Démarche adoptée

### Approche méthodique

Nous avons adopté une approche réfléchie et structurée pour mener à bien ce projet :

1. **Reverse Engineering** : 
   - Analyse approfondie du code existant pour comprendre l'architecture
   - Identification des responsabilités de chaque classe
   - Compréhension des mécanismes de mouvement des pions

2. **Test-Driven Development (TDD)** :
   - Écriture des tests en premier pour les fonctionnalités de base
   - Tests pour les fonctionnalités non encore implémentées (capture diagonale et prise en passant)
   - Les tests de prise en passant ont été poussés plus tard à cause des problèmes de push Git rencontrés par Ilyas

3. **Débogage** :
   - Utilisation principale du débogueur intégré de Pharo
   - Analyse pas à pas du code pour identifier les bugs
   - Vérification des états intermédiaires lors de l'exécution

4. **Vérification** :
   - Validation que toutes les fonctionnalités fonctionnent correctement
   - Exécution de la suite complète de tests
   - Vérification manuelle des comportements dans l'interface
   - Ajout de commentaires dans le code pour une meilleure communications entre nous.


Cette démarche nous a permis de progresser de manière structurée et de garantir la qualité du code produit.

## Structure des fichiers

```
src/
├── BaselineOfMygChess/          # Configuration Metacello
├── Myg-Chess-Core/              # Logique métier
│   ├── MyPawn.class.st          # Implémentation des pions (KATA)
│   ├── MyChessGame.class.st     # Gestion de la partie
│   ├── MyChessBoard.class.st    # Plateau d'échecs
│   ├── MyChessSquare.class.st   # Cases du plateau
│   └── ...                      # Autres pièces
├── Myg-Chess-Importers/         # Import FEN/PGN
│   ├── MyFENParser.class.st
│   └── MyFENGame.class.st
└── Myg-Chess-Tests/             
    ├── MyPawnTest.class.st      # Tests unitaires de nos pions 
    └── ...
```


