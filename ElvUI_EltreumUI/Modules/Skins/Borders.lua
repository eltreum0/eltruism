local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local A = E:GetModule('Auras')

local classcolorreaction = {
	["WARRIOR"] = {r1 = 0.77646887302399, g1 = 0.60784178972244, b1 = 0.4274500310421},
	["PALADIN"] = {r1 = 0.95686066150665, g1 = 0.54901838302612, b1 = 0.72941017150879},
	["HUNTER"] = {r1 = 0.66666519641876, g1 = 0.82744914293289, b1 = 0.44705784320831},
	["ROGUE"] = {r1 = 0.99999779462814, g1 = 0.95686066150665, b1 = 0.40784224867821},
	["PRIEST"] = {r1 = 0.99999779462814, g1 = 0.99999779462814, b1 = 0.99999779462814},
	["DEATHKNIGHT"] = {r1 = 0.76862573623657, g1 = 0.11764679849148, b1 = 0.2274504750967},
	["SHAMAN"] = {r1 = 0, g1 = 0.4392147064209, b1 = 0.86666476726532},
	["MAGE"] = {r1 = 0.24705828726292, g1 = 0.78039044141769, b1 = 0.92156660556793},
	["WARLOCK"] = {r1 = 0.52941060066223, g1 = 0.53333216905594, b1 = 0.93333131074905},
	["MONK"] = {r1 = 0, g1 = 0.99999779462814, b1 = 0.59607714414597},
	["DRUID"] = {r1 = 0.99999779462814, g1 = 0.48627343773842, b1 = 0.039215601980686},
	["DEMONHUNTER"] = {r1 = 0.63921427726746, g1 = 0.1882348805666, b1 = 0.78823357820511},
	["NPCFRIENDLY"] = {r1 = 0.2, g1 = 1, b1 = 0.2},
	["NPCNEUTRAL"] = {r1 = 0.89, g1 = 0.89, b1 = 0},
	["NPCUNFRIENDLY"] = {r1 = 0.94, g1 = 0.37, b1 = 0},
	["NPCHOSTILE"] = {r1 = 0.8, g1 = 0, b1 = 0},
}

local targetborder
local targetcreatedcheck = false
local targettargetborder
local targettargetcreatedcheck = false
local targetcastbarborder
local targetcastbarcreatedcheck = false
local bordertexture
local classcolor
local focusborder
local bossborder

