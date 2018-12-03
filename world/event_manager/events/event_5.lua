local e = function(world)
  local char = world:get_char_alive("carl")
  local name = char and char:get_name() or "CHARACTER_NAME"
  local rand_char = world:get_random_alive_char()
  local rand_char_name = rand_char and rand_char:get_name()
  return char and {
    {
      text = "Неожиданно для всех " .. name .. " останавливается.\n'Я слышу чьи-то шаги.'\nПутники оглядываются и обнаруживают медленно двигающегося медведя. Кажется, он не успел еще их заметить.",
      buttons = {
        {
          text = "Бежать по дороге",
          action = "next",
          value = 2
        },
        {
          text = "Спрятаться и переждать (-20 времени)",
          action = "close",
          lost = {
            time = 20
          }
        }
      }
    },
    {
      text = "Путники практически одновременно начинают бежать дальше по дороге. Все, кроме " .. name .. ". Но никто этого не замечает. Кроме медведя.",
      buttons = {
        {
          text = "Продолжить путь без " .. name,
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
      text = "Путники устали от длинной пустынной и не меняющей своего направления дороги, их слух притупился от постоянного ветра и снега. Как вдруг неожиданно для всех на " .. rand_char_name .. " бросается белый медведь. Остальные от страха побежали дальше по тропе. Медведь не стал их преследовать. Кажется, ему хватило одного.",
      buttons = {
        {
          text = "Продолжить путь без " .. rand_char_name,
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
