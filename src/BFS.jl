#= Auteur : PALIERNE Erwan (E215834C) ; groupe 681C 
   Rôle : Implémentation de l'algorithme BFS
=#

include("structure.jl")


function BFS(G, D, A)
    # Créer une file d'attente
    file = File()

    # Ensuite y ajouter le point de départ D
    enfiler(file, D)

    # Dictionnaire des prédécesseurs
    predecesseurs = Dict{Any, Any}() 
    predecesseurs[D] = nothing

    # Compteur du nombre des sommets visités
    nombre_de_sommet = 0

    # Dictionnaire supplémentaire des vérifications pour ne pas visiter un même sommet deux fois
    verification = Set()
    push!(verification, D)

    while !estvide(file)
        # défilage de la tête
        URHere = defiler(file)

        # marquer le sommet comme visité
        nombre_de_sommet += 1

        # pour chaque successeur de mon sommet (ses voisins)
        for succ in G[URHere]
            successeur = succ[1] # les poids sont ignorés dans cet algorithme

            # je vérifie s'il n'est pas encore visité 
            if !(successeur in verification)
                # s'il n'est pas encore visité , je l'ajoute dans la file
                enfiler(file, successeur)
                push!(verification, successeur)

                # ensuite j'enregistre son prédécesseur
                predecesseurs[successeur] = URHere
            end
        end

        # Si le nœud d'arrivée est trouvé, on arrête la recherche
        if URHere == A 
            break
        end
    end

    # Reconstitution du chemin depuis D jusqu'à A
    chemin = []
    # courant reçoit le point d'arrivée A
    courant = A
    # Distance réelle du chemin
    distance = 0.0

    # Tant que je ne suis pas arrivé au point de départ D, j'ajoute le prédécesseur de courant dans mon chemin
    while courant != D 
        push!(chemin, courant)
        distance += 1.0
        courant = predecesseurs[courant]
    end
    push!(chemin, courant) # lorsque courant = D
    # Je vais alors inverser l'ordre des élements dans mon tableau pour les renvoyer dans le bon ordre
    return reverse(chemin), nombre_de_sommet, distance
end
