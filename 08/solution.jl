instr = readlines("input.txt")
repeat = zeros(Int,length(instr))


let pos = 1, acc = 0
    while true
        if repeat[pos] == 1
            break
        else repeat[pos] = 1
        end

        if instr[pos][1:3] == "acc"
            acc += eval(Meta.parse(instr[pos][5:end]))
            pos += 1
        elseif instr[pos][1:3] == "jmp"
            pos += eval(Meta.parse(instr[pos][5:end]))
        else
            pos += 1
        end
    end

    println(acc)
end
