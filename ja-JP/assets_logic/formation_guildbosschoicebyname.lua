-- params : ...
-- function num : 0 , upvalues : _ENV
GetFormation_GuildBossChoiceUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ABtn = ui:GetChild("ABtn")
  uis.BBtn = ui:GetChild("BBtn")
  uis.CBtn = ui:GetChild("CBtn")
  uis.DBtn = ui:GetChild("DBtn")
  uis.EBtn = ui:GetChild("EBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