--Borders on frames
function ElvUI_EltreumUI:Borders()
	if E.db.ElvUI_EltreumUI.borders.borders then
		--borders not nice with transparent power
		if E.db["unitframe"]["units"]["player"]["power"]["width"] == "spaced" then
			E.db["unitframe"]["colors"]["transparentPower"] = false
		end

		if E.db.ElvUI_EltreumUI.borders.texture then
			bordertexture = E.LSM:Fetch("border", E.db.ElvUI_EltreumUI.borders.texture)
			if bordertexture == nil then --the border was not found so apply the default
				bordertexture = E.LSM:Fetch("border", "Eltreum-Border-1")
				E.db.ElvUI_EltreumUI.borders.texture = "Eltreum-Border-1"
			end
		else --use default if value is nil
			bordertexture = "Interface\\Addons\\ElvUI_EltreumUI\\Media\border\\Eltreum-Border-1.tga"
		end

		if E.db.ElvUI_EltreumUI.borders.classcolor == true then
			classcolor = E:ClassColor(E.myclass, true)
		else
			classcolor = {
				r = E.db.ElvUI_EltreumUI.bordercolors.r,
				g = E.db.ElvUI_EltreumUI.bordercolors.g,
				b = E.db.ElvUI_EltreumUI.bordercolors.b
			}
		end

		local playertargetsize = E.db.ElvUI_EltreumUI.borders.playertargetsize
		local baredgesize = E.db.ElvUI_EltreumUI.borders.baredgesize
		local xbar = E.db.ElvUI_EltreumUI.borders.bar1xborder
		local ybar = E.db.ElvUI_EltreumUI.borders.bar1yborder
		local xbar2 = E.db.ElvUI_EltreumUI.borders.bar2xborder
		local ybar2 = E.db.ElvUI_EltreumUI.borders.bar2yborder
		local xbar3 = E.db.ElvUI_EltreumUI.borders.bar3xborder
		local ybar3 = E.db.ElvUI_EltreumUI.borders.bar3yborder
		local xbar4 = E.db.ElvUI_EltreumUI.borders.bar4xborder
		local ybar4 = E.db.ElvUI_EltreumUI.borders.bar4yborder
		local xbar5 = E.db.ElvUI_EltreumUI.borders.bar5xborder
		local ybar5 = E.db.ElvUI_EltreumUI.borders.bar5yborder
		local xbar6 = E.db.ElvUI_EltreumUI.borders.bar6xborder
		local ybar6 = E.db.ElvUI_EltreumUI.borders.bar6yborder
		local leftchatsizex = E.db.ElvUI_EltreumUI.borders.leftchatborderx
		local leftchatsizey = E.db.ElvUI_EltreumUI.borders.leftchatbordery
		local rightchatsizex = E.db.ElvUI_EltreumUI.borders.rightchatborderx
		local rightchatsizey = E.db.ElvUI_EltreumUI.borders.rightchatbordery
		local partysizex = E.db.ElvUI_EltreumUI.borders.partysizex
		local partysizey = E.db.ElvUI_EltreumUI.borders.partysizey
		local raidsizex = E.db.ElvUI_EltreumUI.borders.raidsizex
		local raidsizey = E.db.ElvUI_EltreumUI.borders.raidsizey
		local raid40sizex = E.db.ElvUI_EltreumUI.borders.raid40sizex
		local raid40sizey = E.db.ElvUI_EltreumUI.borders.raid40sizey

		--elvui unitframes
		if E.private.unitframe.enable then

			--player
			if E.db.ElvUI_EltreumUI.borders.playerborder and E.db.unitframe.units.player.enable then
				local playerborder
				if not _G["EltruismPlayerBorder"] then
					playerborder = CreateFrame("Frame", "EltruismPlayerBorder", _G.ElvUF_Player_HealthBar, BackdropTemplateMixin and "BackdropTemplate")
				else
					playerborder = _G["EltruismPlayerBorder"]
				end
				playerborder:SetSize(E.db.ElvUI_EltreumUI.borders.xplayer, E.db.ElvUI_EltreumUI.borders.yplayer)
				playerborder:SetPoint("CENTER", _G.ElvUF_Player_HealthBar, "CENTER", 0, 0)
				playerborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = playertargetsize,
				})
				playerborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				playerborder:SetFrameStrata("LOW")
			end

			--player castbar
			if E.db.ElvUI_EltreumUI.borders.playercastborder and E.db.unitframe.units.player.castbar.enable then
				local playercastbarborder
				if not _G["EltruismPlayerCastBarBorder"] then
					playercastbarborder = CreateFrame("Frame", "EltruismPlayerCastBarBorder", _G.ElvUF_Player_CastBar, BackdropTemplateMixin and "BackdropTemplate")
				else
					playercastbarborder = _G["EltruismPlayerCastBarBorder"]
				end
				local isattachedplayer = E.db.unitframe.units.player.castbar.iconAttached
				if isattachedplayer == false then
					playercastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xplayercast + E.db.unitframe.units.player.castbar.iconSize, E.db.ElvUI_EltreumUI.borders.yplayercast)
					playercastbarborder:SetPoint("CENTER", _G["ElvUF_Player_CastBar"], "CENTER", -E.db.unitframe.units.player.castbar.iconSize/2, 0)
				elseif isattachedplayer == true then
					playercastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xplayercast, E.db.ElvUI_EltreumUI.borders.yplayercast)
					playercastbarborder:SetPoint("CENTER", _G["ElvUF_Player_CastBar"], "CENTER", -E.db.unitframe.units.player.castbar.iconSize/2, 0)
				end
				playercastbarborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = playertargetsize,
				})
				playercastbarborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				playercastbarborder:SetFrameStrata("MEDIUM")
			end

			--target
			if E.db.ElvUI_EltreumUI.borders.targetborder and E.db.unitframe.units.target.enable and targetcreatedcheck == false then
				if not _G["EltruismTargetBorder"] then
					targetborder = CreateFrame("Frame", "EltruismTargetBorder", _G.ElvUF_Target_HealthBar, BackdropTemplateMixin and "BackdropTemplate")
				else
					targetborder = _G["EltruismTargetBorder"]
				end
				targetborder:SetSize(E.db.ElvUI_EltreumUI.borders.xtarget, E.db.ElvUI_EltreumUI.borders.ytarget)
				targetborder:SetPoint("CENTER", _G.ElvUF_Target_HealthBar, "CENTER", 0 ,0)
				targetborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = playertargetsize,
				})
				targetborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				targetborder:SetFrameStrata("LOW")
				targetcreatedcheck = true
			end

			--target castbar
			if E.db.ElvUI_EltreumUI.borders.targetcastborder and E.db.unitframe.units.target.castbar.enable and targetcastbarcreatedcheck == false and not (E.db.unitframe.units.target.castbar.overlayOnFrame == "Power") then
				if not _G["EltruismTargetCastBarBorder"] then
					targetcastbarborder = CreateFrame("Frame", "EltruismTargetCastBarBorder", _G.ElvUF_Target_CastBar, BackdropTemplateMixin and "BackdropTemplate")
				else
					targetcastbarborder = _G["EltruismTargetCastBarBorder"]
				end
				local isattachedtarget = E.db.unitframe.units.target.castbar.iconAttached
				if isattachedtarget == false then
					targetcastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xcasttarget + E.db.unitframe.units.target.castbar.iconSize, E.db.ElvUI_EltreumUI.borders.ycasttarget)
					targetcastbarborder:SetPoint("CENTER", _G["ElvUF_Target_CastBar"], "CENTER", -E.db.unitframe.units.target.castbar.iconSize/2, 0)
				elseif isattachedtarget == true then
					targetcastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xcasttarget, E.db.ElvUI_EltreumUI.borders.ycasttarget)
					targetcastbarborder:SetPoint("CENTER", _G["ElvUF_Target_CastBar"], "CENTER", -E.db.unitframe.units.target.castbar.iconSize/2, 0)
				end
				targetcastbarborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = playertargetsize,
				})
				targetcastbarborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				targetcastbarborder:SetFrameStrata("MEDIUM")
				targetcastbarcreatedcheck = true
			end

			--target of target
			if E.db.ElvUI_EltreumUI.borders.targettargetborder and E.db.unitframe.units.targettarget.enable and targettargetcreatedcheck == false then
				if not _G["EltruismTargetTargetBorder"] then
					targettargetborder = CreateFrame("Frame", "EltruismTargetTargetBorder", _G.ElvUF_TargetTarget_HealthBar, BackdropTemplateMixin and "BackdropTemplate")
				else
					targettargetborder = _G["EltruismTargetTargetBorder"]
				end
				targettargetborder:SetSize(E.db.ElvUI_EltreumUI.borders.xtargettarget, E.db.ElvUI_EltreumUI.borders.ytargettarget)
				targettargetborder:SetPoint("CENTER", _G.ElvUF_TargetTarget_HealthBar, "CENTER", 0 ,0)
				targettargetborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = playertargetsize,
				})
				targettargetborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				targettargetborder:SetFrameStrata("LOW")
				targettargetcreatedcheck = true
			end

			--pet
			if E.db.ElvUI_EltreumUI.borders.petborder and E.db.unitframe.units.pet.enable then
				local petborder
				if not _G["EltruismPetBorder"] then
					petborder = CreateFrame("Frame", "EltruismPetBorder", _G.ElvUF_Pet_HealthBar, BackdropTemplateMixin and "BackdropTemplate")
				else
					petborder = _G["EltruismPetBorder"]
				end
				local petsizex, petsizey = _G["ElvUF_Pet_HealthBar"]:GetSize()
				petborder:SetSize(petsizex, petsizey)
				petborder:SetPoint("TOPRIGHT", _G.ElvUF_Pet_HealthBar,"TOPRIGHT", 17, 16)
				petborder:SetPoint("BOTTOMLEFT", _G.ElvUF_Pet_HealthBar,"BOTTOMLEFT", -17, -16)
				petborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = playertargetsize,
				})
				petborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				petborder:SetFrameStrata("LOW")
			end

			--party
			if E.db.ElvUI_EltreumUI.borders.partyborders and E.db.unitframe.units.party.enable and not self.partyborderscreated then
				local bordersparty = {}
				for i = 1,5 do
					table.insert(bordersparty, _G["ElvUF_PartyGroup1UnitButton"..i])
				end
				local function createpartyborders()
					for _,v in pairs(bordersparty) do
						local partyborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						partyborder:SetSize(partysizex, partysizey)
						partyborder:SetPoint("CENTER", v, "CENTER")
						partyborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize+1,
						})
						if E.db.ElvUI_EltreumUI.borders.classcolor == true then
							partyborder:SetBackdropBorderColor(1, 1, 1, 1)
						else
							partyborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
						end
						partyborder:SetFrameStrata("MEDIUM")
					end
					self.partyborderscreated = true
				end
				createpartyborders()
			end

			--raid
			if E.db.ElvUI_EltreumUI.borders.raidborders and E.db.unitframe.units.raid.enable and not self.raidborderscreated then
				local bordersraid = {}
				for i = 1,5 do
					table.insert(bordersraid, _G["ElvUF_RaidGroup1UnitButton"..i])
					table.insert(bordersraid, _G["ElvUF_RaidGroup2UnitButton"..i])
					table.insert(bordersraid, _G["ElvUF_RaidGroup3UnitButton"..i])
					table.insert(bordersraid, _G["ElvUF_RaidGroup4UnitButton"..i])
					table.insert(bordersraid, _G["ElvUF_RaidGroup5UnitButton"..i])
					table.insert(bordersraid, _G["ElvUF_RaidGroup6UnitButton"..i])
					table.insert(bordersraid, _G["ElvUF_RaidGroup7UnitButton"..i])
					table.insert(bordersraid, _G["ElvUF_RaidGroup8UnitButton"..i])
				end
				local function createraidborders()
					for _,v in pairs(bordersraid) do
						local raidborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						raidborder:SetSize(raidsizex, raidsizey)
						raidborder:SetPoint("CENTER", v, "CENTER")
						raidborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize+1,
						})
						if E.db.ElvUI_EltreumUI.borders.classcolor == true then
							raidborder:SetBackdropBorderColor(1, 1, 1, 1)
						else
							raidborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
						end
						raidborder:SetFrameStrata("MEDIUM")
					end
					self.raidborderscreated = true
				end
				createraidborders()
			end

			--raid40
			if E.db.ElvUI_EltreumUI.borders.raid40borders and E.db.unitframe.units.raid40.enable and not self.raid40borderscreated then
				local bordersraid40 = {}
				for i = 1,5 do
					table.insert(bordersraid40, _G["ElvUF_Raid40Group1UnitButton"..i])
					table.insert(bordersraid40, _G["ElvUF_Raid40Group2UnitButton"..i])
					table.insert(bordersraid40, _G["ElvUF_Raid40Group3UnitButton"..i])
					table.insert(bordersraid40, _G["ElvUF_Raid40Group4UnitButton"..i])
					table.insert(bordersraid40, _G["ElvUF_Raid40Group5UnitButton"..i])
					table.insert(bordersraid40, _G["ElvUF_Raid40Group6UnitButton"..i])
					table.insert(bordersraid40, _G["ElvUF_Raid40Group7UnitButton"..i])
					table.insert(bordersraid40, _G["ElvUF_Raid40Group8UnitButton"..i])
				end
				local function createraid40borders()
					for _,v in pairs(bordersraid40) do
						local raidborder40 = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						raidborder40:SetSize(raid40sizex, raid40sizey)
						raidborder40:SetPoint("CENTER", v, "CENTER")
						raidborder40:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize+1,
						})
						if E.db.ElvUI_EltreumUI.borders.classcolor == true then
							raidborder40:SetBackdropBorderColor(1, 1, 1, 1)
						else
							raidborder40:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
						end
						raidborder40:SetFrameStrata("MEDIUM")
					end
					self.raid40borderscreated = true
				end
				createraid40borders()
			end

			--focus
			if E.db.ElvUI_EltreumUI.borders.focusborder and E.db.unitframe.units.focus.enable and not E.Classic then
				if not _G["EltruismFocusBorder"] then
					focusborder = CreateFrame("Frame", "EltruismFocusBorder", _G.ElvUF_Focus_HealthBar, BackdropTemplateMixin and "BackdropTemplate")
				else
					focusborder = _G["EltruismFocusBorder"]
				end
				focusborder:SetSize(E.db.ElvUI_EltreumUI.borders.xfocus, E.db.ElvUI_EltreumUI.borders.yfocus)
				focusborder:SetPoint("CENTER", _G.ElvUF_Focus_HealthBar, "CENTER", 0, 0)
				focusborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = playertargetsize,
				})
				focusborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				focusborder:SetFrameStrata("LOW")
			end

			--boss
			if E.db.ElvUI_EltreumUI.borders.bossborder and E.db.unitframe.units.boss.enable and not E.Classic then
				local bordersboss = {}
				for i = 1,8 do
					local bossmembers = {_G["ElvUF_Boss"..i]}
					for _, frame in pairs(bossmembers) do
						bossborder = CreateFrame("Frame", "EltruismBossBorder"..i, frame, BackdropTemplateMixin and "BackdropTemplate")
						bossborder:SetSize(E.db.ElvUI_EltreumUI.borders.xboss, E.db.ElvUI_EltreumUI.borders.yboss)
						bossborder:SetPoint("CENTER", frame, "CENTER")
						bossborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = playertargetsize,
						})
						if UnitExists("boss"..i) and E.db.ElvUI_EltreumUI.borders.classcolor == true then
							local reactionboss= UnitReaction("player", "boss"..i)
							if reactionboss >= 5 then
								bossborder:SetBackdropBorderColor(classcolorreaction["NPCFRIENDLY"]["r1"], classcolorreaction["NPCFRIENDLY"]["g1"], classcolorreaction["NPCFRIENDLY"]["b1"], 1)
							elseif reactionboss == 4 then
								bossborder:SetBackdropBorderColor(classcolorreaction["NPCNEUTRAL"]["r1"], classcolorreaction["NPCNEUTRAL"]["g1"], classcolorreaction["NPCNEUTRAL"]["b1"], 1)
							elseif reactionboss == 3 then
								bossborder:SetBackdropBorderColor(classcolorreaction["NPCUNFRIENDLY"]["r1"], classcolorreaction["NPCUNFRIENDLY"]["g1"], classcolorreaction["NPCUNFRIENDLY"]["b1"], 1)
							elseif reactionboss == 2 or reactionboss == 1 then
								bossborder:SetBackdropBorderColor(classcolorreaction["NPCHOSTILE"]["r1"], classcolorreaction["NPCHOSTILE"]["g1"], classcolorreaction["NPCHOSTILE"]["b1"], 1)
							end
						else
							bossborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
						end
						bossborder:SetFrameStrata("MEDIUM")
					end
				end
			end

		end

		--elvui action bars (has to be split because it bar can be different sizes)
		if E.private.actionbar.enable then
			--action bar 1
			if E.db.ElvUI_EltreumUI.borders.bar1borders and E.db.actionbar.bar1.enabled and not self.abboderscreatedbar1 then
				local borders1 = {}
				for i = 1,12 do
					table.insert(borders1, _G["ElvUI_Bar1Button"..i])
				end
				local function createbar1borders()
					for _,v in pairs(borders1) do
						local barborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						barborder:SetSize(xbar, ybar)
						barborder:SetPoint("CENTER", v, "CENTER")
						barborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize,
						})
						barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					end
					self.abboderscreatedbar1 = true
				end
				createbar1borders()
			end

			--bar2
			if E.db.ElvUI_EltreumUI.borders.bar2borders and E.db.actionbar.bar2.enabled and not self.abboderscreatedbar2 then
				local borders2 = {}
				for i = 1,12 do
					table.insert(borders2, _G["ElvUI_Bar2Button"..i])
				end
				local function createbar2borders()
					for _,v in pairs(borders2) do
						local barborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						barborder:SetSize(xbar2, ybar2)
						barborder:SetPoint("CENTER", v, "CENTER")
						barborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize,
						})
						barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					end
					self.abboderscreatedbar2 = true
				end
				createbar2borders()
			end

			--bar3
			if E.db.ElvUI_EltreumUI.borders.bar3borders and E.db.actionbar.bar3.enabled and not self.abboderscreatedbar3 then
				local borders3 = {}
				for i = 1,12 do
					table.insert(borders3, _G["ElvUI_Bar3Button"..i])
				end
				local function createbar3borders()
					for _,v in pairs(borders3) do
						local barborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						barborder:SetSize(xbar3, ybar3)
						barborder:SetPoint("CENTER", v, "CENTER")
						barborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize,
						})
						barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					end
					self.abboderscreatedbar3 = true
				end
				createbar3borders()
			end

			--bar4
			if E.db.ElvUI_EltreumUI.borders.bar4borders and E.db.actionbar.bar4.enabled and not self.abboderscreatedbar4 then
				local borders4 = {}
				for i = 1,12 do
					table.insert(borders4, _G["ElvUI_Bar4Button"..i])
				end
				local function createbar4borders()
					for _,v in pairs(borders4) do
						local barborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						barborder:SetSize(xbar4, ybar4)
						barborder:SetPoint("CENTER", v, "CENTER")
						barborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize,
						})
						barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					end
					self.abboderscreatedbar4 = true
				end
				createbar4borders()
			end

			--bar5
			if E.db.ElvUI_EltreumUI.borders.bar5borders and E.db.actionbar.bar5.enabled and not self.abboderscreatedbar5 then
				local borders5 = {}
				for i = 1,12 do
					table.insert(borders5, _G["ElvUI_Bar5Button"..i])
				end
				local function createbar5borders()
					for _,v in pairs(borders5) do
						local barborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						barborder:SetSize(xbar5, ybar5)
						barborder:SetPoint("CENTER", v, "CENTER")
						barborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize,
						})
						barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					end
					self.abboderscreatedbar5 = true
				end
				createbar5borders()
			end

			--bar6
			if E.db.ElvUI_EltreumUI.borders.bar6borders and E.db.actionbar.bar6.enabled and not self.abboderscreatedbar6 then
				local borders6 = {}
				for i = 1,12 do
					table.insert(borders6, _G["ElvUI_Bar6Button"..i])
				end
				local function createbar6borders()
					for _,v in pairs(borders6) do
						local barborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						barborder:SetSize(xbar6, ybar6)
						barborder:SetPoint("CENTER", v, "CENTER")
						barborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize,
						})
						barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					end
					self.abboderscreatedbar6 = true
				end
				createbar6borders()
			end
		end

		--nameplate power bar
		local powerbarsize = E.db.ElvUI_EltreumUI.borders.powerbarsize
		local EltruismPowerBar = _G.EltruismPowerBar
		if E.db.ElvUI_EltreumUI.borders.powerbarborder then
			local powerbarborder
			if not _G["EltruismPowerBarBorder"] then
				powerbarborder = CreateFrame("Frame", "EltruismPowerBarBorder", EltruismPowerBar, BackdropTemplateMixin and "BackdropTemplate")
			else
				powerbarborder = _G["EltruismPowerBarBorder"]
			end
			powerbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xpowerbar, E.db.ElvUI_EltreumUI.borders.ypowerbar)
			powerbarborder:SetPoint("CENTER", EltruismPowerBar, "CENTER", 0, 0)
			powerbarborder:SetBackdrop({
				edgeFile = bordertexture,
				edgeSize = powerbarsize,
			})
			powerbarborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			powerbarborder:SetFrameStrata("MEDIUM")
		end

		-- minimap
		if E.private["general"]["minimap"]["enable"] ~= false and E.db.ElvUI_EltreumUI.borders.minimapborder then
			local MinimapBorder
			if not _G["EltruismMiniMapBorderFrame"] then
				MinimapBorder = CreateFrame("Frame", "EltruismMiniMapBorderFrame", _G["Minimap"], BackdropTemplateMixin and "BackdropTemplate")
			else
				MinimapBorder = _G["EltruismMiniMapBorderFrame"]
			end
			local Minimapsizex, Minimapsizey = _G["Minimap"]:GetSize()
			MinimapBorder:SetSize(Minimapsizex, Minimapsizey)
			MinimapBorder:SetParent(_G["Minimap"])
			if not (self.minimaphasBorder) then
				MinimapBorder:SetPoint("TOPRIGHT", _G["Minimap"] ,"TOPRIGHT", 13, 13)
				MinimapBorder:SetPoint("BOTTOMLEFT", _G["MinimapPanel"] ,"BOTTOMLEFT", -13, -13)
				MinimapBorder:SetBackdrop({
					edgeFile = bordertexture,
					--edgeSize = E.db.ElvUI_EltreumUI.borders.baredgesize, --13
					edgeSize = 15,
				})
				MinimapBorder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				MinimapBorder:SetFrameStrata("MEDIUM")
				if E.db.datatexts.panels.MinimapPanel.backdrop == false or E.db.datatexts.panels.MinimapPanel.enable == false then
					MinimapBorder:SetPoint("BOTTOMLEFT", _G["Minimap"] ,"BOTTOMLEFT", -13, -13)
				end
				if IsAddOnLoaded("ElvUI_SLE") and E.private["sle"]["minimap"]["rectangle"] == true then --Shadow and Light Rectangle Minimap
					MinimapBorder:SetPoint("TOPRIGHT", _G["Minimap"].backdrop ,"TOPRIGHT", 12, 11)
					MinimapBorder:SetPoint("BOTTOMLEFT", _G["MinimapPanel"] ,"BOTTOMLEFT", -13, -13)
					if E.db.datatexts.panels.MinimapPanel.backdrop == false or E.db.datatexts.panels.MinimapPanel.enable == false then
						MinimapBorder:SetPoint("BOTTOMLEFT", _G["Minimap"].backdrop ,"BOTTOMLEFT", -11, -11)
					end
					local updatelocationpos = CreateFrame("Frame")
					updatelocationpos:RegisterEvent("ZONE_CHANGED")
					updatelocationpos:RegisterEvent("ZONE_CHANGED_INDOORS")
					updatelocationpos:RegisterEvent("ZONE_CHANGED_NEW_AREA")
					updatelocationpos:RegisterEvent("PLAYER_ENTERING_WORLD")
					updatelocationpos:RegisterEvent("MINIMAP_UPDATE_ZOOM")
					updatelocationpos:SetScript("OnEvent", function()
						_G.Minimap.location:ClearAllPoints()
						_G.Minimap.location:SetPoint('TOP', _G.Minimap, 'TOP', 0, -15)
					end)

				elseif IsAddOnLoaded("ElvUI_WindTools") and E.db["WT"]["maps"]["rectangleMinimap"]["enable"] == true then --Windtools rectangle minimap
					MinimapBorder:SetPoint("TOPRIGHT", _G["MinimapBackdrop"] ,"TOPRIGHT", 12, 11)
					MinimapBorder:SetPoint("BOTTOMLEFT", _G["MinimapBackdrop"] ,"BOTTOMLEFT", -12, -12)
				end
				MinimapBorder:Show()
				self.minimaphasBorder = true
			end
		end

		--chat
		if E.private.chat.enable and E.db.ElvUI_EltreumUI.borders.chatborder then
			--left chat
			local LeftChatBorder = CreateFrame("Frame", "EltruismLeftChatBorderFrame", _G["LeftChatPanel"], BackdropTemplateMixin and "BackdropTemplate")
			LeftChatBorder:SetParent(_G["LeftChatPanel"].backdrop)
			if not (self.LeftChatIsSkinned) then
				LeftChatBorder:SetSize(leftchatsizex, leftchatsizey)
				LeftChatBorder:SetPoint("CENTER", _G["LeftChatMover"] ,"CENTER")
				LeftChatBorder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = E.db.ElvUI_EltreumUI.borders.baredgesize, --13
				})
				LeftChatBorder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				LeftChatBorder:SetFrameStrata("MEDIUM")
				self.LeftChatIsSkinned = true
			end

			--right chat
			local RightChatBorder = CreateFrame("Frame", "EltruismRightChatBorderFrame", _G["RightChatPanel"], BackdropTemplateMixin and "BackdropTemplate")
			RightChatBorder:SetParent(_G["RightChatPanel"].backdrop)
			if not (self.RightChatIsSkinned) then
				RightChatBorder:SetSize(rightchatsizex, rightchatsizey)
				RightChatBorder:SetPoint("CENTER", _G["RightChatMover"] ,"CENTER")
				RightChatBorder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = E.db.ElvUI_EltreumUI.borders.baredgesize, --13
				})
				RightChatBorder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				RightChatBorder:SetFrameStrata("MEDIUM")
				self.RightChatIsSkinned = true
			end

			if E.db["chat"]["panelBackdrop"] == "RIGHT" then
				LeftChatBorder:Hide()
			elseif E.db["chat"]["panelBackdrop"] == "LEFT" then
				RightChatBorder:Hide()
			elseif E.db["chat"]["panelBackdrop"] == "HIDEBOTH" then
				LeftChatBorder:Hide()
				RightChatBorder:Hide()
			end
		end

	end
