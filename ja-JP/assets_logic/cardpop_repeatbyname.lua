-- params : ...
-- function num : 0 , upvalues : _ENV
GetCardPop_RepeatUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


