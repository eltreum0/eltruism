local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
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
local UnitInParty = _G.UnitInParty
local UnitInRaid = _G.UnitInRaid
local type = _G.type

--set the textures for single units
function ElvUI_EltreumUI:ApplyUnitCustomTexture(unit,name,unittexture,noOrientation)
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	if not UFdb then return end
	local elvDB = E.db.unitframe
	if not UnitExists(unit) then return end

	local _, classunit = UnitClass(unit)
	local reaction = UnitReaction(unit, "player")
	local isCharmed = UnitIsCharmed(unit)
	isCharmed = E:NotSecretValue(isCharmed) and isCharmed or false

	local isPlayer = UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))
	local isActualPlayer = false

	local unitframe = _G["ElvUF_"..name]
	if not (unitframe and unitframe.Health and unitframe.Health:GetStatusBarTexture() ~= nil) then return end

	if unitframe.realUnit then
		if name == "Player" and unitframe.__unit == "vehicle" then
			isPlayer = false
			isActualPlayer = false
		end
		if name == "Pet" and unitframe.__unit == "player" then
			isPlayer = true
			isActualPlayer = true
			classunit = E.myclass
		end
	end

	local targetUFOrientation = UFdb.UForientation
	if not noOrientation and targetUFOrientation and unitframe.Health.EltruismOrientation ~= targetUFOrientation then
		unitframe.Health:SetOrientation(targetUFOrientation)
		unitframe.Health.EltruismOrientation = targetUFOrientation
	end

	local healthTexture
	if (isPlayer and not isCharmed) or isActualPlayer then
		if not E:NotSecretValue(classunit) or not classunit then
			classunit = E.myclass or "ELTRUISM"
		end
		if UFdb.ufcustomtexture.enable then
			if UFdb.ufcustomtexture.classdetect then
				healthTexture = ElvUI_EltreumUI:UnitframeClassTextureCustom(classunit)
			else
				local customTex = UFdb.ufcustomtexture[unittexture.."texture"]
				healthTexture = E.LSM:Fetch("statusbar", customTex or elvDB.statusbar or UF.db.statusbar)
			end
		elseif UFdb.gradientmode.enable and (UFdb.gradientmode["enable"..unit] or UFdb.gradientmode["enable"..unittexture]) then
			if UFdb.gradientmode.useUFtexture then
				healthTexture = E.LSM:Fetch("statusbar", elvDB.statusbar or UF.db.statusbar)
			else
				healthTexture = E.LSM:Fetch("statusbar", UFdb.gradientmode.texture or elvDB.statusbar or UF.db.statusbar)
			end
		elseif UFdb.uftextureversion and UFdb.uftextureversion ~= "NONE" then
			healthTexture = ElvUI_EltreumUI:UnitframeClassTexture(classunit)
		else
			healthTexture = E.LSM:Fetch("statusbar", elvDB.statusbar or UF.db.statusbar)
		end
	else
		local isTap = UnitIsTapDenied(unit)
		isTap = E:NotSecretValue(isTap) and isTap
		local isPlayerControlled = UnitPlayerControlled(unit)
		isPlayerControlled = E:NotSecretValue(isPlayerControlled) and isPlayerControlled

		local customNpcTexture
		local defaultNpcTexture
		if isTap and not isPlayerControlled then
			customNpcTexture = ElvUI_EltreumUI:UnitframeClassTextureCustom("TAPPED")
			defaultNpcTexture = ElvUI_EltreumUI:UnitframeClassTexture("TAPPED")
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
				local canAttack = UnitCanAttack("player", unit)
				if E:NotSecretValue(canAttack) and canAttack then
					npcClass = "NPCHOSTILE"
				else
					local isEnemy = UnitIsEnemy("player", unit)
					if E:NotSecretValue(isEnemy) and isEnemy then
						npcClass = "NPCHOSTILE"
					else
						local isFriend = UnitIsFriend("player", unit)
						if E:NotSecretValue(isFriend) and isFriend then
							npcClass = "NPCFRIENDLY"
						else
							npcClass = "NPCHOSTILE"
						end
					end
				end
			end
			customNpcTexture = ElvUI_EltreumUI:UnitframeClassTextureCustom(npcClass)
			defaultNpcTexture = ElvUI_EltreumUI:UnitframeClassTexture(npcClass)
		end

		if UFdb.ufcustomtexture.enable then
			if UFdb.ufcustomtexture.classdetect then
				healthTexture = customNpcTexture
			else
				local customTex = UFdb.ufcustomtexture[unittexture.."texture"]
				healthTexture = E.LSM:Fetch("statusbar", customTex or elvDB.statusbar or UF.db.statusbar)
			end
		elseif UFdb.gradientmode.enable and (UFdb.gradientmode["enable"..unit] or UFdb.gradientmode["enable"..unittexture]) then
			if UFdb.gradientmode.useUFtexture then
				healthTexture = E.LSM:Fetch("statusbar", elvDB.statusbar or UF.db.statusbar)
			else
				healthTexture = E.LSM:Fetch("statusbar", UFdb.gradientmode.texture or elvDB.statusbar or UF.db.statusbar)
			end
		elseif UFdb.uftextureversion and UFdb.uftextureversion ~= "NONE" then
			healthTexture = defaultNpcTexture
		else
			healthTexture = E.LSM:Fetch("statusbar", elvDB.statusbar or UF.db.statusbar)
		end
	end

	local isTransparent = (unitframe.Health.isTransparent ~= nil and unitframe.Health.isTransparent) or elvDB.colors.transparentHealth
	local barTex = unitframe.Health:GetStatusBarTexture()
	local backdropTex = unitframe.Health.backdropTex or unitframe.Health.bg
	local backdropTexture = UFdb.ufcustomtexture.backdroptexture and E.LSM:Fetch("statusbar", UFdb.ufcustomtexture.backdroptexture) or (elvDB.statusbar and E.LSM:Fetch("statusbar", elvDB.statusbar))

	if not isTransparent then
		if UFdb.darkmode then
			local defaultTex = (elvDB.statusbar and E.LSM:Fetch("statusbar", elvDB.statusbar)) or (UF.db.statusbar and E.LSM:Fetch("statusbar", UF.db.statusbar))
			if barTex and defaultTex then
				barTex:SetTexture(defaultTex)
			end
			if backdropTex and healthTexture then
				backdropTex:SetTexture(healthTexture)
			end
		elseif UFdb.lightmode then
			if barTex and healthTexture then
				barTex:SetTexture(healthTexture)
			end
			if backdropTex and backdropTexture then
				backdropTex:SetTexture(backdropTexture)
			end
		end
		if backdropTex and UFdb.ufcustomtexture.backdroptexturestaticsize then
			backdropTex:SetAllPoints(unitframe.Health)
			if UFdb.ufcustomtexture.fliptargetbackdrop and name == 'Target' then
				backdropTex:SetTexCoord(1, 0, 0, 1)
			else
				backdropTex:SetTexCoord(0, 1, 0, 1)
			end
		end
	else
		if UFdb.darkmode then
			if barTex and barTex.SetColorTexture then
				barTex:SetColorTexture(0, 0, 0, 0)
			end
			if backdropTex and healthTexture then
				backdropTex:SetTexture(healthTexture)
			end
		elseif UFdb.lightmode then
			if barTex and healthTexture then
				barTex:SetTexture(healthTexture)
			end
			if backdropTex and backdropTexture then
				backdropTex:SetTexture(backdropTexture)
			end
		end
		if backdropTex and UFdb.ufcustomtexture.backdroptexturestaticsize then
			backdropTex:SetAllPoints(unitframe.Health)
			if UFdb.ufcustomtexture.fliptargetbackdrop and name == 'Target' then
				backdropTex:SetTexCoord(1, 0, 0, 1)
			else
				backdropTex:SetTexCoord(0, 1, 0, 1)
			end
		end
	end

	if ElvUI_EltreumUI.ApplyBackdropAlphas then
		ElvUI_EltreumUI.ApplyBackdropAlphas(UFdb, unitframe.Health.bg, unitframe.Health.backdrop, backdropTex, isTransparent, barTex)
	end
