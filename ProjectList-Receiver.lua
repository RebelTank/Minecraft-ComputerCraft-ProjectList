--Program to display list of projects to remote displays (receiver program)
--by RebelTank
--Add screen click functionality for scrolling list. Click to interrupt and resume scroll.
--Multiline list items

rednet.open("right") --Set to the side of the wireless
m = peripheral.wrap("left") --Set to the side of the display
W, H = m.getSize()
line = 1
projects = {}
m.setBackgroundColor(colors.yellow)
m.setTextColor(colors.black)
m.setTextScale(1) --Maybe calculate this based on display size?

m.clear()
m.setCursorPos(1,1)
m.write("Ready and waiting...")

while true do
 --listen for new message
 local sender, msg, dist = rednet.receive()
 
 --parse message
 line = tonumber(string.match(msg, '%d+'))
 projects[line] = msg
 
 --display message
 m.clear()
 m.setCursorPos(1,1)
 m.write("Project List")
 for i = 1, #projects do
  m.setCursorPos(1, i+1)
  m.write(projects[i])
  i = i + 1
 end
end

rednet.close("right")