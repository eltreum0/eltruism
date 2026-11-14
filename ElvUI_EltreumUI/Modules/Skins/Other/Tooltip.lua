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
local GameTooltipStatusBar = _G.GameTooltipStatusBar
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local canaccessvalue = _G.canaccessvalue

local isTooltipGradientEnabled = false
local GameTooltipTextLeft1 = _G.GameTooltipTextLeft1

--resolve tooltip class or reaction color key
local function ResolveTooltipColorKey(unit, reaction, isPlayer)
	if isPlayer then
		local _, classunit = UnitClass(unit)
		if not classunit or not canaccessvalue(classunit) then return nil end
		return classunit
	end

	if reaction then
		if reaction >= 5 then
			return "NPCFRIENDLY"
		elseif reaction == 4 then
			return "NPCNEUTRAL"
		elseif reaction == 3 then
			return "NPCUNFRIENDLY"
		elseif reaction <= 2 then
			return "NPCHOSTILE"
		end
	end

	return nil
end

--gradient tooltip healthbar
local function GameTooltipStatusBarGradient(unit, isPlayer, colorKey)
	local db = E.db.ElvUI_EltreumUI.unitframes.gradientmode
	local statusBar = GameTooltipStatusBar or _G.GameTooltipStatusBar
	if not statusBar then return end
	GameTooltipStatusBar = statusBar
	local tex = statusBar:GetStatusBarTexture()
	if not tex then return end

	local lookupKey = colorKey
	if not isPlayer and UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
		lookupKey = "TAPPED"
	end
	if not lookupKey then return end

	local minC, maxC
	if db.customcolor then
		minC, maxC = ElvUI_EltreumUI:GradientColorsCustom(lookupKey, false, false)
	else
		minC, maxC = ElvUI_EltreumUI:GradientColors(lookupKey, false, false)
	end
	tex:SetGradient(db.orientation, minC, maxC)
end

--gradient tooltip text
local function SetTooltipGradient(unit, updateText)
	if not unit then return end
	if not isTooltipGradientEnabled and (not E.private.tooltip.enable or not E.db.ElvUI_EltreumUI.skins.gradienttooltip or not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable) then return end
	if GameTooltip and GameTooltip:IsForbidden() then return end
	if not ElvUI_EltreumUI:IsThisASafeSecret() or not canaccessvalue(unit) then return end

	local isPlayer = UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))
	local reaction = not isPlayer and UnitReaction(unit, "player") or nil
	local colorKey = ResolveTooltipColorKey(unit, reaction, isPlayer)
	if not colorKey and isPlayer then return end

	if updateText then
		local textLeft1 = GameTooltipTextLeft1 or _G["GameTooltipTextLeft1"]
		if textLeft1 then
			GameTooltipTextLeft1 = textLeft1
			local tooltipname = textLeft1:GetText()
			if tooltipname and canaccessvalue(tooltipname) then
				if colorKey and (tooltipname ~= textLeft1.EltruismLastGradientText or colorKey ~= textLeft1.EltruismLastColorKey) then
					local strippedName = E:StripString(tooltipname)
					local gradientText = ElvUI_EltreumUI:GradientName(strippedName, colorKey)
					if gradientText then
						textLeft1:SetText(gradientText)
						textLeft1.EltruismLastGradientText = gradientText
						textLeft1.EltruismLastColorKey = colorKey
					end
				end
			end
		end
	end

	GameTooltipStatusBarGradient(unit, isPlayer, colorKey)
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

--clear cached tooltip gradient text
function ElvUI_EltreumUI:ClearTooltipGradientCache()
	local textLeft1 = GameTooltipTextLeft1 or _G["GameTooltipTextLeft1"]
	if textLeft1 then
		textLeft1.EltruismLastGradientText = nil
		textLeft1.EltruismLastColorKey = nil
	end
end

--gradient tooltip
function ElvUI_EltreumUI:TooltipGradient()
	if GameTooltip and GameTooltip:IsForbidden() then return end
	if not E.db.ElvUI_EltreumUI then return end

	local fixunit = TT:GetDisplayedUnit(_G.GameTooltip)
	if fixunit and canaccessvalue(fixunit) then
		SetTooltipGradient(fixunit, true)
	end
end

--gradient tooltip status bar only (health updates)
function ElvUI_EltreumUI:TooltipStatusBarGradient()
	if not isTooltipGradientEnabled then return end
	local statusBar = GameTooltipStatusBar or _G.GameTooltipStatusBar
	if not statusBar or not statusBar:IsShown() then return end
	if not GameTooltip or GameTooltip:IsForbidden() or not GameTooltip:IsShown() then return end
	GameTooltipStatusBar = statusBar

	local fixunit = TT:GetDisplayedUnit(GameTooltip)
	if fixunit and canaccessvalue(fixunit) then
		SetTooltipGradient(fixunit, false)
	end
end

--backward compatibility alias
function ElvUI_EltreumUI:Tooltip()
	ElvUI_EltreumUI:TooltipGradient()
end

