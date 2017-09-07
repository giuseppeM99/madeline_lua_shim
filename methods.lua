--[[ //Base function
function (..., callback, extra)
  local callback = callback or ok_cb
  local res = madeline.method(...)
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end
]]
--[[ TODO
  DIALOGS & CONTACTS
    del_contact
    rename_contact
--]]
local function ok_cb(a, b, c)
end

if not mimetype then
  mimetype = require "mimetype"
end

resolve_username_madeline = resolve_username

function resolve_username(username, callback, extra)
  local callback = callback or ok_cb
  local res = fixfp(get_full_info(username))
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, packInfo(res, {}))
  end
  return false, callback(extra, false, false)
end

function user_info(input, callback, extra)
  local callback = callback or ok_cb
  local res = fixfp(get_full_info(input))
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    local rr = {}
    packInfo(res, rr)
    if rr ~= {} then
      return true, callback(extra, true, rr)
    end
    return false, callback(extra, false, {error = "Peer is not an user"})
  end
  return false, callback(extra, false, false)
end

function chat_info(input, callback, extra)
  local callback = callback or ok_cb
  local res = fixfp(get_full_info(input))
  if res then
    if type(res) == 'table' and res.error or not res.type == "chat" then
      return false, callback(extra, false, res)
    end
    local rres = packInfo(res, {})
    rres.members = {}
    for k, v in pairs(res.full.participants.participants) do
      local user = {}
      packInfo(fixfp(get_full_info(v.user_id)), user)
      if v._ == 'chatParticipantAdmin' then
        user.admin = true
      elseif v._ == 'chatParticipantCreator' then
        user.creator = true
        user.admin = true
      end
      table.insert(rres.members, user)
    end
    --local s = packMembers(rres, rres.members, 1)
    return true, callback(extra, true, rres)
  end
  return false, callback(extra, false, false)
end

function channel_info(input, callback, extra)
  local callback = callback or ok_cb
  local res = fixfp(get_full_info(input))
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    res = packInfo(res, {})
    if res.peer_type ~= 'channel' then
      return false, callback(extra, false, false)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

local function _channel_get_users(channel, filter)

  local res = fixfp(get_pwr_chat(channel))
  if not res or type(res) == 'table' and res.error then
    return false, res
  end
  if res.type ~= "channel" and res.type ~= "supergroup" then
    return false, false
  end
  local users = {}
  return packMembers(res, users, filter), users
end

function channel_get_users(input, callback, extra)
  local callback = callback or ok_cb
  local success, result = _channel_get_users(input, 1)
  return success, callback(extra, success, result)
end

function channel_get_members(input, callback, extra)
  return channel_get_users(input, callback, extra)
end

function channel_get_bots(input, callback, extra)
  local callback = callback or ok_cb
  local success, result = _channel_get_users(input, 3)
  return success, callback(extra, success, result)
end

function channel_get_admins(input, callback, extra)
  local callback = callback or ok_cb
  local success, result = _channel_get_users(input, 2)
  return success, callback(extra, success, result)
end

function create_group_chat(user, title, callback, extra)
  local callback = callback or ok_cb
  local res = messages.createChat({users = {user}, title = title})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function rename_chat(chat, name, callback, extra)
  local callback = callback or ok_cb
  local res = messages.editChatTitle({chat_id = chat, title = name})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function chat_set_photo(chat, photo_path, callback, extra)
  local callback = callback or ok_cb
  if not photo_path or type(photo_path) ~= 'string' then
    return false, callback(extra, false, {error = 'Photo not provided'})
  end
  local inputFile = upload(photo_path)
  if not inputFile then
    return false, callback(extra, false, {error = 'Can not open file: ' .. photo_path})
  end
  local res = messages.editChatPhoto({chat_id = chat, photo = {_ = 'inputChatUploadedPhoto', file = inputFile}})
end

function chat_upgrade(chat, callback, extra)
  local callback = callback or ok_cb
  local res = messages.migrateChat({chat_id = chat})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function import_chat_link(hash, callback, extra)
  local callback = callback or ok_cb
  local res = fixfp(messages.importChatInvite({hash = hash}))
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function export_chat_link(chat, callback, extra)
  local callback = callback or ok_cb
  local res = chat:match("chat#i?d?") and fixfp(messages.exportChatInvite({chat_id = chat})) or fixfp(channels.exportInvite({channel = chat}))
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res.link)
  end
  return false, callback(extra, false, false)
end

