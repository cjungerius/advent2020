using DelimitedFiles

function surround((a, b)::Tuple{Int,Int})
    return ([(a - 1, b - 1),(a, b - 1),(a + 1, b - 1),(a - 1, b),(a + 1, b),(a - 1, b + 1),(a, b + 1),(a + 1, b + 1)])
end

input = readlines("input.txt")
max_x = length(input[1])
max_y = length(input)

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
                nextstate[key] = !any([get(state, i, false) for i in surround(key)])
            elseif state[key] == true
                nextstate[key] = !(sum([get(state, i, false) for i in surround((key))]) ≥ 4)
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

#graph of each seat's neighbors for pt 2?