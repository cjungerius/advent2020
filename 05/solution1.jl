function seatid(code)
    code = replace(code,r"B|R"=>"1")
    code = replace(code,r"F|L"=>"0")
    parse(Int,code;base=2)
end

function main(args)
    highest = 0
    input = readlines(args[1])
    ids = seatid.(input)
    maximum(ids)
end

println(main(ARGS))