function main(args)

    f = open(args[1]);
    input = parse.(Int64,readlines(f))
    close(f)

    n = length(input)
    M = zeros((n,n,n))
    for i = 1:n
        for j = 1:n
            for k = 1:n
                M[i,j,k] = input[i] + input[j] + input[k]
            end
        end
    end

    idx = findall(x->x==2020,M)[1]
    solution = input[idx[1]] * input[idx[2]] * input[idx[3]]
    println(solution)
end

main(ARGS)

    