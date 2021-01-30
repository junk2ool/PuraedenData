-- params : ...
-- function num : 0 , upvalues : _ENV
FormationPresetMgr = {}
local self = FormationPresetMgr
-- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

FormationPresetMgr.OpenUI = function(formation, externalData, ...)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  FormationPresetData.ChosedPreset = {deckSchemes = formation}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  FormationPresetData.ExternalData = externalData
  if FormationPresetData.Initialized then
    (FormationPresetData.FindChosedPreset)(formation)
    ;
    (FormationPresetData.RefreshPresetFC)()
    OpenWindow((WinResConfig.FormationPresetWindow).name, UILayer.HUD)
  else
    ;
    (FormationPresetService.ReqDeckScheme)()
  end
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

FormationPresetMgr.RecvInitData = function(msg, ...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  FormationPresetData.Initialized = true
  ;
  (FormationPresetData.Init)()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  FormationPresetData.PresetData = msg.deckSchemes
  ;
  (FormationPresetData.RefreshPresetFC)()
  ;
  (FormationPresetData.FindChosedPreset)((FormationPresetData.ChosedPreset).deckSchemes)
  OpenWindow((WinResConfig.FormationPresetWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

FormationPresetMgr.RecvPresetData = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if msg.type == FormationPresetChangeType.Delete then
    (FormationPresetData.PresetFC)[(msg.deckScheme).id] = nil
    local count = #FormationPresetData.PresetData
    for i = 1, count do
      if ((FormationPresetData.PresetData)[i]).id == (msg.deckScheme).id then
        (table.remove)(FormationPresetData.PresetData, i)
        break
      end
    end
  else
    do
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(60000605))
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (FormationPresetData.PresetFC)[(msg.deckScheme).id] = (FormationPresetData.GetPresetFC)(msg.deckScheme)
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

      FormationPresetData.EditPreset = msg.deckScheme
      ;
      (table.sort)((msg.deckScheme).deckSchemes, FormationPresetData.FormationSort)
      if msg.type == FormationPresetChangeType.Add then
        (table.insert)(FormationPresetData.PresetData, msg.deckScheme)
        ;
        (table.sort)(FormationPresetData.PresetData, FormationPresetData.Sort)
      else
        if msg.type == FormationPresetChangeType.Alter then
          local count = #FormationPresetData.PresetData
          for i = 1, count do
            -- DECOMPILER ERROR at PC102: Confused about usage of register: R6 in 'UnsetPending'

            if ((FormationPresetData.PresetData)[i]).id == (msg.deckScheme).id then
              (FormationPresetData.PresetData)[i] = msg.deckScheme
              break
            end
          end
          do
            do
              -- DECOMPILER ERROR at PC127: Confused about usage of register: R2 in 'UnsetPending'

              if FormationPresetData.ChosedPreset and (FormationPresetData.ChosedPreset).id == (msg.deckScheme).id and not (FormationPresetData.CompareFormation)((FormationPresetData.ChosedPreset).deckSchemes, (msg.deckScheme).deckSchemes) then
                FormationPresetData.ChosedPreset = nil
              end
              -- DECOMPILER ERROR at PC131: Confused about usage of register: R1 in 'UnsetPending'

              FormationPresetData.OriginFormation = (msg.deckScheme).deckSchemes
              ;
              (table.sort)(FormationPresetData.PresetData, FormationPresetData.Sort)
              if UIMgr:IsWindowOpen((WinResConfig.FormationPresetWindow).name) then
                UIMgr:SendWindowMessage((WinResConfig.FormationPresetWindow).name, (WindowMsgEnum.FormationPreset).E_MSG_REFRESH_PRESET)
              else
                OpenWindow((WinResConfig.FormationPresetWindow).name, UILayer.HUD)
              end
            end
          end
        end
      end
    end
  end
end


