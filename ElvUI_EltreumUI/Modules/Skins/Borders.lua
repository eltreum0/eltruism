local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local A = E:GetModule('Auras')
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local BackdropTemplateMixin = _G.BackdropTemplateMixin
local table = _G.table
local pairs = _G.pairs
local UnitExists = _G.UnitExists
local UnitReaction = _G.UnitReaction
local IsAddOnLoaded = _G.IsAddOnLoaded
local tostring = _G.tostring
local UnitIsPlayer = _G.UnitIsPlayer
local UnitClass = _G.UnitClass

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

local targetborder,targettargetborder,targetcastbarborder,petborder,playerborder,stanceborder
local bordertexture,classcolor,focusborder,bossborder,powerbarborder, playercastbarborder
local barborder1,barborder2,barborder3,barborder4,barborder5,barborder6,partyborder,totemborderaction
local MinimapBorder,LeftChatBorder,RightChatBorder,auraborder,raidborder,raidborder40,totemborderfly
local rectangleminimapdetect = CreateFrame("FRAME")
local updatelocationpos = CreateFrame("Frame")

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

		--used for testing
		--[[local testBorder = CreateFrame("Frame", "TestBorder", _G["GameMenuFrame"], BackdropTemplateMixin and "BackdropTemplate")
		local testsizex, testsizey = _G["GameMenuFrame"]:GetSize()
		testBorder:SetSize(testsizex, testsizey)
		testBorder:SetParent(_G["GameMenuFrame"])
		testBorder:SetAllPoints(_G["GameMenuFrame"])
		if not (self.testBorder) then
			testBorder:SetBackdrop({
				edgeFile = bordertexture,
				--edgeSize = E.db.ElvUI_EltreumUI.borders.baredgesize, --13
				edgeSize = 15,
			})
			testBorder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			testBorder:SetFrameStrata("TOOLTIP")
			self.testBorder = true
		end]]

		--elvui unitframes
		if E.private.unitframe.enable then

			--player
			if E.db.ElvUI_EltreumUI.borders.playerborder and E.db.unitframe.units.player.enable then
				if not _G["EltruismPlayerBorder"] then
					playerborder = CreateFrame("Frame", "EltruismPlayerBorder", _G.ElvUF_Player_HealthBar, BackdropTemplateMixin and "BackdropTemplate")
				else
					playerborder = _G["EltruismPlayerBorder"]
				end
				playerborder:SetSize(E.db.ElvUI_EltreumUI.borders.xplayer, E.db.ElvUI_EltreumUI.borders.yplayer)
				if E.db["unitframe"]["units"]["player"]["power"]["width"] == "spaced" then
					playerborder:SetPoint("CENTER", _G.ElvUF_Player_HealthBar, "CENTER", 0, 0)
				else
					playerborder:SetPoint("CENTER", _G.ElvUF_Player, "CENTER", 0, 0)
				end
				playerborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = E.db.ElvUI_EltreumUI.borders.playertargetsize,
				})
				playerborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				playerborder:SetFrameStrata("LOW")
			end

			--player castbar
			if E.db.ElvUI_EltreumUI.borders.playercastborder and E.db.unitframe.units.player.castbar.enable and not (E.db.unitframe.units.player.castbar.overlayOnFrame ~= "None")  then
				if not _G["EltruismPlayerCastBarBorder"] then
					playercastbarborder = CreateFrame("Frame", "EltruismPlayerCastBarBorder", _G.ElvUF_Player_CastBar, BackdropTemplateMixin and "BackdropTemplate")
				else
					playercastbarborder = _G["EltruismPlayerCastBarBorder"]
				end
				if E.db.unitframe.units.player.castbar.iconAttached == false then
					playercastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xplayercast + E.db.unitframe.units.player.castbar.iconSize, E.db.ElvUI_EltreumUI.borders.yplayercast)
					if E.db["unitframe"]["units"]["player"]["castbar"]["iconPosition"] == "RIGHT" then
						playercastbarborder:SetPoint("CENTER", _G["ElvUF_Player_CastBar"], "CENTER", E.db.unitframe.units.player.castbar.iconSize/2, 0)
					elseif E.db["unitframe"]["units"]["player"]["castbar"]["iconPosition"] == "LEFT" then
						playercastbarborder:SetPoint("CENTER", _G["ElvUF_Player_CastBar"], "CENTER", -E.db.unitframe.units.player.castbar.iconSize/2, 0)
					else
						playercastbarborder:SetPoint("CENTER", _G["ElvUF_Player_CastBar"], "CENTER", 0, 0)
					end
				elseif E.db.unitframe.units.player.castbar.iconAttached ~= false then
					playercastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xplayercast, E.db.ElvUI_EltreumUI.borders.yplayercast)
					--playercastbarborder:SetPoint("CENTER", _G["ElvUF_Player_CastBar"], "CENTER", -E.db.unitframe.units.player.castbar.iconSize/2, 0)
					playercastbarborder:SetPoint("CENTER", _G["ElvUF_Player_CastBar"].Holder, "CENTER", 0, 0)
				end
				playercastbarborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = E.db.ElvUI_EltreumUI.borders.playertargetcastsize,
				})
				playercastbarborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				playercastbarborder:SetFrameStrata("MEDIUM")
			end

			--target
			if E.db.ElvUI_EltreumUI.borders.targetborder and E.db.unitframe.units.target.enable then
				if not _G["EltruismTargetBorder"] then
					targetborder = CreateFrame("Frame", "EltruismTargetBorder", _G.ElvUF_Target_HealthBar, BackdropTemplateMixin and "BackdropTemplate")
				else
					targetborder = _G["EltruismTargetBorder"]
				end
				targetborder:SetSize(E.db.ElvUI_EltreumUI.borders.xtarget, E.db.ElvUI_EltreumUI.borders.ytarget)
				if E.db["unitframe"]["units"]["target"]["power"]["width"] == "spaced" then
					targetborder:SetPoint("CENTER", _G.ElvUF_Target_HealthBar, "CENTER", 0 ,0)
				else
					targetborder:SetPoint("CENTER", _G.ElvUF_Target, "CENTER", 0 ,0)
				end
				targetborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = E.db.ElvUI_EltreumUI.borders.playertargetsize,
				})
				targetborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				targetborder:SetFrameStrata("LOW")
				--targetborder:SetFrameLevel(12)
			end

			--target castbar
			if E.db.ElvUI_EltreumUI.borders.targetcastborder and E.db.unitframe.units.target.castbar.enable and not (E.db.unitframe.units.target.castbar.overlayOnFrame ~= "None") then
				if not _G["EltruismTargetCastBarBorder"] then
					targetcastbarborder = CreateFrame("Frame", "EltruismTargetCastBarBorder", _G.ElvUF_Target_CastBar, BackdropTemplateMixin and "BackdropTemplate")
				else
					targetcastbarborder = _G["EltruismTargetCastBarBorder"]
				end
				if E.db.unitframe.units.target.castbar.iconAttached == false then
					targetcastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xcasttarget + E.db.unitframe.units.target.castbar.iconSize, E.db.ElvUI_EltreumUI.borders.ycasttarget)
					if E.db["unitframe"]["units"]["target"]["castbar"]["iconPosition"] == "RIGHT" then
						targetcastbarborder:SetPoint("CENTER", _G["ElvUF_Target_CastBar"], "CENTER", E.db.unitframe.units.target.castbar.iconSize/2, 0)
					elseif E.db["unitframe"]["units"]["target"]["castbar"]["iconPosition"] == "LEFT" then
						targetcastbarborder:SetPoint("CENTER", _G["ElvUF_Target_CastBar"], "CENTER", -E.db.unitframe.units.target.castbar.iconSize/2, 0)
					else
						targetcastbarborder:SetPoint("CENTER", _G["ElvUF_Target_CastBar"], "CENTER", 0, 0)
					end
				elseif E.db.unitframe.units.target.castbar.iconAttached ~= false then
					targetcastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xcasttarget, E.db.ElvUI_EltreumUI.borders.ycasttarget)
					--targetcastbarborder:SetPoint("CENTER", _G["ElvUF_Target_CastBar"], "CENTER", -E.db.unitframe.units.target.castbar.iconSize/2, 0)
					targetcastbarborder:SetPoint("CENTER", _G["ElvUF_Target_CastBar"].Holder, "CENTER", 0, 0)
				end
				targetcastbarborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = E.db.ElvUI_EltreumUI.borders.playertargetcastsize,
				})
				targetcastbarborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				targetcastbarborder:SetFrameStrata("MEDIUM")
			end

			--target of target
			if E.db.ElvUI_EltreumUI.borders.targettargetborder and E.db.unitframe.units.targettarget.enable then
				if not _G["EltruismTargetTargetBorder"] then
					targettargetborder = CreateFrame("Frame", "EltruismTargetTargetBorder", _G.ElvUF_TargetTarget_HealthBar, BackdropTemplateMixin and "BackdropTemplate")
				else
					targettargetborder = _G["EltruismTargetTargetBorder"]
				end
				targettargetborder:SetSize(E.db.ElvUI_EltreumUI.borders.xtargettarget, E.db.ElvUI_EltreumUI.borders.ytargettarget)
				if E.db["unitframe"]["units"]["targettarget"]["power"]["width"] == "spaced" then
					targettargetborder:SetPoint("CENTER", _G.ElvUF_TargetTarget_HealthBar, "CENTER", 0 ,0)
				else
					targettargetborder:SetPoint("CENTER", _G.ElvUF_TargetTarget, "CENTER", 0 ,0)
				end
				targettargetborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = E.db.ElvUI_EltreumUI.borders.playertargetsize,
				})
				targettargetborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				targettargetborder:SetFrameStrata("LOW")
			end

			--pet
			if E.db.ElvUI_EltreumUI.borders.petborder and E.db.unitframe.units.pet.enable then
				if not _G["EltruismPetBorder"] then
					petborder = CreateFrame("Frame", "EltruismPetBorder", _G.ElvUF_Pet_HealthBar, BackdropTemplateMixin and "BackdropTemplate")
				else
					petborder = _G["EltruismPetBorder"]
				end
				petborder:SetSize(E.db.ElvUI_EltreumUI.borders.petsizex, E.db.ElvUI_EltreumUI.borders.petsizey)
				if E.db["unitframe"]["units"]["pet"]["power"]["width"] == "spaced" then
					petborder:SetPoint("CENTER", _G.ElvUF_Pet_HealthBar,"CENTER", 0, 0)
				else
					petborder:SetPoint("CENTER", _G.ElvUF_Pet,"CENTER", 0, 0)
				end
				petborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = E.db.ElvUI_EltreumUI.borders.petsize,
				})
				petborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				petborder:SetFrameStrata("LOW")
			end

			--party
			if E.db.ElvUI_EltreumUI.borders.partyborders and E.db.unitframe.units.party.enable then
				local bordersparty = {}
				for i = 1,5 do
					table.insert(bordersparty, _G["ElvUF_PartyGroup1UnitButton"..i])
				end
				local function createpartyborders()
					for i,v in pairs(bordersparty) do
						if not _G["EltruismPartyBorder"..i] then
							partyborder = CreateFrame("Frame", "EltruismPartyBorder"..i, v, BackdropTemplateMixin and "BackdropTemplate")
						else
							partyborder = _G["EltruismPartyBorder"..i]
						end
						partyborder:SetSize(E.db.ElvUI_EltreumUI.borders.partysizex, E.db.ElvUI_EltreumUI.borders.partysizey)
						partyborder:SetPoint("CENTER", v, "CENTER")
						partyborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = E.db.ElvUI_EltreumUI.borders.groupsize,
						})
						if E.db.ElvUI_EltreumUI.borders.classcolor == true then
							partyborder:SetBackdropBorderColor(1, 1, 1, 1)
						else
							partyborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
						end
						partyborder:SetFrameStrata("MEDIUM")
					end
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
					for i,v in pairs(bordersraid) do
						if not _G["EltruismRaid"..i.."Border"..i] then
							raidborder = CreateFrame("Frame", "EltruismRaid"..i.."Border"..i, v, BackdropTemplateMixin and "BackdropTemplate")
							--raidborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						else
							raidborder = _G["EltruismRaid"..i.."Border"..i]
						end
						raidborder:SetSize(E.db.ElvUI_EltreumUI.borders.raidsizex, E.db.ElvUI_EltreumUI.borders.raidsizey)
						raidborder:SetPoint("CENTER", v, "CENTER")
						raidborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = E.db.ElvUI_EltreumUI.borders.groupsize,
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
					for i,v in pairs(bordersraid40) do
						--local raidborder40 = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						if not _G["Eltruism40Raid"..i.."Border"..i] then
							raidborder40 = CreateFrame("Frame", "Eltruism40Raid"..i.."Border"..i, v, BackdropTemplateMixin and "BackdropTemplate")
							--raidborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						else
							raidborder40 = _G["Eltruism40Raid"..i.."Border"..i]
						end
						raidborder40:SetSize(E.db.ElvUI_EltreumUI.borders.raid40sizex, E.db.ElvUI_EltreumUI.borders.raid40sizey)
						raidborder40:SetPoint("CENTER", v, "CENTER")
						raidborder40:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = E.db.ElvUI_EltreumUI.borders.groupsize,
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
				if E.db["unitframe"]["units"]["focus"]["power"]["width"] == "spaced" then
					focusborder:SetPoint("CENTER", _G.ElvUF_Focus_HealthBar, "CENTER", 0, 0)
				else
					focusborder:SetPoint("CENTER", _G.ElvUF_Focus, "CENTER", 0, 0)
				end
				focusborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = E.db.ElvUI_EltreumUI.borders.focussize,
				})
				focusborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				focusborder:SetFrameStrata("LOW")
			end

			--boss
			if E.db.ElvUI_EltreumUI.borders.bossborder and E.db.unitframe.units.boss.enable and (not E.Classic and not E.TBC and not E.Wrath) then
				local bordersboss = {}
				for i = 1,8 do
					local bossmembers = {_G["ElvUF_Boss"..i]}
					for _, v in pairs(bossmembers) do
						if not _G["EltruismBossBorder"..i] then
							bossborder = CreateFrame("Frame", "EltruismBossBorder"..i, v, BackdropTemplateMixin and "BackdropTemplate")
						else
							bossborder = _G["EltruismBossBorder"..i]
						end
						bossborder = CreateFrame("Frame", "EltruismBossBorder"..i, v, BackdropTemplateMixin and "BackdropTemplate")
						bossborder:SetSize(E.db.ElvUI_EltreumUI.borders.xboss, E.db.ElvUI_EltreumUI.borders.yboss)
						bossborder:SetPoint("CENTER", v, "CENTER")
						bossborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = E.db.ElvUI_EltreumUI.borders.bosssize,
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
		if E.private.actionbar.enable and not IsAddOnLoaded("ElvUI_ActionBarMasks") then
			--action bar 1
			if E.db.ElvUI_EltreumUI.borders.bar1borders and E.db.actionbar.bar1.enabled then
				local borders1 = {}
				for i = 1,12 do
					table.insert(borders1, _G["ElvUI_Bar1Button"..i])
				end
				local function createbar1borders()
					for i,v in pairs(borders1) do
						if not _G["EltruismAB1Border"..i] then
							barborder1 = CreateFrame("Frame", "EltruismAB1Border"..i, v, BackdropTemplateMixin and "BackdropTemplate")
						else
							barborder1 = _G["EltruismAB1Border"..i]
						end
						barborder1:SetSize(E.db.ElvUI_EltreumUI.borders.bar1xborder, E.db.ElvUI_EltreumUI.borders.bar1yborder)
						barborder1:SetPoint("CENTER", v, "CENTER")
						barborder1:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = E.db.ElvUI_EltreumUI.borders.baredgesize,
						})
						barborder1:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
						--barborder1:SetFrameLevel(1)
					end
				end
				createbar1borders()
			end

			--bar2
			if E.db.ElvUI_EltreumUI.borders.bar2borders and E.db.actionbar.bar2.enabled then
				local borders2 = {}
				for i = 1,12 do
					table.insert(borders2, _G["ElvUI_Bar2Button"..i])
				end
				local function createbar2borders()
					for i,v in pairs(borders2) do
						if not _G["EltruismAB2Border"..i] then
							barborder2 = CreateFrame("Frame", "EltruismAB2Border"..i, v, BackdropTemplateMixin and "BackdropTemplate")
						else
							barborder2 = _G["EltruismAB2Border"..i]
						end
						barborder2:SetSize(E.db.ElvUI_EltreumUI.borders.bar2xborder, E.db.ElvUI_EltreumUI.borders.bar2yborder)
						barborder2:SetPoint("CENTER", v, "CENTER")
						barborder2:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = E.db.ElvUI_EltreumUI.borders.baredgesize,
						})
						barborder2:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
						--barborder2:SetFrameLevel(1)
					end
				end
				createbar2borders()
			end

			--bar3
			if E.db.ElvUI_EltreumUI.borders.bar3borders and E.db.actionbar.bar3.enabled then
				local borders3 = {}
				for i = 1,12 do
					table.insert(borders3, _G["ElvUI_Bar3Button"..i])
				end
				local function createbar3borders()
					for i,v in pairs(borders3) do
						if not _G["EltruismAB3Border"..i] then
							barborder3 = CreateFrame("Frame", "EltruismAB3Border"..i, v, BackdropTemplateMixin and "BackdropTemplate")
						else
							barborder3 = _G["EltruismAB3Border"..i]
						end
						barborder3:SetSize(E.db.ElvUI_EltreumUI.borders.bar3xborder, E.db.ElvUI_EltreumUI.borders.bar3yborder)
						barborder3:SetPoint("CENTER", v, "CENTER")
						barborder3:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = E.db.ElvUI_EltreumUI.borders.baredgesize,
						})
						barborder3:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
						--barborder3:SetFrameLevel(1)
					end
				end
				createbar3borders()
			end

			--bar4
			if E.db.ElvUI_EltreumUI.borders.bar4borders and E.db.actionbar.bar4.enabled then
				local borders4 = {}
				for i = 1,12 do
					table.insert(borders4, _G["ElvUI_Bar4Button"..i])
				end
				local function createbar4borders()
					for i,v in pairs(borders4) do
						if not _G["EltruismAB4Border"..i] then
							barborder4 = CreateFrame("Frame", "EltruismAB4Border"..i, v, BackdropTemplateMixin and "BackdropTemplate")
						else
							barborder4 = _G["EltruismAB4Border"..i]
						end
						barborder4:SetSize(E.db.ElvUI_EltreumUI.borders.bar4xborder, E.db.ElvUI_EltreumUI.borders.bar4yborder)
						barborder4:SetPoint("CENTER", v, "CENTER")
						barborder4:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = E.db.ElvUI_EltreumUI.borders.baredgesize,
						})
						barborder4:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
						--barborder4:SetFrameLevel(1)
					end
				end
				createbar4borders()
			end

			--bar5
			if E.db.ElvUI_EltreumUI.borders.bar5borders and E.db.actionbar.bar5.enabled then
				local borders5 = {}
				for i = 1,12 do
					table.insert(borders5, _G["ElvUI_Bar5Button"..i])
				end
				local function createbar5borders()
					for i,v in pairs(borders5) do
						if not _G["EltruismAB5Border"..i] then
							barborder5 = CreateFrame("Frame", "EltruismAB5Border"..i, v, BackdropTemplateMixin and "BackdropTemplate")
						else
							barborder5 = _G["EltruismAB5Border"..i]
						end
						barborder5:SetSize(E.db.ElvUI_EltreumUI.borders.bar5xborder, E.db.ElvUI_EltreumUI.borders.bar5yborder)
						barborder5:SetPoint("CENTER", v, "CENTER")
						barborder5:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = E.db.ElvUI_EltreumUI.borders.baredgesize,
						})
						barborder5:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
						--barborder5:SetFrameLevel(1)
					end
				end
				createbar5borders()
			end

			--bar6
			if E.db.ElvUI_EltreumUI.borders.bar6borders and E.db.actionbar.bar6.enabled then
				local borders6 = {}
				for i = 1,12 do
					table.insert(borders6, _G["ElvUI_Bar6Button"..i])
				end
				local function createbar6borders()
					for i,v in pairs(borders6) do
						if not _G["EltruismAB6Border"..i] then
							barborder6 = CreateFrame("Frame", "EltruismAB6Border"..i, v, BackdropTemplateMixin and "BackdropTemplate")
						else
							barborder6 = _G["EltruismAB6Border"..i]
						end
						barborder6:SetSize(E.db.ElvUI_EltreumUI.borders.bar6xborder, E.db.ElvUI_EltreumUI.borders.bar6yborder)
						barborder6:SetPoint("CENTER", v, "CENTER")
						barborder6:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = E.db.ElvUI_EltreumUI.borders.baredgesize,
						})
						barborder6:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
						--barborder6:SetFrameLevel(1)
					end
				end
				createbar6borders()
			end

			--stances
			if E.db.ElvUI_EltreumUI.borders.stanceborders and E.db.actionbar.stanceBar.enabled then
				local stanceborders = {}
				for i = 1,12 do
					table.insert(stanceborders, _G["ElvUI_StanceBarButton"..i])
				end
				local function createstanceborders()
					for i,v in pairs(stanceborders) do
						if not _G["EltruismStanceBorder"..i] then
							stanceborder = CreateFrame("Frame", "EltruismStanceBorder"..i, v, BackdropTemplateMixin and "BackdropTemplate")
						else
							stanceborder = _G["EltruismStanceBorder"..i]
						end
						stanceborder:SetSize(E.db.ElvUI_EltreumUI.borders.stancexborder, E.db.ElvUI_EltreumUI.borders.stanceyborder)
						stanceborder:SetPoint("CENTER", v, "CENTER")
						stanceborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = E.db.ElvUI_EltreumUI.borders.stanceedgesize,
						})
						stanceborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
						--stanceborder:SetFrameLevel(1)
					end
				end
				createstanceborders()
			end


		end

		--wotlk shaman totem bar
		if E.Wrath and E.myclass == 'SHAMAN' and E.db.ElvUI_EltreumUI.borders.totembar and not E.private["general"]["totemBar"] == false then
			local borderstotemaction = {}
			local borderstotemfly = {}
			for i = 1,4 do
				table.insert(borderstotemaction, _G["MultiCastActionButton"..i])
			end
			table.insert(borderstotemaction, _G["MultiCastSummonSpellButton"])
			table.insert(borderstotemaction, _G["MultiCastRecallSpellButton"])

			--flyout is not nice to interact with
			--[[for i = 1,7 do
				table.insert(borderstotemfly, _G["MultiCastFlyoutButton"..i])
			end]]
			local function createtotemborders()
				for i,v in pairs(borderstotemaction) do
					if not _G["EltruismTotemBorderAction"..i] then
						totemborderaction = CreateFrame("Frame", "EltruismTotemBorderAction"..i, v, BackdropTemplateMixin and "BackdropTemplate")
					else
						totemborderaction = _G["EltruismTotemBorderAction"..i]
					end
					totemborderaction:SetSize(E.db.ElvUI_EltreumUI.borders.totemxborder, E.db.ElvUI_EltreumUI.borders.totemyborder)
					totemborderaction:SetPoint("CENTER", v, "CENTER")
					totemborderaction:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = E.db.ElvUI_EltreumUI.borders.totemedgesize,
					})
					totemborderaction:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					--totemborderaction:SetFrameLevel(1)
				end
				--[[for i,v in pairs(borderstotemfly) do
					if not _G["EltruismTotemBorderFly"..i] then
						totemborderfly = CreateFrame("Frame", "EltruismTotemBorderFly"..i, v, BackdropTemplateMixin and "BackdropTemplate")
					else
						totemborderfly = _G["EltruismTotemBorderFly"..i]
					end
					totemborderfly:SetSize(E.db.ElvUI_EltreumUI.borders.totemxborder, E.db.ElvUI_EltreumUI.borders.totemyborder)
					totemborderfly:SetPoint("CENTER", v, "CENTER")
					totemborderfly:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = E.db.ElvUI_EltreumUI.borders.totemedgesize,
					})
					totemborderfly:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					--totemborderfly:SetFrameLevel(1)
				end]]
			end
			createtotemborders()
		end

		--nameplate power bar
		if E.db.ElvUI_EltreumUI.borders.powerbarborder then
			if not _G["EltruismPowerBarBorder"] then
				powerbarborder = CreateFrame("Frame", "EltruismPowerBarBorder", _G.EltruismPowerBar, BackdropTemplateMixin and "BackdropTemplate")
			else
				powerbarborder = _G["EltruismPowerBarBorder"]
			end
			powerbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xpowerbar, E.db.ElvUI_EltreumUI.borders.ypowerbar)
			powerbarborder:SetPoint("CENTER", _G.EltruismPowerBar, "CENTER", 0, 0)
			powerbarborder:SetBackdrop({
				edgeFile = bordertexture,
				edgeSize = E.db.ElvUI_EltreumUI.borders.powerbarsize,
			})
			powerbarborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			powerbarborder:SetFrameStrata("MEDIUM")
		end

		-- minimap
		if E.private["general"]["minimap"]["enable"] ~= false and E.db.ElvUI_EltreumUI.borders.minimapborder then
			if not _G["EltruismMiniMapBorderFrame"] then
				MinimapBorder = CreateFrame("Frame", "EltruismMiniMapBorderFrame", _G["Minimap"], BackdropTemplateMixin and "BackdropTemplate")
			else
				MinimapBorder = _G["EltruismMiniMapBorderFrame"]
			end
			MinimapBorder:SetSize(E.db.ElvUI_EltreumUI.borders.minimapsizex, E.db.ElvUI_EltreumUI.borders.minimapsizey)
			MinimapBorder:SetParent(_G["Minimap"])
			MinimapBorder:SetBackdrop({
				edgeFile = bordertexture,
				--edgeSize = E.db.ElvUI_EltreumUI.borders.baredgesize, --13
				edgeSize = E.db.ElvUI_EltreumUI.borders.minimapsize,
			})
			MinimapBorder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			MinimapBorder:SetFrameStrata("MEDIUM")

			if E.db.datatexts.panels.MinimapPanel.backdrop == false or E.db.datatexts.panels.MinimapPanel.enable == false then
				MinimapBorder:SetPoint("CENTER", _G["MinimapBackdrop"] ,"CENTER", 0, 0)
			else
				MinimapBorder:SetPoint("CENTER", _G["MMHolder"] ,"CENTER", 0, 0)
			end

			if IsAddOnLoaded("ElvUI_SLE") and E.private["sle"]["minimap"]["rectangle"] == true then --Shadow and Light Rectangle Minimap
				rectangleminimapdetect:SetPoint("TOPRIGHT", _G["Minimap"].backdrop ,"TOPRIGHT", 0, 0)
				rectangleminimapdetect:SetPoint("BOTTOMLEFT", _G["MinimapPanel"] ,"BOTTOMLEFT", 0, 0)

				MinimapBorder:SetPoint("CENTER", rectangleminimapdetect ,"CENTER", 0, 0)
				if E.db.datatexts.panels.MinimapPanel.backdrop == false or E.db.datatexts.panels.MinimapPanel.enable == false then
					MinimapBorder:SetPoint("CENTER", _G["Minimap"].backdrop.Center ,"CENTER", 0, 0)
				end
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
				MinimapBorder:SetPoint("CENTER", _G["MinimapBackdrop"] ,"CENTER", 0, 0)

				updatelocationpos:RegisterEvent("ZONE_CHANGED")
				updatelocationpos:RegisterEvent("ZONE_CHANGED_INDOORS")
				updatelocationpos:RegisterEvent("ZONE_CHANGED_NEW_AREA")
				updatelocationpos:RegisterEvent("PLAYER_ENTERING_WORLD")
				updatelocationpos:RegisterEvent("MINIMAP_UPDATE_ZOOM")
				updatelocationpos:SetScript("OnEvent", function()
					_G.Minimap.location:ClearAllPoints()
					_G.Minimap.location:SetPoint('TOP', _G.Minimap, 'TOP', 0, -15)
				end)
			end
		end

		--chat
		if E.private.chat.enable and E.db.ElvUI_EltreumUI.borders.chatborder then
			--left chat
			if not _G["EltruismLeftChatBorderFrame"] then
				LeftChatBorder = CreateFrame("Frame", "EltruismLeftChatBorderFrame", _G["LeftChatPanel"], BackdropTemplateMixin and "BackdropTemplate")
			else
				LeftChatBorder = _G["EltruismLeftChatBorderFrame"]
			end
			LeftChatBorder:SetParent(_G["LeftChatPanel"].backdrop)
			LeftChatBorder:SetSize(E.db.ElvUI_EltreumUI.borders.leftchatborderx, E.db.ElvUI_EltreumUI.borders.leftchatbordery)
			LeftChatBorder:SetPoint("CENTER", _G["LeftChatMover"] ,"CENTER")
			LeftChatBorder:SetBackdrop({
				edgeFile = bordertexture,
				edgeSize = E.db.ElvUI_EltreumUI.borders.chatsize, --13
			})
			LeftChatBorder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			LeftChatBorder:SetFrameStrata("MEDIUM")

			--right chat
			if not _G["EltruismRightChatBorderFrame"] then
				RightChatBorder = CreateFrame("Frame", "EltruismRightChatBorderFrame", _G["RightChatPanel"], BackdropTemplateMixin and "BackdropTemplate")
			else
				RightChatBorder = _G["EltruismRightChatBorderFrame"]
			end
			RightChatBorder:SetParent(_G["RightChatPanel"].backdrop)
			RightChatBorder:SetSize(E.db.ElvUI_EltreumUI.borders.rightchatborderx, E.db.ElvUI_EltreumUI.borders.rightchatbordery)
			RightChatBorder:SetPoint("CENTER", _G["RightChatMover"] ,"CENTER")
			RightChatBorder:SetBackdrop({
				edgeFile = bordertexture,
				edgeSize = E.db.ElvUI_EltreumUI.borders.chatsize, --13
			})
			RightChatBorder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			RightChatBorder:SetFrameStrata("MEDIUM")

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

