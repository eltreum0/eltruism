local E = unpack(ElvUI)
local _G = _G
local TT = E:GetModule('Tooltip')
local string = _G.string
local format = string.format
local UnitIsTapDenied = _G.UnitIsTapDenied
local UnitPlayerControlled = _G.UnitPlayerControlled
local UnitIsPlayer = _G.UnitIsPlayer
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local GetItemInfo = _G.C_Item and _G.C_Item.GetItemInfo or _G.GetItemInfo
local GetItemQualityColor = _G.C_Item and _G.C_Item.GetItemQualityColor or _G.GetItemQualityColor
local GameTooltip = _G.GameTooltip
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local UnitInPartyIsAI = _G.UnitInPartyIsAI

--gradient tooltip healthbar
local function GameTooltipStatusBarGradient(unit, classunit, reaction)
	local db = E.db.ElvUI_EltreumUI.unitframes.gradientmode
	local tex = _G.GameTooltipStatusBar:GetStatusBarTexture()
	local minC, maxC

	if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
		if db.customcolor then
			minC, maxC = ElvUI_EltreumUI:GradientColorsCustom(classunit, false, false)
		else
			minC, maxC = ElvUI_EltreumUI:GradientColors(classunit, false, false)
		end
		tex:SetGradient(db.orientation, minC, maxC)
	else
		if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
			if db.customcolor then
				minC, maxC = ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, false)
			else
				minC, maxC = ElvUI_EltreumUI:GradientColors("TAPPED", false, false)
			end
			tex:SetGradient(db.orientation, minC, maxC)
		elseif reaction then
			local reactionKey
			if reaction >= 5 then
				reactionKey = "NPCFRIENDLY"
			elseif reaction == 4 then
				reactionKey = "NPCNEUTRAL"
			elseif reaction == 3 then
				reactionKey = "NPCUNFRIENDLY"
			elseif reaction <= 2 then
				reactionKey = "NPCHOSTILE"
			end

			if reactionKey then
				if db.customcolor then
					minC, maxC = ElvUI_EltreumUI:GradientColorsCustom(reactionKey, false, false)
				else
					minC, maxC = ElvUI_EltreumUI:GradientColors(reactionKey, false, false)
				end
				tex:SetGradient(db.orientation, minC, maxC)
			end
		end
	end
end

--gradient tooltip text
local function SetTooltipGradient(unit)
	if not unit or not E.private.tooltip.enable or not E.db.ElvUI_EltreumUI.skins.gradienttooltip then return end
	if GameTooltip and GameTooltip:IsForbidden() then return end
	if not ElvUI_EltreumUI:IsThisASafeSecret() or not ElvUI_EltreumUI:IsThisASafeSecret(unit, true) then return end

	local _, classunit = UnitClass(unit)
	if not classunit or not ElvUI_EltreumUI:IsThisASafeSecret(classunit, true) or not E:NotSecretValue(classunit) then return end

	local reaction = UnitReaction(unit, "player")
	local textLeft1 = _G["GameTooltipTextLeft1"]
	local tooltipname = textLeft1 and textLeft1:GetText()

	if tooltipname and ElvUI_EltreumUI:IsThisASafeSecret(tooltipname, true) then
		tooltipname = E:StripString(tooltipname)
		if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
			textLeft1:SetText(ElvUI_EltreumUI:GradientName(tooltipname, classunit))
		elseif reaction then
			local reactionKey
			if reaction >= 5 then
				reactionKey = "NPCFRIENDLY"
			elseif reaction == 4 then
				reactionKey = "NPCNEUTRAL"
			elseif reaction == 3 then
				reactionKey = "NPCUNFRIENDLY"
			elseif reaction <= 2 then
				reactionKey = "NPCHOSTILE"
			end
			if reactionKey then
				textLeft1:SetText(ElvUI_EltreumUI:GradientName(tooltipname, reactionKey))
			end
		end
	end

	GameTooltipStatusBarGradient(unit, classunit, reaction)
end

