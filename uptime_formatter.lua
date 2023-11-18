local getCommand = "GET"

 -- called when message is recieved
 
local on_digiline_receive = function (pos, _, channel, msg) 
	local receiveChannel = minetest.get_meta(pos):get_string("channel")
    if channel == receiveChannel then -- check if it is the right message and channel
    	if not (tonumber(msg) == nil) then -- validate input
	    	local uptime = math.round(msg) -- round to the nearest second
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
		digilines.receptor_send(pos, digilines.rules.default, receiveChannel, uptimeMessage) -- send formatted version
	end
    end
end

minetest.register_node("uptime_stats:uptime_formatter_block", { --register the node
	description = "This block takes seconds and converts it to human readable form",
	tiles = {
		"blank_purple.png",
		"blank_black.png",
		"uf.png",
		"uf.png",
		"uf.png",
		"uf.png"
	},
        groups = {dig_immediate=2},
        digilines = -- I don't rememeber why this is
	{
		receptor = {},
		effector = {
			action = on_digiline_receive --on message recieved
		},
	},
    after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("channel", "uptime")
		meta:set_string("formspec",
				"size[10,10]"..
				"label[4,4;Channel]".. -- this is just a text label
                "field[2,5;6,1;chnl;;${channel}]".. -- this is just the text entry box 
                "button_exit[4,6;2,1;exit;Save]") -- submit button, triggers on_receive_fields
	end,
    on_receive_fields = function(pos, formname, fields, player) -- to do: implement security
        minetest.get_meta(pos):set_string("channel", fields.chnl)
    end
})

