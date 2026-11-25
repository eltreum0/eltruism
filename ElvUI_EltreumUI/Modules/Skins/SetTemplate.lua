local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local valuecolors = E.myClassColor
local colorsborders = valuecolors
local _G = _G
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local getmetatable = _G.getmetatable
local type = _G.type
local BackdropTemplateMixin = _G.BackdropTemplateMixin
local fixedConfig = false
local ipairs = _G.ipairs
local abs = _G.math.abs
local strfind = _G.string.find

local barBorderKeys = { "bar1borders", "bar2borders", "bar3borders", "bar4borders", "bar5borders", "bar6borders" }
local barNamePrefixes = { "ElvUI_Bar1", "ElvUI_Bar2", "ElvUI_Bar3", "ElvUI_Bar4", "ElvUI_Bar5", "ElvUI_Bar6" }

local widgetAtlas = {
	["widgetstatusbar-fill-blue"] = { r = 0, g = 0, b = 255, a = 1},
	["widgetstatusbar-fill-green"] = { r = 0, g = 255, b = 0, a = 1},
	["widgetstatusbar-fill-red"] = { r = 255, g = 0, b = 0, a = 1},
	["widgetstatusbar-fill-white"] = { r = 255, g = 255, b = 255, a = 1},
	["widgetstatusbar-fill-yellow"] = { r = 255, g = 255, b = 0, a = 1},
	["cosmic-bar-fill-white"] = { r = 255, g = 255, b = 255, a = 1},
	["mixingpool-frame-fill-white"] = { r = 255, g = 255, b = 255, a = 1},
}

local function GetDefaultUniversalBorderColor()
	if E.db.ElvUI_EltreumUI.borders.classcolor then
		return E.myClassColor.r, E.myClassColor.g, E.myClassColor.b, 1
	elseif E.db.ElvUI_EltreumUI.borders.bordercolors then
		return E.db.ElvUI_EltreumUI.borders.bordercolors.r, E.db.ElvUI_EltreumUI.borders.bordercolors.g, E.db.ElvUI_EltreumUI.borders.bordercolors.b, 1
	elseif colorsborders then
		return colorsborders.r, colorsborders.g, colorsborders.b, 1
	else
		return 1, 1, 1, 1
	end
end

local function IsDefaultBorderColor(r, g, b)
	if not r or not g or not b then return true end
	if E.media then
		if E.media.bordercolor then
			local br = E.media.bordercolor[1] or E.media.bordercolor.r
			local bg = E.media.bordercolor[2] or E.media.bordercolor.g
			local bb = E.media.bordercolor[3] or E.media.bordercolor.b
			if br and bg and bb then
				if abs(r - br) < 0.02 and abs(g - bg) < 0.02 and abs(b - bb) < 0.02 then
					return true
				end
			end
		end
		if E.media.unitframeBorderColor then
			local ubr = E.media.unitframeBorderColor[1] or E.media.unitframeBorderColor.r
			local ubg = E.media.unitframeBorderColor[2] or E.media.unitframeBorderColor.g
			local ubb = E.media.unitframeBorderColor[3] or E.media.unitframeBorderColor.b
			if ubr and ubg and ubb then
				if abs(r - ubr) < 0.02 and abs(g - ubg) < 0.02 and abs(b - ubb) < 0.02 then
					return true
				end
			end
		end
	end
	return false
end

local function FrameHasRegularBorder(frame)
	local bordersDB = E.db.ElvUI_EltreumUI.borders
	if not (bordersDB.borders and bordersDB.universalborderssettings.hideWithBorders) then
		return false
	end
	if frame.EltruismBorder or frame.EltruismRegularBorder then
		return true
	end
	local name = frame:GetName() or (frame.GetDebugName and frame:GetDebugName())
	if name then
		if strfind(name, "Eltruism", 1, true) and strfind(name, "Border", 1, true) then return true end
		local parent = frame:GetParent()
		local parentName = parent and parent:GetName()
		if bordersDB.playerborder and (strfind(name, "ElvUF_Player", 1, true) or (parentName and strfind(parentName, "ElvUF_Player", 1, true))) then
			return true
		end
		if bordersDB.targetborder and (strfind(name, "ElvUF_Target", 1, true) or (parentName and strfind(parentName, "ElvUF_Target", 1, true))) then
			return true
		end
		if bordersDB.minimapborder and (strfind(name, "Minimap", 1, true) or strfind(name, "MMHolder", 1, true)) then
			return true
		end
		if (bordersDB.leftchatborder and strfind(name, "LeftChatPanel", 1, true)) or (bordersDB.rightchatborder and strfind(name, "RightChatPanel", 1, true)) then
			return true
		end
		for i = 1, 6 do
			if bordersDB[barBorderKeys[i]] then
				local prefix = barNamePrefixes[i]
				if strfind(name, prefix, 1, true) or (parentName and strfind(parentName, prefix, 1, true)) then
					return true
				end
			end
		end
	end
	return false
