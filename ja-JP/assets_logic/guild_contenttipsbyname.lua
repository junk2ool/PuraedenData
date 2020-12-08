-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_ContentTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.BuildWordTxt = ui:GetChild("BuildWordTxt")
  uis.root = ui
  return uis
end


