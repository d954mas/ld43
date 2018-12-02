local e = function(world)
  return {
    {
      text = "Началась невиданная для эти краев метель. Некоторые деревья были сорваны с корнем. Вы решили переждать метель в пещере.",
      buttons = {
        {
          text = "Дальше",
          action = "close",
          lost = {
            time = 15
          }
        }
      }
    }
  }
end

return e
