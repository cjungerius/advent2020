instr = readlines("input.txt")

function boot(instr::Array{String})
    repeat = Set()
    pos = 1
    acc = 0
    while true
        if pos > length(instr)
            return (0, acc)
        elseif in(pos,repeat)
            return (pos, acc)
        else 
            push!(repeat,pos)
        end

        if instr[pos][1:3] == "acc"
            acc += Meta.parse(instr[pos][5:end])
            pos += 1
        elseif instr[pos][1:3] == "jmp"
            pos += Meta.parse(instr[pos][5:end])
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