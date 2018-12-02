local e = function(world)
  local char = world:get_random_alive_char()
  local name = char and char:get_name() or "CHARACTER_NAME"
  return {
    {
      text = name .. " замечает на дороге странно блестящее нечто.",
      buttons = {
        {
          text = "Пройти мимо",
          action = "close"
        },
        {
          text = "Подобрать",
          action = "next",
          value = 2
        }
      }
    },
    {
      text = "Взяв в руки необычный для этих мест предмет, " .. name .. " узнает в нем Амулет. На обратной стороне амулета выцарапана карта. " .. name .. " оглядевшись понимает, куда ведет карта.",
      buttons = {
        {
          text = "Выкинуть амулет и продолжить путь",
          action = "close"
        },
        {
          text = "Дойти до места, обозначенного картой. (-20 времени)",
          action = "next",
          value = 3,
          lost = {
            time = 20
          }
        }
      }
    },
    {
      text = "Дойдя до места вы обнаруживаете ... кости!? До вас доносится смех самой смерти.",
      buttons = {
        {
          text = "Продолжить путь",
          action = "close"
        }
      }
    }
  }
end

return e