end

--set the textures for group units
function ElvUI_EltreumUI:ApplyGroupCustomTexture(button,noOrientation,frametype)
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	if not UFdb then return end
	local elvDB = E.db.unitframe
	local unit = button.__unit or button.unit
	if not unit then return end
	if not button.Health then return end

	--due to raid pet, check if is player
	local buttonclass
	if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
		buttonclass = select(2, UnitClass(unit))
		if not E:NotSecretValue(buttonclass) or not buttonclass then
			buttonclass = "NPCFRIENDLY"
		end
	else
		buttonclass = "NPCFRIENDLY"
	end

	local targetUFOrientation = UFdb.UForientation
	if not noOrientation and targetUFOrientation and button.Health.EltruismOrientation ~= targetUFOrientation then
		button.Health:SetOrientation(targetUFOrientation)
		button.Health.EltruismOrientation = targetUFOrientation
	end

	local healthTexture
	if UFdb.ufcustomtexture.enable then
		if not UFdb.ufcustomtexture.noclasstexture then
			healthTexture = ElvUI_EltreumUI:UnitframeClassTextureCustom(buttonclass)
		else
			if frametype == "raid" then
				healthTexture = ElvUI_EltreumUI:UnitframeClassTextureCustom("RAID")
			elseif frametype == "party" then
				healthTexture = ElvUI_EltreumUI:UnitframeClassTextureCustom("PARTY")
			else
				healthTexture = ElvUI_EltreumUI:UnitframeClassTexture(buttonclass)
			end
		end
	elseif UFdb.gradientmode.enable and UFdb.gradientmode.enablegroupunits then
		if UFdb.gradientmode.useUFtexture then
			healthTexture = E.LSM:Fetch("statusbar", elvDB.statusbar or UF.db.statusbar)
		else
			healthTexture = E.LSM:Fetch("statusbar", UFdb.gradientmode.texture or elvDB.statusbar or UF.db.statusbar)
		end
	elseif UFdb.uftextureversion and UFdb.uftextureversion ~= "NONE" then
		healthTexture = ElvUI_EltreumUI:UnitframeClassTexture(buttonclass)
	else
		healthTexture = E.LSM:Fetch("statusbar", elvDB.statusbar or UF.db.statusbar)
	end

	local isTransparent = (button.Health.isTransparent ~= nil and button.Health.isTransparent) or elvDB.colors.transparentHealth
	local barTex = button.Health:GetStatusBarTexture()
	local backdropTex = button.Health.backdropTex or button.Health.bg
	local backdropTexture = UFdb.ufcustomtexture.backdroptexture and E.LSM:Fetch("statusbar", UFdb.ufcustomtexture.backdroptexture) or (elvDB.statusbar and E.LSM:Fetch("statusbar", elvDB.statusbar))

	if not isTransparent then
		if UFdb.darkmode then
			local defaultTex = (elvDB.statusbar and E.LSM:Fetch("statusbar", elvDB.statusbar)) or (UF.db.statusbar and E.LSM:Fetch("statusbar", UF.db.statusbar))
			if barTex and defaultTex then
				barTex:SetTexture(defaultTex)
			end
			if backdropTex and healthTexture then
				backdropTex:SetTexture(healthTexture)
			end
		elseif UFdb.lightmode then
			if barTex and healthTexture then
				barTex:SetTexture(healthTexture)
			end
			if backdropTex and backdropTexture then
				backdropTex:SetTexture(backdropTexture)
			end
		end
		if backdropTex and UFdb.ufcustomtexture.backdroptexturestaticsize then
			backdropTex:SetAllPoints(button.Health)
		end
	else
		if UFdb.darkmode then
			if barTex and barTex.SetColorTexture then
				barTex:SetColorTexture(0, 0, 0, 0)
			end
			if backdropTex and healthTexture then
				backdropTex:SetTexture(healthTexture)
			end
		elseif UFdb.lightmode then
			if barTex and healthTexture then
				barTex:SetTexture(healthTexture)
			end
			if backdropTex and backdropTexture then
				backdropTex:SetTexture(backdropTexture)
			end
		end
		if backdropTex and UFdb.ufcustomtexture.backdroptexturestaticsize then
			backdropTex:SetAllPoints(button.Health)
		end
	end

	if ElvUI_EltreumUI.ApplyBackdropAlphas then
		ElvUI_EltreumUI.ApplyBackdropAlphas(UFdb, button.Health.bg, button.Health.backdrop, backdropTex, isTransparent, barTex)
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
		if ((type(unit) == "string" and UnitExists(unit)) or UnitInParty("player") or UnitInRaid("player") or forced) then

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
local individualUnits = {
	player = { name = "Player", db = "player" },
	target = { name = "Target", db = "target" },
	targettarget = { name = "TargetTarget", db = "targettarget" },
	targettargettarget = { name = "TargetTargetTarget", db = "targettargettarget" },
	pet = { name = "Pet", db = "pet" },
	focus = { name = "Focus", db = "focus" },
	focustarget = { name = "FocusTarget", db = "focustarget" },
}

