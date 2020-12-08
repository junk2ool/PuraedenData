-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuildBoss_SpendUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.GoldBackImage = ui:GetChild("GoldBackImage")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.root = ui
  return uis
end


