### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ d5efbc10-3866-11eb-3b7e-fdda95d1ea16
input = readlines("example.txt")

# ╔═╡ 14e4fbb0-3867-11eb-3cfd-d5d8cd966da8
struct Bag
	name::String
	containedby::Array{String}
	containedn::Array{Int}
end

# ╔═╡ 2abd5450-3867-11eb-3df8-1fa8a7cd9570
begin
name = r""
contents = r"(\d+) ([a-z]+ [a-z]+)"
end

# ╔═╡ Cell order:
# ╠═d5efbc10-3866-11eb-3b7e-fdda95d1ea16
# ╠═14e4fbb0-3867-11eb-3cfd-d5d8cd966da8
# ╠═2abd5450-3867-11eb-3df8-1fa8a7cd9570
