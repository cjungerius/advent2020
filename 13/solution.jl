function shortestwait(input)
    timestamp = parse(Int,input[1])

    buses = split(input[2],',')
    filter!(i->!contains(i,'x'),buses)
    buses = parse.(Int,buses)

    wait = buses .- timestamp.%buses

    wait[argmin(wait)]*buses[argmin(wait)]
end


input = readlines("input.txt")
shortestwait(input)