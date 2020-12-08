-- params : ...
-- function num : 0 , upvalues : _ENV
GetTower_LuckTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TipsImage = ui:GetChild("TipsImage")
  uis.ItemWordTxt = ui:GetChild("ItemWordTxt")
  uis.root = ui
  return uis
end


