function print(...) --just to put a \n at the end :D
  local ar = {...}
  for _, v in ipairs(ar) do
    if (type(v) == "string") then
      io.write(v)
      io.write(" ")
    elseif (type(v) == "number" or type(v) == "boolean") then
      io.write(tostring(v))
      io.write(" ")
    else
      io.write(type(v))
      io.write(" ")
    end
  end
  io.write("\n")
end

methodsPath = "methods.lua"

function loadBot()
  started = false
  package.loaded = nil
  crons = {}
  print("Loading the bot...")
  loadfile("shim.lua")()
  _methods = loadfile(methodsPath)
  if not  io.open("bot/bot.lua") then
    loadfile("bot/_bot.lua")()
  else
    loadfile("bot/bot.lua")()
  end
  print("Bot loaded!")
end

--Loading initial values
started = false
crons = {}
if os.execute("mediainfo -h") then
  useMediaInfo = true
  mediainfo = loadfile("mediainfo.lua")()
end
if not started then
  print("Starting...")
  loadBot()
end
