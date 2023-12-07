local getCommand = "GET"

 -- called when message is recieved
 
local on_digiline_receive = function (pos, _, channel, msg) 
	local receiveChannel = minetest.get_meta(pos):get_string("channel")
	local formatString = minetest.get_meta(pos):get_string("formatString")
  local timeZone = minetest.get_meta(pos):get_string("timeZone")
    if channel == receiveChannel then -- check if it is the right message and channel
    	if not (tonumber(msg) == nil) then -- validate input for the actual seconds
	    	local time = math.round(msg) -- round to the nearest second
        local adjustment = tonumber(timeZone)
        if (adjustment ~= nil) then
          time = time + (adjustment * 3600)
        end
    local timeMessage = processString(formatString, tonumber(time))
		digilines.receptor_send(pos, digilines.rules.default, receiveChannel, timeMessage) -- send formatted version
      end
    end
end

minetest.register_node(":stats:time_formatter_block", { --register the node
	description = "This block takes UNIX time in seconds and converts it to human readable form with the format spec",
	tiles = {
		"stats_brown.png",
		"stats_black.png",
		"stats_tf.png",
		"stats_tf.png",
		"stats_tf.png",
		"stats_tf.png"
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
		meta:set_string("formatString", "%H:%M")
    meta:set_string("timeZone", "0")
		meta:set_string("formspec",
				"size[10,10]"..
				"label[4,2;Channel]".. -- this is just a text label
                "field[2,3;6,1;chnl;;${channel}]".. -- this is just the text entry box 
                		"label[4,4;format string]".. -- this is just a text label
                "field[2,5;6,1;formatString;;${formatString}]".. -- this is just the format string
                    "label[4,6;timeZone]".. -- Label for the time zone.
                "field[2,7;6,1;timeZone;;${timeZone}]"..
                "button_exit[4,8;2,1;exit;Save]") -- submit button, triggers on_receive_fields
	end,
    on_receive_fields = function(pos, formname, fields, player) -- to do: implement security
        minetest.get_meta(pos):set_string("channel", fields.chnl)
        minetest.get_meta(pos):set_string("formatString", fields.formatString)
        minetest.get_meta(pos):set_string("timeZone", fields.timeZone)
    end
})

function processString(formatString, inputTime)   -- format specifer followed by seconds
	return os.date(formatString, inputTime)
end
