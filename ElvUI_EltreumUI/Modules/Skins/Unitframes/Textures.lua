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
local _, unit1class, buttonclass, classunit, unitframe, namebar, reaction,groupbar
local headergroup = nil
local headertank = nil
local headerassist = nil
local headerraidpet = nil
local forced
local group, groupbutton, tankbutton, assistbutton, raidpetbutton,partypetbutton
local IsInGroup = _G.IsInGroup
local UnitIsCharmed = _G.UnitIsCharmed
local pairs = _G.pairs
local UnitInPartyIsAI = _G.UnitInPartyIsAI

--set the textures for single units
function ElvUI_EltreumUI:ApplyUnitCustomTexture(unit,name,unittexture,noOrientation)
	_, classunit = UnitClass(unit)
	reaction = UnitReaction(unit, "player")
	if UnitExists(unit) then
		if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
			if classunit then
				namebar = ElvUI_EltreumUI:UnitframeClassTexture(classunit)
			end
		else
			if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
				namebar = ElvUI_EltreumUI:UnitframeClassTexture("TAPPED")
			else
				if reaction then
					if reaction >= 5 then
						namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCFRIENDLY")
					elseif reaction == 4 then
						namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCNEUTRAL")
					elseif reaction == 3 then
						namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCUNFRIENDLY")
					elseif reaction <= 2 then
						namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCHOSTILE")
					end
				end
			end
		end
		unitframe = _G["ElvUF_"..name]
		if unitframe and unitframe.Health and unitframe.Health:GetStatusBarTexture() ~= nil then
			if not noOrientation then
				unitframe.Health:SetOrientation(E.db.ElvUI_EltreumUI.unitframes.UForientation)
			end
			if E.db.unitframe.colors.transparentHealth and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
				if unitframe.Health and unitframe.Health.backdrop then
					if E.db.unitframe.thinBorders then
						unitframe.Health.backdrop:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					else
						unitframe.Health.backdrop.Center:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					end
					if E.db.ElvUI_EltreumUI.unitframes.lightmode then
						if unitframe.Health.bg then
							unitframe.Health.bg:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
						end
						if unitframe.Health.backdropTex then
							unitframe.Health.backdropTex:SetVertexColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
						end
					end
				end
			end
			if (UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))) and not UnitIsCharmed(unit) then
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect then
							unitframe.Health:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(classunit))
						else
							unitframe.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"][unittexture.."texture"]))
						end
					end
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unit] then
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
								unitframe.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							end
						end
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if unitframe.Health.backdropTex then
						if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect then
								unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(classunit))
							else
								unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"][unittexture.."texture"]))
							end
						end
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unit] then
							if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
								if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
									unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
								end
							end
						end
					end
				end
			else
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect then
							if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
								unitframe.Health:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("TAPPED"))
							else
								if reaction then
									if reaction >= 5 then
										unitframe.Health:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCFRIENDLY"))
									elseif reaction == 4 then
										unitframe.Health:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCNEUTRAL"))
									elseif reaction == 3 then
										unitframe.Health:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCUNFRIENDLY"))
									elseif reaction <= 2 then
										unitframe.Health:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCHOSTILE"))
									end
								end
							end
						else
							unitframe.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"][unittexture.."texture"]))
						end
					end
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unit] then
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
								unitframe.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							end
						end
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						if unitframe.Health.backdropTex then
							if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect then
								if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
									unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("TAPPED"))
								else
									if reaction then
										if reaction >= 5 then
											unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCFRIENDLY"))
										elseif reaction == 4 then
											unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCNEUTRAL"))
										elseif reaction == 3 then
											unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCUNFRIENDLY"))
										elseif reaction <= 2 then
											unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCHOSTILE"))
										end
									end
								end
							else
								unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"][unittexture.."texture"]))
							end
						end
					end
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unit] then
						if unitframe.Health.backdropTex then
							if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
								if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
									unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
								end
							end
						end
					end
				end
			end
			if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if E.db.ElvUI_EltreumUI.unitframes.uftextureversion ~= "NONE" then
						unitframe.Health:GetStatusBarTexture():SetTexture(namebar)
					end
					unitframe.Health.backdrop:SetBackdropColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha) --after 11.0.5 it seems like the backdrop gets class colored
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and unitframe.Health.backdropTex then
					unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
					unitframe.Health.backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				end
			end
		end
	end
end

--set the textures for group units
function ElvUI_EltreumUI:ApplyGroupCustomTexture(button,noOrientation,frametype)

	--due to raid pet, check if is player
	if UnitIsPlayer(button.unit) or (E.Retail and UnitInPartyIsAI(button.unit)) then
		_, buttonclass = UnitClass(button.unit)
	else
		buttonclass = "NPCFRIENDLY"
	end

	if buttonclass and button.Health then
		if not noOrientation then
			button.Health:SetOrientation(E.db.ElvUI_EltreumUI.unitframes.UForientation)
		end
		if E.db.unitframe.colors.transparentHealth and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
			if E.db.unitframe.thinBorders then
				button.Health.backdrop:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			else
				button.Health.backdrop.Center:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			end
			if E.db.ElvUI_EltreumUI.unitframes.lightmode then
				if button.Health.bg then
					button.Health.bg:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				end
				if button.Health.backdropTex then
					button.Health.backdropTex:SetVertexColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				end
			end
		end

		groupbar = ElvUI_EltreumUI:UnitframeClassTexture(buttonclass)
		if E.db.ElvUI_EltreumUI.unitframes.lightmode then
			button.Health.backdrop:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
				if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture then
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
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
						button.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
					end
				else
					if E.db.ElvUI_EltreumUI.unitframes.uftextureversion ~= "NONE" then
						button.Health:GetStatusBarTexture():SetTexture(groupbar)
					end
				end
			end
		elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
			if button.Health.backdropTex then
				if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
					if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture then
						button.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(buttonclass))
					else
						button.Health.backdropTex:SetTexture(groupbar)
					end
				else
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
							button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
						end
					else
						if E.db.ElvUI_EltreumUI.unitframes.uftextureversion ~= "NONE" then
							button.Health.backdropTex:SetTexture(groupbar)
						end
					end
				end
			end
		end
	end
