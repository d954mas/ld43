local e = function(world)
  local char = world:get_char_alive("angel") or world:get_random_alive_char()
  local name = char and char:get_name() or "CHARACTER_NAME"
  return
  {
    {
      text = "You have found a corpse, there's a mysterious note and a bag lying right beside it. The bag is tied up and looks untouched. ",
      buttons = {
        {
          text = "Walk past",
          action = "close"
        },
        {
          text = "Open the bag",
          action = "next",
          value = 2
        },
        {
          text = "Read the note ",
          action = "next",
          value = 3
        }
      }
    },
    {
      text = name .. " dares to open the bag, in a flash a giant spider jumps right on the face. Wanderers run away in fear, but " .. name .. " doesn't." ,
      buttons = {
        {
          text = "Run as far as you can ",
          action = "close",
          lost = {
            character = char:get_id()
          }
        }
      }
    },
    {
      text = "'I have to leave this bag right here, but please, don't touch it. I'm coming back for it as soon as I can. '",
      buttons = {
        {
          text = "Оpen the bag ",
          action = "next",
          value = 2
        },
        {
          text = "Walk past",
          action = "close"
        }
      }
    }
  }
end

return e
