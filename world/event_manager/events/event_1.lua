local e = function (world) 
  return {
    {
      icon = "1",
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
      icon = "1",
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
