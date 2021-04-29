-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityReturn_LogonRewardByName")
require("ActivityReturn_TipsByName")
require("ActivityReturn_WordContentByName")
GetActivityReturn_LogonMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PicLoader = ui:GetChild("PicLoader")
  uis.LogonReward = GetActivityReturn_LogonRewardUis(ui:GetChild("LogonReward"))
  uis.Decorate_04_Image = GetActivityReturn_TipsUis(ui:GetChild("Decorate_04_Image"))
  uis.AnimationLoader = ui:GetChild("AnimationLoader")
  uis.WordContent = GetActivityReturn_WordContentUis(ui:GetChild("WordContent"))
  uis.root = ui
  return uis
end