function check_chat_link(hash, callback, extra)
  local callback = callback or ok_cb
  local res = fixfp(messages.checkChatInvite({hash = hash}))
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function channel_leave(channel, callback, extra)
  local callback = callback or ok_cb
  local res = channels.leaveChannel({channel = channel})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function leave_channel(channel, callback, extra)
  return channel_leave(channel, callback, extra)
end

function channel_join(channel, callback, extra)
  local callback = callback or ok_cb
  local res = channels.joinChannel({channel = channel})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function delete_msg(message, callback, extra)
  local callback = callback or ok_cb
  local res = {}
  if message.inputPeer._ == "peerChannel" then
    res = fixfp(channels.deleteMessages({channel = message.inputPeer, id = {message.id}}))
  else
    res = fixfp(messages.deleteMessages({revoke = true, id = {message.id}})) -- so this method does not exist? https://daniil.it/MadelineProto/API_docs/methods/messages_deleteMessages.html
  end
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function send_msg(peer, text, callback, extra)
  local callback = callback or ok_cb
  local res = fixfp(messages.sendMessage({peer = peer, message = text}))
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, tgmsg(res.updates[1].message))
  end
  return false, callback(extra, false, false)
end

local function getMimeType(file_path)
  local mime_type
  if useMediaInfo then
    local info = mediainfo(file_path)
    mime_type = info:getMimeType()
  end
  if not mime_type then
    local name = file_path:match("/?([%w_%.%-]+)$")
    mime_type = mimetype.get_content_type(name:match("%.(%w+)$"))
  end
  return mime_type or ""
end

function send_document(peer, file_path, callback, extra)
  local callback = callback or ok_cb
  local inputFile = upload(file_path)
  local filename = file_path:match("/?([%w_%.%-]+)$")
  local documentAttribute = {{_ = "documentAttributeFilename", file_name = filename}}
  local mime_type = getMimeType(file_path)
  if useMediaInfo then
    if mime_type:match("video") then
      local info = mediainfo(file_path)
      local va = {_ = "documentAttributeVideo"}
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
      local va = {_ = "documentAttributeImageSize"}
      if info:getWidth() then
        va.w = info:getWidth()
      end
      if info:getHeight() then
        va.h = info:getHeight()
      end
    elseif mime_type:match("audio") then
      local info = mediainfo(file_path)
      local va = {_ = "documentAttributeAudio"}
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
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, tgmsg(res.updates[1].message))
  end
  return false, callback(extra, false, false)
end

function send_video(peer, file_path, callback, extra)
  local callback = callback or ok_cb
  local inputFile = upload(file_path)
  local filename = file_path:match("/?([%w_%.%-]+)$")
  local documentAttribute = {{_ = "documentAttributeFilename", file_name = filename}, {_ = "documentAttributeVideo", w = 0, h = 0, duration = 0}}
  if useMediaInfo then
    local info = mediainfo(file_path)
    documentAttribute[2].w = info:getWidth()
    documentAttribute[2].h = info:getHeight()
    documentAttribute[2].duration = info:getDuration()
  end
  local inputMedia = {_ = "inputMediaUploadedDocument", file = inputFile, attributes = documentAttribute, caption = "", mime_type = getMimeType(file_path)}
  local res = fixfp(messages.sendMedia({peer = peer, media = inputMedia}))
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, tgmsg(res.updates[1].message))
  end
  return false, callback(extra, false, false)
end

function send_photo(peer, file_path, callback, extra)
  local callback = callback or ok_cb
  local inputFile = upload(file_path)
  local inputMedia = {_ = "inputMediaUploadedPhoto", file = inputFile, caption = ""}
  local res = fixfp(messages.sendMedia({peer = peer, media = inputMedia}))
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, tgmsg(res.updates[1].message))
  end
  return false, callback(extra, false, false)
end

function send_file(peer, file_path, callback, extra)
  return send_document(peer, file_path, callback, extra)
end

function send_text(peer, file_path, callback, extra)
  local callback = callback or ok_cb
  local r, f = pcall(io.open(file_path))
  if not r then
    return false, callback(extra, false, {error = 'Can not open file: ' .. file_path})
  end
  local r = f:read('*all')
  f:close()
  if not r then
    return false, callback(extra, false, {error = 'Can not read from file: ' .. file_path})
  end
  if #r > 4096 then
    return false, callback(extra, false, {error = 'Text file is too big'})
  end
  return send_msg(peer, r, callback, extra)
end

