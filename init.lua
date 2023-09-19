 -- print("we are loaded")

 -- called when message is recieved
local on_digiline_receive = function () 
    print("Hello World!")
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
