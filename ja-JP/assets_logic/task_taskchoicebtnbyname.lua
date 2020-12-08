-- params : ...
-- function num : 0 , upvalues : _ENV
require("Task_TaskChoiceBtnBgByName")
require("CommonResource_RedDollByName")
GetTask_TaskChoiceBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TaskChoiceBtnBg = GetTask_TaskChoiceBtnBgUis(ui:GetChild("TaskChoiceBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.lockCtr = ui:GetController("lock")
  uis.root = ui
  return uis
end


