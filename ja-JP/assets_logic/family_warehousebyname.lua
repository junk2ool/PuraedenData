-- params : ...
-- function num : 0 , upvalues : _ENV
GetFamily_WarehouseUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.BtnList = ui:GetChild("BtnList")
  uis.SortBtn = ui:GetChild("SortBtn")
  uis.FunctionBtn = ui:GetChild("FunctionBtn")
  uis.CardHeadList = ui:GetChild("CardHeadList")
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


