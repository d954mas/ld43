local e = function(world)
  return
  {
    {
      text = "Wanderers see an apple tree full of reddish deliciously looking apples, which is kinda weird to see in the middle of nowhere. The suspicion only grows as they notice it has no leaves on its thin branches. ",
      buttons = {
        {
          text = "Collect and eat some apples  (-20 time)",
          action = "close",
          reward = {
            food = math.random(8, 12)
          },
          lost = {
            time = 20
          }

        },
        {
          text = "Walk past ",
          action = "close"
        }
      }
    }
  }
end

return e
