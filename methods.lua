--[[ //Base function
function (..., callback, extra)
  local res = madeline.method(...)
  if res or res.error then
    if res == {} then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, true)
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
  print("Chat info")
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
  local res = messages.sendMessage({peer = peer, message = text})
  if res then
    if res == {} then
      return false, callback(extra, false, false)
    end
    return true, callback(extra, true, true)
  end
  return false, callback(extra, false, false)
end

--doesn't works, madeline returns an error
function send_document(peer, file_path, callback, extra)
  local inputFile = upload(file_path)
  vardump(inputFile)
  local res = messages.sendMedia({peer = peer, media = inputFile})
  vardump(res)
  if res then
    if res == {} or res.error then
      return false, callback(extra, false, res)
    end
    return true, callback(extra, true, true)
  end
  return false, callback(extra, false, false)
end
