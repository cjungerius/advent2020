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

function navigationwaypoint(input)
    x = 0
    y = 0
    wx = 10
    wy = 1
    for line in input
        value = parse(Int,line[2:end])
        if line[1]=='F'
            x += wx*value
            y += wy*value
        elseif line[1]=='N'
            wy += value
        elseif line[1]=='S'
            wy -= value
        elseif line[1]=='W'
            wx -= value
        elseif line[1]=='E'
            wx += value
        elseif line[1]=='L'
            angle = deg2rad(value)
            wx, wy = cos(angle)*wx - sin(angle)*wy, sin(angle)*wx + cos(angle)*wy
        elseif line[1]=='R'
            angle = 2*pi - deg2rad(value)
            wx, wy = cos(angle)*wx - sin(angle)*wy, sin(angle)*wx + cos(angle)*wy
        end
    end
    abs(x) + abs(y)
end
input = readlines("input.txt")
navigation(input)
navigationwaypoint(input)