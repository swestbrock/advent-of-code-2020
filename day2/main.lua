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

local function find_valids(array)
    io.write("dummy\n")
    return 0
end

io.write("Advent of code 2020 - day 2\n")

local array = get_lines("input.txt")
local number = find_valids()

io.write("Found " .. number .. " valid passwords.\n")

os.exit()