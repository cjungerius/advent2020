function validation(field, value)
fields = Dict(
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
                m = match(r"^#[0-9|a-f]{6}$",value)
                return !isnothing(m)
            end
        ),
        (
            "ecl",
            function(value)
                m = match(r"^amb$|^blu$|^brn$|^gry$|^grn$|^hzl$|^oth$",value)
                return !isnothing(m)
            end
        ),
        (
            "pid",
            function(value)
                m = match(r"^\d{9}$",value)
                return !isnothing(m)
            end
        )
    ]
)

fields[field](value)
end



function main(args)

    input = args[1]
    fieldn = 0
    valid = 0

    for line in eachline(input)
        if length(line) > 0
            for match in eachmatch(r"([a-z]+)\:(\S+)",line)
                if in(match.captures[1], fields)
                    fieldn += validation(match.captures[1], match.captures[2])
                end
            end
        else
            if fieldn == 7
                valid += 1
            end
            fieldn = 0
        end
    end

    #check last field
    if fieldn == 7
        valid += 1
    end

valid
end

println(main(ARGS))