local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local tostring = _G.tostring
local UnitIsPlayer = _G.UnitIsPlayer
local IsInGroup = _G.IsInGroup
local IsInRaid = _G.IsInRaid
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local UnitClassification = _G.UnitClassification
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local SetPortraitTexture = _G.SetPortraitTexture

local notexcoord = {
	["RELEAF"] = true,
	["BLIZZARD"] = false,
	["BORDER"] = false,
	["ORIGINAL"] = true,
}

--create and update the portraits
local modelcheck = CreateFrame("PlayerModel", "EltruismPortraitFixModel")
local function CreatePorfraitFrameAndTexture(frame,name,invert,update,db,f)
	if not frame then return end
	if not frame.USE_PORTRAIT then return end
	if not frame.unit then return end

	if db == "party" and E.db.ElvUI_EltreumUI.unitframes.portrait[db].position.align == "RIGHT" then
		invert = true
	end

	local model = modelcheck:GetModelFileID()
	if not model then
		modelcheck:SetUnit(frame.unit)
		model = modelcheck:GetModelFileID()
		modelcheck:ClearModel()
		frame.EltruismModelID = model
	end

	local isPlayerCustom
	if E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
		if UnitIsPlayer(frame.unit) then
			isPlayerCustom = true
		else
			isPlayerCustom = false
		end
	end

	if not frame.EltruismPortrait then
		if frame.Portrait then
			frame.Portrait:Hide()
			frame.Portrait:Kill()
			--frame.Portrait:ClearAllPoints()
		end
		frame.EltruismPortrait = CreateFrame("FRAME", name.."EltruismPortrait", frame)
		frame.EltruismPortrait:SetPoint("CENTER", frame, tostring(E.db.ElvUI_EltreumUI.unitframes.portrait[db].position.align), E.db.ElvUI_EltreumUI.unitframes.portrait[db].position.x, E.db.ElvUI_EltreumUI.unitframes.portrait[db].position.y)
		frame.EltruismPortrait:SetSize(E.db.ElvUI_EltreumUI.unitframes.portrait[db].size,E.db.ElvUI_EltreumUI.unitframes.portrait[db].size)
		frame.EltruismPortrait:SetFrameLevel(frame:GetFrameLevel()+18)
		frame.EltruismPortrait:SetFrameStrata(frame:GetFrameStrata())
		frame.EltruismPortrait.border = frame.EltruismPortrait:CreateTexture(name.."EltruismPortraitTexture", "OVERLAY", nil, 5)
		frame.EltruismPortrait.border:SetParent(frame.EltruismPortrait)
		frame.EltruismPortrait.border:SetAllPoints(frame.EltruismPortrait)

		frame.EltruismPortrait.Mask = frame.EltruismPortrait:CreateMaskTexture()
		frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\mask.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
		frame.EltruismPortrait.Mask:SetAllPoints(frame.EltruismPortrait)

		frame.EltruismPortrait.portrait = frame.EltruismPortrait:CreateTexture(name.."EltruismPortraitPortrait", "OVERLAY", nil, 4)
		frame.EltruismPortrait.portrait:SetAllPoints(frame.EltruismPortrait)

		frame.EltruismPortrait.edge = frame.EltruismPortrait:CreateTexture(name.."EltruismPortraitEdge", "OVERLAY", nil, 6)
		frame.EltruismPortrait.edge:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Edge.tga")
		frame.EltruismPortrait.edge:SetAllPoints(frame.EltruismPortrait)

		frame.EltruismPortrait.rare = frame.EltruismPortrait:CreateTexture(name.."EltruismPortraitRare", "OVERLAY", nil, 7)
		frame.EltruismPortrait.rare:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Rare.tga")
		frame.EltruismPortrait.rare:SetAllPoints(frame.EltruismPortrait)

		frame.EltruismPortrait.background = frame.EltruismPortrait:CreateTexture(name.."EltruismPortraitBackground", "OVERLAY", nil, -7)
		frame.EltruismPortrait.background:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\maskcircle.tga")
		frame.EltruismPortrait.background:SetAllPoints(frame.EltruismPortrait)
		frame.EltruismPortrait.background:SetVertexColor(1,0,0,0)
	end

	if not frame.EltruismPortrait then return end

	if invert then
		frame.EltruismPortrait.rare:SetTexCoord(1, 0, 0, 1)
	end
	if not E.db.ElvUI_EltreumUI.unitframes.portrait[db].rare or E.db.ElvUI_EltreumUI.unitframes.portrait[db].type ~= "CIRCLE" then
		frame.EltruismPortrait.rare:SetTexture()
	end
	if E.db.ElvUI_EltreumUI.unitframes.portrait[db].type ~= "BLIZZARD" or not E.db.ElvUI_EltreumUI.unitframes.portrait[db].edge then
		frame.EltruismPortrait.edge:SetTexture()
	end
	if E.db.ElvUI_EltreumUI.unitframes.portrait[db].type == "BLIZZARD" then
		if E.db.ElvUI_EltreumUI.unitframes.portrait.shadow then
			frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\PortraitShadow.tga")
		else
			frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Portrait.tga")
		end
		if invert then
			frame.EltruismPortrait.border:SetTexCoord(1, 0, 0, 1)
			if isPlayerCustom then
				if notexcoord[E.db.ElvUI_EltreumUI.unitframes.portrait[db].style] then
					frame.EltruismPortrait.portrait:SetTexCoord(0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				else
					frame.EltruismPortrait.portrait:SetTexCoord(1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				end
			end
			frame.EltruismPortrait.edge:SetTexCoord(1, 0, 0, 1)
			frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\maskinvert.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
		else
			frame.EltruismPortrait.border:SetTexCoord(0, 1, 0, 1)
			frame.EltruismPortrait.edge:SetTexCoord(0, 1, 0, 1)
			frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\mask.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
		end
	else
		if E.db.ElvUI_EltreumUI.unitframes.portrait.shadow then
			frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\CircleShadow.tga")
		else
			frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Circle.tga")
		end
		frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\maskcircle.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	end

	if frame.Portrait then
		frame.Portrait:Hide()
		frame.Portrait:Kill()
		--frame.Portrait:ClearAllPoints()
	end

	if isPlayerCustom and E.db.ElvUI_EltreumUI.unitframes.portrait[db].style ~= "ORIGINAL" and E.db.ElvUI_EltreumUI.unitframes.portrait[db].customcircle and E.db.ElvUI_EltreumUI.unitframes.portrait[db].background then
		if UnitIsPlayer(frame.unit) or (E.Retail and UnitInPartyIsAI(frame.unit)) then
			frame.EltruismPortrait.background:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.portrait[db].backgroundcolor.r,E.db.ElvUI_EltreumUI.unitframes.portrait[db].backgroundcolor.g,E.db.ElvUI_EltreumUI.unitframes.portrait[db].backgroundcolor.b,1)
		end
	else
		frame.EltruismPortrait.background:SetVertexColor(1,0,0,0)
	end

	if update then
		--if not UnitExists(frame.unit) then return end
		if not isPlayerCustom or (E.db.ElvUI_EltreumUI.unitframes.portrait[db].customcircle and isPlayerCustom) then
			frame.EltruismPortrait.portrait:SetMask("")
			frame.EltruismPortrait.portrait:Show()
			frame.EltruismPortrait.border:Show()
			frame.EltruismPortrait.rare:SetAlpha(1)
			frame.EltruismPortrait.edge:SetAlpha(1)
			if not isPlayerCustom then
				SetPortraitTexture(frame.EltruismPortrait.portrait,frame.unit,true)
			end
			frame.EltruismPortrait.portrait:AddMaskTexture(frame.EltruismPortrait.Mask)

			if not isPlayerCustom then
				if (ElvUI_EltreumUI:ShouldRotatePortrait(model) or db == "pet") and db ~= "player" and db ~= "boss" and (db ~= "party" or (db == "party" and E.db.ElvUI_EltreumUI.unitframes.portrait[db].position.align == "RIGHT")) then
					frame.EltruismPortrait.portrait:SetTexCoord(1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				else
					frame.EltruismPortrait.portrait:SetTexCoord(E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				end
			end

			if E.db.ElvUI_EltreumUI.unitframes.portrait[db].customcircle and isPlayerCustom then
				if not (UnitIsPlayer(frame.unit) or (E.Retail and UnitInPartyIsAI(frame.unit))) then
					frame.EltruismPortrait.portrait:Hide()
					frame.EltruismPortrait.border:Hide()
					frame.EltruismPortrait.background:SetVertexColor(1,0,0,0)
				end
			end

			--color
			if not E.db.ElvUI_EltreumUI.unitframes.portrait[db].customcolor then
				if UnitIsPlayer(frame.unit) or (E.Retail and UnitInPartyIsAI(frame.unit)) then
					local _, unitclass = UnitClass(frame.unit)
					if E.db.ElvUI_EltreumUI.unitframes.portrait.gradient then
						if (E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor) and not E.db.ElvUI_EltreumUI.unitframes.portrait[db].defaultgradient then
							frame.EltruismPortrait.border:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColorsCustom(unitclass, E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							frame.EltruismPortrait.edge:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColorsCustom(unitclass, E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							frame.EltruismPortrait.rare:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColorsCustom(unitclass, E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
						else
							frame.EltruismPortrait.border:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(unitclass, E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							frame.EltruismPortrait.edge:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(unitclass, E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							frame.EltruismPortrait.rare:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(unitclass, E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
						end
					else
						local classrgb = ElvUI_EltreumUI:GetClassColorsRGB(unitclass)
						frame.EltruismPortrait.border:SetVertexColor(classrgb.r,classrgb.g,classrgb.b,1)
						frame.EltruismPortrait.edge:SetVertexColor(classrgb.r,classrgb.g,classrgb.b,1)
						frame.EltruismPortrait.rare:SetVertexColor(classrgb.r,classrgb.g,classrgb.b,1)
					end
				else
					local reaction = UnitReaction(frame.unit, "player")
					if not reaction then return end
					if E.db.ElvUI_EltreumUI.unitframes.portrait.gradient then
						if (E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor) and not E.db.ElvUI_EltreumUI.unitframes.portrait[db].defaultgradient then
							if reaction >= 5 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							elseif reaction == 4 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							elseif reaction == 3 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							elseif reaction <= 2 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							end
						else
							if reaction >= 5 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							elseif reaction == 4 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							elseif reaction == 3 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							elseif reaction <= 2 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							end
						end
					else
						if reaction >= 5 then
							local classrgb = ElvUI_EltreumUI:GetClassColorsRGB("NPCFRIENDLY")
							frame.EltruismPortrait.border:SetVertexColor(classrgb.r,classrgb.g,classrgb.b,1)
							frame.EltruismPortrait.edge:SetVertexColor(classrgb.r,classrgb.g,classrgb.b,1)
						elseif reaction == 4 then
							local classrgb = ElvUI_EltreumUI:GetClassColorsRGB("NPCNEUTRAL")
							frame.EltruismPortrait.border:SetVertexColor(classrgb.r,classrgb.g,classrgb.b,1)
							frame.EltruismPortrait.edge:SetVertexColor(classrgb.r,classrgb.g,classrgb.b,1)
						elseif reaction == 3 then
							local classrgb = ElvUI_EltreumUI:GetClassColorsRGB("NPCUNFRIENDLY")
							frame.EltruismPortrait.border:SetVertexColor(classrgb.r,classrgb.g,classrgb.b,1)
							frame.EltruismPortrait.edge:SetVertexColor(classrgb.r,classrgb.g,classrgb.b,1)
						elseif reaction == 2 or reaction == 1 then
							local classrgb = ElvUI_EltreumUI:GetClassColorsRGB("NPCHOSTILE")
							frame.EltruismPortrait.border:SetVertexColor(classrgb.r,classrgb.g,classrgb.b,1)
							frame.EltruismPortrait.edge:SetVertexColor(classrgb.r,classrgb.g,classrgb.b,1)
						end
					end
				end
			else
				frame.EltruismPortrait.border:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.r,E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.g,E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.b,1)
				frame.EltruismPortrait.edge:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.r,E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.g,E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.b,1)
				frame.EltruismPortrait.rare:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.r,E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.g,E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.b,1)
			end

			if E.db.ElvUI_EltreumUI.unitframes.portrait[db].rare and E.db.ElvUI_EltreumUI.unitframes.portrait[db].type == "CIRCLE" then
				frame.EltruismPortrait.rare:SetAlpha(1)
				local c = UnitClassification(frame.unit)
				if (c == 'rare') or (c == 'rareelite') then
					frame.EltruismPortrait.rare:SetVertexColor(1,1,1,1)
					frame.EltruismPortrait.border:SetVertexColor(1,1,1,1)
					frame.EltruismPortrait.edge:SetVertexColor(1,1,1,1)
				elseif(c == 'elite') or (c == 'worldboss') then
					frame.EltruismPortrait.rare:SetVertexColor(0.84,0.74,0.35,1)
					frame.EltruismPortrait.border:SetVertexColor(0.84,0.74,0.35,1)
					frame.EltruismPortrait.edge:SetVertexColor(0.84,0.74,0.35,1)
				else
					if not UnitIsPlayer(frame.unit) then
						frame.EltruismPortrait.rare:SetVertexColor(0,0,0,0)
					end
				end
			else
				frame.EltruismPortrait.rare:SetAlpha(0)
			end
		end

		if isPlayerCustom then
			if UnitIsPlayer(frame.unit) or (E.Retail and UnitInPartyIsAI(frame.unit)) then
				local _, unitclass = UnitClass(frame.unit)
				frame.EltruismPortrait.portrait:SetTexture(ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.unitframes.portrait[db].style,unitclass,false,"128",true))
				frame.EltruismPortrait.border:Hide()
				frame.EltruismPortrait.rare:SetAlpha(0)
				frame.EltruismPortrait.edge:SetAlpha(0)
				frame.EltruismPortrait.portrait:Show()
			else
				frame.EltruismPortrait.border:SetAlpha(0)
				frame.EltruismPortrait.rare:SetAlpha(0)
				frame.EltruismPortrait.edge:SetAlpha(0)
				frame.EltruismPortrait.portrait:Hide()
			end

			if E.db.ElvUI_EltreumUI.unitframes.portrait[db].customcircle then
				if UnitIsPlayer(frame.unit) or (E.Retail and UnitInPartyIsAI(frame.unit)) then
					frame.EltruismPortrait.border:Show()
				end
				frame.EltruismPortrait.portrait:AddMaskTexture(frame.EltruismPortrait.Mask)
			else
				frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\clearmask.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
				frame.EltruismPortrait.portrait:AddMaskTexture(frame.EltruismPortrait.Mask)
				frame.EltruismPortrait.portrait:SetMask("")
				frame.EltruismPortrait.border:Hide()
				--frame.EltruismPortrait.portrait:SetMask("")
			end
		else
			frame.EltruismPortrait.border:Show()
			frame.EltruismPortrait.edge:SetAlpha(1)
		end

		if invert then
			if isPlayerCustom then
				if notexcoord[E.db.ElvUI_EltreumUI.unitframes.portrait[db].style] then
					frame.EltruismPortrait.portrait:SetTexCoord(0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				else
					frame.EltruismPortrait.portrait:SetTexCoord(1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				end
			end
		else
			if isPlayerCustom then
				if notexcoord[E.db.ElvUI_EltreumUI.unitframes.portrait[db].style] then
					frame.EltruismPortrait.portrait:SetTexCoord(0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				else
					frame.EltruismPortrait.portrait:SetTexCoord(-0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				end
			end
		end

		frame.EltruismPortrait:SetPoint("CENTER", frame, tostring(E.db.ElvUI_EltreumUI.unitframes.portrait[db].position.align), E.db.ElvUI_EltreumUI.unitframes.portrait[db].position.x, E.db.ElvUI_EltreumUI.unitframes.portrait[db].position.y)
		frame.EltruismPortrait:SetSize(E.db.ElvUI_EltreumUI.unitframes.portrait[db].size,E.db.ElvUI_EltreumUI.unitframes.portrait[db].size)

		if not E.db.ElvUI_EltreumUI.unitframes.portrait[db].rare or E.db.ElvUI_EltreumUI.unitframes.portrait[db].type ~= "CIRCLE" or isPlayerCustom then
			frame.EltruismPortrait.rare:SetTexture()
		else
			frame.EltruismPortrait.rare:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Rare.tga")
		end

		if E.db.ElvUI_EltreumUI.unitframes.portrait[db].type ~= "BLIZZARD" or not E.db.ElvUI_EltreumUI.unitframes.portrait[db].edge or isPlayerCustom then
			frame.EltruismPortrait.edge:SetTexture()
		else
			frame.EltruismPortrait.edge:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Edge.tga")
		end

		if E.db.ElvUI_EltreumUI.unitframes.portrait[db].type == "BLIZZARD" then
			if E.db.ElvUI_EltreumUI.unitframes.portrait.shadow then
				frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\PortraitShadow.tga")
			else
				frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Portrait.tga")
			end
			if invert then
				frame.EltruismPortrait.border:SetTexCoord(1, 0, 0, 1)
				if isPlayerCustom then
					if notexcoord[E.db.ElvUI_EltreumUI.unitframes.portrait[db].style] then
						frame.EltruismPortrait.portrait:SetTexCoord(0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					else
						frame.EltruismPortrait.portrait:SetTexCoord(1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					end
				end
				frame.EltruismPortrait.edge:SetTexCoord(1, 0, 0, 1)
				frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\maskinvert.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
			else
				frame.EltruismPortrait.border:SetTexCoord(0, 1, 0, 1)
				if isPlayerCustom then
					if notexcoord[E.db.ElvUI_EltreumUI.unitframes.portrait[db].style] then
						frame.EltruismPortrait.portrait:SetTexCoord(0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					else
						frame.EltruismPortrait.portrait:SetTexCoord(-0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					end
				end
				frame.EltruismPortrait.edge:SetTexCoord(0, 1, 0, 1)
				frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\mask.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
			end
			if isPlayerCustom then
				frame.EltruismPortrait.Mask:SetColorTexture(0,0,0,1)
			end
		else
			if E.db.ElvUI_EltreumUI.unitframes.portrait.shadow then
				frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\CircleShadow.tga")
			else
				frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Circle.tga")
			end
			if invert then
				if isPlayerCustom then
					if notexcoord[E.db.ElvUI_EltreumUI.unitframes.portrait[db].style] then
						frame.EltruismPortrait.portrait:SetTexCoord(0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					else
						frame.EltruismPortrait.portrait:SetTexCoord(1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					end
				end
			else
				if isPlayerCustom then
					if notexcoord[E.db.ElvUI_EltreumUI.unitframes.portrait[db].style] then
						frame.EltruismPortrait.portrait:SetTexCoord(0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					else
						frame.EltruismPortrait.portrait:SetTexCoord(-0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					end
				end
			end
			if E.db.ElvUI_EltreumUI.unitframes.portrait[db].customcircle and isPlayerCustom then
				frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\maskcircle.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
			elseif isPlayerCustom and not E.db.ElvUI_EltreumUI.unitframes.portrait[db].customcircle then
				frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\clearmask.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
			elseif not isPlayerCustom then
				frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\maskcircle.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
			end
		end
	end

	if E.db.ElvUI_EltreumUI.unitframes.portrait[db].enable then
		frame.EltruismPortrait:Show()
	else
		frame.EltruismPortrait:Hide()
	end
end

--main hook
function ElvUI_EltreumUI:BlizzPortraits(unit,hasStateChanged)
	if E.db.ElvUI_EltreumUI.unitframes.portrait.enable then
		if unit == "player" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_Player"],"ElvUF_Player",false,hasStateChanged,"player")
		end
		if unit == "target" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_Target"],"ElvUF_Target",true,hasStateChanged,"target")
		end
		if unit == "targettarget" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_TargetTarget"],"ElvUF_TargetTarget",true,hasStateChanged,"targettarget")
		end
		if unit == "pet" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_Pet"],"ElvUF_Pet",false,hasStateChanged,"pet")
		end
		if not (E.Classic or E.ClassicHC) then
			if unit == "focus" then
				CreatePorfraitFrameAndTexture(_G["ElvUF_Focus"],"ElvUF_Focus",false,hasStateChanged,"focus")
			end
			if unit == "focustarget" then
				CreatePorfraitFrameAndTexture(_G["ElvUF_FocusTarget"],"ElvUF_FocusTarget",false,hasStateChanged,"focustarget")
			end
		end
		for i = 1, 8 do
			if _G["ElvUF_Boss"..i] and _G["ElvUF_Boss"..i].unit then
				CreatePorfraitFrameAndTexture(_G["ElvUF_Boss"..i],"ElvUF_Boss"..i,false,true,"boss")
			end
		end
		if IsInGroup() and not IsInRaid() then
			for i = 1, 5 do
				if _G["ElvUF_PartyGroup1UnitButton"..i] and _G["ElvUF_PartyGroup1UnitButton"..i].unit then
					CreatePorfraitFrameAndTexture(_G["ElvUF_PartyGroup1UnitButton"..i],"ElvUF_PartyGroup1UnitButton"..i,false,true,"party")
				else
					break
				end
			end
		end
	end
end
local UF = E:GetModule('UnitFrames')
hooksecurefunc(UF,"PortraitUpdate", ElvUI_EltreumUI.BlizzPortraits)

--hook for party frames and others
function ElvUI_EltreumUI:BlizzPortraitsGroup(frame)
	if E.db.ElvUI_EltreumUI.unitframes.portrait.enable then
		if not frame then return end
		if not frame.USE_PORTRAIT then return end
		if not frame:GetName() then return end
		if frame:GetName():match("PartyGroup") and not frame:GetName():match("Pet") then
			E:Delay(0, function() CreatePorfraitFrameAndTexture(frame,tostring(frame:GetName()),false,true,"party") end)
		end
		if frame:GetName():match("Focus") then
			E:Delay(0, function() CreatePorfraitFrameAndTexture(frame,tostring(frame:GetName()),false,true,tostring(frame.unit)) end)
		end
		if frame:GetName():match("FocusTarget") then
			E:Delay(0, function() CreatePorfraitFrameAndTexture(frame,tostring(frame:GetName()),false,true,"focustarget") end)
		end
		if frame:GetName():match("TargetTarget") then
			E:Delay(0, function() CreatePorfraitFrameAndTexture(frame,tostring(frame:GetName()),true,true,"targettarget") end)
		end
		if frame:GetName():match("Boss") then
			E:Delay(0, function() CreatePorfraitFrameAndTexture(frame,tostring(frame:GetName()),false,true,"boss") end)
		end
	end
end
hooksecurefunc(UF,"Configure_Portrait", ElvUI_EltreumUI.BlizzPortraitsGroup)
hooksecurefunc(UF,"Update_PartyFrames", ElvUI_EltreumUI.BlizzPortraitsGroup)
hooksecurefunc(UF,"Update_BossFrames", ElvUI_EltreumUI.BlizzPortraitsGroup)

--function to update portrait when settings change
function ElvUI_EltreumUI:BlizzPortraitSettingUpdate(unit)
	if E.db.ElvUI_EltreumUI.unitframes.portrait.enable then
		if unit == "player" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_Player"],"ElvUF_Player",false,true,"player",true)
		end
		if unit == "target" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_Target"],"ElvUF_Target",true,true,"target",true)
		end
		if unit == "pet" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_Pet"],"ElvUF_Pet",false,true,"pet",true)
		end
		if unit == "party" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_PartyGroup1UnitButton1"],"ElvUF_PartyGroup1UnitButton1",false,true,"party",true)
			CreatePorfraitFrameAndTexture(_G["ElvUF_PartyGroup1UnitButton2"],"ElvUF_PartyGroup1UnitButton2",false,true,"party",true)
			CreatePorfraitFrameAndTexture(_G["ElvUF_PartyGroup1UnitButton3"],"ElvUF_PartyGroup1UnitButton3",false,true,"party",true)
			CreatePorfraitFrameAndTexture(_G["ElvUF_PartyGroup1UnitButton4"],"ElvUF_PartyGroup1UnitButton4",false,true,"party",true)
			CreatePorfraitFrameAndTexture(_G["ElvUF_PartyGroup1UnitButton5"],"ElvUF_PartyGroup1UnitButton5",false,true,"party",true)
		end
		if unit == "targettarget" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_TargetTarget"],"ElvUF_TargetTarget",true,true,"targettarget",true)
		end
		if unit == "focus" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_Focus"],"ElvUF_Focus",false,true,"focus",true)
		end
		if unit == "focustarget" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_FocusTarget"],"ElvUF_FocusTarget",false,true,"focustarget",true)
		end
		if unit == "boss" then
			for i = 1, 8 do
				if _G["ElvUF_Boss"..i] and _G["ElvUF_Boss"..i].unit then
					CreatePorfraitFrameAndTexture(_G["ElvUF_Boss"..i],"ElvUF_Boss"..i,false,true,"boss",true)
				end
			end
		end
	end
end