function ElvUI_EltreumUI:PostUpdateHealth(bar, unit)
	if not bar or type(bar) ~= "table" or not bar.GetParent then return end
	local u = unit
	if ElvUI_EltreumUI:EncounterCheck() then return end
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	if not UFdb or not UFdb.UFmodifications or not E.private.unitframe.enable then return end
	local elvDB = E.db.unitframe

	local parent = bar.origParent or bar:GetParent()
	if not parent then return end

	local frameType = parent.unitframeType
	if not frameType then
		local fUnit = parent.__unit or parent.unit or u
		if fUnit then
			parent.__unit = fUnit
			ElvUI_EltreumUI:ApplyGroupCustomTexture(parent, true)
			if UFdb.gradientmode and UFdb.gradientmode.enable and UFdb.hasMode then
				ElvUI_EltreumUI:ApplyGroupGradient(parent, true)
			end
		end
		return
	end

	local info = individualUnits[frameType]
	if info then
		if elvDB.units[frameType] and not elvDB.units[frameType].enable then return end
		local unitID = u or frameType
		ElvUI_EltreumUI:ApplyUnitCustomTexture(unitID, info.name, info.db)
		if UFdb.gradientmode and UFdb.gradientmode.enable and UFdb.hasMode then
			ElvUI_EltreumUI:ApplyUnitGradient(unitID, info.name, info.db)
		end
	elseif frameType == "boss" and (E.Retail or E.Mists or E.TBC or E.Wrath) then
		local frameName = parent:GetName()
		local bossName = frameName and frameName:sub(7)
		local bossUnit = parent.unit or parent.__unit or (bossName and bossName:lower())
		if bossName and bossUnit then
			ElvUI_EltreumUI:ApplyUnitCustomTexture(bossUnit, bossName, "boss", true)
			if UFdb.gradientmode and UFdb.gradientmode.enable and UFdb.hasMode then
				ElvUI_EltreumUI:ApplyUnitGradient(bossUnit, bossName, "boss", true)
			end
		end
	elseif frameType == "arena" and not E.Classic then
		local frameName = parent:GetName()
		local arenaName = frameName and frameName:sub(7)
		local arenaUnit = parent.unit or parent.__unit or (arenaName and arenaName:lower())
		if arenaName and arenaUnit then
			ElvUI_EltreumUI:ApplyUnitCustomTexture(arenaUnit, arenaName, "arena", true)
			if UFdb.gradientmode and UFdb.gradientmode.enable and UFdb.hasMode then
				ElvUI_EltreumUI:ApplyUnitGradient(arenaUnit, arenaName, "arena", true)
			end
		end
	elseif frameType == "party" then
		local isPet = parent.unit and parent.unit:match("pet")
		if not isPet then
			ElvUI_EltreumUI:ApplyGroupCustomTexture(parent, true, "party")
		else
			ElvUI_EltreumUI:ApplyGroupCustomTexture(parent, true)
		end
		if UFdb.gradientmode and UFdb.gradientmode.enable and UFdb.hasMode then
			ElvUI_EltreumUI:ApplyGroupGradient(parent, true)
		end
	elseif frameType == "raid" or frameType == "raid1" or frameType == "raid2" or frameType == "raid3" then
		ElvUI_EltreumUI:ApplyGroupCustomTexture(parent, true, "raid")
		if UFdb.gradientmode and UFdb.gradientmode.enable and UFdb.hasMode then
			ElvUI_EltreumUI:ApplyGroupGradient(parent, true)
		end
	elseif frameType == "tank" or frameType == "assist" or frameType == "raidpet" then
		ElvUI_EltreumUI:ApplyGroupCustomTexture(parent, true)
		if UFdb.gradientmode and UFdb.gradientmode.enable and UFdb.hasMode then
			ElvUI_EltreumUI:ApplyGroupGradient(parent, true)
		end
	end
