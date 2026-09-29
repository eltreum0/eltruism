local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local select = _G.select
local UnitIsTapDenied = _G.UnitIsTapDenied
local UnitPlayerControlled = _G.UnitPlayerControlled
local UnitIsCharmed = _G.UnitIsCharmed
local pairs = _G.pairs
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local UnitCanAttack = _G.UnitCanAttack
local UnitIsEnemy = _G.UnitIsEnemy
local UnitIsFriend = _G.UnitIsFriend

--set the textures for single units
function ElvUI_EltreumUI:ApplyUnitCustomTexture(unit,name,unittexture,noOrientation)
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	if not UFdb then return end
	local _, classunit = UnitClass(unit)
	local reaction = UnitReaction(unit, "player")
	local isCharmed = E:NotSecretValue(UnitIsCharmed(unit)) and UnitIsCharmed(unit) or false
	local namebar
	if UnitExists(unit) then
		if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
			if not E:NotSecretValue(classunit) or not classunit then
				classunit = E.myclass
			end
			namebar = ElvUI_EltreumUI:UnitframeClassTexture(classunit)
		else
			local isTap = E:NotSecretValue(UnitIsTapDenied(unit)) and UnitIsTapDenied(unit)
			local isPlayerControlled = E:NotSecretValue(UnitPlayerControlled(unit)) and UnitPlayerControlled(unit)
			if isTap and not isPlayerControlled then
				namebar = ElvUI_EltreumUI:UnitframeClassTexture("TAPPED")
			else
				local npcClass
				if reaction and E:NotSecretValue(reaction) then
					if reaction >= 5 then
						npcClass = "NPCFRIENDLY"
					elseif reaction == 4 then
						npcClass = "NPCNEUTRAL"
					elseif reaction == 3 then
						npcClass = "NPCUNFRIENDLY"
					elseif reaction <= 2 then
						npcClass = "NPCHOSTILE"
					end
				end
				if not npcClass then
					if (UnitCanAttack and E:NotSecretValue(UnitCanAttack("player", unit)) and UnitCanAttack("player", unit)) or (UnitIsEnemy and E:NotSecretValue(UnitIsEnemy("player", unit)) and UnitIsEnemy("player", unit)) then
						npcClass = "NPCHOSTILE"
					elseif UnitIsFriend and E:NotSecretValue(UnitIsFriend("player", unit)) and UnitIsFriend("player", unit) then
						npcClass = "NPCFRIENDLY"
					else
						npcClass = "NPCHOSTILE"
					end
				end
				namebar = ElvUI_EltreumUI:UnitframeClassTexture(npcClass)
			end
		end
		local unitframe = _G["ElvUF_"..name]
		if unitframe and unitframe.Health and unitframe.Health:GetStatusBarTexture() ~= nil then
			if not noOrientation then
				unitframe.Health:SetOrientation(UFdb.UForientation)
			end
			if (E.db.unitframe.colors.transparentHealth or UFdb.lightmode) and not UFdb.gradientmode.enablebackdrop then
				if unitframe.Health and unitframe.Health.backdrop then
					local backdropAlpha = UFdb.ufcustomtexture.backdropalpha or 1
					local transparentHealth = E.db.unitframe.colors.transparentHealth or UFdb.lightmode
					local healthAlpha = transparentHealth and (UFdb.ufcustomtexture.healthalpha or 1) or 1
					if backdropAlpha == 1 and healthAlpha < 1 then
						backdropAlpha = healthAlpha
					end
					unitframe.Health.backdrop:SetAlpha(backdropAlpha)
					if UFdb.lightmode then
						unitframe.Health.backdrop:SetBackdropColor(0, 0, 0, 0)
						if unitframe.Health.backdrop.Center and unitframe.Health.backdrop.Center:IsShown() then
							unitframe.Health.backdrop.Center:Hide()
						end
						if unitframe.Health.bg then
							unitframe.Health.bg:SetAlpha(backdropAlpha)
							unitframe.Health.bg:SetVertexColor(0, 0, 0, backdropAlpha)
						end
						if unitframe.Health.backdropTex and not unitframe.EltruismDebuffExists then
							unitframe.Health.backdropTex:SetAlpha(backdropAlpha)
							unitframe.Health.backdropTex:SetVertexColor(0, 0, 0, backdropAlpha)
						end
					else
						unitframe.Health.backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
						if unitframe.Health.backdrop.Center then
							if not unitframe.Health.backdrop.Center:IsShown() then
								unitframe.Health.backdrop.Center:Show()
							end
							unitframe.Health.backdrop.Center:SetAlpha(backdropAlpha)
						end
						if unitframe.Health.bg then
							unitframe.Health.bg:SetAlpha(backdropAlpha)
						end
						if unitframe.Health.backdropTex and not unitframe.EltruismDebuffExists then
							unitframe.Health.backdropTex:SetAlpha(backdropAlpha)
						end
					end
				end
			end
			if (UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))) and not isCharmed then
				if UFdb.lightmode then
					if UFdb.ufcustomtexture.enable then
						if UFdb.ufcustomtexture.classdetect then
							unitframe.Health:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(classunit))
						else
							unitframe.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", UFdb.ufcustomtexture[unittexture.."texture"]))
						end
					end
					if UFdb.gradientmode.enable and (UFdb.gradientmode["enable"..unit] or UFdb.gradientmode["enable"..unittexture]) then
						if not UFdb.ufcustomtexture.enable then
							if not UFdb.gradientmode.useUFtexture then
								unitframe.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", UFdb.gradientmode.texture))
							end
						end
					end
				elseif UFdb.darkmode then
					if unitframe.Health.backdropTex then
						if UFdb.ufcustomtexture.enable then
							if UFdb.ufcustomtexture.classdetect then
								unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(classunit))
							else
								unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", UFdb["ufcustomtexture"][unittexture.."texture"]))
							end
						end
						if UFdb.gradientmode.enable and (UFdb.gradientmode["enable"..unit] or UFdb.gradientmode["enable"..unittexture]) then
							if not UFdb.ufcustomtexture.enable then
								if not UFdb.gradientmode.useUFtexture then
									unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", UFdb.gradientmode.texture))
								end
							end
						end
					end
				end
			else
				if UFdb.lightmode then
					if UFdb.ufcustomtexture.enable then
						if UFdb.ufcustomtexture.classdetect then
							local isTap = E:NotSecretValue(UnitIsTapDenied(unit)) and UnitIsTapDenied(unit)
							local isPlayerControlled = E:NotSecretValue(UnitPlayerControlled(unit)) and UnitPlayerControlled(unit)
							if isTap and not isPlayerControlled then
								unitframe.Health:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("TAPPED"))
							else
								local npcClass
								if reaction and E:NotSecretValue(reaction) then
									if reaction >= 5 then
										npcClass = "NPCFRIENDLY"
									elseif reaction == 4 then
										npcClass = "NPCNEUTRAL"
									elseif reaction == 3 then
										npcClass = "NPCUNFRIENDLY"
									elseif reaction <= 2 then
										npcClass = "NPCHOSTILE"
									end
								end
								if not npcClass then
									if (UnitCanAttack and E:NotSecretValue(UnitCanAttack("player", unit)) and UnitCanAttack("player", unit)) or (UnitIsEnemy and E:NotSecretValue(UnitIsEnemy("player", unit)) and UnitIsEnemy("player", unit)) then
										npcClass = "NPCHOSTILE"
									elseif UnitIsFriend and E:NotSecretValue(UnitIsFriend("player", unit)) and UnitIsFriend("player", unit) then
										npcClass = "NPCFRIENDLY"
									else
										npcClass = "NPCHOSTILE"
									end
								end
								unitframe.Health:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(npcClass))
							end
						else
							unitframe.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", UFdb["ufcustomtexture"][unittexture.."texture"]))
						end
					end
					if UFdb.gradientmode.enable and (UFdb.gradientmode["enable"..unit] or UFdb.gradientmode["enable"..unittexture]) then
						if not UFdb.ufcustomtexture.enable then
							if not UFdb.gradientmode.useUFtexture then
								unitframe.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", UFdb.gradientmode.texture))
							end
						end
					end
				elseif UFdb.darkmode then
					if UFdb.ufcustomtexture.enable then
						if unitframe.Health.backdropTex then
							if UFdb.ufcustomtexture.classdetect then
								local isTap = E:NotSecretValue(UnitIsTapDenied(unit)) and UnitIsTapDenied(unit)
								local isPlayerControlled = E:NotSecretValue(UnitPlayerControlled(unit)) and UnitPlayerControlled(unit)
								if isTap and not isPlayerControlled then
									unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("TAPPED"))
								else
									local npcClass
									if reaction and E:NotSecretValue(reaction) then
										if reaction >= 5 then
											npcClass = "NPCFRIENDLY"
										elseif reaction == 4 then
											npcClass = "NPCNEUTRAL"
										elseif reaction == 3 then
											npcClass = "NPCUNFRIENDLY"
										elseif reaction <= 2 then
											npcClass = "NPCHOSTILE"
										end
									end
									if not npcClass then
										if (UnitCanAttack and E:NotSecretValue(UnitCanAttack("player", unit)) and UnitCanAttack("player", unit)) or (UnitIsEnemy and E:NotSecretValue(UnitIsEnemy("player", unit)) and UnitIsEnemy("player", unit)) then
											npcClass = "NPCHOSTILE"
										elseif UnitIsFriend and E:NotSecretValue(UnitIsFriend("player", unit)) and UnitIsFriend("player", unit) then
											npcClass = "NPCFRIENDLY"
										else
											npcClass = "NPCHOSTILE"
										end
									end
									unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(npcClass))
								end
							else
								unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", UFdb["ufcustomtexture"][unittexture.."texture"]))
							end
						end
					end
					if UFdb.gradientmode.enable and (UFdb.gradientmode["enable"..unit] or UFdb.gradientmode["enable"..unittexture]) then
						if unitframe.Health.backdropTex then
							if not UFdb.ufcustomtexture.enable then
								if not UFdb.gradientmode.useUFtexture then
									unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", UFdb.gradientmode.texture))
								end
							end
						end
					end
				end
			end
			if not UFdb.gradientmode.enable and not UFdb.ufcustomtexture.enable then
				if UFdb.lightmode then
					if UFdb.uftextureversion ~= "NONE" then
						unitframe.Health:GetStatusBarTexture():SetTexture(namebar)
					end
					unitframe.Health.backdrop:SetBackdropColor(0,0,0,UFdb.ufcustomtexture.backdropalpha) --after 11.0.5 it seems like the backdrop gets class colored
				elseif UFdb.darkmode and unitframe.Health.backdropTex then
					unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", UFdb.ufcustomtexture.backdroptexture))
					unitframe.Health.backdropTex:SetAlpha(UFdb.ufcustomtexture.backdropalpha)
				end
			end
		end
	end
