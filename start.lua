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

function loadBot()
  started = false
  crons = {}
  lastCron = os.time()
  print("Loading the bot...")
  loadfile("shim.lua")()
  loadfile("bot/bot.lua")()
  print("Bot loaded!")
end

--Loading initial values
started = false
crons = {}
lastCron = os.time()

if not started then
  print("Starting...")
  loadBot()
end
