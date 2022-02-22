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



local classcolor = E:ClassColor(E.myclass, true)
local skillglowcolor = {classcolor.r, classcolor.g, classcolor.b, 1}
local LCG = E.Libs.CustomGlow
local AB = E:GetModule('ActionBars')

--local procFrame
--local buttonname
--local USABLE

local SPELL_ID = {
	[25236]	= true, --execute
	[34428] = true, --victory rush
}

local proc

function ElvUI_EltreumUI:PositionAndSizeBar(barName)
	local bar = AB['handledBars'][barName]
	if not bar then return end
	local button
	local procFrame = CreateFrame('frame')
	procFrame:RegisterEvent('ACTIONBAR_UPDATE_USABLE')
	procFrame:SetScript('OnEvent', function()

		for i=1, NUM_ACTIONBAR_BUTTONS do
			button = bar.buttons[i]
			local buttonname = button:GetName()
			if _G[buttonname].GetSpellId and _G[buttonname]:GetSpellId() then
				proc = _G[buttonname]:GetSpellId()
			end

			if SPELL_ID[proc] then
				local USABLE = IsUsableSpell(proc)
				if USABLE and _G[buttonname].GetSpellId and _G[buttonname]:GetSpellId() == proc then
					LCG.PixelGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, high)
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
f:SetScript("OnEvent", function(event)
	hooksecurefunc(AB, 'PositionAndSizeBar', ElvUI_EltreumUI.PositionAndSizeBar)
	for i = 1, 10 do
		AB:PositionAndSizeBar('bar'..i)
	end
end)

