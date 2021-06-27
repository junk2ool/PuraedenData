-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivityDungeonTwo_SpendUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.StartBtn = ui:GetChild("StartBtn")
  uis.ReduceBtn = ui:GetChild("ReduceBtn")
  uis.AddBtn = ui:GetChild("AddBtn")
  uis.MaxBtn = ui:GetChild("MaxBtn")
  uis.Decorate_22_Image = ui:GetChild("Decorate_22_Image")
  uis.ChangeNumberTxt = ui:GetChild("ChangeNumberTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


