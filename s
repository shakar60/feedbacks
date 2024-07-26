local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local TabFeedbackSection = TabF:AddSection({
  Name = "Send A Feedback Here"
})

local function sendFeedback(feedback)
  -- Check if feedback is empty
  if feedback == nil or feedback == "" then
      print("Feedback is empty. Not sending to webhook.")
      return
  end

  local Webhook_URL = "https://discord.com/api/webhooks/1218952689656795167/SJbwUyrhhj0TWBlMWCdIWRAI3OlNGdSeS7BwzMBv7CyyNO8iU38ydeVZ6x2gQUKldpqe"

  local playerName = game.Players.LocalPlayer.Name
  local playerDisplayName = game.Players.LocalPlayer.DisplayName
  local playerUserId = game.Players.LocalPlayer.UserId

  -- Construct player's Roblox profile link
  local playerProfileLink = "https://www.roblox.com/users/" .. playerUserId .. "/profile"

  local data = {
      ["embeds"] = {
          {
              ["title"] = "Feedback Received",
              ["description"] = feedback,
              ["type"] = "rich",
              ["color"] = tonumber("000000"), -- Black
              ["fields"] = {
                  {
                      ["name"] = "Player UserName:",
                      ["value"] = playerName,
                      ["inline"] = true,
                  },
                  {
                      ["name"] = "Player DisplayName:",
                      ["value"] = playerDisplayName,
                      ["inline"] = true,
                  },
                  {
                      ["name"] = "User ID:",
                      ["value"] = playerUserId,
                      ["inline"] = true,
                  },
                  {
                      ["name"] = "Player Profile:",
                      ["value"] = "[" .. playerName .. "'s Profile](" .. playerProfileLink .. ")",
                      ["inline"] = true,
                  },
              },
              ["footer"] = {
                  ["text"] = "Feedback sent from Universal Shakar's Hub",
              },
          },
      },
  }

  local PlayerData = HttpService:JSONEncode(data)

  local Request = http_request or request or HttpPost or syn.request
  Request({Url = Webhook_URL, Body = PlayerData, Method = "POST", Headers = {["Content-Type"] = "application/json"}})
end

TabFeedbackSection:AddTextbox({
  Name = "Feedback",
  Default = "",
  TextDisappear = true,
  Callback = function(feedback)
      print("Received feedback:", feedback)
      sendFeedback(feedback)
  end
})
