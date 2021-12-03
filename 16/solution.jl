function validation(input)
	valid = Set()
	invalid = []
	for i in 1:20
		line = input[i]
		numbers = collect(eachmatch(r"[[:digit:]]+",line))
		
		for i in 1:2:4		
			push!(valid,parse(Int,numbers[i].match):parse(Int,numbers[i+1].match)...)
		end
	end

	for i in 26:length(input)
		line = split(input[i],",")
		numbers = parse.(Int,line)
		for number in numbers
			if !(number in valid)
				push!(invalid,number)
			end
		end
	end
sum(invalid)
end

input = readlines("input.txt")
validation(input)