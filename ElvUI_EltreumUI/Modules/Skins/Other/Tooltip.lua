local E = unpack(ElvUI)
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local TT = E:GetModule('Tooltip')
local string = _G.string
local UnitIsTapDenied = _G.UnitIsTapDenied
local UnitPlayerControlled = _G.UnitPlayerControlled
local UnitIsPlayer = _G.UnitIsPlayer
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local GetItemInfo = _G.C_Item and _G.C_Item.GetItemInfo or _G.GetItemInfo
local GetItemQualityColor = _G.C_Item and _G.C_Item.GetItemQualityColor or _G.GetItemQualityColor
local GameTooltip = _G.GameTooltip
local ElvUI_EltreumUI = _G.ElvUI_EltreumUI
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

--gradient tooltip health
local function SetTooltipGradient(unit)
	if not unit then return end
	if not E.private.tooltip.enable then return end
	if E.db.ElvUI_EltreumUI.skins.gradienttooltip then
		local _, classunit = UnitClass(unit)
		local reaction = UnitReaction(unit, "player")
		if GameTooltip and GameTooltip:IsForbidden() then return end

		local tooltipname = _G["GameTooltipTextLeft1"]:GetText()
		if tooltipname and classunit and reaction then
			tooltipname = E:StripString(tooltipname)
			if (UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))) and classunit then
				_G["GameTooltipTextLeft1"]:SetText(ElvUI_EltreumUI:GradientName(tooltipname, classunit))
			else
				if reaction and reaction >= 5 then
					_G["GameTooltipTextLeft1"]:SetText(ElvUI_EltreumUI:GradientName(tooltipname, "NPCFRIENDLY"))
				elseif reaction and reaction == 4 then
					_G["GameTooltipTextLeft1"]:SetText(ElvUI_EltreumUI:GradientName(tooltipname, "NPCNEUTRAL"))
				elseif reaction and reaction == 3 then
					_G["GameTooltipTextLeft1"]:SetText(ElvUI_EltreumUI:GradientName(tooltipname, "NPCUNFRIENDLY"))
				elseif reaction and reaction == 2 or reaction == 1 then
					_G["GameTooltipTextLeft1"]:SetText(ElvUI_EltreumUI:GradientName(tooltipname, "NPCHOSTILE"))
				end
			end
		end

		if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
				_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, false))
			else
				_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, false))
			end
		else
			if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
					_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, false))
				else
					_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, false))
				end
			else
				if reaction and reaction >= 5 then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
						_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, false))
					else
						_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, false))
					end
				elseif reaction and reaction == 4 then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
						_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, false))
					else
						_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, false))
					end
				elseif reaction and reaction == 3 then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
						_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, false))
					else
						_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, false))
					end
				elseif reaction and reaction <= 2 then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
						_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, false))
					else
						_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, false))
					end
				end
			end
		end
	end
end

