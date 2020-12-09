using DelimitedFiles
using Base.Iterators

input = readdlm("input.txt", Int)

function xmas(input::Array{Int})
    preamble = 25::Int
    test = Set{Int}()
    for (i, val) in zip(countfrom(preamble+1),input[preamble+1:end])
        empty!(test)
        for preval in input[i - preamble:i - 1]
            if !in(val - preval, test)
                push!(test, preval)
            elseif val - preval ≠ preval
                continue
            end
        end
        if length(test) == preamble
            return val
        end
    end
    return 0
end

function contiguous(input)
    target = xmas(input)
    for i in 1:length(input)
        arr = empty([],Int)
        next = i+1
        while sum(arr) ≤ target
            if sum(arr) == target
                return minimum(arr) + maximum(arr)
            else
                push!(arr,input[next])
                next += 1
            end
        end
    end
end


        

