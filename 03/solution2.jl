using BenchmarkTools

function treecounter(slope, (xstep,ystep))
    trees = 0
    y=1
    x=1
    width = length(slope[1])

    while y <= length(slope)        

        if slope[y][x] == '#'
            trees += 1
        end
        
        x += xstep
        y += ystep

        if x > width
            x -= width
        end

    end
    trees
end

function main(args)
    slope = readlines(args[1])    
    steps = [(1,1), (3,1), (5,1), (7,1), (1,2)]    
    trees = [treecounter(slope, step) for step in steps]
    reduce(*, trees)
end

println(main(ARGS))

@btime main(ARGS)