--hook or unhook unit tooltip gradient
function ElvUI_EltreumUI:TooltipGradientHook()
	if not TT or not E.db.ElvUI_EltreumUI then return end
	if not E.private then return end
	if not E.private.tooltip then return end
	if not E.db.ElvUI_EltreumUI.unitframes then return end
	if not E.db.ElvUI_EltreumUI.unitframes.gradientmode then return end
	if not E.db.ElvUI_EltreumUI.skins then return end

	isTooltipGradientEnabled = (E.private.tooltip.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.skins.gradienttooltip) and true or false

	if isTooltipGradientEnabled then
		if E.Modern and not ElvUI_EltreumUI.EltruismTooltipUnitHooked then
			_G.TooltipDataProcessor.AddTooltipPostCall(_G.Enum.TooltipDataType.Unit, function(tt)
				if tt == GameTooltip and isTooltipGradientEnabled then
					ElvUI_EltreumUI:TooltipGradient()
				end
			end)
			ElvUI_EltreumUI.EltruismTooltipUnitHooked = true
		end
		if not self:IsHooked(TT, 'AddTargetInfo') then
			self:SecureHook(TT, 'AddTargetInfo', 'TooltipGradient')
		end
		if not self:IsHooked(TT, 'GameTooltip_OnTooltipSetUnit') then
			self:SecureHook(TT, 'GameTooltip_OnTooltipSetUnit', 'TooltipGradient')
		end
		if not self:IsHooked(TT, 'MODIFIER_STATE_CHANGED') then
			self:SecureHook(TT, 'MODIFIER_STATE_CHANGED', 'TooltipGradient')
		end
		if not self:IsHooked(TT, 'GameTooltipStatusBar_UpdateUnitHealth') then
			self:SecureHook(TT, 'GameTooltipStatusBar_UpdateUnitHealth', 'TooltipStatusBarGradient')
		end
		if _G.GameTooltipStatusBar and not self:IsHooked(_G.GameTooltipStatusBar, 'OnShow') then
			self:SecureHookScript(_G.GameTooltipStatusBar, 'OnShow', 'TooltipStatusBarGradient')
		end

		local fixunit = TT:GetDisplayedUnit(_G.GameTooltip)
		if fixunit and E:NotSecretValue(fixunit) then
			SetTooltipGradient(fixunit, true)
		end
	else
		ElvUI_EltreumUI:ClearTooltipGradientCache()
		if self:IsHooked(TT, 'AddTargetInfo') then
			self:Unhook(TT, 'AddTargetInfo')
		end
		if self:IsHooked(TT, 'GameTooltip_OnTooltipSetUnit') then
			self:Unhook(TT, 'GameTooltip_OnTooltipSetUnit')
		end
		if self:IsHooked(TT, 'MODIFIER_STATE_CHANGED') then
			self:Unhook(TT, 'MODIFIER_STATE_CHANGED')
		end
		if self:IsHooked(TT, 'GameTooltipStatusBar_UpdateUnitHealth') then
			self:Unhook(TT, 'GameTooltipStatusBar_UpdateUnitHealth')
		end
		if _G.GameTooltipStatusBar and self:IsHooked(_G.GameTooltipStatusBar, 'OnShow') then
			self:Unhook(_G.GameTooltipStatusBar, 'OnShow')
		end
	end
end

--item tooltip hook helpers for non-modern
local function OnTooltipSetItem_GameTooltip(tooltip)
	ApplyTooltipItemFormatting(tooltip, "GameTooltip", false)
end

local function OnTooltipSetItem_Shopping1(tooltip)
	ApplyTooltipItemFormatting(tooltip, "ShoppingTooltip1", true)
end

local function OnTooltipSetItem_Shopping2(tooltip)
	ApplyTooltipItemFormatting(tooltip, "ShoppingTooltip2", true)
end

--hook or unhook item tooltip formatting
function ElvUI_EltreumUI:TooltipItemHook()
	if not E.db.ElvUI_EltreumUI then return end

	if E.Modern then
		if not ElvUI_EltreumUI.EltruismTooltipItemHooked then
			_G.TooltipDataProcessor.AddTooltipPostCall(_G.Enum.TooltipDataType.Item, function(tt)
				if tt and E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.skins.gradienttooltip then
					ApplyTooltipItemFormatting(GameTooltip, "GameTooltip", false)
				end
			end)
			ElvUI_EltreumUI.EltruismTooltipItemHooked = true
		end
	else
		local enable = E.db.ElvUI_EltreumUI.skins.ilvltooltip or E.db.ElvUI_EltreumUI.skins.gradienttooltip
		if enable then
			if GameTooltip and not self:IsHooked(GameTooltip, "OnTooltipSetItem") then
				self:SecureHookScript(GameTooltip, "OnTooltipSetItem", OnTooltipSetItem_GameTooltip)
			end
			if _G.ShoppingTooltip1 and not self:IsHooked(_G.ShoppingTooltip1, "OnTooltipSetItem") then
				self:SecureHookScript(_G.ShoppingTooltip1, "OnTooltipSetItem", OnTooltipSetItem_Shopping1)
			end
			if _G.ShoppingTooltip2 and not self:IsHooked(_G.ShoppingTooltip2, "OnTooltipSetItem") then
				self:SecureHookScript(_G.ShoppingTooltip2, "OnTooltipSetItem", OnTooltipSetItem_Shopping2)
			end
		else
			if GameTooltip and self:IsHooked(GameTooltip, "OnTooltipSetItem") then
				self:Unhook(GameTooltip, "OnTooltipSetItem")
			end
			if _G.ShoppingTooltip1 and self:IsHooked(_G.ShoppingTooltip1, "OnTooltipSetItem") then
				self:Unhook(_G.ShoppingTooltip1, "OnTooltipSetItem")
			end
			if _G.ShoppingTooltip2 and self:IsHooked(_G.ShoppingTooltip2, "OnTooltipSetItem") then
				self:Unhook(_G.ShoppingTooltip2, "OnTooltipSetItem")
			end
		end
	end
end

--initialize tooltip hooks
function ElvUI_EltreumUI:InitTooltip()
	ElvUI_EltreumUI:TooltipGradientHook()
	ElvUI_EltreumUI:TooltipItemHook()
end

if E.db and E.db.ElvUI_EltreumUI then
	ElvUI_EltreumUI:InitTooltip()
end
