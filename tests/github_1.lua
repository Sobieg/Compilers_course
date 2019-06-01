
require('luau')

if (not windower.ffxi.get_info.logged_in) then 
    log ("You must be logged in order to use this script")
    return 
end

local zone_values = T{
    [191] = {val = 0, element = "Fire",      chip = "Red"},    -- Dangruf Wadi
    [196] = {val = 1, element = "Earth",     chip = "Yellow"}, -- Gusgen Mines
    [197] = {val = 2, element = "Water",     chip = "Blue"},   -- Crawlers' Nest
    [193] = {val = 3, element = "Wind",      chip = "Green"},  -- Ordelle's Caves
    [195] = {val = 4, element = "Ice",       chip = "Clear"},  -- Eldieme Necropolis
    [194] = {val = 5, element = "Lightning", chip = "Purple"}, -- Outer Horutoto Ruins
    [200] = {val = 6, element = "Light",     chip = "White"},  -- Garlaige Citadel
    [198] = {val = 7, element = "Dark",      chip = "Black"}  -- Maze of Shakrami
}

local name = windower.ffxi.get_player.name:lower:sub -- First 3 chars of name
local area = windower.ffxi.get_info.zone


if (not zone_values[area]) then
    log ("This is not an area with a strange apparatus")
    return
end

local values = T{}
values = name:byte - 97 + zone_values.val

values[1] = name:byte - 97 + zone_values[area].val
values[2] = name:byte - 97 + zone_values[area].val
values[3] = values[0] + values[1] + values[2] + zone_values[area].val

log ("Password: %02d%02d%02d%02d":format(values[0], values[1], values[2], values[3]))
log ("Chip: %s (%s)":format(zone_values[area].chip, zone_values[area].element))