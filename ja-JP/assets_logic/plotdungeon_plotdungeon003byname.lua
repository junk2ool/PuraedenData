
		 ---@return PlotDungeon_PlotDungeon003
function GetPlotDungeon_PlotDungeon003Uis(ui)
		 ---@class PlotDungeon_PlotDungeon003
         ---@field public 01_Btn FairyGUI.GButton
         ---@field public 02_Btn FairyGUI.GButton
         ---@field public 03_Btn FairyGUI.GButton
         ---@field public 04_Btn FairyGUI.GButton
         ---@field public 05_Btn FairyGUI.GButton

		 local uis ={}
		 uis.01_Btn = ui:GetChild("01_Btn")
		 uis.02_Btn = ui:GetChild("02_Btn")
		 uis.03_Btn = ui:GetChild("03_Btn")
		 uis.04_Btn = ui:GetChild("04_Btn")
		 uis.05_Btn = ui:GetChild("05_Btn")
		uis.root=ui
		 return uis
end