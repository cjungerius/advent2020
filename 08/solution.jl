using DataStructures

function boot(instr::Array{String})
    repeat = Set()
    pos = 1
    acc = 0
    while true
        if pos > length(instr)
            return (0, acc)
        elseif in(pos, repeat)
            return (pos, acc)
        else 
            push!(repeat, pos)
        end

        if instr[pos][1:3] == "acc"
            acc += parse(Int, instr[pos][5:end])
            pos += 1
        elseif instr[pos][1:3] == "jmp"
            pos += parse(Int, instr[pos][5:end])
        else
            pos += 1
        end
    end
end


function fixedboot(instr)
    jmpornop = findall(instr) do line
        occursin(r"(jmp|nop)", line)
    end

    for i in jmpornop
        println(i)
        if instr[i][1:3] == "jmp"
            instr[i] = replace(instr[i], "jmp" => "nop")
            code, acc = boot(instr)
            if code == 0
                return acc
                break
            end
            instr[i] = replace(instr[i], "nop" => "jmp")
        else
            instr[i] = replace(instr[i], "nop" => "jmp")
            code, acc = boot(instr)
            if code == 0
                return acc
                break
            end
            instr[i] = replace(instr[i], "jmp" => "nop")
        end

    end
end

function smartfix(instr::Array{String})
    #the fancy (read: overcomplicated, but not brute force) way to solve part 2: FUN WITH GRAPHS

    #forward graph: where does every node point to? We also populate our list of switching points, and note where they *would* point to if changed
        forward = zeros(Int, length(instr))
        switch = []
        for (i, line) in enumerate(instr)
            if line[1:3] == "jmp"
                forward[i] = i + parse(Int, line[5:end])
                push!(switch,[i,i+1])
            elseif line[1:3] == "nop"
                forward[i] = i + 1
                push!(switch,[i,i+parse(Int, line[5:end])])
            else
                forward[i] = i + 1
            end
        end
    
    #backward graph: where is each node being pointed at from?
        backward = []
        for i = 1:length(forward) + 1
            push!(backward, findall(x -> x == i, forward))
        end
    
    #time to see which nodes are reachable with BFS:
    
        q = Queue{Int}()
    
    #from the start (note: only one neighbor per node so no iteration needed there)
        enqueue!(q,1)
        startspan = Set(1)
        while !isempty(q)
            node = dequeue!(q)
            if !in(forward[node], startspan)
                push!(startspan, forward[node])
                enqueue!(q, forward[node])
            end
        end
    
    #and which nodes can reach the end (note: now multiple nodes can point at the same so we iterate through the neighbors)
        enqueue!(q,length(backward))
        endspan = Set(length(backward))
        while !isempty(q)
            node = dequeue!(q)
            for neighbor in backward[node]
                if !in(neighbor, endspan)
                    push!(endspan, neighbor)
                    enqueue!(q, neighbor)
                end
            end
        end
    
    #now: which node is reachable from the start, AND would reach a member of the 'end span' if it switched from ("jmp"|"nop") to ("nop"|"jmp")?
        solution = findfirst(switch) do pair
            in(pair[1], startspan) && in(pair[2], endspan)
        end
        
        #now we change the command and run the amended code!
            cmds = ["jmp","nop"]
            idx = switch[solution][1]
            instr[idx] = replace(instr[idx],cmds[occursin.(cmds,instr[idx])][1] => cmds[.!occursin.(cmds,instr[idx])][1])
            boot(instr) #calls the function that actually runs the instruction
    end


function main()
    instr = readlines("input.txt")
    boot(instr)
    smartfix(instr)
end