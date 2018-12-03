local e = function(world)
  local robert = world:get_char_alive("robert")
  local rand = robert and 100 or math.random(0, 100)
  return {
    {
      text = "On the way you hear an unfamiliar voice and find out it comes out of a tree. You think you completely lost your mind by now when it says, \"Do you want to play a game? People lie, cards never do. If you would be lucky enough to take a card with a number more then 50, I\'ll reward you generously. But if you won\'t, well...",
      buttons = {
        robert and {
          text = "Let ".. robert:get_name() .. " play" ,
          action = "next",
          lost = rand <= 50 and {
            time = 40,
            food = 10
          },
          reward = rand > 50 and {
            time = 40,
            food = 10
          },
          value = 2
        }
        or {
          text = "Give it a chance" ,
          action = "next",
          lost = rand < 0.5 and {
            time = 40,
            food = 10
          },
          reward = rand >= 0.5 and {
            time = 49,
            food = 10
          },
          value = 2
        },
        {
          text = "Walk past" ,
          action = "close"
        }
      },
    },
      {
        text = "You get a card with the number of " .. rand .. ". " .. (robert and "Robert is proud of himself" or rand <= 50 and "Well, you lose. Cards don't lie. Take your reward " or "Surprising. Yet cards don't lie, take your reward .") ,
        action = "close",
        lost = rand <= 50 and {
          time = 50,
          food = 10
        },
        reward = rand > 50 and {
          time = 50,
          food = 10
        },
        buttons = {
          {
            text = "Continue your journey " ,
            action = "close"
          }
        }
      }
    }
end

return e