function ElvUI_EltreumUI:AuraBorders()
	if E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.auraborder and E.private.auras.enable then
		--if not button then return end
		if E.db.ElvUI_EltreumUI.borders.classcolor == true or E.db.ElvUI_EltreumUI.borders.classcolor == nil then
			classcolor = E:ClassColor(E.myclass, true)
		elseif E.db.ElvUI_EltreumUI.borders.classcolor == false then
			classcolor = {
				r = E.db.ElvUI_EltreumUI.bordercolors.r,
				g = E.db.ElvUI_EltreumUI.bordercolors.g,
				b = E.db.ElvUI_EltreumUI.bordercolors.b
			}
		end

		local auraborders = {}
		for i = 1,40 do
			table.insert(auraborders, _G["ElvUIPlayerBuffsAuraButton"..i])
		end
		local function createauraborders()
			for i,v in pairs(auraborders) do
				if not _G["EltruismAuraBorder"..tostring(i)] then
					auraborder = CreateFrame("Frame", "EltruismAuraBorder"..tostring(i), v, BackdropTemplateMixin and "BackdropTemplate")
				else
					auraborder = _G["EltruismAuraBorder"..tostring(i)]
				end
				auraborder:SetSize(E.db.ElvUI_EltreumUI.borders.aurasizex, E.db.ElvUI_EltreumUI.borders.aurasizey)
				auraborder:SetPoint("CENTER", v, "CENTER", 0, 0)
				auraborder:SetBackdrop({
				edgeFile = E.LSM:Fetch("border", E.db.ElvUI_EltreumUI.borders.texture),
				edgeSize = E.db.ElvUI_EltreumUI.borders.aurasize,
				})
				auraborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				auraborder:SetFrameStrata("MEDIUM")
				auraborder:SetFrameLevel(4)
			end
		end
		createauraborders()
	end
