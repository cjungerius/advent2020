### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ e57b1760-3884-11eb-0ade-63eabd96da6d
using DataStructures

# ╔═╡ d5efbc10-3866-11eb-3b7e-fdda95d1ea16
input = readlines("input.txt")

# ╔═╡ 2ed7e6d0-3881-11eb-209e-179d410ac587
baglist = map(input) do line
	join(split(line)[1:2]," ")
end

# ╔═╡ 2abd5450-3867-11eb-3df8-1fa8a7cd9570
m = r"(\d+) ([a-z]+ [a-z]+)"

# ╔═╡ ccac4270-3881-11eb-2b08-c9f2f2eaa551
contentlist = map(input) do line
	collect(eachmatch(m, line))
end

# ╔═╡ 14e4fbb0-3867-11eb-3cfd-d5d8cd966da8
struct Bag
	containedby::Array{String}
	containedn::Array{Int}
	contains::Array{String}
	containsn::Array{Int}
end

# ╔═╡ 80504420-3882-11eb-2a82-cdba89fe21e8
begin
graph = Dict(map(x -> (x, Bag([],[],[],[])), baglist))
for (i, content) in enumerate(contentlist)

	for entry in content
		push!(graph[entry.captures[2]].containedby,baglist[i])
		push!(graph[entry.captures[2]].containedn,parse(Int,entry.captures[1]))
		push!(graph[baglist[i]].contains,entry.captures[2])
		push!(graph[baglist[i]].containsn, parse(Int,entry.captures[1]))
	end

end
	graph
end
		
		

# ╔═╡ ed1e4fb0-3883-11eb-2fba-8b1fe472296e
#BFS upwards

let	total = 0
	q = Deque{String}()
	visited = Set()
	push!(q,"shiny gold")

	while !isempty(q)
		node = popfirst!(q)
		for neighbor in graph[node].containedby
			if !in(neighbor,visited)
				total += 1
				push!(q,neighbor)
				push!(visited,neighbor)
			end
		end
	end
	total
end

# ╔═╡ fbe691d0-3890-11eb-2c69-b9d21e2f3ab8
#DFS downwards

let total = 0
	s = Stack{String}()
	push!(s,"shiny gold")
	
	while !isempty(s)
		node = pop!(s)
		for (i,neighbor) in enumerate(graph[node].contains)
			for n = 1:graph[node].containsn[i]
			push!(s,neighbor)
			total += 1
			end
		end
	end
	total
end

# ╔═╡ Cell order:
# ╠═e57b1760-3884-11eb-0ade-63eabd96da6d
# ╠═d5efbc10-3866-11eb-3b7e-fdda95d1ea16
# ╠═2ed7e6d0-3881-11eb-209e-179d410ac587
# ╠═2abd5450-3867-11eb-3df8-1fa8a7cd9570
# ╠═ccac4270-3881-11eb-2b08-c9f2f2eaa551
# ╠═14e4fbb0-3867-11eb-3cfd-d5d8cd966da8
# ╠═80504420-3882-11eb-2a82-cdba89fe21e8
# ╠═ed1e4fb0-3883-11eb-2fba-8b1fe472296e
# ╠═fbe691d0-3890-11eb-2c69-b9d21e2f3ab8
