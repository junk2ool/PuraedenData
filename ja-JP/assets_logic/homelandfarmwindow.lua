-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_FarmByName")
local HomelandFarmWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local MAXLANDNUM = 6
local landItems = {}
local swipeDic = {}
local fakeItemPool = {}
local checkPoints = {}
local selectedLandIndex = {}
local showSeeds = {}
local SeedShowType = {All = 1, Normal = 2, Rare = 3, Prop = 4}
local seedShowType = SeedShowType.All
local sortIsUp = true
local myTime = {}
local farmInfo = {}
local windMial, clickedItem = nil, nil
local oriFarmExp = 0
local expTimer = nil
HomelandFarmWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, farmInfo, oriFarmExp, HomelandFarmWindow, MAXLANDNUM, landItems, swipeDic, sortIsUp, myTime, seedShowType, SeedShowType
  bridgeObj:SetView((WinResConfig.HomelandFarmWindow).package, (WinResConfig.HomelandFarmWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetFamily_FarmUis(contentPane)
  farmInfo = (HomelandData.GetFarmInfo)()
  oriFarmExp = farmInfo.farmExp
  ;
  (HomelandFarmWindow.InitAssetResource)()
  ;
  ((uis.HouseBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    ld("Homeland", function(...)
      -- function num : 0_0_0_0 , upvalues : _ENV
      (HomelandMgr.OpenRoom)()
    end
)
  end
)
  for i = 1, MAXLANDNUM do
    local landBtn = (uis.root):GetChild("Land_" .. tostring(i))
    do
      (table.insert)(landItems, landBtn)
      local index = i
      ;
      (landBtn.onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : HomelandFarmWindow, index
    (HomelandFarmWindow.OnClickLandFunc)(index)
  end
)
    end
  end
  ;
  ((uis.HarvestBtn).onClick):Set(function(...)
    -- function num : 0_0_2 , upvalues : _ENV
    (HomelandService.ReqLandHarvest)(0)
  end
)
  ;
  ((uis.WareHouseBtn).onClick):Set(function(...)
    -- function num : 0_0_3 , upvalues : HomelandFarmWindow
    (HomelandFarmWindow.OpenWareHouse)()
  end
)
  ;
  ((uis.ShopBtn).onClick):Set(function(...)
    -- function num : 0_0_4 , upvalues : _ENV
    (HomelandService.ReqFarmShopTypeData)(7)
  end
)
  ;
  (((uis.FarmScene).root).onClick):Set(function(...)
    -- function num : 0_0_5 , upvalues : uis, _ENV, swipeDic
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    if (uis.c1Ctr).selectedIndex == 1 then
      (uis.c1Ctr).selectedIndex = 0
      for key,value in pairs(swipeDic) do
        value:Dispose()
      end
      swipeDic = {}
    end
  end
)
  sortIsUp = true
  for index,value in ipairs(myTime) do
    if value then
      value:Stop()
    end
  end
  myTime = {}
  seedShowType = SeedShowType.All
  ;
  ((((uis.Warehouse).CardHeadList).scrollPane).onScroll):Add(function(...)
    -- function num : 0_0_6 , upvalues : HomelandFarmWindow
    (HomelandFarmWindow.CheckArrow)()
  end
)
  ;
  (HomelandFarmWindow.CheckArrow)()
  ;
  (HomelandFarmWindow.InitLandArea)()
  ;
  (HomelandFarmWindow.RefreshFarmWindow)()
  local effect, obj = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_FARMLAND_WINDMIAL, false, false, nil, 100)
  ;
  ((uis.Empty).root):AddChild(effect)
  effect:SetXY(((uis.Empty).root).width * 0.5, ((uis.Empty).root).height * 0.5)
  ;
  (SkeletonAnimationUtil.SetAnimation)(obj, 0, "idle", true, nil, true)
  ;
  (HomelandFarmWindow.AddBgEffect)()
  ;
  (GuideMgr.PictureTriggerGuide)((WinResConfig.HomelandFarmWindow).name)
end

HomelandFarmWindow.OnClickLandFunc = function(clickIndex, ...)
  -- function num : 0_1 , upvalues : _ENV, clickedItem, landItems, farmInfo, HomelandFarmWindow
  print("----------------clickIndex", clickIndex)
  clickedItem = landItems[clickIndex]
  local landData = (HomelandData.GetLandInfoByIndex)(clickIndex)
  if not (landData.serverData).status then
    local landStatus = (ProtoEnum.LAND_STATUS).DEFAULT_LOCK
  end
  if landStatus == (ProtoEnum.LAND_STATUS).DEFAULT_LOCK then
    local farmLvl = farmInfo.farmLevel
    do
      local landConfigData = nil
      for key,value in pairs((TableData.gTable).BaseFamilyFarmLandData) do
        if value.type == clickIndex then
          landConfigData = value
        end
      end
      do
        local needLvl = landConfigData.farm_level
        if needLvl <= farmLvl and (Util.CheckCostResources)(landConfigData.cost, nil, nil, false, true) then
          local costStr = split(landConfigData.cost, ",")
          local str = ""
          for k,v in pairs(costStr) do
            str = str .. (MessageMgr.GetCostImgHtmlByStr)(v)
          end
          ;
          (MessageMgr.OpenConfirmWindow)((PUtil.get)(259, str), function(...)
    -- function num : 0_1_0 , upvalues : _ENV, landConfigData
    (HomelandService.ReqLandUnlock)(landConfigData.id)
  end
)
        end
        do
          ;
          (MessageMgr.SendCenterTips)((PUtil.get)(256, needLvl))
        end
        if landStatus == (ProtoEnum.LAND_STATUS).FREE then
          local seedNum = 0
          for key,value in pairs(farmInfo.seedInfo) do
            seedNum = seedNum + value.stock
          end
          if seedNum > 0 then
            (HomelandFarmWindow.OpenWareHouse)()
          else
            ;
            (MessageMgr.OpenConfirmWindow)((PUtil.get)(253), function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    (HomelandService.ReqFarmShopTypeData)(7)
  end
)
          end
        else
          do
            if landStatus == (ProtoEnum.LAND_STATUS).PLANTED then
              (MessageMgr.OpenConfirmWindow)((PUtil.get)(252), function(...)
    -- function num : 0_1_2 , upvalues : _ENV, landData
    (HomelandService.ReqLandUproot)((landData.serverData).id)
  end
)
            else
              if landStatus == (ProtoEnum.LAND_STATUS).HARVEST then
                (HomelandService.ReqLandHarvest)((landData.serverData).id)
              end
            end
          end
        end
      end
    end
  end
end

HomelandFarmWindow.SetLandState = function(index, ...)
  -- function num : 0_2 , upvalues : landItems, _ENV, farmInfo, HomelandFarmWindow
  local land = landItems[index]
  local landData = (HomelandData.GetLandInfoByIndex)(index)
  print("-------index", index, (landData.serverData).status)
  local timeGrp = (land:GetChild("Plant")):GetChild("Time")
  timeGrp.visible = false
  if not (landData.serverData).status then
    local landStatus = (ProtoEnum.LAND_STATUS).DEFAULT_LOCK
  end
  if landStatus == (ProtoEnum.LAND_STATUS).DEFAULT_LOCK then
    (land:GetController("c1")).selectedIndex = 1
    local farmLvl = farmInfo.farmLevel
    local landConfigData = nil
    for key,value in pairs((TableData.gTable).BaseFamilyFarmLandData) do
      if value.type == index then
        landConfigData = value
      end
    end
    local needLvl = landConfigData.farm_level
    print("判断是否可以解锁", farmLvl, needLvl)
    if needLvl <= farmLvl then
      ((land:GetChild("LandTips_A")):GetController("c1")).selectedIndex = 1
    else
      ;
      ((land:GetChild("LandTips_A")):GetController("c1")).selectedIndex = 2
    end
  else
    do
      if landStatus == (ProtoEnum.LAND_STATUS).FREE then
        (land:GetController("c1")).selectedIndex = 0
        ;
        ((land:GetChild("LandTips_A")):GetController("c1")).selectedIndex = 2
      else
        if landStatus == (ProtoEnum.LAND_STATUS).PLANTED then
          (land:GetController("c1")).selectedIndex = 0
          ;
          ((land:GetChild("LandTips_A")):GetController("c1")).selectedIndex = 2
          ;
          (HomelandFarmWindow.CreatPlantOnLand)(index, landData.serverData)
        else
          if landStatus == (ProtoEnum.LAND_STATUS).HARVEST then
            (land:GetController("c1")).selectedIndex = 0
            ;
            ((land:GetChild("LandTips_A")):GetController("c1")).selectedIndex = 0
            ;
            (HomelandFarmWindow.CreatPlantOnLand)(index, landData.serverData)
          end
        end
      end
    end
  end
end

HomelandFarmWindow.RefreshFarmWindow = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV, farmInfo, oriFarmExp, MAXLANDNUM, HomelandFarmWindow, seedShowType
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.Level).WordTxt).text = (PUtil.get)(236)
  local farmConfig = ((TableData.gTable).BaseFamilyFarmUpData)[farmInfo.farmLevel + 76610000]
  local farmMaxLevel = 0
  for key,value in pairs((TableData.gTable).BaseFamilyFarmUpData) do
    if farmMaxLevel < value.level then
      farmMaxLevel = value.level
    end
  end
  local lvlUpExp = 0
  lvlUpExp = farmConfig.nextExp
  local levelExpBar = ((uis.Level).root):GetChild("LevelExpBar")
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

  if farmMaxLevel == farmInfo.farmLevel and lvlUpExp < farmInfo.farmExp then
    ((uis.Level).LevelExpTxt).text = (PUtil.get)(60000432)
    levelExpBar.value = 100
  else
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((uis.Level).LevelExpTxt).text = farmInfo.farmExp .. "/" .. lvlUpExp
  end
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.Level).FarmLevelTxt).text = (PUtil.get)(22) .. farmInfo.farmLevel
  if oriFarmExp < farmInfo.farmExp then
    ((LeanTween.value)(levelExpBar.value, farmInfo.farmExp / lvlUpExp * 100, 0.5)):setOnUpdate(function(value, ...)
    -- function num : 0_3_0 , upvalues : levelExpBar
    levelExpBar.value = value
  end
)
    ;
    (((LeanTween.value)(oriFarmExp, farmInfo.farmExp, 0.5)):setOnUpdate(function(value, ...)
    -- function num : 0_3_1 , upvalues : uis, _ENV, lvlUpExp
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

    ((uis.Level).LevelExpTxt).text = (math.floor)(value) .. "/" .. lvlUpExp
  end
)):setOnComplete(function(...)
    -- function num : 0_3_2 , upvalues : oriFarmExp, farmInfo
    oriFarmExp = farmInfo.farmExp
  end
)
  else
    if farmInfo.farmExp < oriFarmExp then
      (((LeanTween.value)(levelExpBar.value, 100, 0.25)):setOnUpdate(function(value, ...)
    -- function num : 0_3_3 , upvalues : levelExpBar
    levelExpBar.value = value
  end
)):setOnComplete(function(...)
    -- function num : 0_3_4 , upvalues : _ENV, farmInfo, lvlUpExp, levelExpBar, oriFarmExp
    ((LeanTween.value)(0, farmInfo.farmExp / lvlUpExp * 100, 0.25)):setOnUpdate(function(value, ...)
      -- function num : 0_3_4_0 , upvalues : levelExpBar, oriFarmExp, farmInfo
      levelExpBar.value = value
      oriFarmExp = farmInfo.farmExp
    end
)
  end
)
    else
      levelExpBar.value = farmInfo.farmExp / lvlUpExp * 100
    end
  end
  for i = 1, MAXLANDNUM do
    (HomelandFarmWindow.SetLandState)(i)
  end
  if (uis.c1Ctr).selectedIndex == 1 then
    (HomelandFarmWindow.ShowSeedList)(seedShowType)
  end
