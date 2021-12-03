input = readlines("input.txt")
input = split(input[2],',')
divisors = [parse(Int,input[1])]
remainders = [0]

for i in 2:length(input)
	if !contains(input[i],'x')
		push!(divisors,parse(Int,input[i]))
		push!(remainders,parse(Int,input[i]) - (i-1)%parse(Int,input[i]))
	end
end


function findminx(num,rem)
	p = prod(num)
	result = 0
	for i in 1:length(num)
		pp = p ÷ num[i]
		result = result + rem[i] * invmod(pp,num[i]) * pp
	end
	return result % p
end
