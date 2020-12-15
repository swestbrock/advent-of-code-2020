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
    Check if password is valid (first half).
]]--
local function check_old_policy(str)
    local is_valid = false
    local str_ = str:gsub(" ","")
    local minmax = str_:match("%d+%p%d+")
    local min = tonumber(minmax:match("%d+%p"):match("%d+"))
    local max = tonumber(minmax:match("%p%d+"):match("%d+"))
    local letter = str_:match("%l%p"):match("%l")
    local pw = str_:match("%p%l+")
    local cnt = 0
    -- Count letter occurance
    for c in pw:gmatch("%l") do
        if c == letter then
            cnt = cnt + 1
        end
    end
    -- Check number of letters
    if cnt >= min then
        if cnt <= max then
            is_valid = true;
        end
    end
    return is_valid
end

local function check_new_policy(str)
    local is_valid = false
    local str_ = str:gsub(" ","")
    local positions = str_:match("%d+%p%d+")
    local pos1 = tonumber(positions:match("%d+%p"):match("%d+"))
    local pos2 = tonumber(positions:match("%p%d+"):match("%d+"))
    local letter = str_:match("%l%p"):match("%l")
    local pw = str_:match("%p%l+"):match("%l+")
    -- Check letter occurance
    if letter:byte() == pw:byte(pos1) and
        letter:byte() ~= pw:byte(pos2) then
        is_valid = true
    elseif letter:byte() ~= pw:byte(pos1) and
        letter:byte() == pw:byte(pos2) then
        is_valid = true
    end
    return is_valid
end

--[[
    Find all valid passwords.
]]--
local function find_valids(array)
    local cnt = 0
    for _,v in ipairs(array) do
        if arg[1] == "-o" then
            if check_old_policy(v) then
                cnt = cnt + 1
            end
        elseif arg[1] == "-n"  then
            if check_new_policy(v) then
                cnt = cnt + 1
            end
        else
            if check_old_policy(v) then
                cnt = cnt + 1
            end
        end
    end
    return cnt
end

io.write("Advent of code 2020 - day 2\n")

local array = get_lines("input.txt")
local number = find_valids(array)

io.write("Found " .. number .. " valid passwords.\n")

os.exit()