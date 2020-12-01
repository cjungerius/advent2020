function expenses(input)
    E = input .+ transpose(input)
    idx = findall(x->x==2020, E)[1]
    input[idx[1]] * input[idx[2]]
end

f = open(ARGS[1]);
input = parse.(Int64,readlines(f))
close(f)
println(expenses(input))

