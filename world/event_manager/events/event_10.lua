local e = function(world)
  local char = world:get_char_alive("jon")
  local random_char = world:get_random_alive_char()
  local name = char and char:get_name() or "CHARACTER_NAME"
  local rand_name = random_char:get_name()
  return
  {
    {
      text = "Your path leads to something which looks like a frozen lake, you think you can cross it carefully.",
      buttons = {
        {
          text = "Cross the lake ",
          action = "next",
          value = char and 3 or math.random(2, 3)
        },
        {
          text = "Search for a way to get around  (-5 time)",
          action = "next",
          lost = {
            time = 5
          },
          value = 1
        }
      }
    },
    {
      text = "You got to the other side just fine, it's just you have spent some extra time being careful.  (-15 time).",
      buttons = {
        {
          text = "Continue your journey",
          action = "close",
          lost = {
            time = 15
          }
        }
      }
    },
    {
      text = char and ("On the half of the way " .. name .. "  falls through the ice, probably being the most heavy of all ") or ("On the half of the way " .. rand_name .. " falls through thin ice."),
      buttons = {
        {
          text = "Try to help " .. (char and name or rand_name),
          action = "next",
          value = 4
        },
        {
          text = "Run to the other side.",
          action = "close",
          lost = {
            character = char:get_id()
          }
        }
      }
    },
    {
      text = "Everybody gets to the other side harmless and tired, but time has been spent. (-15 time, -2 food).",
      buttons = {
        {
          text = "Continue your journey",
          action = "close",
          lost = {
            time = 15,
            food = 2
          }
        },
      }
    }
  }
end

return e
