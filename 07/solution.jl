using DataStructures
using SparseArrays

input = readlines("input.txt")

bagdict = Dict()
for (i, line) in enumerate(input)
    bagdict[join(split(line)[1:2], " ")] = i
end

M = spzeros(Int, length(input), length(input))
bagdict

for (i, line) in enumerate(input)
    for m in eachmatch(r"(\d+) ([a-z]+ [a-z]+)", line)
        M[i, bagdict[m.captures[2]]] = parse(Int, m.captures[1])
    end
end
    
let	total = 0
    q = Deque{Int}()
    visited = Set{Int}()
    push!(q, bagdict["shiny gold"])
    
    while !isempty(q)
        node = popfirst!(q)
        for neighbor in findall(!iszero,M[:,node])
            if !in(neighbor, visited)
                total += 1
                push!(q, neighbor)
                push!(visited, neighbor)
            end
        end
    end
    println("part 1: ", total)
end

let total = 0::Int
	s = Stack{Int}()
	push!(s,bagdict["shiny gold"])
	
	while !isempty(s)
		node = pop!(s)
        for neighbor in findall(!iszero, M[node,:])
            for n = 1:M[node,neighbor]
                push!(s,neighbor) 
                total += 1   
            end
		end
	end
	println("part 2: ",total)
end