--[[
Made with <3 by The Doctor
For madeline_lua_tg madeline_lua_shim
]]
local mediainfo = function(file)
  if not file then
    return false
  end
  local han = io.popen("mediainfo -f '" .. file .. "'")
  local info = han:read("*all")
  han:close()
  return {
    info = info,
    getDuration = function(self)
      local Duration = self.info:match("Duration %s+: (%d+)")
      if not Duration then return nil end
      return math.ceil(Duration/1000)
    end,
    getWidth = function(self)
      return self.info:match("Width %s+: (%d+)")
    end,
    getHeight = function(self)
      return self.info:match("Height %s+: (%d+)")
    end,
    getMimeType = function(self)
      return self.info:match("Internet media type %s+ : ([%w/]+)")
    end,
    getTitle = function(self)
      local Title = self.info:match("Title %s+ : ([%w%s&%.]+%c)")
      if not Title then return nil end
      return Title:sub(1, -2)
    end,
    getPerformer = function(self)
      local Performer = self.info:match("Performer %s+ : ([%w%s&%.]+%c)")
      if not Performer then return nil end
      return Performer:sub(1, -2)
    end,
  }
end

return mediainfo
