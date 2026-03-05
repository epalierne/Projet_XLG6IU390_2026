#= Auteur : PALIERNE Erwan (E215834C) ; groupe 681C 
   Rôle : Implémentation de l'algorithme glouton
=#

include("structure.jl")


function heuristique_Manhattan(x, y)
    return abs(x[1] - y[1]) + abs(x[2] - y[2])
end

function glouton(G, D, A)
    # File de priorité triée selon l'heuristique h(v)
    tas = FileAvecPriorite()

    # Dictionnaire pour suivre le chemin
    precedent = Dict{Any, Any}()
    
    # Compteur du nombre des sommets visités
    nombre_de_sommet = 0

    # Dictionnaire supplémentaire des vérifications pour ne pas visiter un même sommet deux fois
    verification = Set()
    push!(verification, D)

    # Initialisation : on met le départ dans le tas
    inserer(tas, D, Float64(heuristique_Manhattan(D, A)))

    precedent[D] = (nothing, 0.0)

    while !estVide(tas)
        # Extraction du sommet avec la plus petite valeur heuristique
        u = (extraire(tas))[1]

        # Marquer le sommet comme visité
        nombre_de_sommet += 1

        # Si on atteint le sommet d'arrivée, on reconstruit le chemin
        if u == A
            chemin = []
            distance = 0.0
            while u != D
                pushfirst!(chemin, u)
                distance += precedent[u][2]
                u = precedent[u][1]
            end
            pushfirst!(chemin, u)
            return chemin, nombre_de_sommet, distance # Retourne le chemin trouvé
        end

        # Explorer les voisins
        for (v, poids) in G[u]
            if !haskey(precedent, v)
                precedent[v] = (u, poids)
                if !(v in verification)
                    inserer(tas, v, Float64(heuristique_Manhattan(v, A)))
                    push!(verification, v)
                end
            end
        end
    end
    return [], nombre_de_sommet, distance # Aucun chemin trouvé
end

