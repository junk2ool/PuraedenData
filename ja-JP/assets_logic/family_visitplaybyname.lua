-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_PlayerChoiceByName")
GetFamily_VisitPlayUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.PlayerList = GetFamily_PlayerChoiceUis(ui:GetChild("PlayerList"))
  uis.root = ui
  return uis
end


