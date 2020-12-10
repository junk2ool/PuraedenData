-- params : ...
-- function num : 0 , upvalues : _ENV
GetPrize_RecordTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.ItemList = ui:GetChild("ItemList")
  uis.root = ui
  return uis
end


