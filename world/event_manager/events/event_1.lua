local e = function (world)
  return {
    {
      text = "...",
      buttons = {
        {
          text = "Дальше",
          action = "next",
          value = 2
        }
      }
    },
    {
      text = "Что это за место? Как мы здесь оказались?",
      buttons = {
        {
          text = "Дальше",
          action = "close"
        }
      }
    }
  }
end

return e