end

local function togglebackdrop(frame,show)
	if not frame then return end
	if frame.TopLeftCorner then
		if show then
			frame.TopLeftCorner:Show()
			frame.TopRightCorner:Show()
			frame.BottomLeftCorner:Show()
			frame.BottomRightCorner:Show()

			frame.LeftEdge:Show()
			frame.RightEdge:Show()
			frame.BottomEdge:Show()
			frame.TopEdge:Show()
		else
			frame.TopLeftCorner:Hide()
			frame.TopRightCorner:Hide()
			frame.BottomLeftCorner:Hide()
			frame.BottomRightCorner:Hide()

			frame.LeftEdge:Hide()
			frame.RightEdge:Hide()
			frame.BottomEdge:Hide()
			frame.TopEdge:Hide()
		end
	end
	if frame.iborder then
		if show then
			frame.iborder:Show()
		else
			frame.iborder:Hide()
			if frame.iborder.SetBackdropBorderColor then
				frame.iborder:SetBackdropBorderColor(0, 0, 0, 0)
			end
		end
	end
	if frame.oborder then
		if show then
			frame.oborder:Show()
		else
			frame.oborder:Hide()
			if frame.oborder.SetBackdropBorderColor then
				frame.oborder:SetBackdropBorderColor(0, 0, 0, 0)
			end
		end
	end
	if frame.backdrop then
		togglebackdrop(frame.backdrop, show)
	end
end

local function HideElvUIBorders(frame)
	if not frame then return end
	togglebackdrop(frame, false)
	if frame.SetBackdropBorderColor then
		frame.eltruismSettingBorder = true
		frame:SetBackdropBorderColor(0, 0, 0, 0)
		frame.eltruismSettingBorder = nil
	end
	frame.ignoreBorderColors = true

	if frame.backdrop then
		togglebackdrop(frame.backdrop, false)
		if frame.backdrop.SetBackdropBorderColor then
			frame.backdrop.eltruismSettingBorder = true
			frame.backdrop:SetBackdropBorderColor(0, 0, 0, 0)
			frame.backdrop.eltruismSettingBorder = nil
		end
		frame.backdrop.ignoreBorderColors = true
	end
	--theres center too, which can show the corners, but hiding or setting alpha causes it to vanish
end

local universalBackdrop = {
	edgeFile = nil,
	edgeSize = nil,
}

local function OnUniversalFrameBorderColor(frametable, r, g, b, a)
	if frametable.eltruismSettingBorder then return end
	if a == 0 and r == 0 and g == 0 and b == 0 then return end

	local ub = frametable.eltruismuniversalborders
	if not ub and frametable.backdrop then
		ub = frametable.backdrop.eltruismuniversalborders
	end
	if not ub and frametable:GetParent() then
		ub = frametable:GetParent().eltruismuniversalborders
	end
	if not ub then return end

	if type(r) == "table" then
		r, g, b, a = r.r, r.g, r.b, r.a
	end

	if IsDefaultBorderColor(r, g, b) then
		local dr, dg, db, da = GetDefaultUniversalBorderColor()
		ub:SetBackdropBorderColor(dr, dg, db, da)
	else
		ub:SetBackdropBorderColor(r, g, b, a or 1)
	end
	ub:Show()

	HideElvUIBorders(frametable)
end

local function OnIconBorderSetShown(ib, shown)
	local parent = ib:GetParent()
	local ub = parent and parent.eltruismuniversalborders
	if not ub then return end
	if shown then
		local ir, ig, ib_b = ib:GetVertexColor()
		if ir and ig and ib_b and not (ir == 1 and ig == 1 and ib_b == 1) then
			ub:SetBackdropBorderColor(ir, ig, ib_b, 1)
		else
			local dr, dg, db, da = GetDefaultUniversalBorderColor()
			ub:SetBackdropBorderColor(dr, dg, db, da)
		end
	else
		local dr, dg, db, da = GetDefaultUniversalBorderColor()
		ub:SetBackdropBorderColor(dr, dg, db, da)
	end
	ub:Show()
	HideElvUIBorders(parent)
end

local function OnIconBorderSetVertexColor(ib, ir, ig, ib_b)
	local parent = ib:GetParent()
	local ub = parent and parent.eltruismuniversalborders
	if not ub then return end
	if ib:IsShown() and ir and ig and ib_b and not (ir == 1 and ig == 1 and ib_b == 1) then
		ub:SetBackdropBorderColor(ir, ig, ib_b, 1)
		ub:Show()
	end
