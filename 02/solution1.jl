using BenchmarkTools

function checkline(line::String)
    regex = match(r"(\d+)-(\d+) (\D): (\D+)",line)
    lowerbound, upperbound = parse.(Int,regex.captures[1:2])
    target = regex.captures[3][1]
    password = regex.captures[4]

    lowerbound <= count(i->i==target,password) <= upperbound
end

function main(args)
    validcount = 0
    for line in eachline(ARGS[1])
        validcount += checkline(line)
    end
    return(validcount)
end

#first run
println(main(ARGS))

#second run
@btime main(ARGS)
    