end

function ElvUI_EltreumUI:AuraBorders(button)
	if E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.auraborder and E.private.auras.enable then
		if not button then return end
		if E.db.ElvUI_EltreumUI.borders.classcolor == true then
			classcolor = E:ClassColor(E.myclass, true)
		else
			classcolor = {
				r = E.db.ElvUI_EltreumUI.bordercolors.r,
				g = E.db.ElvUI_EltreumUI.bordercolors.g,
				b = E.db.ElvUI_EltreumUI.bordercolors.b
			}
		end

		local borders = {}
		for i = 1,40 do
			table.insert(borders, _G["ElvUIPlayerBuffsAuraButton"..i])
		end
		local function createauraborders()
			for i,v in pairs(borders) do
				local test = "EltruismBorder"..tostring(borders[i])
				if not _G.test then
					local auraborder = CreateFrame("Frame", "EltruismBorder"..tostring(borders[i]), v, BackdropTemplateMixin and "BackdropTemplate")
					auraborder:SetSize(E.db.ElvUI_EltreumUI.borders.aurasizex, E.db.ElvUI_EltreumUI.borders.aurasizey)
					auraborder:SetPoint("CENTER", v, "CENTER", 0, 0)
					auraborder:SetBackdrop({
					edgeFile = E.LSM:Fetch("border", E.db.ElvUI_EltreumUI.borders.texture),
					edgeSize = 13,
					})
					auraborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				end
			end
		end
		createauraborders()
	end
