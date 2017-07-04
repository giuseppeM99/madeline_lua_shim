--[[ //Base function
function (..., callback, extra)
  local res = madeline.method(...)
  if res then
    if res == {} or res.error then
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
  if not res or res == {} or res.error then
    return false, res
  end
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

function delete_msg(message, callback, extra)
  local res = {}
  if message.inputPeer._ == "peerChannel" then
    res = fixfp(channels.deleteMessages({channel = message.inputPeer, id = {message.message_id}}))
  else
    res = fixfp(messages.deleteMessages({revoke = true, id = {message.message_id}})) -- so this method does not exist? https://daniil.it/MadelineProto/API_docs/methods/messages_deleteMessages.html
  end
  if res then
    if res == {}  or res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
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

local function getMimeType(file_path)
  if useMediaInfo then
    local info = mediainfo(file_path)
    if info:getMimeType() then
      return info:getMimeType()
    end
  end
  local name = file_path:match("/?([%w_%.%-]+)$")
  return mimetype.get_content_type(name:match("%.(%w+)$"))
end

function send_document(peer, file_path, callback, extra)
  local inputFile = upload(file_path)
  local filename = file_path:match("/?([%w_%.%-]+)$")
  local documentAttribute = {{_="documentAttributeFilename", file_name=filename}}
  local mime_type = getMimeType(file_path)
  if useMediaInfo then
    if mime_type:match("video") then
      local info = mediainfo(file_path)
      local va = {_="documentAttributeVideo"}
      if info:getWidth() then
        va.w = info:getWidth()
      end
      if info:getHeight() then
        va.h = info:getHeight()
      end
      if info:getDuration() then
        va.duration = info:getDuration()
      end
    elseif mime_type:match("image") then
      local info = mediainfo(file_path)
      local va = {_="documentAttributeImageSize"}
      if info:getWidth() then
        va.w = info:getWidth()
      end
      if info:getHeight() then
        va.h = info:getHeight()
      end
    elseif mime_type:match("audio") then
      local info = mediainfo(file_path)
      local va = {_="documentAttributeAudio"}
      if info:getDuration() then
        va.duration = info:getDuration()
      end
      if info:getPerformer() then
        va.performer = info:getPerformer()
      end
      if info:getTitle() then
        va.title = info:getTitle()
      end
    end
    table.insert(documentAttribute, va)
  end
  local inputMedia = {_ = "inputMediaUploadedDocument", file = inputFile, attributes = documentAttribute, caption = "", mime_type = mime_type}
  local res = fixfp(messages.sendMedia({peer = peer, media = inputMedia}))
  if res then
    if res == {} or res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function send_video(peer, file_path, callback, extra)
  local inputFile = upload(file_path)
  local filename = file_path:match("/?([%w_%.%-]+)$")
  local documentAttribute = {{_="documentAttributeFilename", file_name=filename},{_="documentAttributeVideo", w=0, h=0, duration=0}}
  if useMediaInfo then
    local info = mediainfo(file_path)
    documentAttribute[2].w = info:getWidth()
    documentAttribute[2].h = info:getHeight()
    documentAttribute[2].duration = info:getDuration()
  end
  local inputMedia = {_ = "inputMediaUploadedDocument", file = inputFile, attributes = documentAttribute, caption = "", mime_type = getMimeType(file_path)}
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
  local res = fixfp(messages.deleteChatUser({chat_id = chat, user_id = user}))
  if res then
    if res == {} or res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function channel_kick(channel, user, callback, extra)
  local channelBannedRights={_='channelBannedRights', view_messages=true, send_messages=true, send_media=true, send_stickers=true, send_gifs=true, send_games=true, send_inline=true, embed_links=true, until_date=0}
  local res = fixfp(channels.editBanned({channel = channel, user_id = user, banned_rights = channelBannedRights}))
  if res then
    if res == {} or res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function channel_unblock(channel, user, callback, extra)
  local channelBannedRights={_='channelBannedRights', view_messages=false, send_messages=false, send_media=false, send_stickers=false, send_gifs=false, send_games=false, send_inline=false, embed_links=false, until_date=0}
  local res = channels.editBanned({channel = channel, user_id = user, banned_rights = channelBannedRights})
  if res then
    if res == {} or res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function get_message(message, callback, extra)
  local res = {}
  if message.inputPeer._ == "peerChannel" then
    res = fixfp(channels.getMessages({channel= message.inputPeer, id={message.id}}))
  else
    res = fixfp(messages.getMessages({id={message.id}}))
  end
  if res then
    if res == {} or res.error then
      return false, callback(extra, false, res)
    end
    if res.messages[0] then
      return true, callback(extra, true, tomsg(res.messages[0]))
    else
      return false, callback(extra, false, res)
    end
  end
  return false, callback(extra, false, false)
end

function fwd_media(message, destination, callback, extra) --Doesn't works yet, i'll fix it soon or later
  local res = {}
  if message.inputPeer._ == "peerChannel" then
    res = fixfp(channels.getMessages({channel= message.inputPeer, id={message.id}}))
  else
    res = fixfp(messages.getMessages({id={message.id}}))
  end
  if res then
    if res == {} or res.error then
      return false, callback(extra, false, res)
    end
    local fwdMessage = res.messages[0] or false
    if not fwdMessage then
      return false, callback(extra, false, res)
    end
    if fwdMessage.media then
      if fwdMessage.media._ == "messageMediaPhoto" then
        local res = fixfp(messages.sendMedia({peer=destination,media={_="inputMediaPhoto",caption = fwdMessage.media.caption, id={_="inputPhoto", id=fwdMessage.media.photo.id, access_hash=fwdMessage.media.photo.access_hash}}}))
        if res and not res == {} and not res.error then
          return true, callback(extra, true, res)
        else
          return false, callback(extra, false, res)
        end
      elseif fwdMessage.media._ == "messageMediaDocument" then
        local res = fixfp(messages.sendMedia({peer=destination,media={_="inputMediaDocument",caption = fwdMessage.media.caption, id={_="inputPhoto", id=fwdMessage.media.document.id, access_hash=fwdMessage.media.document.access_hash}}}))
        if res and not res == {} and not res.error then
          return true, callback(extra, true, res)
        else
          return false, callback(extra, false, res)
        end
      end
    end
  end
  return false, callback(extra, false, false)
end

function fwd_msg(message, destination, callback, extra)
  local res = fixfp(messages.forwardMessages({from_peer = message.inputPeer, to_peer = destination, id={message.id}}))
  if res then
    if res == {} or res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end
