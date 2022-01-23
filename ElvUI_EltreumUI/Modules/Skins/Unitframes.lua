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

		--player
		local playertexture = LSM:Fetch("statusbar", unitframeclass[E.myclass])
		if UF.units.player then
			local unitframe = _G["ElvUF_Player"]
			if unitframe and unitframe.Health then
				unitframe.Health:SetStatusBarTexture(playertexture)
			end
		end

		--target
		local targetbar = LSM:Fetch("statusbar", "Eltreum-Blank")
		local _, targetclass = UnitClass("target")
		local reactiontarget = UnitReaction("player", "target")
		if UnitExists("target") then
			if targetclass and UnitIsPlayer("target") then
				targetbar = LSM:Fetch("statusbar", unitframeclass[targetclass])
			elseif not UnitIsPlayer("target") then
				if reactiontarget >= 5 then
					targetbar = LSM:Fetch("statusbar", "Eltreum-Class-Hunter")
				elseif reactiontarget == 4 then
					targetbar = LSM:Fetch("statusbar", "Eltreum-Class-Rogue")
				elseif reactiontarget == 3 then
					targetbar = LSM:Fetch("statusbar", "Eltreum-Class-Druid")
				elseif reactiontarget == 2 or reactiontarget == 1 then
					targetbar = LSM:Fetch("statusbar", "Eltreum-Class-DeathKnight")
				end
			end
		end
		if UF.units.target then
			local unitframe = _G["ElvUF_Target"]
			if unitframe and unitframe.Health then
				unitframe.Health:SetStatusBarTexture(targetbar)
			end
		end

		--target of target
		local _, targettargetclass = UnitClass("targettarget")
		local reactiontargettarget = UnitReaction("player", "targettarget")
		local targettargetbar = LSM:Fetch("statusbar", "Eltreum-Blank")
		if UnitExists("targettarget") then
			if targettargetclass and UnitIsPlayer("targettarget") then
				targettargetbar = LSM:Fetch("statusbar", unitframeclass[targettargetclass])
			elseif not UnitIsPlayer("target") then
				if reactiontargettarget >= 5 then
					targettargetbar = LSM:Fetch("statusbar", "Eltreum-Class-Hunter")
				elseif reactiontargettarget == 4 then
					targettargetbar = LSM:Fetch("statusbar", "Eltreum-Class-Rogue")
				elseif reactiontargettarget == 3 then
					targettargetbar = LSM:Fetch("statusbar", "Eltreum-Class-Druid")
				elseif reactiontargettarget == 2 or reactiontargettarget == 1 then
					targettargetbar = LSM:Fetch("statusbar", "Eltreum-Class-DeathKnight")
				end
			end
		end
		if UF.units.targettarget then
			local unitframe = _G["ElvUF_TargetTarget"]
			if unitframe and unitframe.Health then
				unitframe.Health:SetStatusBarTexture(targettargetbar)
			end
		end

		--focus
		local _, focusclass = UnitClass("focus")
		local focusbar = LSM:Fetch("statusbar", "Eltreum-Blank")
		if focusclass and UnitIsPlayer("focus") then
			focusbar = LSM:Fetch("statusbar", unitframeclass[focusclass])
		end
		if UF.units.focus then
			local focusframe = _G["ElvUF_Focus"]
			if focusframe and focusframe.Health then
				focusframe.Health:SetStatusBarTexture(focusbar)
			end
		end

		--pet
		local petbar = LSM:Fetch("statusbar", "Eltreum-Class-Hunter")
		if UF.units.pet then
			local petframe = _G["ElvUF_Pet"]
			if petframe and petframe.Health then
				petframe.Health:SetStatusBarTexture(petbar)
			end
		end

	end
end
hooksecurefunc(UF, "Construct_HealthBar", ElvUI_EltreumUI.ChangeUnitTexture)
--hooksecurefunc(UF, "Update_StatusBars", ElvUI_EltreumUI.ChangeUnitTexture) --if not hooking into this then when the target of target changes it doesnt update
--hooksecurefunc(UF, "Style", ElvUI_EltreumUI.ChangeUnitTexture)
--hooksecurefunc(UF, "Update_StatusBar", ElvUI_EltreumUI.ChangeUnitTexture)
--hooksecurefunc(UF, "ToggleTransparentStatusBar", ElvUI_EltreumUI.ChangeUnitTexture)
--hooksecurefunc(UF, "Update_TargetTargetFrame", ElvUI_EltreumUI.ChangeUnitTexture)
--hooksecurefunc(UF, "Construct_TargetTargetFrame", ElvUI_EltreumUI.ChangeUnitTexture)
