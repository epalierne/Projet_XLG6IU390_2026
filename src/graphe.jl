#= Auteur : PALIERNE Erwan (E215834C) ; groupe 681C 
   Rôle : Manipulation d'une carte avec un graphe équivalent
=#


# Vérifie si un point donné est compris dans la limite des lignes du fichier
function estLibre(vi, vj, nbColonnes, lignes_du_fichier) 
    if vi >= 1 && vi <= length(lignes_du_fichier) && vj >= 1 && vj <= nbColonnes
        return true
    end
    return false
end

function creation_du_graphe(nom_du_fichier::String)
    graphe = Dict()
    poids = Dict('.' => 1.0, 
                 'S' => 5.0, 
                 'W' => 8.0, 
                 '@' => nothing, 
                 'T' => nothing)
    directions = [(-1, 0), (1, 0), # gauche et droite
                      (0, -1), (0, 1)] # haut et bas
    lignes = [] # Initialiser un tableau pour stocker les lignes
    quatres_premieres_lignes = []
    i = 0
    open(nom_du_fichier, "r") do file # Lecture du fichier
        push!(quatres_premieres_lignes, strip(readline(file)))
        push!(quatres_premieres_lignes, strip(readline(file)))
        push!(quatres_premieres_lignes, strip(readline(file)))
        push!(quatres_premieres_lignes, strip(readline(file)))
        # Récupération du nombre des colonnes
        valeur_colonne = split(quatres_premieres_lignes[3])[end]
        nbColonnes = parse(Int, valeur_colonne)
        push!(lignes, strip(readline(file)))
        push!(lignes, strip(readline(file)))
        construire_les_arcs(lignes, 1, poids, directions, nbColonnes, graphe)
        deleteat!(lignes, 2)
        seekstart(file)
        cpt = 0
        for ligne in eachline(file)
            cpt += 1
            if  cpt > 5
                i += 1
                push!(lignes, strip(ligne))
                if i <= length(lignes) - 1 && i >= 2 
                    construire_les_arcs(lignes, i, poids, directions, nbColonnes, graphe)
                end
            end
        end
    end
    # Récupération du nombre des colonnes
    valeur_colonne = split(quatres_premieres_lignes[3])[end]
    nbColonnes = parse(Int, valeur_colonne)
    construire_les_arcs(lignes, length(lignes), poids, directions, nbColonnes, graphe)
    return graphe # Retourner le tableau contenant les lignes du fichier
end

function construire_les_arcs(lignes, i, poids, directions, nbColonnes, graphe)
    j = 0
    for car in lignes[i]
        j += 1
        if poids[car] != nothing
            lesvoisins = []
            for(di, dj) in directions
                vi = i + di
                vj = j + dj
                if estLibre(vi, vj, nbColonnes, lignes)
                    if poids[lignes[vi][vj]] != nothing
                        push!(lesvoisins, ((vi, vj), poids[lignes[vi][vj]]))
                    end
                end
            end
            if length(lesvoisins) > 0
                graphe[(i,j)] = lesvoisins
            end
        end
    end
end
