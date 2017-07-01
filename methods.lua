--[[ //Base function
function (..., callback, extra)
  local res = madeline.method(...)
  if res then
    if res == {} then
      return false, callback(extra, false, false)
    end
    return true, callback(extra, true, true)
  end
  return false, callback(extra, false, false)
end
]]

resolve_username_madeline = resolve_username

function resolve_username(username, callback, extra)
  local res = fixfp(resolve_username_madeline(username))
  if res then
    if res == {} then
      return false, callback(extra, false, false)
    end
    return true, callback(extra, true, packInfo(fixfp(get_info(res.peer)), {}))
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

function send_document(peer, file_path, callback, extra)
  print(peer)
  print(file_path)
  local inputFile = upload(file_path)
  local res = messages.sendMedia({peer = peer, media = inputFile})
  if res then
    if res == {} then
      return false, callback(extra, false, false)
    end
    return true, callback(extra, true, true)
  end
  return false, callback(extra, false, false)
end
