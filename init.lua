local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)

--uptime block
dofile(path.."/uptime.lua") -- uptime block
dofile(path.."/time.lua") -- time block
dofile(path.."/uptime_formatter.lua") -- uptime formatter block
dofile(path.."/time_formatter.lua") -- time formatter block
dofile(path.."/position.lua") -- position block
dofile(path.."/getplayers.lua") -- lists players
