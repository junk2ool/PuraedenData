-- params : ...
-- function num : 0 , upvalues : _ENV
require("GachaCharacter001_CharacterNewCardUpPicByName")
GetLottery_GetCha_LuckBagGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardPicLoader = GetGachaCharacter001_CharacterNewCardUpPicUis(ui:GetChild("CardPicLoader"))
  uis.SpecialOneTimeBtn = ui:GetChild("SpecialOneTimeBtn")
  uis.root = ui
  return uis
end


