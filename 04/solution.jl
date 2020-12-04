using BenchmarkTools

function validation(field, value)
    test = Dict(
        [
            (
                "byr", 
                function(value)
                    x = tryparse(Int, value)
                    if !isnothing(x)
                        return 1920 <= x <= 2002
                    else
                        return false
                    end
                end
            ),
            (
                "iyr",
                function(value)
                    x = tryparse(Int, value)
                    if !isnothing(x)
                        return 2010 <= x <= 2020
                    else
                        return false
                    end
                end
            ),
            (
                "eyr",
                function(value)
                    x = tryparse(Int, value)
                    if !isnothing(x)
                        return 2020 <= x <= 2030
                    else
                        return false
                    end
                end           
            ),
            (
                "hgt",
                function(value)
                    m = match(r"^(\d+)(cm|in)$",value)
                    if !isnothing(m)
                        if m.captures[2] == "cm"
                            return 150 <= parse(Int,m.captures[1]) <= 193
                        else
                            return 59 <= parse(Int,m.captures[1]) <= 76
                        end
                    else
                        return false
                    end
                end
            ),
            (
                "hcl",
                function(value)
                    return occursin(r"^#[0-9|a-f]{6}$",value)
                end
            ),
            (
                "ecl",
                function(value)
                    return occursin(r"^amb$|^blu$|^brn$|^gry$|^grn$|^hzl$|^oth$",value)
                end
            ),
            (
                "pid",
                function(value)
                    return occursin(r"^\d{9}$",value)
                end
            )
        ]
    )

    if test[field](value)
        return field
    else
        return "invalid $field"
    end
end



function main(args)

    fields = Set(["byr","iyr","eyr","hgt","hcl","ecl","pid"])
    input = args[1]
    validfieldsone = Set()
    validfieldstwo = Set()

    validone = 0
    validtwo = 0

    for line in eachline(input)
        if length(line) > 0
            for match in eachmatch(r"([a-z]+)\:(\S+)",line)
                if in(match.captures[1], fields)
                    push!(validfieldsone, match.captures[1])
                    push!(validfieldstwo, validation(match.captures[1], match.captures[2]))
                end
            end
        else
            if validfieldsone == fields
                validone += 1
            end
            if validfieldstwo == fields
                validtwo += 1
            end
            empty!(validfieldsone)
            empty!(validfieldstwo)
        end
    end

    #check last field
    if length(validfieldsone) == 7 && all(in.(validfieldsone, Ref(fields)))
        validone += 1
    end
    if length(validfieldstwo) == 7 && all(in.(validfieldstwo, Ref(fields)))
        validtwo += 1
    end

(validone,validtwo)
end

println(main(ARGS))

@btime(main(ARGS))