-- params : ...
-- function num : 0 , upvalues : _ENV
GetFriends_TipsInfoUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.GuildImage = ui:GetChild("GuildImage")
  uis.BattleImage = ui:GetChild("BattleImage")
  uis.PlayerIDImage = ui:GetChild("PlayerIDImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


