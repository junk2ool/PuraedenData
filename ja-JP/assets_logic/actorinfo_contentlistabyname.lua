-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_PlayerNameByName")
require("ActorInfo_WordByName")
GetActorInfo_ContentListAUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Info_B_Btn = ui:GetChild("Info_B_Btn")
  uis.PlayerName = GetActorInfo_PlayerNameUis(ui:GetChild("PlayerName"))
  uis.ABtn = ui:GetChild("ABtn")
  uis.BBtn = ui:GetChild("BBtn")
  uis.CBtn = ui:GetChild("CBtn")
  uis.DBtn = ui:GetChild("DBtn")
  uis.Word = GetActorInfo_WordUis(ui:GetChild("Word"))
  uis.root = ui
  return uis
end


