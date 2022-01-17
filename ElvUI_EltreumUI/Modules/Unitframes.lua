local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local LSM = LibStub("LibSharedMedia-3.0")

--elvui spark hook
local function EltruismSpark()
	if E.db.ElvUI_EltreumUI.sparkcustomcolor.enable then
		local castbar = _G["ElvUF_Player_CastBar"]
		castbar.Spark_ = castbar:CreateTexture(nil, 'OVERLAY')
		castbar.Spark_:SetTexture(E.media.blankTex)
		--local sparkheight = castbar.Spark_:GetHeight() --check if its needed
		castbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.sparkcustomcolor.b, 1)
		castbar.Spark_:Size(E.db.ElvUI_EltreumUI.sparkcustomcolor.width)
	end
end
hooksecurefunc(UF, 'Construct_Castbar', EltruismSpark)

--color unitframes target texture during light mode
local unitframeclass = {
	['WARRIOR'] = "Eltreum-Class-Warrior",
	['PALADIN'] = "Eltreum-Class-Paladin",
	['HUNTER'] = "Eltreum-Class-Hunter",
	['ROGUE'] = "Eltreum-Class-Rogue",
	['PRIEST'] = "Eltreum-Class-Priest",
	['DEATHKNIGHT'] = "Eltreum-Class-DeathKnight",
	['SHAMAN'] = "Eltreum-Class-Shaman",
	['MAGE'] = "Eltreum-Class-Mage",
	['WARLOCK'] = "Eltreum-Class-Warlock",
	['MONK'] = "Eltreum-Class-Monk",
	['DRUID'] = "Eltreum-Class-Druid",
	['DEMONHUNTER'] = "Eltreum-Class-DemonHunter",
}

--from Benik
function ElvUI_EltreumUI:ChangeUnitTexture()
	if E.db.ElvUI_EltreumUI.lightmode and E.db.ElvUI_EltreumUI.modetexture then
		local bar = LSM:Fetch("statusbar", "Eltreum-Blank")
		local _, targetclass = UnitClass("target")
		if targetclass then
			bar = LSM:Fetch("statusbar", unitframeclass[targetclass])
		end
		local playertexture = LSM:Fetch("statusbar", unitframeclass[E.myclass])
		for _, unitName in pairs(UF.units) do
			local frameNameUnit = E:StringTitle(unitName)
			if frameNameUnit == 'Target' then
				local unitframe = _G["ElvUF_"..frameNameUnit]
				if unitframe and unitframe.Health then
					unitframe.Health:SetStatusBarTexture(bar)
				end
			elseif frameNameUnit == 'Player' then
				local unitframe = _G["ElvUF_"..frameNameUnit]
				if unitframe and unitframe.Health then
					unitframe.Health:SetStatusBarTexture(playertexture)
				end
			end
		end
	end
end
hooksecurefunc(UF, "Update_StatusBars", ElvUI_EltreumUI.ChangeUnitTexture)
hooksecurefunc(UF, "Configure_HealthBar", ElvUI_EltreumUI.ChangeUnitTexture)
hooksecurefunc(UF, "Construct_HealthBar", ElvUI_EltreumUI.ChangeUnitTexture)