end

--set the textures for group units
function ElvUI_EltreumUI:ApplyGroupCustomTexture(button,noOrientation,frametype)
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	if not UFdb then return end

	--due to raid pet, check if is player
	local buttonclass
	if UnitIsPlayer(button.__unit) or (E.Retail and UnitInPartyIsAI(button.__unit)) then
		buttonclass = select(2, UnitClass(button.__unit))
		if not E:NotSecretValue(buttonclass) or not buttonclass then
			buttonclass = "NPCFRIENDLY"
		end
	else
		buttonclass = "NPCFRIENDLY"
	end

	if buttonclass and button.Health then
		if not noOrientation then
			button.Health:SetOrientation(UFdb.UForientation)
		end
		if (E.db.unitframe.colors.transparentHealth or UFdb.lightmode) and not UFdb.gradientmode.enablebackdrop then
			if button.Health and button.Health.backdrop then
				local backdropAlpha = UFdb.ufcustomtexture.backdropalpha or 1
				local transparentHealth = E.db.unitframe.colors.transparentHealth or UFdb.lightmode
				local healthAlpha = transparentHealth and (UFdb.ufcustomtexture.healthalpha or 1) or 1
				if backdropAlpha == 1 and healthAlpha < 1 then
					backdropAlpha = healthAlpha
				end
				button.Health.backdrop:SetAlpha(backdropAlpha)
				if UFdb.lightmode then
					button.Health.backdrop:SetBackdropColor(0, 0, 0, 0)
					if button.Health.backdrop.Center and button.Health.backdrop.Center:IsShown() then
						button.Health.backdrop.Center:Hide()
					end
					if button.Health.bg then
						button.Health.bg:SetAlpha(backdropAlpha)
						button.Health.bg:SetVertexColor(0, 0, 0, backdropAlpha)
					end
					if button.Health.backdropTex and not button.EltruismDebuffExists then
						button.Health.backdropTex:SetAlpha(backdropAlpha)
						button.Health.backdropTex:SetVertexColor(0, 0, 0, backdropAlpha)
					end
				else
					button.Health.backdrop:SetBackdropColor(0, 0, 0, backdropAlpha)
					if button.Health.backdrop.Center then
						if not button.Health.backdrop.Center:IsShown() then
							button.Health.backdrop.Center:Show()
						end
						button.Health.backdrop.Center:SetAlpha(backdropAlpha)
					end
					if button.Health.bg then
						button.Health.bg:SetAlpha(backdropAlpha)
					end
					if button.Health.backdropTex and not button.EltruismDebuffExists then
						button.Health.backdropTex:SetAlpha(backdropAlpha)
					end
				end
			end
		end

		local groupbar = ElvUI_EltreumUI:UnitframeClassTexture(buttonclass)
		if UFdb.lightmode then
			button.Health.backdrop:SetAlpha(UFdb.ufcustomtexture.backdropalpha)
			if UFdb.ufcustomtexture.enable then
				if not UFdb.ufcustomtexture.noclasstexture then
					button.Health:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(buttonclass))
				else
					if frametype then
						if frametype == "raid" then
							button.Health:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("RAID"))
						elseif frametype == "party" then
							button.Health:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("PARTY"))
						end
					else
						button.Health:GetStatusBarTexture():SetTexture(groupbar)
					end
				end
			else
				if UFdb.gradientmode.enable then
					if UFdb.gradientmode.enablegroupunits and not UFdb.gradientmode.useUFtexture then
						button.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", UFdb.gradientmode.texture))
					end
				else
					if UFdb.uftextureversion ~= "NONE" then
						button.Health:GetStatusBarTexture():SetTexture(groupbar)
					end
				end
			end
		elseif UFdb.darkmode then
			if button.Health.backdropTex then
				if UFdb.ufcustomtexture.enable then
					if not UFdb.ufcustomtexture.noclasstexture then
						button.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(buttonclass))
					else
						button.Health.backdropTex:SetTexture(groupbar)
					end
				else
					if UFdb.gradientmode.enable then
						if UFdb.gradientmode.enablegroupunits and not UFdb.gradientmode.useUFtexture then
							button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", UFdb.gradientmode.texture))
						end
					else
						if UFdb.uftextureversion ~= "NONE" then
							button.Health.backdropTex:SetTexture(groupbar)
						end
					end
				end
			end
		end
	end
