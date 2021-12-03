
function writing(input)
    mem = Dict()
	bitmask = 0
	for line in input
		command = split(line, " ")
		if command[1] == "mask"
			bitmask = split(command[3],"")
		else
			address = match(r"[[:digit:]]+", command[1]).match
			value = split(bitstring(parse(Int, command[3]))[end - 35:end],"")
			for i in 1:length(bitmask)
				if bitmask[i] != "X"
					value[i] = bitmask[i]
				end
			end
			mem[address] = parse(Int,join(value),base=2)
		end

	end
	sum(values(mem))
end

function parttwo(input)
	mem = Dict()
	strmem = Dict()
	bitmask = 0
	for line in input
		command = split(line, " ")
		if command[1] == "mask"
			bitmask = split(command[3],"")
		else
			address = bitstring(parse(Int,match(r"[[:digit:]]+", command[1]).match))[end-35:end]	
			value = parse(Int, command[3])
		
			addresses = ["0"]
			for i in 1:length(bitmask)
				if bitmask[i] == "1"
					addresses .*= "1"
				elseif bitmask[i] == "X"
					addresses = repeat(addresses,2)
					addresses[1:end÷2] .*= "1"
					addresses[end÷2+1:end] .*= "0"
				else
					addresses .*= address[i]
				end
			end
			for i in addresses
				mem[parse(Int,i,base=2)] = value
				strmem[i] = value
			end
		end
	end
	mem
end



input = readlines("input.txt")
writing(input)