-- params : ...
-- function num : 0 , upvalues : _ENV
require("Prize_ProbabilityByName")
local PrizeInformationWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local slotShowId, poolType = nil, nil
PrizeInformationWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, slotShowId, uis, PrizeInformationWindow
  bridgeObj:SetView((WinResConfig.PrizeInformationWindow).package, (WinResConfig.PrizeInformationWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  slotShowId = tonumber(argTable[1])
  uis = GetPrize_ProbabilityUis(contentPane)
  ;
  (PrizeInformationWindow.InitConfig)()
  ;
  (PrizeInformationWindow.InitAssetStrip)()
  ;
  (PrizeInformationWindow.RefreshWindow)()
end

PrizeInformationWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : slotShowId, uis, _ENV, PrizeInformationWindow
  if slotShowId == nil then
    return 
  end
  ;
  (uis.TipsList):RemoveChildrenToPool()
  local excelData = ((TableData.gTable).BaseSlotsData)[slotShowId]
  local details = split(excelData.content, "|")
  for index,value in ipairs(details) do
    local detail = split(value, ",")
    local tag = detail[1]
    local title = detail[2]
    local content = detail[3]
    local cardIds = nil
    if tag == "A" then
      cardIds = split(detail[4], ":")
      local item = (uis.TipsList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.PrizeInformationWindow).package, "P_A"))
      ;
      (item:GetChild("WordTxt")).text = (PUtil.get)(tonumber(title))
      ;
      (item:GetChild("ProbabilityTxt")).text = (PUtil.get)(tonumber(content))
      local cardList = item:GetChild("CardList")
      cardList:RemoveChildrenToPool()
      for n,m in ipairs(cardIds) do
        local cardItem = cardList:AddItemFromPool()
        local cardId = tonumber(m)
        local cardData = ((TableData.gTable).BaseCardData)[cardId]
        ;
        (cardItem:GetController("c1")).selectedIndex = 0
        local starList = cardItem:GetChild("StarList")
        starList:RemoveChildrenToPool()
        for i = 1, cardData.star do
          starList:AddItemFromPool()
        end
        ;
        (cardItem:GetChild("NameTxt")).text = cardData.name
        if not cardData.fashionId then
          local fashionId = (((TableData.gTable).BaseCardQualityUpData)[tonumber(tostring(cardId) .. "00")]).unlock_fashion_id
        end
        ;
        (Util.SetSliverHeadIcon)(fashionId, (cardItem:GetChild("CardLoaderPic")):GetChild("CardLoader"))
      end
    else
      do
        if tag == "B" then
          local item = (uis.TipsList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.PrizeInformationWindow).package, "P_B"))
          ;
          (item:GetChild("WordTxt")).text = (PUtil.get)(tonumber(title))
          ;
          (item:GetChild("ProbabilityTxt")).text = (PUtil.get)(tonumber(content))
        else
          do
            if tag == "C" then
              local sorts = split(detail[4], ":")
              local item = (uis.TipsList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.PrizeInformationWindow).package, "P_C"))
              ;
              (item:GetChild("WordTxt")).text = (PUtil.get)(tonumber(title))
              ;
              (item:GetChild("ProbabilityTxt")).text = (PUtil.get)(tonumber(content))
              local itemList = item:GetChild("CardList")
              itemList.numItems = 0
              for i,v in ipairs(sorts) do
                local PoolData = ((PrizeInformationWindow.GetPoolsBySort)(tonumber(v)))
                local obj = nil
                if PoolData.intelligence == 1 then
                  obj = UIMgr:CreateObject("Prize", "PrizeItemB")
                else
                  if PoolData.intelligence == 2 then
                    obj = UIMgr:CreateObject("Prize", "PrizeItemA")
                  else
                    if PoolData.intelligence == 3 then
                      obj = UIMgr:CreateObject("Prize", "PrizeItemS")
                    else
                      obj = UIMgr:CreateObject("Prize", "PrizeItemLast")
                    end
                  end
                end
                local rewardItem = split(PoolData.reward, ":")
                local name = obj:GetChild("NameTxt")
                local icon = obj:GetChild("ItemLoader")
                local Number = obj:GetChild("NumberTxt")
                if PoolData.group_icon and not (Util.StringIsNullOrEmpty)(PoolData.group_icon) then
                  icon.url = (Util.GetItemUrl)(PoolData.group_icon)
                else
                  icon.url = (Util.GetIconPathByID)(tonumber(rewardItem[2]))
                end
                Number.text = rewardItem[3]
                name.visible = false
                itemList:AddChild(obj)
                if PoolData.tip_id and PoolData.tip_id > 0 then
                  (CommonWinMgr.RegisterItemLongPress)(obj, PoolData.tip_id)
                else
                  ;
                  (CommonWinMgr.RegisterItemLongPress)(obj, tonumber(rewardItem[2]))
                end
              end
            end
            do
              -- DECOMPILER ERROR at PC313: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC313: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC313: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC313: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC313: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC313: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

PrizeInformationWindow.InitConfig = function(...)
  -- function num : 0_2 , upvalues : _ENV, poolType
  local configData = nil
  local type = (SlotsData.GetCurrentType)()
  local ShowData = (TableData.gTable).BaseSlotsData
  for _,v in pairs(ShowData) do
    if v.type == type then
      configData = v
    end
  end
  local mData = (TableData.gTable).BaseSlotsRoundData
  for _,v in pairs(mData) do
    if v.type == configData.type then
      poolType = v.pool
    end
  end
end

PrizeInformationWindow.GetPoolsBySort = function(sort, ...)
  -- function num : 0_3 , upvalues : _ENV, poolType
  local PoolData = (TableData.gTable).BaseSlotsPoolData
  for _,v in pairs(PoolData) do
    if v.type == poolType and sort == v.sort then
      return v
    end
  end
end

PrizeInformationWindow.OnShown = function(...)
  -- function num : 0_4
end

PrizeInformationWindow.OnHide = function(...)
  -- function num : 0_5
end

PrizeInformationWindow.InitAssetStrip = function(...)
  -- function num : 0_6 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.PrizeInformationWindow).name
  m.Tip = (PUtil.get)(20000637)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

PrizeInformationWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : uis, contentPane, argTable, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.PrizeInformationWindow).name)
end

PrizeInformationWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8
end

return PrizeInformationWindow

