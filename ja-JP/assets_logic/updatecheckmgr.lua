-- params : ...
-- function num : 0 , upvalues : _ENV
local UpdateCheckMgr = {}
local HttpDownload = CS.HttpDownload
CSServerList = (CS.ServerList).Singleton
CSServerListDownload = (CS.ServerListDownload).Singleton
UpdateCheckMgr.CheckUpdate = function(...)
  -- function num : 0_0 , upvalues : _ENV, UpdateCheckMgr
  local serverListVersionUrl = CSBaseConfig.ServerListVersionUrl
  if (Util.StringIsNullOrEmpty)(serverListVersionUrl) == false then
    (UpdateCheckMgr.DownResVersion)(serverListVersionUrl)
  else
    ;
    (UpdateCheckMgr.DownloadServerList)()
  end
end

UpdateCheckMgr.DownResVersion = function(url, ...)
  -- function num : 0_1 , upvalues : HttpDownload, _ENV, UpdateCheckMgr
  (HttpDownload.Request)(url, 15, function(unityWebRequest, ...)
    -- function num : 0_1_0 , upvalues : HttpDownload, _ENV, UpdateCheckMgr
    local serverListVersion = (HttpDownload.GetString)(unityWebRequest)
    print("最新资源版本：", serverListVersion)
    ;
    (UpdateCheckMgr.DownloadServerList)(serverListVersion)
  end
)
end

UpdateCheckMgr.DownloadServerList = function(serverListVersion, ...)
  -- function num : 0_2 , upvalues : _ENV, HttpDownload, UpdateCheckMgr
  local url = nil
  if CSBaseConfig.AvailableCdnUrl == nil then
    url = CSBaseConfig.BaseIndexServerUrl .. "/serverList/ServerList.json_" .. (CS.IOTools).PlatformFolderName
  else
    url = CSBaseConfig.AvailableCdnUrl .. "/serverList/ServerList.json_" .. (CS.IOTools).PlatformFolderName
  end
  if serverListVersion then
    url = url .. "?version=" .. serverListVersion
  end
  ;
  (HttpDownload.Request)(url, 15, function(unityWebRequest, ...)
    -- function num : 0_2_0 , upvalues : HttpDownload, _ENV, UpdateCheckMgr
    local serverList = (HttpDownload.GetString)(unityWebRequest)
    print("ServerList下载成功：", serverList)
    CSServerList:Init(serverList)
    if (UpdateCheckMgr.NeedDownload)() == true then
      (MessageMgr.OpenSoloConfirmWindow)((PUtil.get)(40002070), function(...)
      -- function num : 0_2_0_0 , upvalues : _ENV
      -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

      CSServerListDownload.downText = nil
      ;
      (LoginService.ReqLogout)(true)
    end
, (PUtil.get)(60000003), (PUtil.get)(20000370))
    end
  end
)
end

UpdateCheckMgr.NeedDownload = function(...)
  -- function num : 0_3 , upvalues : _ENV
  local launch = (CS.Launch).Singleton
  local localVer = launch.resVersion
  local serverVer = CSServerList.ResVersion
  local localAppVer = CSBaseConfig:GetAppBigVersion()
  local serverAppVer = CSServerList:GetAppBigVersion()
  print("本地包版本", localAppVer, tonumber(localAppVer))
  print("远端包版本", serverAppVer, tonumber(serverAppVer))
  print("本地资源版本", localVer, tonumber(localVer))
  print("远端资源版本", serverVer, tonumber(serverVer))
  do return (localAppVer ~= serverAppVer and tonumber(localAppVer) < tonumber(serverAppVer)) or (localVer ~= serverVer and tonumber(localVer) < tonumber(serverVer)) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return UpdateCheckMgr
