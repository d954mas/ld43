local e = function(world)
  local char = world:get_char_alive("carl")
  local name = char and char:get_name() or "CHARACTER_NAME"
  local rand_char = world:get_random_alive_char()
  local rand_char_name = rand_char and rand_char:get_name()
  return char and {
    {
      text = "All of a sudden " .. name .. " stops and says there's a sound walking from behind. Wanderers see a slowly moving bear, which doesn't seem to notice them yet. ",
      buttons = {
        {
          text = "Run further ",
          action = "next",
          value = 2
        },
        {
          text = "Hide and wait until it's safe  (-20 time)",
          action = "close",
          lost = {
            time = 20
          }
        }
      }
    },
    {
      text = "Everybody runs as fast as they only could except " .. name .. ".but nobody notices. Besides the bear.",
      buttons = {
        {
          text = "Continue without " .. name,
          action = "close",
          lost = {
            character = char:get_id()
          }
        }
      }
    }
  }
  or {
    {
      text = "Wanderers get pretty tired of walking by this lonesome road, their senses lose it's sharpness, all of a sudden an arctic bear being completely unnoticed gets closer and attacks " .. rand_char_name .. " . Driven by fear everybody runs, but the bear doesn't follow. Seems like the one was enough. ",
      buttons = {
        {
          text = "Continue without " .. rand_char_name,
          action = "close",
          lost = {
            character = rand_char:get_id()
          }
        }
      }
    }
  }
end

return e
