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
    Check if password is valid.
]]--
local function check_valid(str)
    local is_valid = false
    local str_ = str:gsub(" ","")
    local minmax = str_:match("%d+%p%d+")
    local min = minmax:match("%d+%p")
    local max = minmax:match("%p%d+")
    local letter = str_:match("%l%p")
    local pw = str_:match("%p%l+")
    local cnt = 0
    -- Count letter occurance
    for c in pw:gmatch("%l") do
        if c == letter:match("%l") then
            cnt = cnt + 1
        end
    end
    -- Check number of letters
    if cnt >= tonumber(min:match("%d+")) then
        if cnt <= tonumber(max:match("%d+")) then
            is_valid = true;
        end
    end
    return is_valid
end

--[[
    Find all valid passwords.
]]--
local function find_valids(array)
    local cnt = 0
    for _,v in ipairs(array) do
        if check_valid(v) then
            cnt = cnt + 1
        end
    end
    return cnt
end

io.write("Advent of code 2020 - day 2\n")

local array = get_lines("input.txt")
local number = find_valids(array)

io.write("Found " .. number .. " valid passwords.\n")

os.exit()