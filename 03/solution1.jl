using BenchmarkTools

function main(args)
    trees = 0
    x=1
    for line in eachline(args[1])

        if line[x] == '#'
            trees += 1
        end

        x += 3
        if x > length(line)
            x -= length(line)
        end

    end
    trees
end

println(main(ARGS))

@btime main(ARGS)
