 local getCommand = "GET"
 local receiveChannel = "" -- not implemented
 
 -- print("we are loaded")

 -- called when message is recieved
 
local on_digiline_receive = function (pos, _, channel, msg) 
    if msg == getCommand then -- check if it is the right message
        -- print("uptime requested")
        local uptimeraw = minetest.get_server_uptime()
        local uptime = math.round(uptimeraw) -- round to the nearest second
        local uptimeMessage = ""
        if uptime < 60 then
            uptimeMessage = "Up "..uptime.." second(s)"
        elseif uptime < 3600 then
            uptimeMessage = "Up "..(math.round(uptime/60)).." minute(s)"
        elseif uptime < 86400 then
            uptimeMessage = "Up "..(math.round(uptime/3600)).." hour(s)"
        else
            uptimeMessage = "Up "..(math.round(uptime/86400)).." day(s)"
        end
        digilines.receptor_send(pos, digilines.rules.default, channel, uptimeMessage)
    end
end

minetest.register_node("uptime_stats:stat_block", {
	description = "This is a block to get server uptime",
	tiles = {
		"node.png",
		"node.png",
		"node.png",
		"node.png",
		"node.png",
		"node.png"
	},
        groups = {dig_immediate=2},
        digilines =
	{
		receptor = {},
		effector = {
			action = on_digiline_receive
		},
	},
})
