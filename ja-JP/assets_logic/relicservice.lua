-- params : ...
-- function num : 0 , upvalues : _ENV
RelicService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

RelicService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResTempleInit, RelicService.OnResTempleInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResInStage, RelicService.OnResInStage)
  ;
  (Net.AddListener)((Proto.MsgName).ResRandomMonsterGroupList, RelicService.OnResRandomMonsterGroupList)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

RelicService.ReqTempleInit = function(...)
  -- function num : 0_1 , upvalues : _ENV
  print("神殿初始化数据")
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqTempleInit, m, (Proto.MsgName).ResTempleInit)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

RelicService.OnResTempleInit = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  for index,value in ipairs(msg.stageInfo) do
    print("stageInfo id,isgeted ", value.id, value.isGeted, value.extraRewardState, value.surplusNum)
  end
  print("changeFc", msg.changeFc)
  print("templeWeakenNum", msg.templeWeakenNum)
  print("templeBeginTime", msg.templeBeginTime)
  print("templeEndTime", msg.templeEndTime)
  ;
  (RelicData.SetTempleData)(msg)
  OpenWindow((WinResConfig.RelicMainWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

RelicService.ReqStartChallenge = function(stageId, cardInfo, ...)
  -- function num : 0_3 , upvalues : _ENV
  print("============请求战斗  stageID", stageId)
  local m = {}
  m.id = stageId
  m.cardInfo = (Util.CovertLoaclFormationToRemote)(cardInfo)
  ;
  (Net.Send)((Proto.MsgName).ReqInStage, m, (Proto.MsgName).InitBattleData)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

RelicService.OnResInStage = function(msg, ...)
  -- function num : 0_4
  if not msg.into or not msg.id or msg.cardInfo then
  end
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

RelicService.ReqRandomMonsterGroupList = function(stageId, ...)
  -- function num : 0_5 , upvalues : _ENV
  print("============请求设置随机怪物 595  stageID", stageId)
  local m = {}
  m.stageId = stageId
  ;
  (Net.Send)((Proto.MsgName).ReqRandomMonsterGroupList, m, (Proto.MsgName).ResRandomMonsterGroupList)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

RelicService.OnResRandomMonsterGroupList = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  (RelicData.GetRelicNormalWave)(msg.randomMosterGroup)
  UIMgr:SendWindowMessage((WinResConfig.RelicBattlePreviewWindow).name, (WindowMsgEnum.Relic).E_MSG_RANDOM_MONSTER, {randomMosterGroup = msg.randomMosterGroup})
end

;
(RelicService.Init)()

