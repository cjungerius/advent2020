using DelimitedFiles

function tribonacci(n)
    if 0 ≤ n ≤ 2
        return 0
    elseif n == 3
        return 1
    else
        return tribonacci(n-1) + tribonacci(n-2) + tribonacci(n-3)
    end
end

function partone(input)
    push!(input,0,maximum(input)+3)
    sort!(input)
    differences = zeros(Int,length(input)-1)
    for i in 1:length(differences)
        differences[i] = input[i+1] - input[i]
    end
    onejolt = count(==(1),differences)
    threejolts  = count(==(3), differences)
    return differences
end

function parttwo()
    input = vec(readdlm("input.txt",Int))
    differences = partone(input)
    counter = 3
    paths = []
    for difference in differences
        if difference == 1
            counter += 1
        elseif difference == 3
                push!(paths, counter)
            counter = 3
        end
    end
    combinations = tribonacci.(paths)
    reduce(*,combinations)
end

function parttwodict()
    paths = Dict([0=>1])
    input = vec(readdlm("input.txt",Int))
    sort!(input)
    for i in input
        val = 0
        if in(i-3,keys(paths))
        val += paths[i-3]
        end
        if in(i-2, keys(paths))
        val += paths[i-2]
        end
        if in(i-1,keys(paths))
        val += paths[i-1]
        end
        paths[i] = val
        end
    paths[maximum(input)]
    end


