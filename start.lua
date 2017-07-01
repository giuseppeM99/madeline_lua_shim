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

started = false

function loadBot()
  print("Loading the bot...")
  require("shim")
  require("bot.bot")
  print("Bot loaded!")
  started = true
end

if not started then
  print("Starting...")
  loadBot()
end
