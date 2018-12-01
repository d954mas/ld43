local M = { }

M.events = { }

local function parse_event(event)
  local e = require("main.event_manager.events." .. event)
  table.insert(M.events, e)
end

parse_event("event_1")

return M
