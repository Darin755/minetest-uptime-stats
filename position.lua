local on_digiline_receive = function (pos, _, channel, msg) 
	local receiveChannel = minetest.get_meta(pos):get_string("channel")
    if (type(msg) == "string") and (channel == receiveChannel) then -- check if it is the right message and channel
    	local players = {}
    	local string = ""
    	for w in msg:gmatch("%w+") do
    		table.insert(players, w)
    	end
    	for _, playerName in ipairs(players) do 
        	string = string.." "..tostring(get_playerpos(playerName))
	end
	digilines.receptor_send(pos, digilines.rules.default, receiveChannel, string) -- send position of player msg
    end
end


minetest.register_node("stats:position_block", { --register the node
	description = "This block gets a players position from a players name",
	tiles = {
		"stats_white.png",
		"stats_white.png",
		"stats_pos.png",
		"stats_pos.png",
		"stats_pos.png",
		"stats_pos.png"
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
		meta:set_string("channel", "")
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


--gets player's current position when function is called
function get_playerpos(player)
	local playerobj = minetest.get_player_by_name(player)
	if playerobj then
		return vector.round(playerobj:get_pos())
	else 
		return "not found"
	end
end

