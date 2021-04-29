-- params : ...
-- function num : 0 , upvalues : _ENV
require("BrithDayMainWindow")
BrithDayMgr = {}
-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

BrithDayMgr.OpenBrithDayWindow = function(index, ...)
  -- function num : 0_0 , upvalues : _ENV
  print("0000000000000", index, #BrithDayData.brithDayData)
  if #BrithDayData.brithDayData < index then
    ld("ActivityReturn")
    ;
    (ActivityReturnMgr.CheckNeedOpenUI)()
    return 
  end
  local cardId = (BrithDayData.brithDayData)[index] or nil
  print("111111111111cardId", cardId)
  if cardId then
    OpenWindow((WinResConfig.BrithDayMainWindow).name, UILayer.HUD, cardId, index)
  end
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

BrithDayMgr.Fade = function(...)
  -- function num : 0_1 , upvalues : _ENV
  (BrithDayMainWindow.Fade)()
end