end

local function ApplyIconBorderColor(ib)
	local parent = ib:GetParent()
	local ub = parent and parent.eltruismuniversalborders
	if not ub then return end
	local ir, ig, ib_b = ib:GetVertexColor()
	if ir and ig and ib_b and not (ir == 1 and ig == 1 and ib_b == 1) then
		ub:SetBackdropBorderColor(ir, ig, ib_b, 1)
	else
		local dr, dg, db, da = GetDefaultUniversalBorderColor()
		ub:SetBackdropBorderColor(dr, dg, db, da)
	end
	ub:Show()
	HideElvUIBorders(parent)
end

local function OnIconBorderShow(ib)
	E:Delay(0, ApplyIconBorderColor, ib)
end

local function OnIconBorderHide(ib)
	local parent = ib:GetParent()
	local ub = parent and parent.eltruismuniversalborders
	if not ub then return end
	local dr, dg, db, da = GetDefaultUniversalBorderColor()
	ub:SetBackdropBorderColor(dr, dg, db, da)
	ub:Show()
	HideElvUIBorders(parent)
end

local function EltruismBorders(frame,isUnitFrameElement)
	if (isUnitFrameElement and not (frame:GetDebugName() and frame:GetDebugName():match("AuraBar"))) then return end
	if not E:NotSecretValue(frame) then return end --check for secret frame, avoid it
	if frame.IsForbidden and frame:IsForbidden() then return end
	if FrameHasRegularBorder(frame) then
		if frame.eltruismuniversalborders then
			frame.eltruismuniversalborders:Hide()
		end
		return
	end

	if not E.db.ElvUI_EltreumUI.borders.universalborders then return end

	local xOffset = E.db.ElvUI_EltreumUI.borders.universalborderssettings.xOffset
	local yOffset = E.db.ElvUI_EltreumUI.borders.universalborderssettings.yOffset
	local thickness = E.db.ElvUI_EltreumUI.borders.universalborderssettings.thickness
	local borderTexture = E.LSM:Fetch("border", E.db.ElvUI_EltreumUI.borders.texture)
	local defR, defG, defB, defA = GetDefaultUniversalBorderColor()

	if not frame.eltruismuniversalborders then
		frame.eltruismuniversalborders = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
		frame.eltruismuniversalborders:EnableMouse(false)
		frame.eltruismuniversalborders:SetFrameStrata(E:NotSecretValue(frame:GetFrameStrata()) and frame:GetFrameStrata() or "MEDIUM")
		frame.eltruismuniversalborders:SetFrameLevel(frame:GetFrameLevel()+2)
	end

	frame.eltruismuniversalborders:ClearAllPoints()
	frame.eltruismuniversalborders:SetOutside(frame, xOffset, yOffset)
	universalBackdrop.edgeFile = borderTexture
	universalBackdrop.edgeSize = thickness
	frame.eltruismuniversalborders:SetBackdrop(universalBackdrop)

	--find border color
	local initR, initG, initB, initA = defR, defG, defB, defA
	if frame.GetBackdropBorderColor then
		local curR, curG, curB, curA = frame:GetBackdropBorderColor()
		if curR and curG and curB and not (curR == 0 and curG == 0 and curB == 0 and (not curA or curA == 0)) then
			if not IsDefaultBorderColor(curR, curG, curB) then
				initR, initG, initB, initA = curR, curG, curB, curA or 1
			end
		end
	end

	frame.eltruismuniversalborders:SetBackdropBorderColor(initR, initG, initB, initA)
	frame.eltruismuniversalborders:Show()

	--hide elvui's borders
	HideElvUIBorders(frame)

	--follow elvui's border color
	if not frame.EltruismBorderColorHooked then
		hooksecurefunc(frame, "SetBackdropBorderColor", OnUniversalFrameBorderColor)
		frame.EltruismBorderColorHooked = true
	end

	--icon border/quality
	if frame.IconBorder then
		if not frame.EltruismIconBorderHooked then
			hooksecurefunc(frame.IconBorder, "SetShown", OnIconBorderSetShown)
			hooksecurefunc(frame.IconBorder, "SetVertexColor", OnIconBorderSetVertexColor)
			hooksecurefunc(frame.IconBorder, "Show", OnIconBorderShow)
			hooksecurefunc(frame.IconBorder, "Hide", OnIconBorderHide)
			frame.EltruismIconBorderHooked = true
		end

		if frame.IconBorder:IsShown() then
			local ir, ig, ib_b = frame.IconBorder:GetVertexColor()
			if ir and ig and ib_b and not (ir == 1 and ig == 1 and ib_b == 1) then
				frame.eltruismuniversalborders:SetBackdropBorderColor(ir, ig, ib_b, 1)
			end
		end

		if frame.caerdonButton then
			frame.eltruismuniversalborders:SetFrameLevel(frame:GetFrameLevel()+1)
			frame.caerdonButton:SetFrameLevel(frame:GetFrameLevel()+2)
		end
	end

	--if not hiding the config frame border then the buttons become unclickable
	if not fixedConfig then
		local configFrame = E:Config_GetWindow()
		if configFrame and configFrame.eltruismuniversalborders then
			--configFrame.eltruismuniversalborders:Kill()
			--configFrame.eltruismuniversalborders = nil
			configFrame.eltruismuniversalborders:SetFrameStrata("MEDIUM")
			configFrame.eltruismuniversalborders:EnableMouse(false)
			if configFrame.Center then
				configFrame.Center:ClearAllPoints()
				configFrame.Center:SetPoint("TOPLEFT", configFrame, "TOPLEFT", 2, -2)
				configFrame.Center:SetPoint("BOTTOMRIGHT", configFrame, "BOTTOMRIGHT", -2, 2)
			end
			fixedConfig = true
		end
	end

	-- SharedMedia dropdown preview
	if frame:GetParent() then
		if frame:GetParent().displayButton then
			frame:GetParent().displayButton:SetFrameLevel(frame:GetFrameLevel()+3)
		end
		if frame:GetParent().NameBackground and frame:GetParent().artBackdrop then
			frame:GetParent().artBackdrop:SetOutside(frame.Icon)
		end
	end
	if _G.ElvNP_TargetClassPowerClassPower and _G.ElvNP_TargetClassPowerClassPower.backdrop and _G.ElvNP_TargetClassPowerClassPower.backdrop.eltruismuniversalborders then
		_G.ElvNP_TargetClassPowerClassPower.backdrop.eltruismuniversalborders:SetFrameLevel(frame:GetFrameLevel())
	end
	if frame:GetDebugName() then
		if frame:GetDebugName():match("AuraBar") then
			frame.eltruismuniversalborders:SetFrameLevel(1)
			frame.eltruismuniversalborders:SetFrameStrata("BACKGROUND")
		elseif frame:GetDebugName():match("QuestIcons") then
			frame.eltruismuniversalborders:Hide()
		end
	end

	--even though shadows shouldnt be made, try to handle possible ones
	if frame.shadow then
		frame.shadow:Hide()
	elseif frame.backdrop and frame.backdrop.shadow then
		frame.backdrop.shadow:Hide()
		if frame.backdrop.eltruismuniversalborders and frame.backdrop ~= frame then
			frame.backdrop.eltruismuniversalborders:Hide()
		end
	elseif frame:GetParent() and frame:GetParent().shadow then
		frame:GetParent().shadow:Hide()
	elseif frame:GetParent() and frame:GetParent():GetParent() and frame:GetParent():GetParent().shadow then
		frame:GetParent():GetParent().shadow:Hide()
	end

	-- PetBattle frame exception
	if frame:GetDebugName() and frame:GetDebugName():match("PetBattleFrame") and (frame:GetDebugName():match("Ally") or frame:GetDebugName():match("Enemy")) and frame.Icon then
		frame.eltruismuniversalborders:Hide()
		return
	end

	-- Wardrobe collection
	if frame:GetDebugName() and frame:GetDebugName():match("WardrobeCollectionFrame.ItemsCollectionFrame.Model") and frame:GetParent() then
		if frame:GetParent().HideVisual then
			frame:GetParent().HideVisual:SetFrameLevel(frame:GetFrameLevel()+2)
		end
		if frame:GetParent().Favorite then
			frame:GetParent().Favorite:SetFrameLevel(frame:GetFrameLevel()+2)
		end
	end

	frame.eltruismuniversalbordersadded = true
