local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

local EltruismScreenShot = CreateFrame("Frame", "EltruismScreenShot")
function ElvUI_EltreumUI:AutoScreenshot()
	if E.db.ElvUI_EltreumUI.otherstuff.screenshot then
		if E.Retail then
			EltruismScreenShot:RegisterEvent("ACHIEVEMENT_EARNED")
			EltruismScreenShot:RegisterEvent("CHALLENGE_MODE_COMPLETED")
		end
		EltruismScreenShot:RegisterEvent("PLAYER_LEVEL_UP")
		EltruismScreenShot:SetScript("OnEvent", function()
			Screenshot()
		end)
	end
end

--[[

local classcolor = E:ClassColor(E.myclass, true)
local skillglowcolor = {classcolor.r, classcolor.g, classcolor.b, 1}
local LCG = E.Libs.CustomGlow
local AB = E:GetModule('ActionBars')

local SPELL_ID = {

	--victory rush
	[34428] = true,
	--kill command
	[34026] = true,
	--riposte
	[14251] = true,

	--execute
	[25236]	= true,
	[25234]	= true,
	[20662]	= true,
	[20661]	= true,
	[20660]	= true,
	[20658]	= true,
	[5308] = true,

	--overpower
	[11585] = true,
	[11584] = true,
	[7887] = true,
	[7384] = true,

	--regenge
	[30327] = true,
	[25288] = true,
	[25269] = true,
	[11601] = true,
	[11600] = true,
	[7379] = true,
	[6574] = true,
	[6572] = true,

	--mongoose bite
	[36916] = true,
	[14271] = true,
	[14270] = true,
	[14269] = true,
	[1495] = true,

	--counterattack
	[27067] = true,
	[20910] = true,
	[20909] = true,
	[19306] = true,

	--exorcism
	[27138] = true,
	[10314] = true,
	[10313] = true,
	[10312] = true,
	[5615] = true,
	[5614] = true,
	[879] = true,

	--hammer of wrath
	[27180] = true,
	[24275] = true,
	[24274] = true,
	[24239] = true,

	--shadowbolt
	[27209] = true,
	[25307] = true,
	[11661] = true,
	[11660] = true,
	[11659] = true,
	[7641] = true,
	[1106] = true,
	[1088] = true,
	[705] = true,
	[695] = true,
	[686] = true,

	--earth shock
	[25454] = true,
	[10414] = true,
	[10413] = true,
	[10412] = true,
	[8046] = true,
	[8045] = true,
	[8044] = true,
	[8042] = true,

	--flame shock
	[29228] = true,
	[25457] = true,
	[10448] = true,
	[10447] = true,
	[8053] = true,
	[8052] = true,
	[8050] = true,

	--frost shock
	[25464] = true,
	[10473] = true,
	[10472] = true,
	[8058] = true,
	[8056] = true,
}

local proc

function ElvUI_EltreumUI:PositionAndSizeBar(barName)
	local bar = AB['handledBars'][barName]
	if not bar then return end
	local button
	local procFrame = CreateFrame('frame')
	procFrame:RegisterEvent('ACTIONBAR_UPDATE_USABLE')
	--procFrame:RegisterEvent('ACTIONBAR_UPDATE_STATE')
	--procFrame:RegisterEvent('ACTIONBAR_UPDATE_COOLDOWN')
	procFrame:RegisterEvent('SPELL_UPDATE_USABLE')
	procFrame:RegisterEvent('PLAYER_TARGET_CHANGED')
	procFrame:SetScript('OnEvent', function()

		for i=1, NUM_ACTIONBAR_BUTTONS do
			button = bar.buttons[i]
			local buttonname = button:GetName()
			if _G[buttonname].GetSpellId and _G[buttonname]:GetSpellId() then
				proc = _G[buttonname]:GetSpellId()
			end

			if SPELL_ID[proc] then
				local USABLE, NO_MANA = IsUsableSpell(proc)
				local cd = GetSpellCooldown(proc)
				--print(cd)
				if (UnitExists("target") and UnitCanAttack("player", "target") and cd == 0 and USABLE and not NO_MANA) and _G[buttonname].GetSpellId and _G[buttonname]:GetSpellId() == proc then
					if E.myclass == 'PALADIN' then
						if proc == 27138 or proc == 10314 or proc == 10313 or proc == 10312 or proc == 5615 or proc == 5614 or proc == 879 then
							local unittype = UnitCreatureType("target")
							--if unittype ==  "Demon" or unittype == "Dämon" or unittype == "Demonio" or unittype == "Démon" or unittype == "Demone" or unittype == "Demônio" or unittype == "Демон" or unittype == "악마" or unittype == "恶魔" or unittype == "惡魔" or unittype == "Undead" or unittype == "Untoter" or unittype == "No-muerto" or unittype == "Mort-vivant" or unittype == "Non Morto" or unittype == "Renegado" or unittype == "Нежить" or unittype == "언데드" or unittype == "亡灵" or unittype == "不死族" then
							if unittype == _G.PET_TYPE_DEMON or unittype == _G.BATTLE_PET_DAMAGE_NAME_4 then
								LCG.PixelGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, high)
							else
								LCG.PixelGlow_Stop(_G[buttonname])
							end
						else
							LCG.PixelGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, high)
						end
					else
						LCG.PixelGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, high)
					end
				else
					LCG.PixelGlow_Stop(_G[buttonname])
				end
			elseif SPELL_ID[proc] == nil then
				LCG.PixelGlow_Stop(_G[buttonname])
			end
		end
	end)
end

local f = CreateFrame("FRAME")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
--f:RegisterEvent('ACTIONBAR_UPDATE_USABLE')
f:SetScript("OnEvent", function(event)
	hooksecurefunc(AB, 'PositionAndSizeBar', ElvUI_EltreumUI.PositionAndSizeBar)
	for i = 1, 10 do
		AB:PositionAndSizeBar('bar'..i)
	end
end)

]]
