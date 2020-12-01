function expenses(input)
    ascending = sort(input)
    numbers = Set(ascending)

    for (i,n) in enumerate(ascending)
        diff = 2020-n
        if diff <= n && ascending[i+1] != diff
            break
        end
        if in(diff, numbers)
            return (n*diff)
        end
    end
end

    


f = open(ARGS[1]);
input = parse.(Int64,readlines(f))
close(f)
@time println(expenses(input))

