function seatid(code)
    code = replace(code,r"B|R"=>"1")
    code = replace(code,r"F|L"=>"0")
    row = parse(Int,code[1:7];base=2)
    col = parse(Int,code[8:end];base=2)
    row*8+col
end

function main(args)
    highest = 0
    for line in eachline("input.txt")
        highest = max(highest,seatid(line))
    end
    println(highest)
end

main(ARGS)