#using BenchmarkTools

function main(args)

    input = read(args[1], String)
    input = split(input, "\n\n")
    

# solution to part 1

    let total = 0
        for group in input
	total += sum(isletter.(unique(group)))
        end
	println("answer to part 1: ", total)
    end

# solution to part 2

    input2 = split.(input, "\n", keepempty=false)

    let total = 0
        for group in input2
		for answer in unique(group[1])
			total += all(any.(x -> x == answer, group))
			
		end
	end
	println("answer to part 2: ", total)
    end

end

main(ARGS)

#@btime(main(ARGS))