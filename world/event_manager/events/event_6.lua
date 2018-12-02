local e = function(world)
  local robert = world:get_char_alive("robert")
  local rand = robert and 100 or math.random(0, 100)
  return {
    {
      text = "Вы встречаете говорящее дерево.\n'Я - дерево азарта, а мои карты - единственное чему можно верить. Люди лгут, а карты лгать не могут. Достань мою карту и, если на карте будет число большее 50, тебя ждет божественная награда. Но может и не повезти...'",
      buttons = {
        robert and {
          text = robert:get_name() .. " будет играть" ,
          action = "next",
          lost = rand <= 50 and {
            time = 60,
            food = 20
          },
          reward = rand > 50 and {
            time = 50,
            food = 15
          },
          value = 2
        }
        or {
          text = "Сыграть" ,
          action = "next",
          lost = rand < 0.5 and {
            time = 60,
            food = 20
          },
          reward = rand >= 0.5 and {
            time = 50,
            food = 15
          },
          value = 2
        },
        {
          text = "Пройти мимо дерева" ,
          action = "close"
        }
      },
      {
        text = "Вам выпадает число " .. rand .. ". " .. (robert and "Роберт доволен собой" or rand <= 50 and "Проигрышь! Карты лгать не могут. Получите свою награду." or "Ого, я удивлен. Карты не лгут, получите награду.") ,
        action = "close",
        lost = rand <= 50 and {
          time = 60,
          food = 20
        },
        reward = rand > 50 and {
          time = 50,
          food = 15
        }
      }
    }
  }
end

return e
