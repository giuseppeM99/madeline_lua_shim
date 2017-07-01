resolve_username_madeline = resolve_username

function resolve_username(username, callback, extra)
  local res = fixfp(resolve_username_madeline(username))
  if res then
    if res == {} then
      return false, callback(extra, false, false)
    end
    return true, callback(extra, true, packInfo(fixfp(get_info(res.peer)), {}))
  end
end
