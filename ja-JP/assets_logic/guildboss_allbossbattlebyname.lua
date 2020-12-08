-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuildBoss_AllBossBattleUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.AllBossTipsList = ui:GetChild("AllBossTipsList")
  uis.root = ui
  return uis
end


