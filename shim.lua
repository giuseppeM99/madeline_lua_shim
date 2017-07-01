local serpent = require "serpent"

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

-- for debug
function vardump(...)
  print(serpent.block({...}, {comment=false}))
end

-- in Lua 5.3 numbers are passed as double, even if they are integers (using lua_pushnumber form the Lua C API)
function fixfp(data)
 if tonumber(_VERSION:match("%d+%.%d+")) < 5.3 then
   return data
 end
 if type(data) == "number" then
   return math.ceil(data) == data and math.ceil(data) or data
 end
 if type(data) == "table" then
   for k, v in pairs(data) do
     if type(v) == "number" then
       data[k] = fixfp(v)
     end
     if type(v) == "table" then
       fixfp(v)
     end
   end
 end
 return data
end

-- Pack infos from the madeline function get_info in a tg-cli like object
function packInfo(info, pack)
  if info.type == "channel" or info.type == "supergroup" then
    pack.peer_type = "channel"
    pack.peer_id = info.channel_id
    pack.id = "placeholder"
    pack.megagroup = info.Chat.megagroup
    pack.title = info.Chat.title
    pack.print_name = pack.title:gsub("%s", "_")
    pack.flags = 1
    pack.username = info.Chat.username
    pack.access_hash = info.Chat.access_hash
    pack.bot_api_id = info.bot_api_id
    pack.raw = info.Chat
  elseif info.type == "chat" then
    pack.peer_type = "chat"
    pack.peer_id = info.channel_id
    pack.id = "placeholder"
    pack.title = info.Chat.title
    pack.print_name = pack.title:gsub("%s", "_")
    pack.flags = 1
    pack.access_hash = info.Chat.access_hash
    pack.bot_api_id = info.bot_api_id
    pack.raw = info.Chat
  elseif info.type == "user" or info.type == "bot" then
    pack.peer_type = "user"
    pack.peer_id = info.user_id
    pack.id = "placeholder"
    pack.first_name = info.User.first_name
    pack.last_name = info.User.last_name or nil
    pack.print_name = pack.last_name and (pack.first_name .. "_".. pack.last_name):gsub("%s", "_") or pack.first_name:gsub("%s", "_")
    pack.flags = 1
    pack.username = info.User.username or nil
    pack.access_hash = info.User.access_hash
    pack.bot_api_id = info.bot_api_id
    pack.raw = info.User
  end
  return pack
end

-- Create the tg-cli style msg object
function tgmsg(data)
  msg = {}
  msg.to = {}
  msg.from = {}
  packInfo(fixfp(get_info(data.message.to_id)), msg.to)
  if data.message.from_id then
    packInfo(fixfp(get_info(data.message.from_id)), msg.from)
  else
    msg.from = msg.to
  end
  if data.message.fwd_from then
    msg.fwd_date = data.message.fwd_from.date
    msg.fwd_from = {}
    packInfo(fixfp(get_info(data.message.fwd_from.channel_id or data.message.fwd_from.from_id, msg.fwd_from)))
  end
  msg.text = data.message.message
  msg.out = data.message.out
  msg.message_id = data.message.id
  msg.id = {inputPeer = data.message.to_id, message_id = data.message.id}
  msg.service = false
  msg.date = data.message.date
  msg.flags = 1
  return msg
end



function madeline_update_callback(data)
  require "methods"
  data = fixfp(data)
  if data._ == "updateChannel" then
    --retrive channel info, parse and call on_channel_update
  end
  if data._ == "updateNewChannelMessage" or data._ == "updateNewMessage" then
    local msg = tgmsg(data)
    if msg then
      on_msg_receive(msg)
    end
  end
end
