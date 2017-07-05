local serpent = require "serpent"

-- for debug
function vardump(...)
  print(serpent.block({...}, {comment=false}))
end

--https://stackoverflow.com/questions/640642/how-do-you-copy-a-lua-table-by-value#641993
function deepcopy(o, seen)
  seen = seen or {}
  if o == nil then return nil end
  if seen[o] then return seen[o] end

  local no
  if type(o) == 'table' then
    no = {}
    seen[o] = no

    for k, v in next, o, nil do
      no[deepcopy(k, seen)] = deepcopy(v, seen)
    end
    setmetatable(no, deepcopy(getmetatable(o), seen))
  else -- number, string, boolean, etc
    no = o
  end
  return no
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
  if not pack then
    pack = {}
  end
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
    pack.participants_count = info.Chat.participants_count
    pack.raw = info.Chat
  elseif info.type == "chat" then
    pack.peer_type = "chat"
    pack.peer_id = info.chat_id
    pack.id = "placeholder"
    pack.title = info.Chat.title
    pack.print_name = pack.title:gsub("%s", "_")
    pack.flags = 1
    pack.access_hash = info.Chat.access_hash
    pack.bot_api_id = info.bot_api_id
    pack.members_count = info.Chat.participants_count
    pack.raw = info.Chat
  elseif info.type == "user" or info.type == "bot" then
    pack.peer_type = "user"
    pack.peer_id = info.user_id
    pack.id = "placeholder"
    pack.phone = info.User.phone
    pack.first_name = info.User.first_name
    pack.last_name = info.User.last_name or nil
    if pack.first_name then
      pack.print_name = pack.last_name and (pack.first_name .. "_".. pack.last_name):gsub("%s", "_") or pack.first_name:gsub("%s", "_")
    end
    pack.flags = 1
    pack.username = info.User.username or nil
    pack.access_hash = info.User.access_hash
    pack.bot_api_id = info.bot_api_id
    pack.raw = info.User
  end

  return pack
end

function packService(info, pack)
  if not pack then
    pack = {}
  end
  print("Handling service message", info._)
  if info._ == "messageActionChatAddUser" then
    pack.type = "chat_add_user"
    pack.users = {}
    for _, v in pairs(info.users) do
      table.insert(pack.users, packInfo(fixfp(get_info(v)), {}))
    end
    pack.user = deepcopy(pack.users[1])
  elseif info._ == "messageActionChatDeleteUser" then
    pack.type = "chat_del_user"
    pack.user = packInfo(fixfp(get_info(info.user_id)), {})
  elseif info._ == "messageActionChatJoinedByLink" then
    pack.type = "chat_add_user_link"
    pack.link_issuer = packInfo(fixfp(get_info(info.inviter_id)), {})
  elseif info._ == "messageActionChatDeletePhoto" then
    pack.type = "chat_delete_photo"
  elseif info._ == "messageActionChatEditPhoto" then
    pack.type = "chat_edit_photo"
  elseif info._ == "messageActionChatCreate" then
    pack.type = "chat_created"
    pack.title = info.title
  elseif info._ == "messageActionChannelCreate" then
    pack.type = "channel_create"
    pack.title = info.title
  elseif info._ == "messageActionChatMigrateTo" then
    pack.type = "migrated_to"
    pack.channel_id = info.channel_id
  elseif info._ == "messageActionChannelMigrateFrom" then
    pack.type = "migrate_from"
    pack.title = info.title
    pack.chat_id = info.chat_id
  elseif info._ == "messageActionPinMessage" then
    pack.type = "pin_message"
  elseif info._ == "messageActionChatEtitTitle" then
    pack.type = "chat_edit_title"
    pack.title = info.title
  end

  return pack
end

function packMedia(media, pack)
  if not pack then
    pack = {}
  end
  if media._ == "messageMediaPhoto" then
    pack.type = "photo"
    pack.caption = media.caption
  elseif media._ == "messageMediaGeo" then
    pack.type = "geo"
    pack.longiture = media.geo.long
    pack.latitude = media.geo.loat
  elseif media._ == "messageMediaContact" then
    pack.type = "contact"
    pack.phone = media.phone_number
    pack.first_name = media.first_name
    pack.last_name = media.last_name
    pack.user_id = media.user_id
  elseif media._ == "messageMediaUnsupported" then
    pack.type = "unsupported"
  elseif media._ == "messageMediaDocument" then
    pack.type = "document"
    pack.caption = media.caption
    if media.document.attributes._ == "documentAttributeVideo" then
      pack.type = "video"
    elseif media.document.attributes._ == "documentAttributeAudio" then
      pack.type = "audio"
    elseif media.document.attributes._ == "documentAttributeSticker" then
      pack.subtype = "sticker"
    elseif media.document.attributes._ == "documentAttributeAnimated" then
      pack.subtype = "gif"
    end
  elseif media._ == "messageMediaWebPage" then
    pack.type = "webpage"
    pack.url = media.webpage.url
    pack.title = media.webpage.title
    pack.description = media.webpage.description
    pack.author = media.webpage.author
  elseif media._ == "messageMediaVenue" then
    pack.type = "venue"
  elseif media._ == "messageMediaGame" then
    pack.type = "game"
  elseif media._ == "messageMediaInvoice" then
    pack.type = "invoice"
    pack.longiture = media.geo.long
    pack.latitude = media.geo.loat
    pack.title = media.title
    pack.address = media.address
    pack.provider = media.provider
    pack.venue_id = media.venue_id
  end

  return pack
end

function parsePwrUser(user)
  if user.type == "bot" then
    user.bot = true
    user.type = "user"
  else
    user.bot = false
  end
  user.peer_id = user.id
  user.peer_type = user.type
  if user.first_name then
    user.print_name = user.last_name and (user.first_name .. "_".. user.last_name):gsub("%s", "_") or user.first_name:gsub("%s", "_")
  end
end

function packMembers(memberlist, users, filter)
  if not filter then
    filer = 1
  end
  if memberlist.error or not memberlist.participants then
    return false
  end
  for _, v in pairs(memberlist.participants) do
    parsePwrUser(v.user)
    v.user.role = v.role
    if filter == 2 then
      if not v.role or v.role ~= "user" then --The method get_pwr_chat returns no role if the user is admin ATM
        table.insert(users, v.user)
      end
    elseif filter == 3 then
      if v.user.bot then
        table.insert(users, v.user)
      end
    else
      table.insert(users, v.user)
    end
  end

  return users
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
  if data.message.action then
    msg.service = true
    msg.action = packService(data.message.action, {})
  end
  if data.message.reply_to_msg_id then
    msg.reply_id = {}
    msg.reply_id.inputPeer = deepcopy(data.message.to_id)
    msg.reply_id.id = data.message.reply_to_msg_id
  end
  if data.message.media then
    msg.media = packMedia(data.message.media, {})
  end
  msg.date = data.message.date
  msg.flags = 1
  return msg
end

function postpone(callback, extra, time)
  table.insert(crons, {time = os.time()+time, callback = callback, extra = extra})
end

function doCrons()
  local ts = os.time()
  for k, v in ipairs(crons) do
    if v.time <= ts then
      v.callback(v.extra)
      table.remove(crons, k)
    end
  end
  lastCron = ts
end


function madeline_update_callback(data)
  if not started then
    on_binlog_replay_end()
    on_our_id(fixfp(get_self().id))
  end
  loadfile("methods.lua")()
  data = fixfp(data)
  print("Got update", data._)
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