end

local function EltruismBackground(frame,isUnitFrameElement,isNamePlateElement)
	if isUnitFrameElement and not E.db.ElvUI_EltreumUI.skins.elvui.unitframes then return end
	if isNamePlateElement and not E.db.ElvUI_EltreumUI.skins.elvui.nameplates then return end
	if frame:GetObjectType() == "Button" and not E.db.ElvUI_EltreumUI.skins.elvui.button then return end
	if frame:GetParent() and frame:GetParent():GetObjectType() == "Button" and not E.db.ElvUI_EltreumUI.skins.elvui.button then return end
	if (frame:GetParent() and frame:GetParent().VisitHouseButton) then return end
	if not frame.EltruismBackground then
		frame.eltruismbgtexture = frame:CreateTexture(nil, "BORDER")
		frame.eltruismbgtexture:SetParent(frame)
		frame.eltruismbgtexture:ClearAllPoints()
		frame.eltruismbgtexture:SetPoint("TOPLEFT", 1, -1)
		frame.eltruismbgtexture:SetPoint("BOTTOMRIGHT", -1, 1)
		frame.eltruismbgtexture:SetTexture(E.LSM:Fetch("background", E.db.ElvUI_EltreumUI.skins.elvui.texture), true, true)
		frame.eltruismbgtexture:SetHorizTile(true)
		frame.eltruismbgtexture:SetVertTile(true)
		frame.eltruismbgtexture:SetBlendMode("ADD")
		if (frame:GetObjectType() == "Button" or frame:GetObjectType() == "CheckButton") and frame.icon then --fix for buttons since the texture could overlap over the icon
			frame.eltruismbgtexture:SetDrawLayer("BACKGROUND")
		end
		if frame:GetParent() then
			if frame:GetParent():GetObjectType() == "Button" and frame:GetParent().icon and not isUnitFrameElement then --fix for buttons since the texture could overlap over the icon
				frame.eltruismbgtexture:SetDrawLayer("BACKGROUND")
			end
			if frame:GetParent().TransmogStateTexture then --transmog stuff
				frame.eltruismbgtexture:SetTexture("")
			end
			if frame:GetParent().TransmogSelectedAnim then --transmog stuff
				--frame.eltruismbgtexture:SetTexture("") --at some point this stopped working and now the frame needs to be hidden
				frame:Hide()
			end
		end
		--[[if (frame.SelectedTexture or frame.glossTex) then --fix some more buttons
			frame.eltruismbgtexture:Hide()
		end]]
		if isUnitFrameElement and (frame:GetParent() and frame:GetParent().isTransparent == false) then --only on health
			frame.eltruismbgtexture:SetDrawLayer("ARTWORK")
			frame.eltruismbgtexture:SetParent(frame:GetParent())
		end
		if E.db.ElvUI_EltreumUI.skins.elvui.color.classcolor then
			frame.eltruismbgtexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,0.15)
		else
			frame.eltruismbgtexture:SetVertexColor(E.db.ElvUI_EltreumUI.skins.elvui.color.r,E.db.ElvUI_EltreumUI.skins.elvui.color.g,E.db.ElvUI_EltreumUI.skins.elvui.color.b,E.db.ElvUI_EltreumUI.skins.elvui.color.a)
		end

		if frame.leftHolder then --elvui second config frame stuff
			frame.eltruismbgtexture:SetTexture("")
		end

		 --fix pet battle/transmog issue
		if ElvUI_EltreumUI:IsThisASafeSecret(nil,nil,true) and ElvUI_EltreumUI:IsThisASafeSecret(frame,true) and frame:GetDebugName():match("PetJournalLoadoutPet") then --has secret
			if frame.icon and frame.backdrop then frame.backdrop:SetFrameLevel(frame:GetFrameLevel()+2) end
		end

		frame.EltruismBackground = true
	end
