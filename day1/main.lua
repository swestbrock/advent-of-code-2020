#!/usr/bin/lua5.3

--[[
    Get all lines from file.
]]--
local function get_lines(input)
    local file = io.open(input,"r")
    local lines = {}
    if file then
        local i = 1
        for line in file:lines() do
            lines[i] = line
            i = i + 1
        end
        io.close(file)
    end
    return lines
end

--[[
    Find pair which results in 2020.
]]--
local function find_pair(array)
    local index = 1
    local x = array[1]
    while index <= #array do
        for i = index, #array do
            if ( x + array[i] == 2020 ) then
                local pair = {x, array[i]}
                return pair
            end
        end
        x = array[index]
        index = index + 1
    end
    return nil
end

io.write("Advent of code 2020 - day 1\n")

local array = get_lines("input.txt")
local pair = find_pair(array)

io.write("Found both numbers " .. pair[1] .. " and " .. pair[2] .. " which sum to 2020.\n")
io.write("Puzzle answer is " .. pair[1] * pair[2] .. "\n")

os.exit()