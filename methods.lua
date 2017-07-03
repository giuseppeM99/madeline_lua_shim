--[[ //Base function
function (..., callback, extra)
  local res = madeline.method(...)
  if res or res.error then
    if res == {} then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end
]]

mimetype = require "mimetype"

resolve_username_madeline = resolve_username

function resolve_username(username, callback, extra)
  local res = fixfp(get_info(username))
  if res then
    if res == {} or res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, packInfo(res, {}))
  end
  return false, callback(extra, false, false)
end

function chat_info(input, callback, extra)
  local res = fixfp(get_info(input))
  if res then
    if res == {} or res.error or not res.type == "chat" then
      return false, callback(extra, false, res)
    end
    local res = packInfo(res, {})
    res.members = packMembers(fixfp(get_pwr_chat(input)), {}, 1)
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function channel_info(input, callback, extra)
  local res = fixfp(get_info(input))
  if res then
    if res == {} or res.error or not res.type == "channel" then
      return false, callback(extra, false, res)
    end
    res = packInfo(res, {})
    res.about = get_pwr_chat(input).about
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

local function _channel_get_users(channel, filter)

  local res = fixfp(get_pwr_chat(channel))
  if res.type ~= "channel" and res.type ~= "supergroup" then
    return false, false
  end
  local users = {}
  return packMembers(res, users, filter), users
end

function channel_get_users(input, callback, extra)
  local success, result =_channel_get_users(input, 1)
  return success, callback(extra, success, result)
end

function channel_get_members(input, callback, extra)
  return channel_get_members(input, callback, extra)
end

function channel_get_bots(input, callback, extra)
  local success, result =_channel_get_users(input, 3)
  return success, callback(extra, success, result)
end

function channel_get_admins(input, callback, extra)
  local success, result =_channel_get_users(input, 2)
  return success, callback(extra, success, result)
end

function send_msg(peer, text, callback, extra)
  local res = fixfp(messages.sendMessage({peer = peer, message = text}))
  if res then
    if res == {} or res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

--doesn't works, madeline returns an error
function send_document(peer, file_path, callback, extra)
  local inputFile = upload(file_path)
  local filename = file_path:match("/?([%w_%.%-]+)$")
  local documentAttribute = {{_="documentAttributeFilename", file_name=filename}}
  local inputMedia = {_ = "inputMediaUploadedDocument", file = inputFile, attributes = documentAttribute, caption = "", mime_type = mimetype.get_content_type(filename:match("%.(%w+)$"))}
  local res = fixfp(messages.sendMedia({peer = peer, media = inputMedia}))
  if res then
    if res == {} or res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function send_photo(peer, file_path, callback, extra)
  local inputFile = upload(file_path)
  local inputMedia = {_ = "inputMediaUploadedPhoto", file = inputFile, caption = ""}
  local res = fixfp(messages.sendMedia({peer = peer, media = inputMedia}))
  if res then
    if res == {} or res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

--Errors errors always errors
function chat_del_user(chat, user, callback, extra)
  chat = tonumber(chat:match("(%d+)$"))
  user = tonumber(user:match("(%d+)$"))
  local inputPeer = {_="inputPeerChat", chat_id = chat}
  local res = fixfp(messages.deleteChatUser({chat_id = inputPeer, user_id = user}))
  if res or res.error then
    if res == {} then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function channel_kick(channel, user, callback, extra)
  local channelBannedRights={_='channelBannedRights', view_messages=true, send_messages=true, send_media=true, send_stickers=true, send_gifs=true, send_games=true, send_inline=true, embed_links=true, until_date=0}
  local res = fixfp(channels.editBanned({channel = channel, user_id = user, banned_rights = channelBannedRights}))
  if res or res.error then
    if res == {} then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function channel_unblock(channel, user, callback, extra)
  local channelBannedRights={_='channelBannedRights', view_messages=false, send_messages=false, send_media=false, send_stickers=false, send_gifs=false, send_games=false, send_inline=false, embed_links=false, until_date=0}
  local res = channels.editBanned({channel = channel, user_id = user, banned_rights = channelBannedRights})
  if res or res.error then
    if res == {} then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end
