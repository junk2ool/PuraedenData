-- params : ...
-- function num : 0 , upvalues : _ENV
GetEquipt_ReNameUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameImage = ui:GetChild("NameImage")
  uis.NameImage = ui:GetChild("NameImage")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


