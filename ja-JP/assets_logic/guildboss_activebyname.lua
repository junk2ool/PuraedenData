-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuildBoss_ActiveUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.ActiveProgressBar = ui:GetChild("ActiveProgressBar")
  uis.TipsBtn = ui:GetChild("TipsBtn")
  uis.root = ui
  return uis
end


