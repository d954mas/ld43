local e = function (world)
  return {
    {
      text = "...",
      buttons = {
        {
          text = "Next",
          action = "next",
          value = 2
        }
      }
    },
    {
      text = "What is this place? How did we end up here? ",
      buttons = {
        {
          text = "Next",
          action = "close"
        }
      }
    }
  }
end

return e
