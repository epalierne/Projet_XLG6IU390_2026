#= Auteur : PALIERNE Erwan (E215834C) ; groupe 681C 
   Rôle : Implémentation de l'algorithme A*
=#

include("structure.jl")


function heuristique_Manhattan(x, y)
    return abs(x[1] - y[1]) + abs(x[2] - y[2])
end

function Astar(G, D, A)
    # Initialisation des distances et des prédecesseurs
    distance = Dict{Any, Any}()
    precedent = Dict{Any, Any}()

    # Compteur du nombre des sommets visités
    nombre_de_sommet = 0

    # Dictionnaire supplémentaire des vérifications pour ne pas visiter un même sommet deux fois
    verification = Set()
    push!(verification, D)

    # File de priorité stockant (sommet => poids)
    tas = FileAvecPriorite()

    # Initialisation des valeurs par défaut
    for sommet in keys(G)
        distance[sommet] = Inf
        precedent[sommet] = (nothing, 0.0)
    end

    distance[D] = 0.0 # la distance du sommet de départ est 0
    inserer(tas, D, (0.0 + heuristique_Manhattan(D, A))) # f(D) = g(D) + h(D)
    while !estVide(tas)
        # Extraction du sommet avec la plus petite distance
        u = (extraire(tas))[1]
        dist_u = distance[u]

        # Marquer le sommet comme visité
        nombre_de_sommet += 1  

        # Si on atteint le point d'arrivée, on peut s'arrêter
        if u == A
            break
        end

        # Mise à jour des voisins
        for (v,poids) in G[u]
            new_dist = dist_u + poids
            f_v = new_dist + heuristique_Manhattan(v, A) # f(v) = g(v) + h(v)
            if new_dist < distance[v]
                distance[v] = new_dist
                precedent[v] = (u, poids)
                if !(v in verification)
                    inserer(tas, v, f_v)
                    push!(verification, v)
                end
            end

        end
    end

    chemin = []
    courant = A
    distance = 0.0
    while courant != D
        push!(chemin, courant)
        distance += precedent[courant][2] 
        courant = precedent[courant][1]
    end
    push!(chemin, courant)
    return reverse(chemin), nombre_de_sommet, distance
end
