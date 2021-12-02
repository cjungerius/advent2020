using DelimitedFiles

input = readlines("input.txt")
max_x = length(input[1])
max_y = length(input)
 
function surround(state,(a, b)::Tuple{Int,Int})
    neighbors = []
    for (x ,y) in [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]
            xoffset = copy(x)
            yoffset = copy(y)
            while true
                if haskey(state,(a+xoffset,b+yoffset))
                    push!(neighbors, (a+xoffset,b+yoffset))
                    break
                elseif a+xoffset < 1 || a+xoffset > max_x || b+yoffset < 1 || b+yoffset > max_y 
                    push!(neighbors, (a+xoffset, b+yoffset))
                    break
                else
                    xoffset += x
                    yoffset += y
                end

            end
        end
    return (neighbors)
end

function seats(input)
    
    state = Dict{Tuple{Int,Int},Bool}()
    for (j::Int, line::String) in enumerate(input), i in 1:length(line)
        if line[i] == 'L'
            state[(i, j)] = false
        end
    end
    
    nextstate = copy(state)
    while true
        for key in keys(state)
            if state[key] == false
                nextstate[key] = !any([get(state, i, false) for i in surround(state, key)])
            elseif state[key] == true
                nextstate[key] = !(sum([get(state, i, false) for i in surround(state, key)]) ≥ 5)
            end
        end

        if nextstate == state
            break
        else
            state = copy(nextstate)
        end
    end

    sum(values(state))
end