--skin tooltip
function ElvUI_EltreumUI:Tooltip()
	if (GameTooltip and GameTooltip:IsForbidden()) then return end
	if not IsAddOnLoaded("ElvUI_EltreumUI") then return end
	if not E.db.ElvUI_EltreumUI then return end

	--gradient
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.private.tooltip.enable and E.db.ElvUI_EltreumUI.skins.gradienttooltip then
		if not self.isHooked then
			_G.GameTooltipStatusBar:HookScript("OnShow", function()
				local _,unittp = _G.GameTooltip:GetUnit()
				if unittp then
					SetTooltipGradient(unittp)
				end
			end)
			self.isHooked = true
		end

		local _, fixunit = _G.GameTooltip:GetUnit()
		if fixunit then
			SetTooltipGradient(fixunit)
		end
	end

	--ilvl tooltip & gradient
	if E.Retail then
		if E.db.ElvUI_EltreumUI.skins.gradienttooltip and not self.EltruismTooltipHook then
			TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tt)
				if tt then
					local name,itemLink = GameTooltip:GetItem()
					if not name then return end
					if not itemLink then return end
					local _, _, itemQuality = GetItemInfo(itemLink)
					if not itemQuality then return end
					local r2,g2,b2 = GetItemQualityColor(itemQuality)
					local r1 = r2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset1
					r1 = ElvUI_EltreumUI:Interval(r1, 0, 1)
					local g1 = g2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset1
					g1 = ElvUI_EltreumUI:Interval(g1, 0, 1)
					local b1 = b2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset1
					b1 = ElvUI_EltreumUI:Interval(b1, 0, 1)
					r2 = r2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset2
					r2 = ElvUI_EltreumUI:Interval(r2, 0, 1)
					g2 = g2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset2
					g2 = ElvUI_EltreumUI:Interval(g2, 0, 1)
					b2 = b2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset2
					b2 = ElvUI_EltreumUI:Interval(b2, 0, 1)
					if _G["GameTooltipTextLeft1"]:GetText() ~= nil then
						local icon = strmatch(_G["GameTooltipTextLeft1"]:GetText(), "^.-|t")
						if icon then
							_G["GameTooltipTextLeft1"]:SetText(icon .. " " .. E:TextGradient(name, r1, g1, b1, r2, g2, b2))
						else
							_G["GameTooltipTextLeft1"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
						end
					else
						_G["GameTooltipTextLeft1"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
					end
				end
			end)
			self.EltruismTooltipHook = true
		end
	else
		if (E.db.ElvUI_EltreumUI.skins.ilvltooltip or E.db.ElvUI_EltreumUI.skins.gradienttooltip) then
			if not GameTooltip.EltruismTooltipHook then
				GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
					local name,itemLink = tooltip:GetItem()
					if not name then return end
					if not itemLink then return end
					local itemName, _, itemQuality, itemLevel, _, _, _, _, _, _, _, classID = GetItemInfo(itemLink)

					--so apparently name can return empty, get name from item info in that case
					if name == "" then
						name = itemName
					end

					if E.db.ElvUI_EltreumUI.skins.ilvltooltip then
						local line = _G["GameTooltipTextLeft2"]:GetText()
						if line and not line:match(ITEM_LEVEL) then
							if (itemLink ~= nil) then
								if itemLevel and (classID == 2 or classID == 4)then
									local lefttext = _G["GameTooltipTextLeft2"]:GetText()
									_G["GameTooltipTextLeft2"]:SetText("|cfffece00"..string.format(ITEM_LEVEL, itemLevel).."|r\n"..lefttext)
									if _G["GameTooltipTextRight2"] then
										local righttext = _G["GameTooltipTextRight2"]:GetText()
										if righttext then
											_G["GameTooltipTextRight2"]:SetText("\n"..righttext.." ") --without the space the text truncates
										end
									end
								end
							end
						end
					end

					if E.db.ElvUI_EltreumUI.skins.gradienttooltip then
						if not itemQuality then return end
						local r2,g2,b2 = GetItemQualityColor(itemQuality)
						local r1 = r2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset1
						r1 = ElvUI_EltreumUI:Interval(r1, 0, 1)
						local g1 = g2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset1
						g1 = ElvUI_EltreumUI:Interval(g1, 0, 1)
						local b1 = b2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset1
						b1 = ElvUI_EltreumUI:Interval(b1, 0, 1)
						r2 = r2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset2
						r2 = ElvUI_EltreumUI:Interval(r2, 0, 1)
						g2 = g2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset2
						g2 = ElvUI_EltreumUI:Interval(g2, 0, 1)
						b2 = b2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset2
						b2 = ElvUI_EltreumUI:Interval(b2, 0, 1)
						if b2 < 0 then b2 = 0 elseif b2 > 1 then b2 = 1 end
						if _G["GameTooltipTextLeft1"]:GetText() ~= nil then
							local icon = strmatch(_G["GameTooltipTextLeft1"]:GetText(), "^.-|t")
							if icon then
								_G["GameTooltipTextLeft1"]:SetText(icon .. " " .. E:TextGradient(name, r1, g1, b1, r2, g2, b2))
							else
								_G["GameTooltipTextLeft1"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
							end
						else
							_G["GameTooltipTextLeft1"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
						end
					end
				end)
				GameTooltip.EltruismTooltipHook = true
			end

			if not _G.ShoppingTooltip1.EltruismTooltipHook then
				_G.ShoppingTooltip1:HookScript("OnTooltipSetItem", function(tooltip)
					if E.db.ElvUI_EltreumUI.skins.ilvltooltip then --CURRENTLY_EQUIPPED
						local line = _G["ShoppingTooltip1TextLeft2"]:GetText()
						if line and not line:match(ITEM_LEVEL) then
							local _, itemLink = tooltip:GetItem()
							if (itemLink ~= nil) then
								local _, _, _, itemLevel, _, _, _, _, _, _, _, classID = GetItemInfo(itemLink)
								if itemLevel and (classID == 2 or classID == 4) then
									--tooltip:AddLine(string.format(ITEM_LEVEL, itemLevel))
									--tooltip:AppendText("("..itemLevel..")")
									local lefttext = _G["ShoppingTooltip1TextLeft2"]:GetText()
									_G["ShoppingTooltip1TextLeft2"]:SetText(lefttext.."|r\n".."|cfffece00"..string.format(ITEM_LEVEL, itemLevel))
									_G["ShoppingTooltip1TextLeft2"]:SetJustifyH("LEFT")
									if _G["ShoppingTooltip1TextRight2"] and _G["ShoppingTooltip1TextRight2"]:GetText() then
										local righttext = _G["ShoppingTooltip1TextRight2"]:GetText()
										if righttext then
											_G["ShoppingTooltip1TextRight2"]:SetText("\n"..righttext.." ") --without the space the text truncates
										end
									end
								end
							end
						end
					end
					if E.db.ElvUI_EltreumUI.skins.gradienttooltip then
						local name,itemLink = _G.ShoppingTooltip1:GetItem()
						if not name then return end
						if not itemLink then return end
						local _, _, itemQuality = GetItemInfo(itemLink)
						if not itemQuality then return end
						local r2,g2,b2 = GetItemQualityColor(itemQuality)
						local r1 = r2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset1
						r1 = ElvUI_EltreumUI:Interval(r1, 0, 1)
						local g1 = g2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset1
						g1 = ElvUI_EltreumUI:Interval(g1, 0, 1)
						local b1 = b2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset1
						b1 = ElvUI_EltreumUI:Interval(b1, 0, 1)
						r2 = r2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset2
						r2 = ElvUI_EltreumUI:Interval(r2, 0, 1)
						g2 = g2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset2
						g2 = ElvUI_EltreumUI:Interval(g2, 0, 1)
						b2 = b2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset2
						b2 = ElvUI_EltreumUI:Interval(b2, 0, 1)

						if E.db.ElvUI_EltreumUI.skins.ilvltooltip then
							local _, _, _, itemLevel, _, _, _, _, _, _, _, classID = GetItemInfo(itemLink)
							if itemLevel and (classID == 2 or classID == 4) then
								if _G["ShoppingTooltip1TextLeft2"]:GetText() ~= nil then
									local icon = strmatch(_G["ShoppingTooltip1TextLeft2"]:GetText(), "^.-|t")
									if icon then
										_G["ShoppingTooltip1TextLeft2"]:SetText(icon .. " " .. E:TextGradient(name, r1, g1, b1, r2, g2, b2).."|r\n".."|cfffece00"..string.format(ITEM_LEVEL, itemLevel))
									else
										_G["ShoppingTooltip1TextLeft2"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2).."|r\n".."|cfffece00"..string.format(ITEM_LEVEL, itemLevel))
									end
									_G["ShoppingTooltip1TextLeft2"]:SetJustifyH("LEFT")
									if _G["ShoppingTooltip1TextRight2"] and _G["ShoppingTooltip1TextRight2"]:GetText() then
										local righttext = _G["ShoppingTooltip1TextRight2"]:GetText()
										if righttext then
											_G["ShoppingTooltip1TextRight2"]:SetText("\n"..righttext.." ") --without the space the text truncates
										end
									end
								else
									_G["ShoppingTooltip1TextLeft2"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
								end
							else
								if _G["ShoppingTooltip1TextLeft2"]:GetText() ~= nil then
									local icon = strmatch(_G["ShoppingTooltip1TextLeft2"]:GetText(), "^.-|t")
									if icon then
										_G["ShoppingTooltip1TextLeft2"]:SetText(icon .. " " .. E:TextGradient(name, r1, g1, b1, r2, g2, b2))
									else
										_G["ShoppingTooltip1TextLeft2"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
									end
								else
									_G["ShoppingTooltip1TextLeft2"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
								end
							end
						else
							if _G["ShoppingTooltip1TextLeft1"]:GetText() ~= nil then
								local icon = strmatch(_G["ShoppingTooltip1TextLeft2"]:GetText(), "^.-|t")
								if icon then
									_G["ShoppingTooltip1TextLeft2"]:SetText(icon .. " " .. E:TextGradient(name, r1, g1, b1, r2, g2, b2))
								else
									_G["ShoppingTooltip1TextLeft2"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
								end
							else
								_G["ShoppingTooltip1TextLeft2"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
							end
						end
					end
				end)
				_G.ShoppingTooltip1.EltruismTooltipHook = true
			end

			if not _G.ShoppingTooltip2.EltruismTooltipHook then
				_G.ShoppingTooltip2:HookScript("OnTooltipSetItem", function(tooltip)
					if E.db.ElvUI_EltreumUI.skins.ilvltooltip then --CURRENTLY_EQUIPPED
						local line = _G["ShoppingTooltip2TextLeft2"]:GetText()
						if line and not line:match(ITEM_LEVEL) then
							local _, itemLink = tooltip:GetItem()
							if (itemLink ~= nil) then
								local _, _, _, itemLevel, _, _, _, _, _, _, _, classID = GetItemInfo(itemLink)
								if itemLevel and (classID == 2 or classID == 4) then
									--tooltip:AddLine(string.format(ITEM_LEVEL, itemLevel))
									--tooltip:AppendText("("..itemLevel..")")
									local lefttext = _G["ShoppingTooltip2TextLeft2"]:GetText()
									_G["ShoppingTooltip2TextLeft2"]:SetText(lefttext.."|r\n".."|cfffece00"..string.format(ITEM_LEVEL, itemLevel))
									_G["ShoppingTooltip2TextLeft2"]:SetJustifyH("LEFT")
									if _G["ShoppingTooltip2TextRight2"] and _G["ShoppingTooltip2TextRight2"]:GetText() then
										local righttext = _G["ShoppingTooltip2TextRight2"]:GetText()
										if righttext then
											_G["ShoppingTooltip2TextRight2"]:SetText("\n"..righttext.." ") --without the space the text truncates
										end
									end
								end
							end
						end
					end
					if E.db.ElvUI_EltreumUI.skins.gradienttooltip then
						local name,itemLink = _G.ShoppingTooltip2:GetItem()
						if not name then return end
						if not itemLink then return end
						local _, _, itemQuality = GetItemInfo(itemLink)
						if not itemQuality then return end
						local r2,g2,b2 = GetItemQualityColor(itemQuality)
						local r1 = r2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset1
						r1 = ElvUI_EltreumUI:Interval(r1, 0, 1)
						local g1 = g2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset1
						g1 = ElvUI_EltreumUI:Interval(g1, 0, 1)
						local b1 = b2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset1
						b1 = ElvUI_EltreumUI:Interval(b1, 0, 1)
						r2 = r2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset2
						r2 = ElvUI_EltreumUI:Interval(r2, 0, 1)
						g2 = g2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset2
						g2 = ElvUI_EltreumUI:Interval(g2, 0, 1)
						b2 = b2 + E.db.ElvUI_EltreumUI.skins.gradienttooltipoffset2
						b2 = ElvUI_EltreumUI:Interval(b2, 0, 1)

						if E.db.ElvUI_EltreumUI.skins.ilvltooltip then
							local _, _, _, itemLevel, _, _, _, _, _, _, _, classID = GetItemInfo(itemLink)
							if itemLevel and (classID == 2 or classID == 4) then
								if _G["ShoppingTooltip2TextLeft2"]:GetText() ~= nil then
									local icon = strmatch(_G["ShoppingTooltip2TextLeft2"]:GetText(), "^.-|t")
									if icon then
										_G["ShoppingTooltip2TextLeft2"]:SetText(icon .. " " .. E:TextGradient(name, r1, g1, b1, r2, g2, b2).."|r\n".."|cfffece00"..string.format(ITEM_LEVEL, itemLevel))
									else
										_G["ShoppingTooltip2TextLeft2"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2).."|r\n".."|cfffece00"..string.format(ITEM_LEVEL, itemLevel))
									end
									_G["ShoppingTooltip2TextLeft2"]:SetJustifyH("LEFT")
									if _G["ShoppingTooltip2TextRight2"] and _G["ShoppingTooltip2TextRight2"]:GetText() then
										local righttext = _G["ShoppingTooltip2TextRight2"]:GetText()
										if righttext then
											_G["ShoppingTooltip2TextRight2"]:SetText("\n"..righttext.." ") --without the space the text truncates
										end
									end
								else
									_G["ShoppingTooltip2TextLeft2"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
								end
							else
								if _G["ShoppingTooltip2TextLeft2"]:GetText() ~= nil then
									local icon = strmatch(_G["ShoppingTooltip2TextLeft2"]:GetText(), "^.-|t")
									if icon then
										_G["ShoppingTooltip2TextLeft2"]:SetText(icon .. " " .. E:TextGradient(name, r1, g1, b1, r2, g2, b2))
									else
										_G["ShoppingTooltip2TextLeft2"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
									end
								else
									_G["ShoppingTooltip2TextLeft2"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
								end
							end
						else
							if _G["ShoppingTooltip2TextLeft1"]:GetText() ~= nil then
								local icon = strmatch(_G["ShoppingTooltip2TextLeft2"]:GetText(), "^.-|t")
								if icon then
									_G["ShoppingTooltip2TextLeft2"]:SetText(icon .. " " .. E:TextGradient(name, r1, g1, b1, r2, g2, b2))
								else
									_G["ShoppingTooltip2TextLeft2"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
								end
							else
								_G["ShoppingTooltip2TextLeft2"]:SetText(E:TextGradient(name, r1, g1, b1, r2, g2, b2))
							end
						end
					end
				end)
				_G.ShoppingTooltip2.EltruismTooltipHook = true
			end
		end
	end
end
hooksecurefunc(TT, 'AddTargetInfo', ElvUI_EltreumUI.Tooltip)
hooksecurefunc(TT, 'GameTooltip_OnTooltipSetUnit', ElvUI_EltreumUI.Tooltip)
hooksecurefunc(TT, 'MODIFIER_STATE_CHANGED', ElvUI_EltreumUI.Tooltip)