end

local function EltruisAce3(frame)
	if not ElvUI_EltreumUI:IsThisASafeSecret() then return end
	if E.db.ElvUI_EltreumUI.skins.ace3.enable then
		if not frame.EltruismAce3HooksSetup then
			E:Delay(0,function()
				if frame.IsForbidden and frame:IsForbidden() then return end
				if not _G.InCombatLockdown() and ElvUI_EltreumUI:IsThisASafeSecret(frame,true) and ElvUI_EltreumUI:IsThisASafeSecret(frame:GetParent(),true) then
					if frame:GetParent() then
						if frame:GetParent().obj then
							if frame:GetParent().obj.SetValue then
								if not frame:GetParent().obj.EltruismHookLabel then
									hooksecurefunc(frame:GetParent().obj,"SetValue", function(frametext)
										E:Delay(0, function()
											if frametext.label then
												if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
													frametext.label:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
												else
													frametext.label:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
												end
											end
											if frametext.titletext then
												if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
													frametext.titletext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
												else
													frametext.titletext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
												end
											end
										end)
									end)
									frame:GetParent().obj.EltruismHookLabel = true
								end
							end
							if frame:GetParent().obj.SetText then
								if not frame:GetParent().obj.EltruismHookSetText then
									hooksecurefunc(frame:GetParent().obj,"SetText", function(frametext)
										E:Delay(0, function()
											if frametext.label then
												if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
													frametext.label:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
												else
													frametext.label:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
												end
											end
											if frametext.titletext then
												if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
													frametext.titletext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
												else
													frametext.titletext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
												end
											end
										end)
									end)
									frame:GetParent().obj.EltruismHookSetText = true
								end
							end
						end
						if frame:GetParent().label then
							if frame:GetParent().label.SetText then
								if not frame:GetParent().EltruismHookSetTextLabel then
									hooksecurefunc(frame:GetParent().label,"SetText", function(frametext)
										E:Delay(0, function()
											if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
												frametext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
											else
												frametext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
											end
										end)
									end)
									frame:GetParent().EltruismHookSetTextLabel = true
								end
							end
						end
						if frame:GetParent().titletext then
							if frame:GetParent().titletext.SetText then
								if not frame:GetParent().EltruismHookSetTextTitleText then
									hooksecurefunc(frame:GetParent().titletext,"SetText", function(frametext)
										E:Delay(0, function()
											if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
												frametext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
											else
												frametext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
											end
										end)
									end)
									frame:GetParent().EltruismHookSetTextTitleText = true
								end
							end
						end
					end
				end
			end)
			frame.EltruismAce3HooksSetup = true
		end
		E:Delay(0,function()
			if frame.IsForbidden and frame:IsForbidden() then return end
			if not _G.InCombatLockdown() and ElvUI_EltreumUI:IsThisASafeSecret(frame,true) and ElvUI_EltreumUI:IsThisASafeSecret(frame:GetParent(),true) then
				if frame:GetParent() then
					if frame:GetParent().obj then
						if frame:GetParent().obj.label and frame:GetParent().obj.label.SetTextColor then
							if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
								frame:GetParent().obj.label:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
							else
								frame:GetParent().obj.label:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
							end
						end
						if frame:GetParent().obj.titletext and frame:GetParent().obj.titletext.SetTextColor then
							if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
								frame:GetParent().obj.titletext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
							else
								frame:GetParent().obj.titletext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
							end
						end
					end
					if frame:GetParent().label then
						if frame:GetParent().label.SetText then
							if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
								frame:GetParent().label:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
							else
								frame:GetParent().label:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
							end
						end
					end
					if frame:GetParent().titletext then
						if frame:GetParent().titletext.SetText then
							if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
								frame:GetParent().titletext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
							else
								frame:GetParent().titletext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
							end
						end
					end
					if frame:GetParent().Label then
						if frame:GetParent().Label.SetText then
							if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
								frame:GetParent().Label:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
							else
								frame:GetParent().Label:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
							end
						end
					end
				end
			end
			if ElvUI_EltreumUI:IsThisASafeSecret(frame.name,true) and frame.name and frame.name.SetText then
				if frame.objectType and frame.objectType == "item" then
					return
				end
				if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
					frame.name:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
				else
					frame.name:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
				end
			end
			if frame.TitleText and frame.TitleText.SetText then
				if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
					frame.TitleText:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
				else
					frame.TitleText:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
				end
			end
			if frame.TitleContainer and frame.TitleContainer.TitleText and frame.TitleContainer.TitleText.SetText then
				if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
					frame.TitleContainer.TitleText:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
				else
					frame.TitleContainer.TitleText:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
				end
			end
			if frame.Name and frame.Name.SetText and not frame.HotKey then
				if frame.objectType and frame.objectType == "item" then
					return
				end
				if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
					frame.Name:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
				else
					frame.Name:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
				end
			end
			if frame.Header and frame.Header.Text and frame.Header.Text.SetText then
				if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
					frame.Header.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
				else
					frame.Header.Text:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
				end
			end
		end)
	end