end

HomelandFarmWindow.OpenWareHouse = function(...)
  -- function num : 0_4 , upvalues : uis, sortIsUp, HomelandFarmWindow, _ENV, SeedShowType
  if (uis.c1Ctr).selectedIndex == 1 then
    return 
  else
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.c1Ctr).selectedIndex = 1
  end
  ;
  (((uis.Warehouse).SortBtn).onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : sortIsUp, HomelandFarmWindow
    sortIsUp = not sortIsUp
    ;
    (HomelandFarmWindow.ShowSeedList)()
  end
)
  ;
  (((uis.Warehouse).FunctionBtn).onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : HomelandFarmWindow
    (HomelandFarmWindow.AutoPlant)()
  end
)
  ;
  ((uis.Warehouse).BtnList):RemoveChildrenToPool()
  local allBtn = ((uis.Warehouse).BtnList):AddItemFromPool()
  ;
  (allBtn:GetChild("NameTxt")).text = (PUtil.get)(25)
  ;
  (allBtn.onClick):Set(function(...)
    -- function num : 0_4_2 , upvalues : uis, HomelandFarmWindow, SeedShowType
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.Warehouse).BtnList).selectedIndex = 0
    ;
    (HomelandFarmWindow.ShowSeedList)(SeedShowType.All)
  end
)
  local normalSeedBtn = ((uis.Warehouse).BtnList):AddItemFromPool()
  ;
  (normalSeedBtn:GetChild("NameTxt")).text = (PUtil.get)(237)
  ;
  (normalSeedBtn.onClick):Set(function(...)
    -- function num : 0_4_3 , upvalues : uis, HomelandFarmWindow, SeedShowType
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.Warehouse).BtnList).selectedIndex = 1
    ;
    (HomelandFarmWindow.ShowSeedList)(SeedShowType.Normal)
  end
)
  local rareBtn = ((uis.Warehouse).BtnList):AddItemFromPool()
  ;
  (rareBtn:GetChild("NameTxt")).text = (PUtil.get)(238)
  ;
  (rareBtn.onClick):Set(function(...)
    -- function num : 0_4_4 , upvalues : uis, HomelandFarmWindow, SeedShowType
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.Warehouse).BtnList).selectedIndex = 2
    ;
    (HomelandFarmWindow.ShowSeedList)(SeedShowType.Rare)
  end
)
  ;
  (((uis.Warehouse).SortBtn):GetChild("n6")).text = (PUtil.get)(241)
  ;
  (((uis.Warehouse).FunctionBtn):GetChild("title")).text = (PUtil.get)(240)
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.Warehouse).BtnList).selectedIndex = 0
  ;
  (HomelandFarmWindow.ShowSeedList)(SeedShowType.All, true)