end
hooksecurefunc(A, 'CreateIcon', ElvUI_EltreumUI.AuraBorders) --aura (minimap) shadows


function ElvUI_EltreumUI:BordersTargetChanged() --does not work whent target of target changes if the target is not in party/raid, no event to register :(
	if E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.classcolor == true then

		if E.db.ElvUI_EltreumUI.borders.targetborder and E.db.unitframe.units.target.enable then
			if UnitExists("target") and targetborder ~= nil then
				if UnitIsPlayer("target") then
					local _, targetclass = UnitClass("target")
					targetborder:SetBackdropBorderColor(classcolorreaction[targetclass]["r1"], classcolorreaction[targetclass]["g1"], classcolorreaction[targetclass]["b1"], 1)
				elseif not UnitIsPlayer("target") then
					local reactiontarget = UnitReaction("player", "target")
					if reactiontarget >= 5 then
						targetborder:SetBackdropBorderColor(classcolorreaction["NPCFRIENDLY"]["r1"], classcolorreaction["NPCFRIENDLY"]["g1"], classcolorreaction["NPCFRIENDLY"]["b1"], 1)
					elseif reactiontarget == 4 then
						targetborder:SetBackdropBorderColor(classcolorreaction["NPCNEUTRAL"]["r1"], classcolorreaction["NPCNEUTRAL"]["g1"], classcolorreaction["NPCNEUTRAL"]["b1"], 1)
					elseif reactiontarget == 3 then
						targetborder:SetBackdropBorderColor(classcolorreaction["NPCUNFRIENDLY"]["r1"], classcolorreaction["NPCUNFRIENDLY"]["g1"], classcolorreaction["NPCUNFRIENDLY"]["b1"], 1)
					elseif reactiontarget == 2 or reactiontarget == 1 then
						targetborder:SetBackdropBorderColor(classcolorreaction["NPCHOSTILE"]["r1"], classcolorreaction["NPCHOSTILE"]["g1"], classcolorreaction["NPCHOSTILE"]["b1"], 1)
					end
				end
			end
		end

		if E.db.ElvUI_EltreumUI.borders.targetcastborder and E.db.unitframe.units.target.castbar.enable and not (E.db.unitframe.units.target.castbar.overlayOnFrame == "Power") then
			if UnitExists("target") and targetcastbarborder ~= nil then
				if UnitIsPlayer("target") then
					local _, targetclass = UnitClass("target")
					targetcastbarborder:SetBackdropBorderColor(classcolorreaction[targetclass]["r1"], classcolorreaction[targetclass]["g1"], classcolorreaction[targetclass]["b1"], 1)
				elseif not UnitIsPlayer("target") then
					local reactiontarget = UnitReaction("player", "target")
					if reactiontarget >= 5 then
						targetcastbarborder:SetBackdropBorderColor(classcolorreaction["NPCFRIENDLY"]["r1"], classcolorreaction["NPCFRIENDLY"]["g1"], classcolorreaction["NPCFRIENDLY"]["b1"], 1)
					elseif reactiontarget == 4 then
						targetcastbarborder:SetBackdropBorderColor(classcolorreaction["NPCNEUTRAL"]["r1"], classcolorreaction["NPCNEUTRAL"]["g1"], classcolorreaction["NPCNEUTRAL"]["b1"], 1)
					elseif reactiontarget == 3 then
						targetcastbarborder:SetBackdropBorderColor(classcolorreaction["NPCUNFRIENDLY"]["r1"], classcolorreaction["NPCUNFRIENDLY"]["g1"], classcolorreaction["NPCUNFRIENDLY"]["b1"], 1)
					elseif reactiontarget == 2 or reactiontarget == 1 then
						targetcastbarborder:SetBackdropBorderColor(classcolorreaction["NPCHOSTILE"]["r1"], classcolorreaction["NPCHOSTILE"]["g1"], classcolorreaction["NPCHOSTILE"]["b1"], 1)
					end
				end
			end
		end

		if E.db.ElvUI_EltreumUI.borders.targettargetborder and E.db.unitframe.units.targettarget.enable then
			if UnitExists("targettarget") and targettargetborder ~= nil then
				if UnitIsPlayer("targettarget") then
					local _, targettargetclass = UnitClass("targettarget")
					targettargetborder:SetBackdropBorderColor(classcolorreaction[targettargetclass]["r1"], classcolorreaction[targettargetclass]["g1"], classcolorreaction[targettargetclass]["b1"], 1)
				elseif not UnitIsPlayer("targettarget") then
					local reactiontargettarget = UnitReaction("player", "targettarget")
					if reactiontargettarget >= 5 then
						targettargetborder:SetBackdropBorderColor(classcolorreaction["NPCFRIENDLY"]["r1"], classcolorreaction["NPCFRIENDLY"]["g1"], classcolorreaction["NPCFRIENDLY"]["b1"], 1)
					elseif reactiontargettarget == 4 then
						targettargetborder:SetBackdropBorderColor(classcolorreaction["NPCNEUTRAL"]["r1"], classcolorreaction["NPCNEUTRAL"]["g1"], classcolorreaction["NPCNEUTRAL"]["b1"], 1)
					elseif reactiontargettarget == 3 then
						targettargetborder:SetBackdropBorderColor(classcolorreaction["NPCUNFRIENDLY"]["r1"], classcolorreaction["NPCUNFRIENDLY"]["g1"], classcolorreaction["NPCUNFRIENDLY"]["b1"], 1)
					elseif reactiontargettarget == 2 or reactiontargettarget == 1 then
						targettargetborder:SetBackdropBorderColor(classcolorreaction["NPCHOSTILE"]["r1"], classcolorreaction["NPCHOSTILE"]["g1"], classcolorreaction["NPCHOSTILE"]["b1"], 1)
					end
				end
			end
		end

		if E.db.ElvUI_EltreumUI.borders.focusborder and E.db.unitframe.units.focus.enable and not E.Classic then
			if UnitExists("focus") and focusborder ~= nil then
				if UnitIsPlayer("focus") then
					local _, focusclass = UnitClass("focus")
					focusborder:SetBackdropBorderColor(classcolorreaction[focusclass]["r1"], classcolorreaction[focusclass]["g1"], classcolorreaction[focusclass]["b1"], 1)
				elseif not UnitIsPlayer("focus") then
					local reactionfocus = UnitReaction("player", "focus")
					if reactionfocus >= 5 then
						focusborder:SetBackdropBorderColor(classcolorreaction["NPCFRIENDLY"]["r1"], classcolorreaction["NPCFRIENDLY"]["g1"], classcolorreaction["NPCFRIENDLY"]["b1"], 1)
					elseif reactionfocus == 4 then
						focusborder:SetBackdropBorderColor(classcolorreaction["NPCNEUTRAL"]["r1"], classcolorreaction["NPCNEUTRAL"]["g1"], classcolorreaction["NPCNEUTRAL"]["b1"], 1)
					elseif reactionfocus == 3 then
						focusborder:SetBackdropBorderColor(classcolorreaction["NPCUNFRIENDLY"]["r1"], classcolorreaction["NPCUNFRIENDLY"]["g1"], classcolorreaction["NPCUNFRIENDLY"]["b1"], 1)
					elseif reactionfocus == 2 or reactionfocus == 1 then
						focusborder:SetBackdropBorderColor(classcolorreaction["NPCHOSTILE"]["r1"], classcolorreaction["NPCHOSTILE"]["g1"], classcolorreaction["NPCHOSTILE"]["b1"], 1)
					end
				end
			end
		end

		if E.db.ElvUI_EltreumUI.borders.bossborder and E.db.unitframe.units.boss.enable then
			for i = 1,8 do
				local bossbordername = _G["EltruismBossBorder"..i]
				if UnitExists("boss"..i) and bossbordername ~= nil then
					if UnitIsPlayer("boss1"..i) then
						local _, bossclass = UnitClass("boss"..i)
						bossbordername:SetBackdropBorderColor(classcolorreaction[bossclass]["r1"], classcolorreaction[bossclass]["g1"], classcolorreaction[bossclass]["b1"], 1)
					elseif not UnitIsPlayer("boss"..i) then
						if E.db.ElvUI_EltreumUI.borders.classcolor == true then
							local reactionboss = UnitReaction("player", "boss1")
							if reactionboss >= 5 then
								bossbordername:SetBackdropBorderColor(classcolorreaction["NPCFRIENDLY"]["r1"], classcolorreaction["NPCFRIENDLY"]["g1"], classcolorreaction["NPCFRIENDLY"]["b1"], 1)
							elseif reactionboss == 4 then
								bossbordername:SetBackdropBorderColor(classcolorreaction["NPCNEUTRAL"]["r1"], classcolorreaction["NPCNEUTRAL"]["g1"], classcolorreaction["NPCNEUTRAL"]["b1"], 1)
							elseif reactionboss == 3 then
								bossbordername:SetBackdropBorderColor(classcolorreaction["NPCUNFRIENDLY"]["r1"], classcolorreaction["NPCUNFRIENDLY"]["g1"], classcolorreaction["NPCUNFRIENDLY"]["b1"], 1)
							elseif reactionboss <=2 then
								bossbordername:SetBackdropBorderColor(classcolorreaction["NPCHOSTILE"]["r1"], classcolorreaction["NPCHOSTILE"]["g1"], classcolorreaction["NPCHOSTILE"]["b1"], 1)
							end
						else
							bossborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
						end
					end
				end
			end
		end

	end
end

local updatetargettarget = CreateFrame("Frame")
updatetargettarget:RegisterUnitEvent("UNIT_TARGET", "target")
--updatetargettarget:RegisterUnitEvent("UNIT_TARGET", "player")
--updatetargettarget:RegisterUnitEvent("PLAYER_TARGET_CHANGED")
--updatetargettarget:RegisterUnitEvent("UNIT_TARGET", "boss1")
updatetargettarget:RegisterUnitEvent("ENCOUNTER_START")
updatetargettarget:RegisterUnitEvent("PLAYER_FOCUS_CHANGED")
updatetargettarget:SetScript("OnEvent", function()
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif not E.private.ElvUI_EltreumUI then
		return
	end
	if E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.classcolor == true then
		ElvUI_EltreumUI:BordersTargetChanged()
	end
end)
