local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')

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




--[[

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


function ElvUI_EltreumUI:LightModeUFTexture(frame)
	if frame then
		print(frame)
	end
	local _, targetclass = UnitClass("target")
	print(targetclass)


	--local  a = _G["ElvUF_Target_HealthBar"]:GetTexture()

	--_G["ElvUF_Target_HealthBar"]:SetTexture(unitframeclass[targetclass])

	if E.db.ElvUI_EltreumUI.lightmode then
		if frame then
			print(frame)
		else
			print("no frame")
		end
		local _, targetclass = UnitClass("target")
		--local a = UnitGUID("target")
		print(targetclass) --.." and unitguid "..a)

		--i know that the table outputs 16 characters, of which the first 5 are zeroes and the other 11 are the ones that show up as ElvUF_Target_HealthBar.ABCDEFGHIJK
		--need to find a way to get those letters, then simply attach to the ElvUF_Target_HealthBar name and set texture
		local z = _G["ElvUF_Target_HealthBar"]:GetStatusBarTexture()
		print(z)


			local r = _G["ElvUF_Target_HealthBar"]:GetAttribute();
			local s = _G["ElvUF_Target_HealthBar"]:GetChildren()
			local t = _G["ElvUF_Target_HealthBar"]:GetNumChildren()
			local v = _G["ElvUF_Target_HealthBar"]:GetID()
			print("nchildren  "..t.." and id "..v)

			for index, data in pairs(s) do
			    print(index)
			    for key, value in pairs(data) do
			        print('\t', key, value)
			        for key, value in ipairs(data) do
				        print('\t', key, value)
				    end
			    end
			end
			--_G["ElvUF_Target_HealthBar"..z]:SetStatusBarTexture(unitframeclass[targetclass])
end
hooksecurefunc(UF, "Configure_HealthBar", ElvUI_EltreumUI.LightModeUFTexture)
end
]]

--function ElvUI_EltreumUI:Construct_HealthBar(frame, bg, text, textPos)
--	health.bg = ElvUI_EltreumUI.LightModeUFTexture
--end
--hooksecurefunc(UF, "Construct_HealthBar", ElvUI_EltreumUI.Construct_HealthBar)