end

HomelandFarmWindow.SelectSeed = function(sType, ...)
  -- function num : 0_5 , upvalues : SeedShowType, _ENV, farmInfo
  local tShowSeeds = {}
  if sType == SeedShowType.All then
    for key,value in pairs(farmInfo.seedInfo) do
      local seedConfig = ((TableData.gTable).BaseFamilyFarmSeedData)[value.id]
      ;
      (table.insert)(tShowSeeds, {seedConfig = seedConfig, stock = value.stock})
    end
  else
    do
      if sType == SeedShowType.Normal then
        for key,value in pairs(farmInfo.seedInfo) do
          local seedConfig = ((TableData.gTable).BaseFamilyFarmSeedData)[value.id]
          if seedConfig.intelligence == 1 then
            (table.insert)(tShowSeeds, {seedConfig = seedConfig, stock = value.stock})
          end
        end
      else
        do
          if sType == SeedShowType.Rare then
            for key,value in pairs(farmInfo.seedInfo) do
              local seedConfig = ((TableData.gTable).BaseFamilyFarmSeedData)[value.id]
              if seedConfig.intelligence == 2 then
                (table.insert)(tShowSeeds, {seedConfig = seedConfig, stock = value.stock})
              end
            end
          else
          end
          do
            if sType == SeedShowType.Prop then
              return tShowSeeds
            end
          end
        end
      end
    end
  end
