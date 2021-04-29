-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityReturn_PicByName")
require("ActivityReturn_TimeWordByName")
GetActivityReturn_PicShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Pic = GetActivityReturn_PicUis(ui:GetChild("Pic"))
  uis.TimeWord = GetActivityReturn_TimeWordUis(ui:GetChild("TimeWord"))
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.root = ui
  return uis
end