local function ApplyTooltipItemFormatting(tooltip, tooltipName, isShopping)
	local name, itemLink = tooltip:GetItem()
	if not name or not itemLink then return end

	local itemName, _, itemQuality, itemLevel, _, _, _, _, _, _, _, classID = GetItemInfo(itemLink)
	name = (name == "") and itemName or name --so apparently name can return empty, get name from item info in that case

	local db = E.db.ElvUI_EltreumUI.skins
	local isClassicIlvl = (E.Classic or E.Wrath or E.TBC or E.Forever) and db.ilvltooltip

	local targetLineName = isShopping and (tooltipName .. "TextLeft2") or "GameTooltipTextLeft2"
	local rightLineName = isShopping and (tooltipName .. "TextRight2") or "GameTooltipTextRight2"
	local mainLineName = isShopping and targetLineName or "GameTooltipTextLeft1"

	local mainLineFrame = _G[mainLineName]
	local mainText = mainLineFrame and mainLineFrame:GetText()

	if isClassicIlvl then
		local lineFrame = _G[targetLineName]
		local lineText = lineFrame and lineFrame:GetText()

		if lineText and not lineText:match(_G.ITEM_LEVEL) and itemLevel and (classID == 2 or classID == 4) then
			lineFrame:SetText(format("%s|r\n|cfffece00%s", lineText, format(_G.ITEM_LEVEL, itemLevel)))
			--tooltip:AddLine(stringformat(ITEM_LEVEL, itemLevel))
			--tooltip:AppendText("("..itemLevel..")")
			if isShopping then
				lineFrame:SetJustifyH("LEFT")
			end
			local rightFrame = _G[rightLineName]
			local rightText = rightFrame and rightFrame:GetText()
			if rightText then
				rightFrame:SetText(format("\n%s ", rightText))
			end
		end
	end

	if db.gradienttooltip and itemQuality then
		local r2, g2, b2 = GetItemQualityColor(itemQuality)
		local offset1, offset2 = db.gradienttooltipoffset1, db.gradienttooltipoffset2
		local r1, g1, b1 = E:Clamp(r2 + offset1, 0, 1), E:Clamp(g2 + offset1, 0, 1), E:Clamp(b2 + offset1, 0, 1)
		r2, g2, b2 = E:Clamp(r2 + offset2, 0, 1), E:Clamp(g2 + offset2, 0, 1), E:Clamp(b2 + offset2, 0, 1)

		if mainText and ElvUI_EltreumUI:IsThisASafeSecret(mainText, true) then
			local icon = _G.strmatch(mainText, "^.-|t")
			local gradientName = E:TextGradient(name, r1, g1, b1, r2, g2, b2)
			mainLineFrame:SetText(icon and format("%s %s", icon, gradientName) or gradientName)
		else
			mainLineFrame:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
		end
	end
end

--skin tooltip
function ElvUI_EltreumUI:Tooltip()
	if GameTooltip and GameTooltip:IsForbidden() then return end
	if not IsAddOnLoaded("ElvUI_EltreumUI") or not E.db.ElvUI_EltreumUI then return end

	--gradient
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.private.tooltip.enable and E.db.ElvUI_EltreumUI.skins.gradienttooltip then
		if not ElvUI_EltreumUI.tooltipStatusBarHooked then
			_G.GameTooltipStatusBar:HookScript("OnShow", function()
				local unittp = TT:GetDisplayedUnit(_G.GameTooltip)
				if unittp and E:NotSecretValue(unittp) then
					SetTooltipGradient(unittp)
				end
			end)
			ElvUI_EltreumUI.tooltipStatusBarHooked = true
		end

		local fixunit = TT:GetDisplayedUnit(_G.GameTooltip)
		if fixunit and E:NotSecretValue(fixunit) then
			SetTooltipGradient(fixunit)
		end
	end

	--ilvl tooltip & gradient
	if E.Modern then
		if E.db.ElvUI_EltreumUI.skins.gradienttooltip and not ElvUI_EltreumUI.EltruismTooltipHook then
			_G.TooltipDataProcessor.AddTooltipPostCall(_G.Enum.TooltipDataType.Item, function(tt)
				if tt then ApplyTooltipItemFormatting(GameTooltip, "GameTooltip", false) end
			end)
			ElvUI_EltreumUI.EltruismTooltipHook = true
		end
	else
		if E.db.ElvUI_EltreumUI.skins.ilvltooltip or E.db.ElvUI_EltreumUI.skins.gradienttooltip then
			if not GameTooltip.EltruismTooltipHook then
				GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
					ApplyTooltipItemFormatting(tooltip, "GameTooltip", false)
				end)
				GameTooltip.EltruismTooltipHook = true
			end

			if not _G.ShoppingTooltip1.EltruismTooltipHook then
				_G.ShoppingTooltip1:HookScript("OnTooltipSetItem", function(tooltip)
					ApplyTooltipItemFormatting(tooltip, "ShoppingTooltip1", true)
				end)
				_G.ShoppingTooltip1.EltruismTooltipHook = true
			end

			if not _G.ShoppingTooltip2.EltruismTooltipHook then
				_G.ShoppingTooltip2:HookScript("OnTooltipSetItem", function(tooltip)
					ApplyTooltipItemFormatting(tooltip, "ShoppingTooltip2", true)
				end)
				_G.ShoppingTooltip2.EltruismTooltipHook = true
			end
		end
	end
end
ElvUI_EltreumUI:SecureHook(TT, 'AddTargetInfo', 'Tooltip')
ElvUI_EltreumUI:SecureHook(TT, 'GameTooltip_OnTooltipSetUnit', 'Tooltip')
ElvUI_EltreumUI:SecureHook(TT, 'MODIFIER_STATE_CHANGED', 'Tooltip')
ElvUI_EltreumUI:SecureHook(TT, 'GameTooltipStatusBar_UpdateUnitHealth', 'Tooltip')