end
ElvUI_EltreumUI:SecureHook(UF, "PostUpdateHealthColor", "PostUpdateHealth")
ElvUI_EltreumUI:SecureHook(UF, "Style", "CustomTexture") --old target of target hook

-- replace absorb texture with unitframe texture
function ElvUI_EltreumUI:SetTexture_HealComm(_, obj)
	if not obj or type(obj) ~= "table" then return end
	if ElvUI_EltreumUI:EncounterCheck() then return end
	local UFdb = E.db.ElvUI_EltreumUI.unitframes
	if not UFdb or not UFdb.UFmodifications or not UFdb.ufcustomtexture then return end

	local texture
	if UFdb.ufcustomtexture.enableHealComm then
		texture = E.LSM:Fetch("statusbar", E.db.unitframe.statusbar)
	elseif UFdb.ufcustomtexture.enableHealCommCustom then
		texture = E.LSM:Fetch("statusbar", UFdb.ufcustomtexture.enableHealCommTexture)
	end

	if texture then
		if obj.healingPlayer and obj.healingPlayer.SetStatusBarTexture then
			obj.healingPlayer:SetStatusBarTexture(texture)
		end
		if obj.healingOther and obj.healingOther.SetStatusBarTexture then
			obj.healingOther:SetStatusBarTexture(texture)
		end
		if obj.damageAbsorb and obj.damageAbsorb.SetStatusBarTexture then
			obj.damageAbsorb:SetStatusBarTexture(texture)
		end
		if obj.healAbsorb and obj.healAbsorb.SetStatusBarTexture then
			obj.healAbsorb:SetStatusBarTexture(texture)
		end
	end
end
ElvUI_EltreumUI:SecureHook(UF, "SetTexture_HealComm", "SetTexture_HealComm")

