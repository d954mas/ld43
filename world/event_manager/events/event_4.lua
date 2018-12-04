local e = function(world)
  local char = world:get_random_alive_char()
  local name = char and char:get_name() or "CHARACTER_NAME"
  return {
    {
      text = name .. " has noticed something peculiarly shiny on the road. ",
      buttons = {
        {
          text = "Walk past ",
          action = "close"
        },
        {
          text = "Pick up ",
          action = "next",
          value = 2
        }
      }
    },
    {
      text = "Taking a closer look on that something " .. name .. " recognizes an Amulet in it. There's a map on the back side. ",
      buttons = {
        {
          text = "Throw it out and continue walking further ",
          action = "close"
        },
        {
          text = "Check out the place on the map. (-30 time)",
          action = "next",
          value = 3,
          lost = {
            time = 30
          }
        }
      }
    },
    {
      text = "When you got to the place you only found someone's bones, nothing useful was there. You presume the death\'s laughing at you. ",
      buttons = {
        {
          text = "Continue your journey",
          action = "close"
        }
      }
    }
  }
end

return e
