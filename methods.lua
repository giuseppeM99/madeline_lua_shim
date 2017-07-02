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
      vardump(res)
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, packInfo(res, {}))
  end
  return false, callback(extra, false, false)
end

function channel_info(input, callback, extra)
  local res = fixfp(get_info(input))
  if res then
    if res == {} or res.error or not res.type == "channel" then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, packInfo(res, {}))
  end
  return false, callback(extra, false, false)
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
  vardump(inputFile)
  local res = fixfp(messages.sendMedia({peer = peer, media = inputFile}))
  vardump(res)
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
  local res = fixfp(messages.deleteChatUser({chat_id = chat, user_id = user}))
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
