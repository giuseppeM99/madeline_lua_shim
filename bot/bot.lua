--for test purpose

function ok_cb(extra, success, result)
end

local myid = 68972553 --put here your id to test

now = os.time()

function on_msg_receive(msg)
  if not started then
    print("Not yet started")
    return
  end
  print(now)
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
    if msg.text:match("test") then
      send_document("user#id" .. msg.from.peer_id, "launch.sh", ok_cb, nil)
    end
  end
end
