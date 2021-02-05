-- params : ...
-- function num : 0 , upvalues : _ENV
GetFamily_TalkRUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Nothing_01_Image = ui:GetChild("Nothing_01_Image")
  uis.TalkTxt = ui:GetChild("TalkTxt")
  uis.root = ui
  return uis
end