end

HomelandFarmWindow.SortSeed = function(...)
  -- function num : 0_6 , upvalues : _ENV, showSeeds, sortIsUp
  (table.sort)(showSeeds, function(a, b, ...)
    -- function num : 0_6_0 , upvalues : sortIsUp
    if (a.seedConfig).quality >= (b.seedConfig).quality then
      do return not sortIsUp end
      do return (b.seedConfig).quality < (a.seedConfig).quality end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
end

HomelandFarmWindow.ShowSeedList = function(showType, isInit, ...)
  -- function num : 0_7 , upvalues : seedShowType, showSeeds, HomelandFarmWindow, uis, SeedShowType, _ENV
  if showType then
    seedShowType = showType
    showSeeds = {}
    showSeeds = (HomelandFarmWindow.SelectSeed)(showType)
  end
  ;
  ((uis.Warehouse).CardHeadList):RemoveChildrenToPool()
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  if #showSeeds == 0 then
    ((uis.Warehouse).c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

    if showType == SeedShowType.Rare then
      ((uis.Warehouse).WordTxt).text = (PUtil.get)(292)
    else
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((uis.Warehouse).WordTxt).text = (PUtil.get)(242)
    end
  else
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.Warehouse).c1Ctr).selectedIndex = 0
    ;
    (HomelandFarmWindow.SortSeed)()
    for key,value in pairs(showSeeds) do
      local seedConfig = value.seedConfig
      local seedItem = ((uis.Warehouse).CardHeadList):AddItemFromPool()
      ;
      ((seedItem:GetChild("ItemFrame")):GetChild("IconLoader")).url = (Util.GetItemUrl)(seedConfig.icon)
      ;
      ((seedItem:GetChild("ItemFrame")):GetChild("NumberTxt")).text = value.stock
      ;
      (seedItem:GetChild("WordTxt")).text = (LuaTime.GetTimeStrDHM)(seedConfig.end_time)
      ;
      ((seedItem:GetChild("ItemFrame")):GetController("Quality")).selectedIndex = seedConfig.quality
      ;
      (HomelandFarmWindow.InitSeedGestureAndClick)(seedItem, value)
    end
  end
end

