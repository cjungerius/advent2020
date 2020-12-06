### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 1b209650-37b9-11eb-24c1-3332d8c0026d
begin
input = read("input.txt",String)
input = split(input,"\n\n")
end

# ╔═╡ dae25bf0-37b8-11eb-28cc-ad94a7d502ea
#solution to part 1

let total = 0
for group in input
	total += sum(isletter.(unique(group)))
end
	total
end

# ╔═╡ 2b7ddbe0-37bc-11eb-04b8-1bc36ec7037a
#solution to part 2
input2 = split.(input,"\n",keepempty=false)

# ╔═╡ 6c6f60b2-37bc-11eb-0ab1-a9930cf35f97
let total = 0
for group in input2
		for answer in unique(group[1])
			total += all(any.(x->x==answer,group))
			
		end
	end
	total
end
	

# ╔═╡ Cell order:
# ╠═1b209650-37b9-11eb-24c1-3332d8c0026d
# ╠═dae25bf0-37b8-11eb-28cc-ad94a7d502ea
# ╠═2b7ddbe0-37bc-11eb-04b8-1bc36ec7037a
# ╠═6c6f60b2-37bc-11eb-0ab1-a9930cf35f97
