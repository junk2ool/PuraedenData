-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivityDungeonTwo_PlotMainUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ChapterTxt = ui:GetChild("ChapterTxt")
  uis.NumberPagesTxt = ui:GetChild("NumberPagesTxt")
  uis.MapList = ui:GetChild("MapList")
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.root = ui
  return uis
end


