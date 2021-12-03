function test(input, n)
	number = 0
	next = 0
	said = Dict()

	for i in 1:n
	number = next
		if i < length(input)
			said[input[i]] = i
			next = input[i + 1]
		elseif !haskey(said, number)
			said[number] = i
			next = 0
		else
			
			next = i - said[number]
			said[number] = i
		end
	end
	number
end

