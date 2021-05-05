-- params : ...
-- function num : 0 , upvalues : _ENV
require("HeroDungeon_Map006_1ByName")
require("HeroDungeon_HeroDungeonMonsterByName")
require("HeroDungeon_HeroDungeonMonsterOtherByName")
GetHeroDungeon_HeroPlotMap006Uis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Effect_1_Grp = GetHeroDungeon_Map006_1Uis(ui:GetChild("Effect_1_Grp"))
  uis.LineGrp = ui:GetChild("LineGrp")
  uis.Monster_01_Grp = GetHeroDungeon_HeroDungeonMonsterUis(ui:GetChild("Monster_01_Grp"))
  uis.Monster_02_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_02_Grp"))
  uis.Monster_03_Grp = GetHeroDungeon_HeroDungeonMonsterUis(ui:GetChild("Monster_03_Grp"))
  uis.Monster_04_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_04_Grp"))
  uis.Monster_05_Grp = GetHeroDungeon_HeroDungeonMonsterUis(ui:GetChild("Monster_05_Grp"))
  uis.Monster_06_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_06_Grp"))
  uis.Monster_07_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_07_Grp"))
  uis.Monster_08_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_08_Grp"))
  uis.Monster_09_Grp = GetHeroDungeon_HeroDungeonMonsterUis(ui:GetChild("Monster_09_Grp"))
  uis.Monster_10_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_10_Grp"))
  uis.Monster_11_Grp = GetHeroDungeon_HeroDungeonMonsterUis(ui:GetChild("Monster_11_Grp"))
  uis.Monster_12_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_12_Grp"))
  uis.Monster_13_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_13_Grp"))
  uis.Monster_14_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_14_Grp"))
  uis.Monster_15_Grp = GetHeroDungeon_HeroDungeonMonsterUis(ui:GetChild("Monster_15_Grp"))
  uis.Monster_16_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_16_Grp"))
  uis.Monster_17_Grp = GetHeroDungeon_HeroDungeonMonsterUis(ui:GetChild("Monster_17_Grp"))
  uis.Monster_18_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_18_Grp"))
  uis.Monster_19_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_19_Grp"))
  uis.Monster_20_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_20_Grp"))
  uis.Monster_21_Grp = GetHeroDungeon_HeroDungeonMonsterUis(ui:GetChild("Monster_21_Grp"))
  uis.Monster_22_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_22_Grp"))
  uis.Monster_23_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_23_Grp"))
  uis.Monster_24_Grp = GetHeroDungeon_HeroDungeonMonsterUis(ui:GetChild("Monster_24_Grp"))
  uis.MonsterGrp = ui:GetChild("MonsterGrp")
  uis.root = ui
  return uis
end


