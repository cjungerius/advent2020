function navigation(input)
    x = 0
    y = 0
    r = 0
    for line in input
        value = parse(Int,line[2:end])
        if line[1]=='F'
            x += cos(deg2rad(r))*value
            y -= sin(deg2rad(r))*value
        elseif line[1]=='N'
            y += value
        elseif line[1]=='S'
            y -= value
        elseif line[1]=='W'
            x -= value
        elseif line[1]=='E'
            x += value
        elseif line[1]=='L'
            r -= value
        elseif line[1]=='R'
            r += value
        end
    end
    abs(x)+abs(y)
end

input = readlines(ARGS[1])
println(navigation(input))