local e = function(world)
  return {
    {
      text = "A wind is only getting stronger, suddenly a snow storm has begun. You decided to wait into the safety until it would calm down.",
      buttons = {
        {
          text = "Next",
          action = "close",
          lost = {
            time = 1
          }
        }
      }
    }
  }
end

return e
