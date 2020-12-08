instr = readlines("input.txt")

function boot(instr::Array{String})
    repeat = zeros(Int, length(instr))
    pos = 1
    acc = 0
    while true
        if pos > length(repeat)
            return (0, acc)
        elseif repeat[pos] == 1
            return (pos, acc)
        else 
            repeat[pos] = 1
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
end

jumpornop = findall(instr) do line
    occursin(r"(jmp|nop)", line)
end

for i in jumpornop
    if instr[i][1:3] == "jmp"
        instr[i] = replace(instr[i],"jmp" => "nop")
        code, acc = boot(instr)
        if code == 0
            println(acc)
            break
        end
        instr[i] = replace(instr[i],"nop" => "jmp")
    else
        instr[i] = replace(instr[i],"nop" => "jmp")
        code, acc = boot(instr)
        if code == 0
            println(acc)
            break
        end
        instr[i] = replace(instr[i],"jmp" => "nop")
    end

end