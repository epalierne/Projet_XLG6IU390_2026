# Projet d'informatique scientifique

## Description

Le but de ce projet est de produire une solution logicielle à un problème de _pathfinding_.
Pour le moment, sont implémentés en Julia 4 algorithmes de recherche du plus court chemin : 

- l'algorithme BFS, 
- l'algorithme de Dijkstra, 
- l'algorithme A*, 
- l'algorithme Glouton.

---

## Installation

### Prérequis

- Avoir installé Julia (version 1.11)

### Étapes d'installation

1. Clonage du dépôt :
```
git clone https://github.com/epalierne/Projet_XLG6IU390_2026.git
cd Projet_XLG6IU390_2026
```

2. Compilation :
```
julia
include("src/pathfind.jl")
```

3. Exécution de l'un des algorithmes sur un fichier _fname_ avec comme points de départ et d'arrivée (xD,yD) et (xA,yA) respectivement :
```   
algoBFS("dat/fname", (xD,yD), (xA,yA))  
algoDijkstra("dat/fname", (xD,yD), (xA,yA))  
algoAstar("dat/fname", (xD,yD), (xA,yA))  
algoGlouton("dat/fname", (xD,yD), (xA,yA))
```

