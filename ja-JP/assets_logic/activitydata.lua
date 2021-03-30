-- params : ...
-- function num : 0 , upvalues : _ENV
ActivityData = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

ActivityData.GetCards = function(...)
  -- function num : 0_0 , upvalues : _ENV
  local List = (CardData.GetObtainedCardList)()
  local cardList = {}
  local limitConfig = nil
  for _,v in ipairs(List) do
    limitConfig = ((TableData.gTable).BaseCardLimitData)[v.id]
    if limitConfig == nil or limitConfig.shop_display ~= 0 and (limitConfig.hide_time == nil or (LuaTime.GetTimeStamp)() < tonumber(limitConfig.hide_time)) then
      (table.insert)(cardList, v)
    end
  end
  return cardList
end