function chat_del_user(chat, user, callback, extra)
  local callback = callback or ok_cb
  chat = chat:gsub("chat#i?d?", "")
  if not chat:match("^%d+$") then
    return false, callback(extra, error, {error = "CHAT_ID_INVALID"})
  end
  local res = fixfp(messages.deleteChatUser({chat_id = chat, user_id = user}))
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function channel_kick(channel, user, callback, extra)
  local callback = callback or ok_cb
  local channelBannedRights = {_ = 'channelBannedRights', view_messages = true, send_messages = true, send_media = true, send_stickers = true, send_gifs = true, send_games = true, send_inline = true, embed_links = true, until_date = 0}
  local res = fixfp(channels.editBanned({channel = channel, user_id = user, banned_rights = channelBannedRights}))
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function channel_unblock(channel, user, callback, extra)
  local callback = callback or ok_cb
  local channelBannedRights = {_ = 'channelBannedRights', view_messages = false, send_messages = false, send_media = false, send_stickers = false, send_gifs = false, send_games = false, send_inline = false, embed_links = false, until_date = 0}
  local res = channels.editBanned({channel = channel, user_id = user, banned_rights = channelBannedRights})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function get_message(message, callback, extra)
  local callback = callback or ok_cb
  local res = {}
  if message.inputPeer._ == "peerChannel" then
    res = fixfp(channels.getMessages({channel = message.inputPeer, id = {message.id}}))
  else
    res = fixfp(messages.getMessages({id = {message.id}}))
  end
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    if res.messages[0] then
      return true, callback(extra, true, tgmsg(res.messages[0]))
    else
      return false, callback(extra, false, res)
    end
  end
  return false, callback(extra, false, false)
end

function fwd_media(message, destination, callback, extra) --Doesn't works yet, i'll fix it soon or later
  local callback = callback or ok_cb
  local res = {}
  if message.inputPeer._ == "peerChannel" then
    res = fixfp(channels.getMessages({channel = message.inputPeer, id = {message.id}}))
  else
    res = fixfp(messages.getMessages({id = {message.id}}))
  end
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    local fwdMessage = res.messages[0] or false
    if not fwdMessage then
      return false, callback(extra, false, res)
    end
    if fwdMessage.media then
      if fwdMessage.media._ == "messageMediaPhoto" then
        local res = messages.sendMedia({peer = destination, media = {_ = "inputMediaPhoto", caption = fwdMessage.media.caption or '', id = {_ = "inputPhoto", id = fwdMessage.media.photo.id, access_hash = fwdMessage.media.photo.access_hash}}})
        if res and not type(res) == 'table' and not res.error then
          return true, callback(extra, true, res)
        else
          return false, callback(extra, false, res)
        end
      elseif fwdMessage.media._ == "messageMediaDocument" then
        local res = fixfp(messages.sendMedia({peer = destination, media = {_ = "inputMediaDocument", caption = fwdMessage.media.caption or '', id = {_ = "inputPhoto", id = fwdMessage.media.document.id, access_hash = fwdMessage.media.document.access_hash}}}))
        if res and not type(res) == 'table' and not res.error then
          return true, callback(extra, true, tgmsg(res.updates[1].message))
        else
          return false, callback(extra, false, res)
        end
      end
    end
  end
  return false, callback(extra, false, false)
end

function fwd_msg(message, destination, callback, extra)
  local callback = callback or ok_cb
  local res = fixfp(messages.forwardMessages({from_peer = message.inputPeer, to_peer = destination, id = {message.id}}))
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, tgmsg(res.updates[1].message))
  end
  return false, callback(extra, false, false)
end

function mark_read(peer, callback, extra)
  local callback = callback or ok_cb
  local peer = get_info(peer)
  local res
  if peer.InputChannel then
    res = channels.readHistory({channel = peer.InputChannel, max_id = 0})
  else
    res = messages.readHistory({peer = peer.InputPeer, max_id = 0})
  end
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function get_dialog_list(callback, extra)
  local callback = callback or ok_cb
  local res = get_dialogs()
  if not res or type(res) == 'table' and res.error then
    return false, callback(extra, false, res)
  end
  local dialogs = {}
  for _, v in pairs(res) do
    local p = packInfo(fixfp(get_full_info(v)))
    table.insert(dialogs, {peer = p})
  end
  return true, callback(extra, true, dialogs)
end

