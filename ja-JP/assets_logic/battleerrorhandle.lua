-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleErrorHandle = {}
local __error = {}
local __cachedInitBattleData, __cachedExpeditionBattleData = nil, nil
local __elapse = 0
local __timeout = 10
local __enable_update = false
local __enable_error_handle = true
local bindcallback = function(func, ...)
  -- function num : 0_0 , upvalues : _ENV
  if not func then
    return 
  end
  local params = {...}
  return function(...)
    -- function num : 0_0_0 , upvalues : func, _ENV, params
    func((table.unpack)(params))
  end

end

local CacheInitBattleData = function(battleData, ...)
  -- function num : 0_1 , upvalues : __cachedInitBattleData
  __cachedInitBattleData = battleData
end

local CacheExpeditionBattleData = function(expeditionBattleData, ...)
  -- function num : 0_2 , upvalues : __cachedExpeditionBattleData
  __cachedExpeditionBattleData = expeditionBattleData
end

local __error_handle = function(error, ...)
  -- function num : 0_3 , upvalues : __enable_error_handle, __error, _ENV, __cachedInitBattleData, __cachedExpeditionBattleData
  if not __enable_error_handle then
    return 
  end
  if not __error[error] then
    __error[error] = error
    if (Proto.MsgName).ReqExceptionBattleData then
      (Net.Send)((Proto.MsgName).ReqExceptionBattleData, {stackTrace = error, initBattleData = __cachedInitBattleData, expeditionBattleData = __cachedExpeditionBattleData})
    end
  end
  loge("[error handle]" .. tostring(error))
end

local Enable = function(enable, ...)
  -- function num : 0_4 , upvalues : __enable_error_handle
  __enable_error_handle = enable
end

local EnableUpdate = function(enable, ...)
  -- function num : 0_5 , upvalues : __enable_update
  __enable_update = enable
end

local ResetElapse = function(...)
  -- function num : 0_6 , upvalues : __elapse
  __elapse = 0
end

local Update = function(...)
  -- function num : 0_7 , upvalues : __enable_update, _ENV, __elapse, __timeout, __error_handle
  if not __enable_update then
    return 
  end
  if Time.timeScale ~= 0 or not 0 then
    local timescale = 1 / Time.timeScale
  end
  __elapse = __elapse + Time.deltaTime * timescale
  if __timeout < __elapse then
    __error_handle("Failed to continue battle at wave:" .. tostring(BattleData.curWave) .. ",round:" .. tostring(BattleData.roundIndex) .. ",atk:" .. tostring((BattleAtk.curAtkInfo).atkIndex))
    __elapse = 0
  end
end

local Catch = function(func, ...)
  -- function num : 0_8 , upvalues : bindcallback, _ENV, __error_handle
  local callback = bindcallback(func, ...)
  return function(...)
    -- function num : 0_8_0 , upvalues : _ENV, callback, __error_handle
    xpcall(callback, __error_handle)
  end

end

local Clear = function(...)
  -- function num : 0_9 , upvalues : __error, __elapse, __enable_update, __cachedInitBattleData, __cachedExpeditionBattleData
  __error = {}
  __elapse = 0
  __enable_update = false
  __cachedInitBattleData = nil
  __cachedExpeditionBattleData = nil
end

BattleErrorHandle.Catch = Catch
BattleErrorHandle.Clear = Clear
BattleErrorHandle.Update = Update
BattleErrorHandle.ResetElapse = ResetElapse
BattleErrorHandle.EnableUpdate = EnableUpdate
BattleErrorHandle.Handle = __error_handle
BattleErrorHandle.Enable = Enable
BattleErrorHandle.CacheInitBattleData = CacheInitBattleData
BattleErrorHandle.CacheExpeditionBattleData = CacheExpeditionBattleData
return BattleErrorHandle

