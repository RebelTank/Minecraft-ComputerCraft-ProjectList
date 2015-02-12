--Program to display list of projects to remote displays
--by RebelTank

rednet.open("left") --Change to side of wireless
projects = {}
h = fs.open("projectlist.txt", "r")
i = 1

--Add info option if "?" entered.

--write file to array
if h then
 row = h.readLine()
end

while row do
 projects[i] = row
 i = i + 1
 row = h.readLine()
end

if h then
 h.close()
end

--Modify given line
function upadeLine()
 print("Enter line to change. ")
 line = io.read()
 
 print("What should it say? ")
 text = io.read()
 
 projects[tonumber(line)] = line..". "..text
end

--Clear given line
function clearLine()
 print("Enter line to clear. ")
 line = io.read()
 
 projects[tonumber(line)] = line.."."
end

--Refresh all screens and file
function refresh()
 h = fs.open("projectlist.txt", "w")
 
 --broadcast array to boards and print to file
 for i = 1, #projects do
  rednet.broadcast(projects[i])
  h.writeLine(projects[i])
 end
 
 h.close()
end

sleep(5)
refresh()

--Run the menu
while true do
 term.clear()
 term.setCursorPos(1,1)
 print("Menu")
 print("1. Add or change a line.")
 print("2. Clear a line.")
 print("(Enter to refresh screens.)")
 ans = tonumber(io.read())
 
 if ans == 1 then
  updateLine()
 elseif ans == 2 then
  clearLine()
 end
 
 refresh()
end