local function _load(thumb, message, callback, extra)
  local callback = callback or ok_cb
  local res = {}
  if message.inputPeer._ == "peerChannel" then
    res = fixfp(channels.getMessages({channel = message.inputPeer, id = {message.id}}))
  else
    res = fixfp(messages.getMessages({id = {message.id}}))
  end
  local msg
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    msg = res.messages[0] or false
    if not msg then
      return false, callback(extra, false, res)
    end
  end
  if msg.media then
    local dw
    if msg.media.photo and not thumb then
      dw = download_to_dir(msg.media.photo, 'download')
    elseif msg.media.document then
      dw = download_to_dir(thumb and msg.media.document.thumb or msg.media, 'download')
    else
      return false, callback(extra, false, false)
    end
    if dw then
      if dw.error or dw == {} then
        return false, callback(extra, false, dw)
      end
      return true, callback(extra, true, dw)
    end
  end
  return false, callback(extra, false, false)
end

function load_file(...)
  return _load(false, ...)
end

function load_photo(...)
  return _load(false, ...)
end

function load_video(...)
  return _load(false, ...)
end

function load_audio(...)
  return _load(false, ...)
end

function load_document(...)
  return _load(false, ...)
end


function load_video_thumb(...)
  return _load(true, ...)
end

function load_document_thumb(...)
  return _load(true, ...)
end

function send_contact(peer, phone, first_name, last_name, callback, extra)
  local callback = callback or ok_cb
  if not phone or not first_name then
    return false, callback(extra, false, false)
  end
  local media = {_ = 'inputMediaContact', phone_number = phone, first_name = first_name, last_name = last_name or ''}
  local res = messages.sendMedia({peer = peer, media = media})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, tgmsg(res.updates[1].message))
  end
  return false, callback(extra, false, false)
end

function add_contact(phone, first_name, last_name, callback, extra)
  local callback = callback or ok_cb
  local c = {}
  c[0] = {_ = 'inputPhoneContact', phone_number = phone, first_name = first_name, last_name = last_name or ''}
  local res = contacts.importContacts({contacts = c})
  if res then
    if res.error or type(res) == 'table' then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function send_location(peer, lat, long, callback, extra)
  local callback = callback or ok_cb
  local res = messages.sendMedia({peer = peer, media = {_ = 'inputMediaGeoPoint', geo_point = {_ = 'inputGeoPoint', lat = lat, long = long}}})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, tgmsg(res.updates[1].message))
  end
  return false, callback(extra, false, false)
end

function channel_list(callback, extra)
  local callback = callback or ok_cb
  local res = get_dialogs(true)
  if not res or type(res) == 'table' and res.error then
    return false, callback(extra, false, res)
  end
  local dialogs = {}
  for _, v in pairs(res) do
    if v._ == 'peerChannel' then
      table.insert(dialogs, packInfo(fixfp(get_info(v))))
    end
  end
  return true, callback(extra, true, dialogs)
end

function get_contact_list(callback, extra)
  local callback = callback or ok_cb
  local res = contacts.getContacts({hash = 0})
  if res then
    if res.error or type(res) == 'table' then
      return false, callback(extra, false, res)
    end
    local contacts = {}
    for _, v in pairs(res.contacts) do
      local info = packInfo(fixfp(get_info(v.user_id)))
      table.insert(contacts, info)
    end
    return true, callback(extra, true, contacts)
  end
  return false, callback(extra, false, false)
end

function msg_search(peer, pattern, callback, extra)
  local callback = callback or ok_cb
  local res = messages.search(
    {
      peer = peer,
      q = pattern,
      filter = {
        _ = "inputMessagesFilterEmpty"
      },
      min_date = 0,
      max_date = 0,
      offset_id = 0,
      add_offset = 0,
      limit = 40,
      max_id = 0,
      min_id = 0
    }
  )
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    local msgs = {}
    for _, v in pairs(res.messages) do
      table.insert(msgs, tgmsg(v))
    end
    return true, callback(extra, true, msgs)
  end
  return false, callback(extra, false, false)
end

function msg_global_search(pattern, callback, extra)
  local callback = callback or ok_cb
  local res = messages.searchGlobal(
    {
      q = pattern,
      offset_date = 0,
      offset_peer = {
        _ = "inputPeerEmpty"
      },
      offset_id = 0,
      limit = 40,
    }
  )
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    local msgs = {}
    for _, v in pairs(res.messages) do
      table.insert(msgs, tgmsg(v))
    end
    return true, callback(extra, true, msgs)
  end
  return false, callback(extra, false, false)
end

