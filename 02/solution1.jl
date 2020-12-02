function checkline(line::String)
    lowerbound, upperbound = parse.(Int64,match(r"(\d+)-(\d+)",line).captures)
    target = match(r"(\D):",line).captures[1][1]
    password = match(r": (\D+)",line).captures[1]

    if lowerbound <= count(i->i==target,password) <= upperbound
        return 1
    else
        return 0
    end
end

function main(args)
    validcount = 0
    for line in eachline(ARGS[1])
        validcount += checkline(line)
    end
    println(validcount)
end

#first run
main(ARGS)

#second run
@time main(ARGS)
    