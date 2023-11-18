local getCommand = "GET"

 -- called when message is recieved
 
local on_digiline_receive = function (pos, _, channel, msg) 
	local receiveChannel = minetest.get_meta(pos):get_string("channel")
    if channel == receiveChannel then -- check if it is the right message and channel
    	if not (tonumber(msg) == nil) then -- validate input
	    	local time = math.round(msg) -- round to the nearest second
		local timeMessage = ""
		--this is where the formatted time string will go
		--incoming: time, return: timeMessage
		digilines.receptor_send(pos, digilines.rules.default, receiveChannel, timeMessage) -- send formatted version
	end
    end
end

minetest.register_node("uptime_stats:time_formatter_block", { --register the node
	description = "This block takes UNIX time in seconds and converts it to human readable form",
	tiles = {
		"blank_brown.png",
		"blank_black.png",
		"tf.png",
		"tf.png",
		"tf.png",
		"tf.png"
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