function channel_invite(channel, user, callback, extra)
  local callback = callback or ok_cb
  local res = fixfp(channels.inviteToChannel({channel = channel, users = {user}}))
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, pachInfo(get_full_info(res)))
  end
  return false, callback(extra, false, false)
end

function chat_add_user(chat, user, callback, extra)
  local callback = callback or ok_cb
  local res = fixfp(messages.addChatUser({chat_id = chat, user_id = user, fwd_limit = 0}))
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function create_supergroup(user, title, about, callback, extra)
  local callback = callback or ok_cb
  local res = channels.createChannel({broadcast = true, megagroup = true, title = title, about = about})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return channel_invite(res.chats[0], user, callback, extra)
  end
  return false, callback(extra, false, false)
end

function create_channel(user, title, about, callback, extra)
  local callback = callback or ok_cb
  local res = channels.createChannel({broadcast = true, megagroup = false, title = title, about = about})
  if res then
    if res.error or type(res) == 'table' then
      return false, callback(extra, false, res)
    end
    return channel_invite(res.chats[0], user, callback, extra)
  end
  return false, callback(extra, false, false)
end

function rename_channel(channel, title, callback, extra)
  local callback = callback or ok_cb
  local res = channels.editTitle({channel = channel, title = title})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function channel_set_photo(channel, photo, callback, extra)
  local callback = callback or ok_cb
  local inputFile = upload(photo)
  if inputFile then
    local res = channels.editPhoto({channel = channel, photo = {_ = 'inputChatUploadedPhoto', file = inputFile}})
    if res then
      if type(res) == 'table' and res.error then
        return false, callback(extra, false, res)
      end
      return true, callback(extra, true, res)
    end
    return false, callback(extra, false, false)
  end
  return false, callback(extra, false, false)
end

function channel_set_about(channel, about, callback, extra) -- fuck you gimme sum errors pls pls pls
  local callback = callback or ok_cb
  local res = channels.editAbout({channel = channel, about = about})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function channel_set_username(channel, username, callback, extra)
  local callback = callback or ok_cb
  local res = channels.updateUsername({channel = channel, username = username})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, true)
  end
  return false, callback(extra, false, false)
end

function channel_set_mod(channel, user, callback, extra)
  local callback = callback or ok_cb
  return channel_set_admin(channel, user, callback, extra)
end

function channel_set_admin(channel, user, callback, extra)
  local callback = callback or ok_cb
  local res = channels.editAdmin({channel = channel, user_id = user, admin_rights = {
    _ = 'channelAdminRights',
    change_info = true,
    post_messages = true,
    edit_messages = false,
    delete_messages = false,
    ban_users = true,
    invite_users = true,
    invite_link = true,
    pin_messages = true,
    add_admins = false
  }})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function channel_demote(channel, user, callback, extra)
  local callback = callback or ok_cb
  local res = channels.editAdmin({channel = channel, user_id = user, admin_rights = {
    _ = 'channelAdminRights',
    change_info = false,
    post_messages = false,
    edit_messages = false,
    delete_messages = false,
    ban_users = false,
    invite_users = false,
    invite_link = false,
    pin_messages = false,
    add_admins = false
  }})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function delete_channel(channel, callback, extra)
  local callback = callback or ok_cb
  local res = channels.deleteChannel({channel = channel})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end

function channel_delete(...)
  return delete_channel(...)
end

function set_profile_name(first_name, last_name, callback, extra)
  local callback = callback or ok_cb
  local res = account.updateProfile({first_name = first_name, last_name = last_name})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, packInfo(get_info(res)))
  end
  return false, callback(extra, false, res)
end

function set_profile_username(username, callback, extra)
  local callback = callback or ok_cb
  local res = account.updateUsername({username = username})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, packInfo(get_info(res)))
  end
  return false, callback(extra, false, res)
end

function set_profile_photo(photo, callback, extra)
  local callback = callback or ok_cb
  local inputFile = upload(photo)
  if not inputFile then return false, callback(extra, false, false) end
  local photo = photos.uploadProfilePhoto({file = inputFile})
  local res = photos.updateProfilePhoto({id = {_ = 'inputPhoto', id = photo.photo.id, access_hash = photo.photo.access_hash}})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, res)
end

function set_profile_about(about, callback, extra)
  local callback = callback or ok_cb
  local res = account.updateProfile({about = about})
  if res then
    if type(res) == 'table' and res.error then
      return false, callback(extra, false, packInfo(get_info(res)))
    end
    return true, callback(extra, true, res)
  end
  return false, callback(extra, false, false)
end
