-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
GetActorInfo_PlayerNameUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.n5 = GetCommonResource_Line_04Uis(ui:GetChild("n5"))
  uis.root = ui
  return uis
end


