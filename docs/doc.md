# Block docs
## Time block
- This block sends the current UNIX time in seconds when when "GET" is received on the set channel
## Uptime block
- This block sends the game server uptime when GET is recieved
## Players block
- This sends a space separated list of active players when GET is received
## Position Block
- This takes either a single player name or a list of names space separated and responds with the coordinates of each space seperated
## Time Formater
- This takes in seconds and responds with a formatted string based on the format specifer
- See https://www.foragoodstrftime.com as a reference (Format specifier is from c and c++)
## Uptime formater
- This returns a human friendly uptime message. (Example: "up 4 days")

# Brief wiring guide
- For digilines to work they need to be on the same channel. This can be accomplished by setting all of the channels to the same string
- Make sure you wire up each block in a sequence (not parallel) as it won't work if they are all on the same line (See below)
![good](/docs/good.png)
![bad](/docs/bad.png)
