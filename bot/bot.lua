--for test purpose

serpent = require "serpent"

function send_large_msg_callback(cb_extra, success, result)
  local text_max = 4096

  local destination = cb_extra.destination
  local text = cb_extra.text

  if not text then
    return
  end

  local text_len
  if type(text) ~= "boolean" then
    text_len = string.len(text) or 0
  else
    text_len = 0
  end

  if text_len > 0 then
    local num_msg = math.ceil(text_len / text_max)

    if num_msg <= 1 then
      send_msg(destination, text, ok_cb, false)
    else

      local my_text = string.sub(text, 1, 4096)
      local rest = string.sub(text, 4096, text_len)

      local cb_extra = {
        destination = destination,
        text = rest
      }

      send_msg(destination, my_text, send_large_msg_callback, cb_extra)
    end
  end
end

function ok_cb(extra, success, result)
  --vardump(result)
end

function cron_func()
  print("Cron function", os.time())
  postpone(cron_func, nil, 60)
end

function on_binlog_replay_end()
  started = true
end

local myid = 68972553 --put here your id to test

now = os.time()

function on_msg_receive(msg)
  if not started then
    return
  end
  if msg.service then
    vardump(msg.action)
    return
  end
  if msg.from.peer_id == myid then
    if msg.text:match("^!reload$") then
      return loadBot()
    end
    local username = msg.text:match("^!id @?([%w_]+)$")
    if username then
      resolve_username
      (
        username,
        function(extra, success, result)
          print(extra.test)
          vardump(result)
        end, {test="cb_extra"}
      )
    end
    if msg.text:match("channelinfo") then
      channel_info("channel#id" .. msg.to.peer_id, function(extra, success, result) send_large_msg_callback({destination = msg.from.peer_id, text = serpent.block(result, {comment = false})}) end, {})
    end
    if msg.text:match("chat_info") then
      chat_info("chat#id" .. msg.to.peer_id, function(extra, success, result) send_large_msg_callback({destination = msg.to.raw, text = serpent.block(result, {comment = false})}) end, {})
    end
    if msg.text:match("^test$") then
      delete_msg(msg.id, ok_cb, nil)
    end
  end

  if msg.text:match("^/start$") then
    send_msg(msg.from.peer_id, "Il Dottore ti dà il benvenuto nel bot di test per madeline_lua_tg AKA madeline_lua_shim, ecco alcune immagini del Tardis", ok_cb, nil)
    send_msg(msg.from.raw, "The Doctor welcomes you in the test bot for madeline_lua_tg AKA madeline_lua_shim, Here are some pictures of the Tardis", ok_cb, nil)
    send_document("user#id" .. msg.from.peer_id, "tardis.png", ok_cb, nil)
    send_photo("user#id" .. msg.from.peer_id, "tardis.jpg", ok_cb, nil)
  end

end

postpone(cron_func, nil, 60)

function on_our_id(id)
  our_id = id
end