end

local function EltruismShadow(frame,template,isNamePlateElement,eltruismDB,parent,grandParent)
	local shadowDB = eltruismDB.skins.shadow
	local shadowLen = shadowDB.length
	if shadowDB.universalshadows and template ~= "NoBackdrop" then
		if frame then
			if frame.backdrop then
				if not frame.backdrop.shadow then
					frame.backdrop:CreateShadow(shadowLen)
					ElvUI_EltreumUI:ShadowColor(frame.backdrop.shadow,shadowDB,isNamePlateElement)
				end
			else
				if not frame.shadow then
					frame:CreateShadow(shadowLen)
					ElvUI_EltreumUI:ShadowColor(frame.shadow,shadowDB,isNamePlateElement)
				end
			end
		end
	else
		if not shadowDB.nameplates then --nameplates
			if frame.unitFrame then return end
			if isNamePlateElement then return end
			if frame.__unit then return end
			if parent and parent.__unit then return end
			if grandParent and grandParent.__unit then return end
		end
		if shadowDB.enable and not eltruismDB.borders.universalborders then
			--saved instances shadow
			if parent and parent.key and parent.key == "SavedInstancesTooltip" then
				if not frame.shadow then
					frame:CreateShadow(shadowLen)
					ElvUI_EltreumUI:ShadowColor(frame.shadow, shadowDB)
				end
			end

			--possible widget shadows
			if grandParent and grandParent.widgetContainer then
				if not frame.shadow then
					frame:CreateShadow(shadowLen)
					ElvUI_EltreumUI:ShadowColor(frame.shadow, shadowDB)
				end
			end

			--new dropdowns?
			if parent and parent.InitScrollLayout then
				if not frame.shadow then
					frame:CreateShadow(shadowLen)
					ElvUI_EltreumUI:ShadowColor(frame.shadow, shadowDB)
				end
			end

			--petbattle
			if parent and parent.PetType then
				if not frame.shadow then
					frame:CreateShadow(shadowLen)
					ElvUI_EltreumUI:ShadowColor(frame.shadow, shadowDB)
				end
			end
			--if ElvUI_EltreumUI:IsThisASafeSecret(frame,true) and ElvUI_EltreumUI:IsThisASafeSecret(nil,nil,true) and ElvUI_EltreumUI:IsThisASafeSecret(frame:GetDebugName(),true) then
			if E.Mists then
				if strfind(frame:GetDebugName(), "PetBattleFrame", 1, true) then
					if not frame.shadow then
						frame:CreateShadow(shadowLen)
						ElvUI_EltreumUI:ShadowColor(frame.shadow, shadowDB)
					end
				end
			end
			if parent and parent == _G["ElvUIPetBattleActionBar"] then
				if not frame.shadow then
					frame:CreateShadow(shadowLen)
					ElvUI_EltreumUI:ShadowColor(frame.shadow, shadowDB)
				end
			end
		end
	end
