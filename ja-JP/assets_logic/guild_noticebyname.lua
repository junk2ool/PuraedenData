-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_NoticeUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NoticeTxt = ui:GetChild("NoticeTxt")
  uis.root = ui
  return uis
end


