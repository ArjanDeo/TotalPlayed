-- Create a frame to register and handle events
local frame = CreateFrame("Frame")

-- Register the event for time played message
frame:RegisterEvent("TIME_PLAYED_MSG")

-- Event handler for the frame
frame:SetScript("OnEvent", function(self, event, ...)
  if event == "TIME_PLAYED_MSG" then
    -- Get the total played time and played time at this level
    local TotalPlayed, PlayedThisLevel = ...

    -- Check if TotalPlayTimeForCharacter is nil, if so initialize it
    if TotalPlayTimeForCharacter == nil then
      TotalPlayTimeForCharacter = TotalPlayed
      TotalPlayTime = TotalPlayTime + TotalPlayed
    else
      -- Remove this character's previous playtime from the saved total playtime
      TotalPlayTime = TotalPlayTime - TotalPlayTimeForCharacter
      -- Update this character's total playtime to the new value
      TotalPlayTimeForCharacter = TotalPlayed
      -- Add this character's new playtime to the saved total playtime
      TotalPlayTime = TotalPlayTime + TotalPlayTimeForCharacter
    end
  end
end)

-- Request the server to send the played time message
RequestTimePlayed()

-- Define a slash command for "/tp"
SLASH_TotalPlayTime1 = "/tp"
function SlashCmdList.TotalPlayTime(msg)
  -- Print the playtime for this character and total playtime across all characters
  print("You have played this character for " .. (TotalPlayTimeForCharacter / 3600) .. " hours!")
  print("You have played across all characters for " .. (TotalPlayTime / 3600) .. " hours!")
end
