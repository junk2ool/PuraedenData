-- params : ...
-- function num : 0 , upvalues : _ENV
GetActorInfo_ListChoiceUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TypeABtn = ui:GetChild("TypeABtn")
  uis.TypeBBtn = ui:GetChild("TypeBBtn")
  uis.BgList = ui:GetChild("BgList")
  uis.CardHeadList = ui:GetChild("CardHeadList")
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


