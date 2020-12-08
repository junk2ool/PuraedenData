-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_EmojiChoiceByName")
GetFriends_ChatFrameUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ChatList = ui:GetChild("ChatList")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.InputTxt = ui:GetChild("InputTxt")
  uis.EmojiBtn = ui:GetChild("EmojiBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.EmojiChoice = GetFriends_EmojiChoiceUis(ui:GetChild("EmojiChoice"))
  uis.root = ui
  return uis
end