end
hooksecurefunc(A, 'CreateIcon', ElvUI_EltreumUI.AuraBorders) --aura (minimap) shadows

function ElvUI_EltreumUI:BordersTargetChanged() --does not work whent target of target changes if the target is not in party/raid, no event to register :(
	if E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.classcolor == true then

		if E.db.unitframe.units.target.enable then
			if UnitExists("target") then
				if UnitIsPlayer("target") then
					local _, targetclass = UnitClass("target")
					if E.db.ElvUI_EltreumUI.borders.targetborder and E.db.unitframe.units.target.enable and targetborder ~= nil then
						targetborder:SetBackdropBorderColor(classcolorreaction[targetclass]["r1"], classcolorreaction[targetclass]["g1"], classcolorreaction[targetclass]["b1"], 1)
					end
					if E.db.ElvUI_EltreumUI.borders.targetcastborder and E.db.unitframe.units.target.castbar.enable and not (E.db.unitframe.units.target.castbar.overlayOnFrame ~= "None") and targetcastbarborder ~= nil then
						targetcastbarborder:SetBackdropBorderColor(classcolorreaction[targetclass]["r1"], classcolorreaction[targetclass]["g1"], classcolorreaction[targetclass]["b1"], 1)
					end
				elseif not UnitIsPlayer("target") then
					local reactiontarget = UnitReaction("player", "target")
					if reactiontarget >= 5 then
						if E.db.ElvUI_EltreumUI.borders.targetborder and E.db.unitframe.units.target.enable and targetborder ~= nil then
							targetborder:SetBackdropBorderColor(classcolorreaction["NPCFRIENDLY"]["r1"], classcolorreaction["NPCFRIENDLY"]["g1"], classcolorreaction["NPCFRIENDLY"]["b1"], 1)
						end
						if E.db.ElvUI_EltreumUI.borders.targetcastborder and E.db.unitframe.units.target.castbar.enable and not (E.db.unitframe.units.target.castbar.overlayOnFrame ~= "None") and targetcastbarborder ~= nil then
							targetcastbarborder:SetBackdropBorderColor(classcolorreaction["NPCFRIENDLY"]["r1"], classcolorreaction["NPCFRIENDLY"]["g1"], classcolorreaction["NPCFRIENDLY"]["b1"], 1)
						end
					elseif reactiontarget == 4 then
						if E.db.ElvUI_EltreumUI.borders.targetborder and E.db.unitframe.units.target.enable and targetborder ~= nil then
							targetborder:SetBackdropBorderColor(classcolorreaction["NPCNEUTRAL"]["r1"], classcolorreaction["NPCNEUTRAL"]["g1"], classcolorreaction["NPCNEUTRAL"]["b1"], 1)
						end
						if E.db.ElvUI_EltreumUI.borders.targetcastborder and E.db.unitframe.units.target.castbar.enable and not (E.db.unitframe.units.target.castbar.overlayOnFrame ~= "None") and targetcastbarborder ~= nil then
							targetcastbarborder:SetBackdropBorderColor(classcolorreaction["NPCNEUTRAL"]["r1"], classcolorreaction["NPCNEUTRAL"]["g1"], classcolorreaction["NPCNEUTRAL"]["b1"], 1)
						end
					elseif reactiontarget == 3 then
						if E.db.ElvUI_EltreumUI.borders.targetborder and E.db.unitframe.units.target.enable and targetborder ~= nil then
							targetborder:SetBackdropBorderColor(classcolorreaction["NPCUNFRIENDLY"]["r1"], classcolorreaction["NPCUNFRIENDLY"]["g1"], classcolorreaction["NPCUNFRIENDLY"]["b1"], 1)
						end
						if E.db.ElvUI_EltreumUI.borders.targetcastborder and E.db.unitframe.units.target.castbar.enable and not (E.db.unitframe.units.target.castbar.overlayOnFrame ~= "None") and targetcastbarborder ~= nil then
							targetcastbarborder:SetBackdropBorderColor(classcolorreaction["NPCUNFRIENDLY"]["r1"], classcolorreaction["NPCUNFRIENDLY"]["g1"], classcolorreaction["NPCUNFRIENDLY"]["b1"], 1)
						end
					elseif reactiontarget == 2 or reactiontarget == 1 then
						if E.db.ElvUI_EltreumUI.borders.targetborder and E.db.unitframe.units.target.enable and targetborder ~= nil then
							targetborder:SetBackdropBorderColor(classcolorreaction["NPCHOSTILE"]["r1"], classcolorreaction["NPCHOSTILE"]["g1"], classcolorreaction["NPCHOSTILE"]["b1"], 1)
						end
						if E.db.ElvUI_EltreumUI.borders.targetcastborder and E.db.unitframe.units.target.castbar.enable and not (E.db.unitframe.units.target.castbar.overlayOnFrame ~= "None") and targetcastbarborder ~= nil then
							targetcastbarborder:SetBackdropBorderColor(classcolorreaction["NPCHOSTILE"]["r1"], classcolorreaction["NPCHOSTILE"]["g1"], classcolorreaction["NPCHOSTILE"]["b1"], 1)
						end
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

		if E.db.ElvUI_EltreumUI.borders.bossborder and E.db.unitframe.units.boss.enable and not (E.Classic or E.TBC or E.Wrath) then
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

--Function to toggle borders during install
function ElvUI_EltreumUI:ShowHideBorders()
	local borderlist = {
		playerborder,
		targetborder,
		targettargetborder,
		targetcastbarborder,
		petborder,
		focusborder,
		bossborder,
		powerbarborder,
		MinimapBorder,
		LeftChatBorder,
		RightChatBorder,
		playercastbarborder,
		partyborder,
		raidborder,
		raidborder40,
	}
	local barborderbutton
	local barborderbuttonnumber
	if E.db.ElvUI_EltreumUI.borders.borders == false then
		E.db.ElvUI_EltreumUI.borders.borders = true
		ElvUI_EltreumUI:ActionbarBorderAdjust()
		ElvUI_EltreumUI:Borders()
		for _, frame in pairs(borderlist) do
			if frame ~= nil then
				frame:Show()
			end
		end
		for k = 1,6 do
			barborderbutton  = "EltruismAB"..k.."Border"
			for b = 1,12 do
				barborderbuttonnumber = tostring(barborderbutton)..tostring(b)
				if _G[barborderbuttonnumber] ~= nil then
					_G[barborderbuttonnumber]:Show()
				end
			end
		end
		for aura = 1,40 do
			if _G["EltruismAuraBorder"..aura] then
				_G["EltruismAuraBorder"..aura]:Show()
			end
		end
	elseif E.db.ElvUI_EltreumUI.borders.borders == true then
		E.db.ElvUI_EltreumUI.borders.borders = false
		ElvUI_EltreumUI:ActionbarBorderAdjust()
		ElvUI_EltreumUI:Shadows()
		for _, frame in pairs(borderlist) do
			if frame ~= nil then
				frame:Hide()
			end
		end
		for k = 1,6 do
			barborderbutton  = "EltruismAB"..k.."Border"
			for b = 1,12 do
				barborderbuttonnumber = tostring(barborderbutton)..tostring(b)
				if _G[barborderbuttonnumber] ~= nil then
					_G[barborderbuttonnumber]:Hide()
				end
			end
		end
		for aura = 1,40 do
			if _G["EltruismAuraBorder"..aura] then
				_G["EltruismAuraBorder"..aura]:Hide()
			end
		end
	end
end