HomelandFarmWindow.AutoPlant = function(...)
  -- function num : 0_8 , upvalues : _ENV, farmInfo, HomelandFarmWindow, SeedShowType
  local emptyLand = {}
  for index,value in pairs(farmInfo.landInfo) do
    if value.status == (ProtoEnum.LAND_STATUS).FREE then
      (table.insert)(emptyLand, value.id)
    end
  end
  print("-------共有多少个空土地", #emptyLand)
  if #emptyLand == 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(254))
    return 
  end
  local allSeed = (HomelandFarmWindow.SelectSeed)(SeedShowType.All)
  local perSeedNum = {}
  local totalSeedNum = 0
  for index,value in ipairs(allSeed) do
    local num = (math.floor)(value.stock / (value.seedConfig).use_num)
    totalSeedNum = totalSeedNum + value.stock
    if num > 0 then
      (table.insert)(perSeedNum, {id = (value.seedConfig).id, num = num})
      print("种子id为", (value.seedConfig).id, "的种子可以种", num)
    else
      print("种子id为", (value.seedConfig).id, "的种子 不够种一次")
    end
  end
  if totalSeedNum == 0 then
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(253), function(...)
    -- function num : 0_8_0 , upvalues : _ENV
    (HomelandService.ReqFarmShopTypeData)(7)
  end
)
    return 
  end
  if #perSeedNum == 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(255))
    return 
  end
  for index,value in ipairs(perSeedNum) do
    print("===种子id", value.id, "可种植次数", value.num)
  end
  local finalPlantInfo = {}
  for index,value in ipairs(emptyLand) do
    for j,k in ipairs(perSeedNum) do
      if k.num > 0 then
        (table.insert)(finalPlantInfo, {landId = value, seedId = k.id})
        -- DECOMPILER ERROR at PC136: Confused about usage of register: R15 in 'UnsetPending'

        ;
        (perSeedNum[j]).num = (perSeedNum[j]).num - 1
        break
      end
    end
  end
  for index,value in ipairs(finalPlantInfo) do
    print("最后土地为", value.landId, "的土地种植了", value.seedId)
  end
  ;
  (HomelandService.ReqLandPlanting)(finalPlantInfo)
end

HomelandFarmWindow.InitSeedGestureAndClick = function(item, seedData, ...)
  -- function num : 0_9 , upvalues : uis, _ENV, selectedLandIndex, HomelandFarmWindow, clickedItem, landItems
  local isDrag = false
  local startPoint, beginPoint, fakeSeedItem = nil, nil, nil
  local inWhichLandIndex = 0
  local loader = ((uis.Land_1).root):GetChild("n1")
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_9_0 , upvalues : isDrag, _ENV, seedData
    if not isDrag then
      OpenWindow((WinResConfig.FamilyTipsWindow).name, UILayer.HUD, 1, (seedData.seedConfig).id)
    end
  end
)
  ;
  (item.onTouchBegin):Set(function(...)
    -- function num : 0_9_1 , upvalues : startPoint, _ENV
    startPoint = Input.mousePosition
  end
)
  local swipeGes = (FairyGUI.SwipeGesture)(item)
  swipeGes.actionDistance = 100
  ;
  (swipeGes.onBegin):Set(function(...)
    -- function num : 0_9_2 , upvalues : selectedLandIndex, beginPoint, _ENV, startPoint, seedData, isDrag, uis, fakeSeedItem, HomelandFarmWindow
    selectedLandIndex = {}
    beginPoint = (Vector3.Normalize)(Input.mousePosition - startPoint)
    local yAxis = Vector3(0, 1, 0)
    local angle = (Vector3.Dot)(beginPoint, yAxis)
    if angle > 0.5 then
      if (seedData.seedConfig).use_num <= seedData.stock then
        isDrag = true
        -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (((uis.Warehouse).CardHeadList).scrollPane).touchEffect = false
        fakeSeedItem = (HomelandFarmWindow.CreatFakeItem)((seedData.seedConfig).icon)
        fakeSeedItem.visible = true
        fakeSeedItem.position = Input.mousePosition
        ;
        (uis.root):AddChild(fakeSeedItem)
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(251))
      end
    end
  end
)
  ;
  (swipeGes.onMove):Set(function(...)
    -- function num : 0_9_3 , upvalues : isDrag, _ENV, item, fakeSeedItem, HomelandFarmWindow
    if isDrag then
      local input = Input.mousePosition
      local itemPosition = Vector3(input.x / Screen.width * ResolutionHandler.Width - item.width * 0.5, (Screen.height - input.y) / Screen.height * ResolutionHandler.Height - item.height * 0.5, 0)
      if fakeSeedItem then
        fakeSeedItem.position = itemPosition
      end
      ;
      (HomelandFarmWindow.CheckHitWhichLand)(Vector3(input.x / Screen.width * ResolutionHandler.Width, (Screen.height - input.y) / Screen.height * ResolutionHandler.Height, 0))
    end
  end
)
  ;
  (swipeGes.onEnd):Set(function(...)
    -- function num : 0_9_4 , upvalues : isDrag, _ENV, uis, fakeSeedItem, selectedLandIndex, seedData, clickedItem, landItems
    if isDrag then
      (SimpleTimer.setTimeout)(0.01, function(...)
      -- function num : 0_9_4_0 , upvalues : isDrag
      isDrag = false
    end
)
      -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (((uis.Warehouse).CardHeadList).scrollPane).touchEffect = true
      if fakeSeedItem then
        fakeSeedItem.visible = false
      end
      for index,value in ipairs(selectedLandIndex) do
        if value ~= -1 then
          print("申请种植种子到土地", value, (seedData.seedConfig).id)
          clickedItem = landItems[value]
          local plantInfo = {
{landId = (((HomelandData.GetLandInfoByIndex)(index)).configData).id, seedId = (seedData.seedConfig).id}
}
          ;
          (HomelandService.ReqLandPlanting)(plantInfo)
        end
      end
    end
  end
)
end

