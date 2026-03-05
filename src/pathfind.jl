#= Auteur : PALIERNE Erwan (E215834C) ; groupe 681C 
   Rôle : 
=#

include("graphe.jl")
include("BFS.jl")
include("Dijkstra.jl")
include("Astar.jl")
include("Glouton.jl")


function algoBFS(fname::String, D::Tuple{Int,Int}, A::Tuple{Int,Int})
    graphe = creation_du_graphe(fname)
    if !haskey(graphe, D) || !haskey(graphe, A)
        println("L'un des deux points est impratiquable.")
    else
        t = time()
        chemin, nombre_de_sommet, distance = BFS(graphe, D, A)
        dt = round(time() - t, digits=6)
        if chemin != nothing
            println(" \n\n Distance  D -> A : ", distance)
            println(" Number of states evaluated : ", nombre_de_sommet)
            println(" Temps : ", dt, " sec")
            println(" Path D -> A " )
            for element in chemin
                print(element)
                if element != chemin[end] print("->") end 
            end
        else
            println(" Il n'existe aucun chemin")
        end
    end
    println("\n\n")
end


function algoDijkstra(fname::String, D::Tuple{Int,Int}, A::Tuple{Int,Int})
    graphe = creation_du_graphe(fname)
    if !haskey(graphe, D) || !haskey(graphe, A)
        println("L'un des deux points est impratiquable.")
    else
        t = time()
        chemin, nombre_de_sommet, distance = Dijkstra(graphe, D, A)
        dt = round(time() - t, digits=6)
        if chemin != nothing
            println(" \n\n Distance  D -> A : ", distance)
            println(" Number of states evaluated : ", nombre_de_sommet)
            println(" Temps : ", dt, " sec")
            println(" Path D -> A ")
            for element in chemin
                print(element)
                if element != chemin[end] print("->") end 
            end
        else
            println(" Il n'existe aucun chemin.")
        end
    end
    println("\n\n")
end


function algoAstar(fname::String, D::Tuple{Int,Int}, A::Tuple{Int,Int})
    graphe = creation_du_graphe(fname)
    if !haskey(graphe, D) || !haskey(graphe, A)
        println("L'un des deux points est impratiquable.")
    else
        t = time()
            chemin, nombre_de_sommet, distance = Astar(graphe, D, A)
        dt = round(time() - t, digits=6)
        if chemin != nothing
            println(" \n\n Distance  D -> A : ", distance)
            println(" Number of states evaluated : ", nombre_de_sommet)
            println(" Temps : ", dt, " sec")
            println(" Path D -> A ")
            for element in chemin
                print(element)
                if element != chemin[end] print("->") end 
            end
        else
            println(" Il n'existe aucun chemin.")
        end
    end
    println("\n\n")
end


function algoGlouton(fname::String, D::Tuple{Int,Int}, A::Tuple{Int,Int})
    graphe = creation_du_graphe(fname)
    if !haskey(graphe, D) || !haskey(graphe, A)
        println("L'un des deux points est impratiquable.")
    else
        t = time()
        chemin, nombre_de_sommet, distance = glouton(graphe, D, A)
        dt = round(time() - t, digits=6)
        if chemin != nothing
            println(" \n\n Distance D -> A : ", distance)
            println(" Number of states evaluated : ", nombre_de_sommet)
            println(" Temps : ", dt, " sec")
            println(" Path D -> A : ")
            for element in chemin
                print(element)
                if element != chemin[end] print("->") end 
            end
        else
            println(" Il n'existe aucun chemin.")
        end
    end
    println("\n\n")
end