end

local function SkinFrame(object)
	if not object then return end --rare but not impossible nil error
	--if E:IsSecretValue(object) then return end --seems to throw an error, test without it
	if object:IsForbidden() then return end
	if object:GetObjectType() == "Texture" then object = object:GetParent() end
	local mt = getmetatable(object).__index
	if not mt then return end
	if type(mt) == 'function' then return end
	if mt.SetTemplate and not mt.SetTemplateEltruismHook then
		hooksecurefunc(mt, "SetTemplate", function(frame, template, _, _, _, isUnitFrameElement, isNamePlateElement)
			if frame:GetObjectType() == "CheckButton" and frame.mask then return end --actionbar masks fix
			if frame.bgrElvUISkin then return end --baganator elvui skin

			local eltruismDB = E.db.ElvUI_EltreumUI
			local skinsDB = eltruismDB.skins
			local bordersDB = eltruismDB.borders
			local parent = frame:GetParent()
			local grandParent = parent and parent:GetParent()

			--if frame.showDispellableDebuff then return end --fix RaidDebufs
			if template ~= "NoBackdrop" then
				if skinsDB.elvui.SetTemplate then
					EltruismBackground(frame,isUnitFrameElement,isNamePlateElement)
				end
				if bordersDB.universalborders then
					EltruismBorders(frame,isUnitFrameElement)
				end
			else
				if frame.eltruismbgtexture then
					frame.eltruismbgtexture:Hide()
				end
			end

			if skinsDB.ace3.enable then
				EltruisAce3(frame)
			end
			if skinsDB.shadow.enable then
				EltruismShadow(frame,template,isNamePlateElement,eltruismDB,parent,grandParent)
			end

			--widget things
			if grandParent and not grandParent.EltruismWidgetHook then
				if grandParent.widgetContainer then

					--font/texture
					if grandParent.Label then
						local _,size = grandParent.Label:GetFont()
						grandParent.Label:SetFont(E.LSM:Fetch("font", E.db.general.font), size, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
					end
					if grandParent.Bar and grandParent.Bar.SetStatusBarColor and grandParent.Bar.SetStatusBarTexture then
						local atlas = grandParent.Bar:GetStatusBarTexture():GetAtlas()
						--grandParent.Bar.EltruismAtlas = atlas
						grandParent.Bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
						if eltruismDB.dev then
							ElvUI_EltreumUI:Print("atlas:",atlas)
						end
						if widgetAtlas[atlas] then
							grandParent.Bar:SetStatusBarColor(widgetAtlas[atlas].r,widgetAtlas[atlas].g,widgetAtlas[atlas].b,widgetAtlas[atlas].a)
						end
						if not grandParent.Bar.EltruismColorHook and grandParent.Bar.DisplayBarValue then
							hooksecurefunc(grandParent.Bar, "DisplayBarValue", function(widget)
								local _, maxValue = widget:GetMinMaxValues()
								S:StatusBarColorGradient(widget, widget:GetValue(), maxValue)
								widget.backdrop:SetAlpha(E.db.general.backdropfadecolor.a)
								widget.backdrop:SetBackdropColor(0,0,0)
								widget:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.elvui.widgettexture))
							end)
							grandParent.Bar.EltruismColorHook = true
						end
					end

					-- hook for when label gets added
					if not grandParent.EltruismLabelHook then
						grandParent:HookScript("OnShow", function(widget)
							if widget.Label then
								local _,size = widget.Label:GetFont()
								widget.Label:SetFont(E.LSM:Fetch("font", E.db.general.font), size, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
							end
							if widget.Bar then
								local atlas = widget.Bar:GetStatusBarTexture():GetAtlas()
								if atlas then
									widget.Bar:GetStatusBarTexture():SetColorTexture(widgetAtlas[atlas].r,widgetAtlas[atlas].g,widgetAtlas[atlas].b,widgetAtlas[atlas].a)
									widget.Bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
								end
							end
						end)
						grandParent.EltruismLabelHook = true
					end

					--same as above, but for when its the first parent
					if parent.Label then
						local _,size = parent.Label:GetFont()
						parent.Label:SetFont(E.LSM:Fetch("font", E.db.general.font), size, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
					end
					if parent.Bar then
						local atlas = parent.Bar:GetStatusBarTexture():GetAtlas()
						if atlas then
							parent.Bar:GetStatusBarTexture():SetColorTexture(widgetAtlas[atlas].r,widgetAtlas[atlas].g,widgetAtlas[atlas].b,widgetAtlas[atlas].a)
							parent.Bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
						end
					end

					-- hook for when label gets added
					if not parent.EltruismLabelHook then
						parent:HookScript("OnShow", function(widget)
							if widget.Label then
								local _,size = widget.Label:GetFont()
								widget.Label:SetFont(E.LSM:Fetch("font", E.db.general.font), size, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
							end
							if widget.Bar then
								local atlas = widget.Bar:GetStatusBarTexture():GetAtlas()
								if atlas then
									widget.Bar:GetStatusBarTexture():SetColorTexture(widgetAtlas[atlas].r,widgetAtlas[atlas].g,widgetAtlas[atlas].b,widgetAtlas[atlas].a)
									widget.Bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
								end
							end
						end)
						parent.EltruismLabelHook = true
					end

					grandParent.EltruismWidgetHook = true
				end
			end

			if frame == _G.QuestInfoItemHighlight then --fix the highlight
				frame:SetBackdropBorderColor(1, 1, 0)
				frame:SetBackdropColor(0, 0, 0, 0)
			end
		end)
		mt.SetTemplateEltruismHook = true
	end
end

--based on elvui toolkit
local frametypes = {
	"Frame",
	"Button",
	"StatusBar",
	"GameTooltip",
	"CheckButton",
	"Slider",
	"ScrollFrame",
	"ColorSelect",
	"MessageFrame",
	--[["EditBox", --this taints everything
	"ScrollingMessageFrame",
	"PlayerModel",
	"ModelScene",
	"DressUpModel",
	"Region",
	"Texture",
	"Cooldown",
	"SimpleHTML",
	"TabardModel",
	"Browser",
	"FogOfWarFrame",
	"UnitPositionFrame",
	"MovieFrame",
	"QuestPOIFrame",
	"ScenarioPOIFrame",
	"Minimap",
	]]

	--used to be blocking only:
	--"Region",
	--"Texture",
	--"Cooldown",
	--"Slider",
	--"ScrollFrame",
	--"ModelScene",
}

local function DelayedSetTemplateChatToggle()
	if E.db.ElvUI_EltreumUI.chat.chattoggles then
		if _G.LeftChatToggleButton then
			_G.LeftChatToggleButton:SetAlpha(1)
			_G.LeftChatToggleButton:Show()
		end
		if _G.RightChatToggleButton then
			_G.RightChatToggleButton:SetAlpha(1)
			_G.RightChatToggleButton:Show()
		end
	end
end

function ElvUI_EltreumUI:SetTemplateSkin()
	if self.SetTemplateSkinHooked then return end
	if E.db.ElvUI_EltreumUI.skins.elvui.SetTemplate or E.db.ElvUI_EltreumUI.skins.ace3.enable or E.db.ElvUI_EltreumUI.skins.shadow.enable or E.db.ElvUI_EltreumUI.borders.universalborders then
		if not E.db.ElvUI_EltreumUI.borders.classcolor then --set the variable here so its not spamming
			colorsborders = {
				r = E.db.ElvUI_EltreumUI.borders.bordercolors.r,
				g = E.db.ElvUI_EltreumUI.borders.bordercolors.g,
				b = E.db.ElvUI_EltreumUI.borders.bordercolors.b
			}
		end
		for _, objtype in ipairs(frametypes) do
			local dummyFrame = CreateFrame(objtype)
			SkinFrame(dummyFrame)
		end
		self.SetTemplateSkinHooked = true
		E:UpdateAll()

		E:Delay(10, DelayedSetTemplateChatToggle)
	end
end