end

local forced = false
function ElvUI_EltreumUI:CustomTexture(unit)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	if not UFdb then return end
	if E.private.unitframe.enable and UFdb.UFmodifications then

		--main issue = the toggle for some units like boss and arena wont work bc it checks for boss1,boss2... instead of just boss
		if E.db.unitframe.units.player.enable then
			ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Player","player")
		end
		if E.db.unitframe.units.target.enable then
			ElvUI_EltreumUI:ApplyUnitCustomTexture("target", "Target","target")
		end
		if E.db.unitframe.units.targettarget.enable then
			ElvUI_EltreumUI:ApplyUnitCustomTexture("targettarget", "TargetTarget","targettarget")
		end
		if E.db.unitframe.units.targettargettarget.enable then
			ElvUI_EltreumUI:ApplyUnitCustomTexture("targettargettarget", "TargetTargetTarget","targettargettarget")
		end
		ElvUI_EltreumUI:ApplyUnitCustomTexture("pet", "Pet","pet")

		if E.Retail or E.Mists or E.TBC or E.Wrath then
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss1", "Boss1", "boss",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss2", "Boss2", "boss",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss3", "Boss3", "boss",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss4", "Boss4", "boss",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss5", "Boss5", "boss",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss6", "Boss6", "boss",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss7", "Boss7", "boss",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("boss8", "Boss8", "boss",true)
		end
		if not E.Classic then
			ElvUI_EltreumUI:ApplyUnitCustomTexture("focus", "Focus", "focus")
			ElvUI_EltreumUI:ApplyUnitCustomTexture("focustarget", "FocusTarget", "focus")
			ElvUI_EltreumUI:ApplyUnitCustomTexture("arena1", "Arena1", "arena",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("arena2", "Arena2", "arena",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("arena3", "Arena3", "arena",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("arena4", "Arena4", "arena",true)
			ElvUI_EltreumUI:ApplyUnitCustomTexture("arena5", "Arena5", "arena",true)
		end

		if unit == "testunit" then
			forced = true
			unit = "player"
		else
			forced = false
		end

		if forced then
			if E.Retail or E.Mists or E.TBC or E.Wrath then
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss1", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss2", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss3", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss4", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss5", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss6", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss7", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Boss8", "boss",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Arena1", "arena",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Arena2", "arena",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Arena3", "arena",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Arena4", "arena",true)
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Arena5", "arena",true)
			end
		end

		--group/raid unitframes
		if (UnitExists(unit) or forced) then

			--party/raid
			if _G["ElvUF_Party"] and _G["ElvUF_Party"]:IsVisible() then
				local partymembers = {_G["ElvUF_PartyGroup1"]:GetChildren()}
				for _, frame in pairs(partymembers) do
					if frame and frame.Health then
						ElvUI_EltreumUI:ApplyGroupCustomTexture(frame,true,"party")
					end
				end
				if E.db.unitframe.units.party.petsGroup.enable then
					if _G["ElvUF_PartyGroup1UnitButton1Pet"] and _G["ElvUF_PartyGroup1UnitButton1Pet"]:IsVisible() then
						for i = 1, 5 do
							local partypetbutton = _G["ElvUF_PartyGroup1UnitButton"..i.."Pet"]
							if partypetbutton and partypetbutton.Health then
								ElvUI_EltreumUI:ApplyGroupCustomTexture(partypetbutton,true)
							end
						end
					end
				end
			end

			if _G["ElvUF_Raid1"] and _G["ElvUF_Raid1"]:IsVisible() then
				for i = 1, 8 do
					if _G["ElvUF_Raid1Group"..i] then
						local raidmembers = {_G["ElvUF_Raid1Group"..i]:GetChildren()}
						for _, frame in pairs(raidmembers) do
							if frame and frame.Health then
								ElvUI_EltreumUI:ApplyGroupCustomTexture(frame,true,"raid")
							end
						end
					end
				end
			end

			if _G["ElvUF_Raid2"] and _G["ElvUF_Raid2"]:IsVisible() then
				for i = 1, 8 do
					if _G["ElvUF_Raid2Group"..i] then
						local raidmembers = {_G["ElvUF_Raid2Group"..i]:GetChildren()}
						for _, frame in pairs(raidmembers) do
							if frame and frame.Health then
								ElvUI_EltreumUI:ApplyGroupCustomTexture(frame,true,"raid")
							end
						end
					end
				end
			end

			if _G["ElvUF_Raid3"] and _G["ElvUF_Raid3"]:IsVisible() then
				for i = 1, 8 do
					if _G["ElvUF_Raid3Group"..i] then
						local raidmembers = {_G["ElvUF_Raid3Group"..i]:GetChildren()}
						for _, frame in pairs(raidmembers) do
							if frame and frame.Health then
								ElvUI_EltreumUI:ApplyGroupCustomTexture(frame,true,"raid")
							end
						end
					end
				end
			end

			--tanks
			if _G["ElvUF_TankUnitButton1"] and _G["ElvUF_TankUnitButton1"]:IsVisible() then
				for i = 1, 8 do
					local tankmembers = {_G["ElvUF_TankUnitButton"..i]}
					for _, frame in pairs(tankmembers) do
						if frame and frame.Health then
							ElvUI_EltreumUI:ApplyGroupCustomTexture(frame,true)
						end
					end
				end
			end

			--tank targets
			if _G["ElvUF_TankUnitButton1Target"] and _G["ElvUF_TankUnitButton1Target"]:IsVisible() then
				for i = 1, 8 do
					local tanktargetmembers = {_G["ElvUF_TankUnitButton"..i.."Target"]}
					for _, frame in pairs(tanktargetmembers) do
						if frame and frame.Health then
							ElvUI_EltreumUI:ApplyGroupCustomTexture(frame)
						end
					end
				end
			end

			--raid assist
			if _G["ElvUF_AssistUnitButton1"] and _G["ElvUF_AssistUnitButton1"]:IsVisible() then
				for i = 1, 8 do
					local assistmembers = {_G["ElvUF_AssistUnitButton"..i]}
					for _, frame in pairs(assistmembers) do
						if frame and frame.Health then
							ElvUI_EltreumUI:ApplyGroupCustomTexture(frame,true)
						end
					end
				end
			end

			--raid assist targets
			if _G["ElvUF_AssistUnitButton1Target"] and _G["ElvUF_AssistUnitButton1Target"]:IsVisible() then
				for i = 1, 8 do
					local assisttargetmembers = {_G["ElvUF_AssistUnitButton"..i.."Target"]}
					for _, frame in pairs(assisttargetmembers) do
						if frame and frame.Health then
							ElvUI_EltreumUI:ApplyGroupCustomTexture(frame)
						end
					end
				end
			end

			--raid pets
			if _G["ElvUF_RaidpetGroup1UnitButton1"] and _G["ElvUF_RaidpetGroup1UnitButton1"]:IsVisible() and E.db.unitframe.units.raidpet.enable then
				for i = 1, 40 do
					local raidpetbutton = {_G["ElvUF_RaidpetGroup1UnitButton"..i]}
					for _, frame in pairs(raidpetbutton) do
						if frame and frame.Health then
							ElvUI_EltreumUI:ApplyGroupCustomTexture(frame,true)
						end
					end
				end
			end
		end
	end
end
local function Eltreum_PostUpdateHealthColorTexture(self)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	if not UFdb then return end
	if E.private.unitframe.enable and UFdb.UFmodifications then
		local frame = self and self:GetParent()
		if frame and frame.unitframeType then
			if frame.unitframeType == "player" and E.db.unitframe.units.player.enable then
				ElvUI_EltreumUI:ApplyUnitCustomTexture("player", "Player","player")
			elseif frame.unitframeType == "target" and E.db.unitframe.units.target.enable then
				ElvUI_EltreumUI:ApplyUnitCustomTexture("target", "Target","target")
			elseif frame.unitframeType == "targettarget" and E.db.unitframe.units.targettarget.enable then
				ElvUI_EltreumUI:ApplyUnitCustomTexture("targettarget", "TargetTarget","targettarget")
			elseif frame.unitframeType == "targettargettarget" and E.db.unitframe.units.targettargettarget.enable then
				ElvUI_EltreumUI:ApplyUnitCustomTexture("targettargettarget", "TargetTargetTarget","targettargettarget")
			elseif frame.unitframeType == "pet" then
				ElvUI_EltreumUI:ApplyUnitCustomTexture("pet", "Pet","pet")
			elseif frame.unitframeType == "focus" and not E.Classic then
				ElvUI_EltreumUI:ApplyUnitCustomTexture("focus", "Focus", "focus")
			elseif frame.unitframeType == "focustarget" and not E.Classic then
				ElvUI_EltreumUI:ApplyUnitCustomTexture("focustarget", "FocusTarget", "focus")
			elseif frame.unitframeType == "boss" and (E.Retail or E.Mists or E.TBC or E.Wrath) then
				local id = frame.unit and frame.unit:match("boss(%d+)")
				if id then
					ElvUI_EltreumUI:ApplyUnitCustomTexture("boss"..id, "Boss"..id, "boss",true)
				end
			elseif frame.unitframeType == "arena" and not E.Classic then
				local id = frame.unit and frame.unit:match("arena(%d+)")
				if id then
					ElvUI_EltreumUI:ApplyUnitCustomTexture("arena"..id, "Arena"..id, "arena",true)
				end
			elseif frame.unitframeType == "party" then
				local isPet = frame.unit and frame.unit:match("pet")
				if not isPet then
					ElvUI_EltreumUI:ApplyGroupCustomTexture(frame,true,"party")
				else
					ElvUI_EltreumUI:ApplyGroupCustomTexture(frame,true)
				end
			elseif frame.unitframeType == "raid" or frame.unitframeType == "raid1" or frame.unitframeType == "raid2" or frame.unitframeType == "raid3" then
				ElvUI_EltreumUI:ApplyGroupCustomTexture(frame,true,"raid")
			elseif frame.unitframeType == "tank" or frame.unitframeType == "assist" or frame.unitframeType == "raidpet" then
				ElvUI_EltreumUI:ApplyGroupCustomTexture(frame,true)
			end
		end
	end
end
hooksecurefunc(UF, "PostUpdateHealthColor", Eltreum_PostUpdateHealthColorTexture) --WAS causing "blinking"/"flashing" issues in 10.0
hooksecurefunc(UF, "Style", ElvUI_EltreumUI.CustomTexture) --old target of target hook

-- replace absorb texture with unitframe texture
function ElvUI_EltreumUI:SetTexture_HealComm(obj)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	if not UFdb then return end
	if UFdb.UFmodifications then
		if UFdb.ufcustomtexture.enableHealComm then
			obj.healingPlayer:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
			obj.healingOther:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
			obj.damageAbsorb:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
			obj.healAbsorb:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
		elseif UFdb.ufcustomtexture.enableHealCommCustom then
			obj.healingPlayer:SetStatusBarTexture(E.LSM:Fetch("statusbar", UFdb.ufcustomtexture.enableHealCommTexture))
			obj.healingOther:SetStatusBarTexture(E.LSM:Fetch("statusbar", UFdb.ufcustomtexture.enableHealCommTexture))
			obj.damageAbsorb:SetStatusBarTexture(E.LSM:Fetch("statusbar", UFdb.ufcustomtexture.enableHealCommTexture))
			obj.healAbsorb:SetStatusBarTexture(E.LSM:Fetch("statusbar", UFdb.ufcustomtexture.enableHealCommTexture))
		end
	end
end
hooksecurefunc(UF, "SetTexture_HealComm", ElvUI_EltreumUI.SetTexture_HealComm)