end

function ElvUI_EltreumUI:CustomTexture(unit)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then

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

		if E.Retail or E.Cata then
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

		forced = false
		if unit == "testunit" then
			forced = true
			unit = "player"
		end

		if forced then
			if E.Retail or E.Cata then
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
		if (IsInGroup() or forced) and UnitExists(unit) and (E.db.ElvUI_EltreumUI.unitframes.lightmode or E.db.ElvUI_EltreumUI.unitframes.darkmode) then
			headergroup = nil
			if _G["ElvUF_Raid1"] and _G["ElvUF_Raid1"]:IsShown() then
				headergroup = _G["ElvUF_Raid1"]
			elseif _G["ElvUF_Raid2"] and _G["ElvUF_Raid2"]:IsShown() then
				headergroup = _G["ElvUF_Raid2"]
			elseif _G["ElvUF_Raid3"] and _G["ElvUF_Raid3"]:IsShown() then
				headergroup = _G["ElvUF_Raid3"]
			elseif _G["ElvUF_Party"] and _G["ElvUF_Party"]:IsShown() then
				headergroup = _G["ElvUF_Party"]
			end

			headertank = nil
			if _G["ElvUF_Tank"] and _G["ElvUF_Tank"]:IsShown() then
				headertank = _G["ElvUF_Tank"]
			end

			headerassist = nil
			if _G["ElvUF_Assist"] and _G["ElvUF_Assist"]:IsShown() then
				headerassist = _G["ElvUF_Assist"]
			end

			headerraidpet = nil
			if _G["ElvUF_RaidpetGroup1"] and _G["ElvUF_RaidpetGroup1"]:IsShown() and E.db.unitframe.units.raidpet.enable then
				headerraidpet = _G["ElvUF_RaidpetGroup1"]
			end

			_, unit1class = UnitClass(unit)
			if not unit1class then
				return
			end

			if headergroup ~= nil then
				for i = 1, headergroup:GetNumChildren() do
					group = select(i, headergroup:GetChildren())
					for j = 1, group:GetNumChildren() do
						groupbutton = select(j, group:GetChildren())
						if groupbutton and groupbutton.Health then
							if headergroup == _G["ElvUF_Party"] then
								ElvUI_EltreumUI:ApplyGroupCustomTexture(groupbutton,true,"party")
							else
								ElvUI_EltreumUI:ApplyGroupCustomTexture(groupbutton,true,"raid")
							end
						end
					end
				end
			end

			if headergroup == _G["ElvUF_Party"] and E.db.unitframe.units.party.petsGroup.enable then
				for i = 1, 5 do
					partypetbutton = _G["ElvUF_PartyGroup1UnitButton"..i.."Pet"]
					if partypetbutton and partypetbutton.Health then
						ElvUI_EltreumUI:ApplyGroupCustomTexture(partypetbutton)
					end
				end
			end

			if headertank ~= nil then
				for i = 1, headertank:GetNumChildren() do
					tankbutton = select(i, headertank:GetChildren())
					if tankbutton and tankbutton.Health then
						ElvUI_EltreumUI:ApplyGroupCustomTexture(tankbutton,true)
					end
				end
			end

			--tank targets
			if _G["ElvUF_TankUnitButton1Target"] and _G["ElvUF_TankUnitButton1Target"]:IsShown() then
				for i = 1, 8 do
					local tanktargetmembers = {_G["ElvUF_TankUnitButton"..i.."Target"]}
					for _, frame in pairs(tanktargetmembers) do
						if frame and frame.Health then
							ElvUI_EltreumUI:ApplyGroupCustomTexture(frame)
						end
					end
				end
			end

			if headerassist ~= nil then
				for i = 1, headerassist:GetNumChildren() do
					assistbutton = select(i, headerassist:GetChildren())
					if assistbutton and assistbutton.Health then
						ElvUI_EltreumUI:ApplyGroupCustomTexture(assistbutton,true)
					end
				end
			end

			if headerraidpet ~= nil then
				for i = 1, headerraidpet:GetNumChildren() do
					raidpetbutton = select(i, headerraidpet:GetChildren())
					if raidpetbutton and raidpetbutton.Health then
						ElvUI_EltreumUI:ApplyGroupCustomTexture(raidpetbutton,true)
					end
				end
			end
		end
	end
end
hooksecurefunc(UF, "PostUpdateHealthColor", ElvUI_EltreumUI.CustomTexture) --WAS causing "blinking"/"flashing" issues in 10.0
hooksecurefunc(UF, "Style", ElvUI_EltreumUI.CustomTexture) --old target of target hook

-- replace absorb texture with unitframe texture
function ElvUI_EltreumUI:SetTexture_HealComm(obj)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enableHealComm then
		obj.myBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
		obj.otherBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
		obj.absorbBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
		obj.healAbsorbBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
	end
end
hooksecurefunc(UF, "SetTexture_HealComm", ElvUI_EltreumUI.SetTexture_HealComm)

