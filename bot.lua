require "shim"

local myid = 68972553 --put here your id to test

function on_msg_receive(msg)
  vardump(msg)
  if msg.from.peer_id == myid then
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
  end
end
