local getCommand = "GET"


local on_digiline_receive = function (pos, _, channel, msg) 
	local receiveChannel = minetest.get_meta(pos):get_string("channel")
    if channel == receiveChannel and msg == getCommand then -- check if it is the right message and channel
        digilines.receptor_send(pos, digilines.rules.default, receiveChannel, os.time()) -- send time
    end
end


minetest.register_node("uptime_stats:time_block", { --register the node
	description = "This block gets current time in seconds",
	tiles = {
		"blank_black.png",
		"blank_black.png",
		"time.png",
		"time.png",
		"time.png",
		"time.png"
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

