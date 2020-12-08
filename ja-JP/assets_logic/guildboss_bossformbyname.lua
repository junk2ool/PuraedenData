-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuildBoss_BossFormUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ShadowImage = ui:GetChild("ShadowImage")
  uis.BossLoader = ui:GetChild("BossLoader")
  uis.BossHpProgressBar = ui:GetChild("BossHpProgressBar")
  uis.OrderTxt = ui:GetChild("OrderTxt")
  uis.HpNumberTxt = ui:GetChild("HpNumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


