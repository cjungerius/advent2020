function checkline(line::String)
    firstidx, secondidx = parse.(Int64,match(r"(\d+)-(\d+)",line).captures)
    target = match(r"(\D):",line).captures[1][1]
    password = match(r": (\D+)",line).captures[1]
    if firstidx > length(password)
        return 0
    end
    if secondidx > length(password)
        return password[firstidx] == target
    end
    xor(password[firstidx]==target, password[secondidx]==target)
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
    