HomelandFarmWindow.InitLandArea = function(...)
  -- function num : 0_10 , upvalues : _ENV, landItems, checkPoints
  for index,value in ipairs(landItems) do
    local rootP = value.position
    local width = value.width
    local height = value.height
    ;
    (table.insert)(checkPoints, {Ap = Vector3(rootP.x, rootP.y + height * 0.5, rootP.z), Bp = Vector3(rootP.x + width * 0.5, rootP.y, rootP.z), Cp = Vector3(rootP.x + width, rootP.y + height * 0.5, rootP.z), Dp = Vector3(rootP.x + width * 0.5, rootP.y + height, rootP.z)})
  end
end

HomelandFarmWindow.CheckHitWhichLand = function(inputP, ...)
  -- function num : 0_11 , upvalues : selectedLandIndex, _ENV, checkPoints
  selectedLandIndex = {}
  for index,value in ipairs(checkPoints) do
    local AB = value.Bp - value.Ap
    local AE = inputP - value.Ap
    local CD = value.Dp - value.Cp
    local CE = inputP - value.Cp
    local t1 = (Vector3.Dot)((Vector3.Cross)(AB, AE), (Vector3.Cross)(CD, CE))
    local DA = value.Ap - value.Dp
    local DE = inputP - value.Dp
    local BC = value.Cp - value.Bp
    local BE = inputP - value.Bp
    local t2 = (Vector3.Dot)((Vector3.Cross)(BC, BE), (Vector3.Cross)(DA, DE))
    if t1 >= 0 and t2 >= 0 then
      (table.insert)(selectedLandIndex, index)
    else
      ;
      (table.insert)(selectedLandIndex, -1)
    end
  end
end

HomelandFarmWindow.GetSwipeGesture = function(item, ...)
  -- function num : 0_12 , upvalues : swipeDic, _ENV
  if swipeDic[item] == nil then
    swipeDic[item] = (FairyGUI.SwipeGesture)(item)
  end
  return swipeDic[item]
end

HomelandFarmWindow.CreatFakeItem = function(str, ...)
  -- function num : 0_13 , upvalues : fakeItemPool, _ENV
  if fakeItemPool[str] then
    return fakeItemPool[str]
  else
    local resourceStr = split(str, ":")
    local fakeSeedItem = UIMgr:CreateObject(resourceStr[1], resourceStr[2])
    fakeItemPool[str] = fakeSeedItem
    return fakeSeedItem
  end
end

