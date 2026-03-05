#= Auteur : PALIERNE Erwan (E215834C) ; groupe 681C 
   Rôle : Implémentation de structures générales
=#

# Implémentation d'une file avec une liste chainée double
mutable struct Noeud 
    valeur::Tuple{Int64, Int64}
    suivant::Union{Noeud, Nothing}
    precedent::Union{Noeud, Nothing}
end 

mutable struct File 
    tete::Union{Noeud, Nothing}
    queue::Union{Noeud, Nothing}
end

# Constructeur
function File() 
    return File(nothing, nothing)
end

function enfiler(file:: File, val::Tuple{Int64, Int64}) 
    noeud = Noeud(val, nothing, nothing)
    if isnothing(file.queue) # Vérifie si vide
        file.tete = file.queue = noeud
    else
        file.queue.suivant = noeud
        noeud.precedent = file.queue
        file.queue = noeud
    end
end

function defiler( file:: File) 
    if isnothing(file.tete)
        throw(ArgumentError("File vide")) 
    end
    val = file.tete.valeur
    file.tete = file.tete.suivant
    if isnothing(file.tete)
        file.queue = nothing
    else
        file.tete.precedent = nothing
    end
    return val
end

function estvide(file::File)
    return isnothing(file.tete) 
end

# Implémentation d'une file avec priorité sur les poids
mutable struct FileAvecPriorite 
    tas::Vector{Tuple{Tuple{Int64, Int64}, Float64}} # Stocke les coordonnées et le poids

    # Constructeur pour une file vide
    function FileAvecPriorite() 
        return new(Vector{Tuple{Tuple{Int64, Int64}, Float64}}()) 
    end
end

# Trouve l'index du parent d'un élément
function indexParent(i::Int64)::Int64 
    return div(i, 2) # division entière
end

# Retourne l'index du fils gauche
function indexFilsgauche(i::Int64)::Int64 
    return 2 * i
end

# Retourne l'index du fils droit
function indexFilsdroit(i::Int64)::Int64 
    return 2 * i + 1
end

# Vérifie si la file de priorité est vide
function estVide(file::FileAvecPriorite)::Bool
    return isempty(file.tas) 
end

# Insère un élement dans la file de priorité
function inserer(file::FileAvecPriorite, val::Tuple{Int64, Int64}, poids::Float64)
    push!(file.tas, (val, poids)) # Ajout de l'élement à la function
    reorganiser(file, length(file.tas))# Réorganiser le tas si necéssaire
end

# Réorganiser la file de priorité après insertion
function reorganiser(file::FileAvecPriorite, i::Int64)
    while i > 1 && file.tas[i][2] < file.tas[indexParent(i)][2] # Comparaison en fonction des poids
        file.tas[i], file.tas[indexParent(i)] = file.tas[indexParent(i)], file.tas[i] # Échange avec le parent
        i = indexParent(i) # pour continuer à remonter
    end 
end

# Extraire avec le plus faible poids
function extraire(file::FileAvecPriorite)::Tuple{Tuple{Int64, Int64}, Float64} 
    if estVide(file)
        error("La file de priorité est vide.")
    end
    racine = file.tas[1] # Stocke l'élément avec la plus petite priorité
    if length(file.tas) == 1 
        pop!(file.tas) # Si il n'y a qu'un seul élement, on le supprime directement
    else
        file.tas[1] = file.tas[end] # Remplace la racine par le dernier élement
        pop!(file.tas) # Supprime le dernier élement
        reorganisation_apres_descente(file, 1) # Réorganise le tas si necéssaire
    end
    return racine
end

# Réorganiser le tas après l'extraction
function reorganisation_apres_descente(file::FileAvecPriorite, i::Int64)
    taille = length(file.tas)
    while true
        gauche = indexFilsgauche(i)
        droite = indexFilsdroit(i)
        pluspetit = i
        # Vérifier si gauche est plus petit
        if gauche <= taille && file.tas[gauche][2] < file.tas[pluspetit][2] 
            pluspetit = gauche
        end
        # Vérifier si droite est plus petit
        if droite <= taille && file.tas[droite][2] < file.tas[pluspetit][2] 
            pluspetit = droite
        end
        # Si l'élément est déjà bien placé, on arrête
        if pluspetit == i 
            break 
        end
        # Échanger l'élement avec le plus petit de ses fils
        file.tas[i], file.tas[pluspetit] = file.tas[pluspetit], file.tas[i]
        i = pluspetit # Continuer la descente
    end 
end