local e = function(world)
  local char = world:get_char_alive("jon")
  local random_char = world:get_random_alive_char()
  local name = char and char:get_name() or "CHARACTER_NAME"
  local rand_name = random_char:get_name()
  return
  {
    {
      text = "Вашь путь простирается через замерзшее озеро, нужно идти аккуранее, чтобы не провалиться под лед. Но в теории у озера должны быть берега, можете попробовать поискать другой путь. (На самом деле путники не уверены, что это озеро)",
      buttons = {
        {
          text = "Пройти через лед",
          action = "next",
          value = char and 3 or math.random(2, 3)
        },
        {
          text = "Искать другой путь (-1 время)",
          action = "next",
          lost = {
            time = 1
          },
          value = 1
        }
      }
    },
    {
      text = "Вы достигаете другого берега без происшествия, но немного потратили лишнего времени из-за осторожности (-10 времени).",
      buttons = {
        {
          text = "Продолжить путь",
          action = "close",
          lost = {
            time = 10
          }
        }
      }
    },
    {
      text = char and ("Вы дошли до середины озера, как вдруг " .. name .. " проваливается под лед, скорее всего из-за веса протеза") or ("Вы дошли до середины озера, как вдруг " .. rand_name .. " проваливается под лед."),
      buttons = {
        {
          text = "Попытаться вытащить " .. (char and name or rand_name),
          action = "next",
          value = 4
        },
        {
          text = "Бежать скорее к берегу, пока трещины не дошли до вас",
          action = "close"
          lost = {
            character = char:get_id()
          }
        }
      }
    },
    {
      text = "К счастью вы все живые добираетесь до берега, но потратив очень много времени и сил (-15 времени, -2 еды).",
      buttons = {
        {
          text = "Продолжить ваш путь",
          action = "close",
          lost = {
            time = 15,
            food = 2
          }
        },
      }
    }
  }
end

return e