HomelandFarmWindow.CreatPlantOnLand = function(landIndex, landInfo, ...)
  -- function num : 0_14 , upvalues : landItems, _ENV, HomelandFarmWindow, myTime
  local tarLand = landItems[landIndex]
  local timeGrp = (tarLand:GetChild("Plant")):GetChild("Time")
  local timeBar = timeGrp:GetChild("TimeBar")
  local seedConfig = ((TableData.gTable).BaseFamilyFarmSeedData)[landInfo.seedId]
  local finalNeedTime = seedConfig.end_time
  timeGrp.visible = landInfo.countDown > 0
  print("landInfo.countDown", landInfo.countDown, finalNeedTime)
  local growType = 1
  if landInfo.countDown <= seedConfig.end_time * 0.5 then
    if landInfo.countDown == 0 then
      growType = 3
    else
      growType = 2
    end
  else
    growType = 1
  end
  timeBar.value = (finalNeedTime - landInfo.countDown) / finalNeedTime * 100
  do
    if landInfo.countDown > 0 then
      local countTime = (LuaTime.CountDownForFarm)(landInfo.countDown, timeGrp:GetChild("TimeTxt"), function(...)
    -- function num : 0_14_0 , upvalues : timeGrp, _ENV, landIndex, HomelandFarmWindow
    timeGrp.visible = false
    ;
    (HomelandData.SetLandInfoByIndex)(landIndex, (ProtoEnum.LAND_STATUS).HARVEST, 0)
    ;
    (HomelandFarmWindow.SetLandState)(landIndex)
  end
, nil, function(value, ...)
    -- function num : 0_14_1 , upvalues : finalNeedTime, landInfo, timeBar, growType, HomelandFarmWindow, tarLand, seedConfig
    local sonValue = finalNeedTime - landInfo.countDown + value
    timeBar.value = sonValue / finalNeedTime * 100
    -- DECOMPILER ERROR at PC19: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC19: Unhandled construct in 'MakeBoolean' P1

    if finalNeedTime * 0.5 <= sonValue and sonValue == finalNeedTime and growType ~= 3 then
      growType = 3
      ;
      (HomelandFarmWindow.SetLandPlant)(tarLand, seedConfig, growType)
    end
    if growType ~= 2 then
      growType = 2
      ;
      (HomelandFarmWindow.SetLandPlant)(tarLand, seedConfig, growType)
    end
    growType = 1
  end
)
      ;
      (table.insert)(myTime, countTime)
    end
    ;
    (HomelandFarmWindow.SetLandPlant)(tarLand, seedConfig, growType)
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

HomelandFarmWindow.SetLandPlant = function(tarLand, seedConfig, growType, ...)
  -- function num : 0_15 , upvalues : _ENV
  local lastChild = (tarLand:GetChild("LandEffects")):GetChild("gnls")
  local plantLoader = (tarLand:GetChild("LandEffects")):GetChild("PlantLoader")
  if lastChild then
    lastChild:Dispose()
  end
  local plantResource, resourceStr = nil, nil
  local x = 0
  local y = 0.4
  if growType == 1 then
    resourceStr = split(seedConfig.grow1_icon, ":")
    x = 35
    y = 0.08
  else
    if growType == 2 then
      resourceStr = split(seedConfig.grow2_icon, ":")
      x = 15
      y = 0.25
    else
      if growType == 3 then
        resourceStr = split(seedConfig.grow3_icon, ":")
      end
    end
  end
  plantLoader.url = UIMgr:GetItemUrl(resourceStr[1], resourceStr[2])
end

HomelandFarmWindow.ClearAllLandPlants = function(...)
  -- function num : 0_16 , upvalues : _ENV, landItems
  for index,value in ipairs(landItems) do
    local lastChild = (value:GetChild("LandEffects")):GetChild("gnls")
    local plantLoader = (value:GetChild("LandEffects")):GetChild("PlantLoader")
    plantLoader.url = nil
    if lastChild then
      lastChild:Dispose()
    end
  end
end

HomelandFarmWindow.CheckArrow = function(...)
  -- function num : 0_17 , upvalues : uis
  if (uis.Warehouse).LeftBtn == nil or (uis.Warehouse).RightBtn == nil then
    return 
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  if (((uis.Warehouse).CardHeadList).scrollPane).contentWidth <= (((uis.Warehouse).CardHeadList).scrollPane).viewWidth then
    ((uis.Warehouse).LeftBtn).visible = false
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.Warehouse).RightBtn).visible = false
  else
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

    if (((uis.Warehouse).CardHeadList).scrollPane).isRightMost then
      ((uis.Warehouse).LeftBtn).visible = true
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.Warehouse).RightBtn).visible = false
    else
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R0 in 'UnsetPending'

      if (((uis.Warehouse).CardHeadList).scrollPane).isLeftMost then
        ((uis.Warehouse).LeftBtn).visible = false
        -- DECOMPILER ERROR at PC50: Confused about usage of register: R0 in 'UnsetPending'

        ;
        ((uis.Warehouse).RightBtn).visible = true
      else
        -- DECOMPILER ERROR at PC54: Confused about usage of register: R0 in 'UnsetPending'

        ;
        ((uis.Warehouse).LeftBtn).visible = true
        -- DECOMPILER ERROR at PC57: Confused about usage of register: R0 in 'UnsetPending'

        ;
        ((uis.Warehouse).RightBtn).visible = true
      end
    end
  end
end

