-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.
require("main.event_manager.events.event_1")
local M = { }

M.events = { }

local function parse_event(event)
  local e = require("main.event_manager.events." .. event)
  table.insert(M.events, e)
end

parse_event("event_1")

return M
