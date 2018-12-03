local e = function(world)
  return
  {
    {
      text = "Путники встречают на своей дороге очень подозрительную яблоню. Дерево не имеет листьев, лишь сочный яблоки свисают с голых ветвей. ",
      buttons = {
        {
          text = "Собрать яблоки и перекусить (-20 времени)",
          action = "close",
          reward = {
            food = math.random(8, 12)
          },
          lost = {
            time = 20
          }

        },
        {
          text = "Пройти мимо",
          action = "close"
        }
      }
    }
  }
end

return e