HomelandFarmWindow.InitAssetResource = function(...)
  -- function num : 0_18 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.HomelandFarmWindow).name
  m.Tip = (PUtil.get)(236)
  m.model = uis.AssetStripGrp
  m.BackBtnFun = function(...)
    -- function num : 0_18_0 , upvalues : _ENV
    UIMgr:CloseToWindow((WinResConfig.HomeWindow).name)
  end

  m.CloseBtnFun = function(...)
    -- function num : 0_18_1 , upvalues : _ENV
    UIMgr:CloseToWindow((WinResConfig.HomeWindow).name)
  end

  m.isSelfClose = true
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.FAMILY_SHOP_COIN}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HomelandFarmWindow.OnClose = function(...)
  -- function num : 0_19 , upvalues : uis, contentPane, argTable, fakeItemPool, landItems, farmInfo, showSeeds, swipeDic, _ENV, myTime, checkPoints, clickedItem
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.c1Ctr).selectedIndex = 0
  uis = nil
  contentPane = nil
  argTable = {}
  fakeItemPool = {}
  landItems = {}
  farmInfo = {}
  showSeeds = {}
  swipeDic = {}
  for index,value in ipairs(myTime) do
    if value then
      value:Stop()
    end
  end
  myTime = {}
  checkPoints = {}
  clickedItem = nil
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.HomelandFarmWindow).name)
end

HomelandFarmWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_20 , upvalues : _ENV, myTime, farmInfo, HomelandFarmWindow, clickedItem
  local windowMsgEnum = WindowMsgEnum.Family
  for index,value in ipairs(myTime) do
    if value then
      value:Stop()
    end
  end
  myTime = {}
  if msgId == windowMsgEnum.E_MSG_SEED_PLANT_SUCCESS then
    farmInfo = {}
    ;
    (HomelandData.SetFarmInfo)((para.data).framInfo)
    farmInfo = (HomelandData.GetFarmInfo)()
    ;
    (HomelandFarmWindow.RefreshFarmWindow)()
    ;
    (HomelandFarmWindow.AddPlantEffect)(clickedItem)
  else
    if msgId == windowMsgEnum.E_MSG_PLANT_HARVEST then
      farmInfo = {}
      ;
      (HomelandData.SetFarmInfo)((para.data).framInfo)
      farmInfo = (HomelandData.GetFarmInfo)()
      ;
      (HomelandFarmWindow.ClearAllLandPlants)()
      ;
      (HomelandFarmWindow.RefreshFarmWindow)()
      if (para.data).landId ~= 0 then
        (HomelandFarmWindow.AddHarvestEffect)(clickedItem)
      end
    else
      if msgId == windowMsgEnum.E_MSG_ROOT_LAND then
        farmInfo = {}
        ;
        (HomelandData.SetFarmInfo)((para.data).framInfo)
        farmInfo = (HomelandData.GetFarmInfo)()
        ;
        (HomelandFarmWindow.ClearAllLandPlants)()
        ;
        (HomelandFarmWindow.RefreshFarmWindow)()
      else
        if msgId == windowMsgEnum.E_MSG_UNLOCK_LAND then
          farmInfo = {}
          ;
          (HomelandData.SetFarmInfo)((para.data).framInfo)
          farmInfo = (HomelandData.GetFarmInfo)()
          ;
          (HomelandFarmWindow.RefreshFarmWindow)()
          ;
          (HomelandFarmWindow.AddUnlockEffect)(clickedItem)
        end
      end
    end
  end
end

HomelandFarmWindow.AddBgEffect = function(...)
  -- function num : 0_21 , upvalues : _ENV, uis
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_FARMLAND_BGEFFECT, false, (uis.FamilyEffects).root, Vector2((GRoot.inst).width * 0.5, (GRoot.inst).height * 0.5))
end

HomelandFarmWindow.AddUnlockEffect = function(item, ...)
  -- function num : 0_22 , upvalues : _ENV
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_FARMLAND_KAIKEN, true, item, Vector2(-item.width * 0.5, item.height * 0.5))
end

HomelandFarmWindow.AddPlantEffect = function(item, ...)
  -- function num : 0_23 , upvalues : _ENV
  if item then
    (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_FARMLAND_ZHONGZHI, true, item, Vector2(-item.width * 0.5, item.height * 0.5))
  end
end

HomelandFarmWindow.AddHarvestEffect = function(item, ...)
  -- function num : 0_24 , upvalues : _ENV
  if item then
    (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_FARMLAND_SHOUHUO, true, item, Vector2(-item.width * 0.5, item.height * 0.5))
  end
end

return HomelandFarmWindow

