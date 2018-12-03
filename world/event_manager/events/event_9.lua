local e = function(world)
  local char = world:get_char_alive("anabel")
  local random_char = world:get_random_alive_char()
  local name = char and char:get_name() or "CHARACTER_NAME"
  local rand_name = random_char:get_name()
  return
  {
    {
      text = rand_name .. " stumbles and whips in pain, some help seem to be required. ",
      buttons = {
        char and {
          text = name .. "  can heal a wound faster (-10 time)",
          action = "close",
          lost = {
            time = 10
          }
        } or {
          text = "Wait until a wanderer can walk (-25 time)",
          action = "close",
          lost = {
            time = 25
          }
        },
        world:count_chars() > 1 and {
          text = "Leave " .. rand_name .. " behind and walk further. ",
          action = "close",
          lost = {
            character = random_char:get_id()
          }
        } or nil
      }
    }
  }
end

return e
