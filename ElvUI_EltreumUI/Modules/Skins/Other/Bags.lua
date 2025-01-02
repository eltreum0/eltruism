local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local CreateFrame = _G.CreateFrame
local GetSpellInfo = _G.C_Spell and _G.C_Spell.GetSpellInfo or _G.GetSpellInfo
local InCombatLockdown = _G.InCombatLockdown
local ipairs = _G.ipairs
local GetProfessions = _G.GetProfessions
local GetProfessionInfo = _G.GetProfessionInfo
local IsSpellKnown = _G.IsSpellKnown
local IsPlayerMoving = _G.IsPlayerMoving
local CastSpell = _G.CastSpell

local function SpellInfo(spellID)
	local spellData = GetSpellInfo(spellID)
	if spellData then
		return spellData.name, spellData.iconID
	else
		return "UNKNOWN", 187874 --fallback value
	end
end

--add profession shortcuts to the ElvUI bags, suggested by Xheno
function ElvUI_EltreumUI:BagProfessions()
	if E.db.ElvUI_EltreumUI.otherstuff.bagProfessionIcons then
		if _G["ElvUI_ContainerFrame"] and not _G["ElvUI_ContainerFrame"].EltruismHook then
			local proftable = {
				[1] = 3101, --Alchemy
				[2] = 2259, --Alchemy
				[3] = 3464, --Alchemy
				[4] = 11611, --Alchemy
				[5] = 28596, --Alchemy
				[6] = 51304, --Alchemy
				[7] = 3100, --Blacksmithing
				[8] = 2018, --Blacksmithing
				[9] = 3538, --Blacksmithing
				[10] = 9785, --Blacksmithing
				[11] = 29844, --Blacksmithing
				[12] = 51300, --Blacksmithing
				[13] = 7411, --Enchanting
				[14] = 7412, --Enchanting
				[15] = 7413, --Enchanting
				[16] = 13920, --Enchanting
				[17] = 28029, --Enchanting
				[18] = 51313, --Enchanting
				--[19] = 13262, --Disenchant
				--[19] = 87067, --cata Disenchant
				[19] = 4036, --Engineering
				[20] = 4037, --Engineering
				[21] = 4038, --Engineering
				[22] = 12656, --Engineering
				[23] = 30350, --Engineering
				[24] = 51306, --Engineering
				[25] = 45357, --Inscription
				[26] = 45358, --Inscription
				[27] = 45359, --Inscription
				[28] = 45360, --Inscription
				[29] = 45361, --Inscription
				[30] = 45363, --Inscription
				[31] = 51005, --Milling
				[32] = 25230, --Jewelcrafting
				[33] = 25229, --Jewelcrafting
				[34] = 28894, --Jewelcrafting
				[35] = 28895, --Jewelcrafting
				[36] = 28897, --Jewelcrafting
				[37] = 51311, --Jewelcrafting
				[38] = 31252, --Prospecting
				[39] = 2108, --Leatherworking
				[40] = 3104, --Leatherworking
				[41] = 3811, --Leatherworking
				[42] = 10662, --Leatherworking
				[43] = 32549, --Leatherworking
				[44] = 51302, --Leatherworking
				[45] = 3908, --Tailoring
				[46] = 3909, --Tailoring
				[47] = 3910, --Tailoring
				[48] = 12180, --Tailoring
				[49] = 26790, --Tailoring
				[50] = 51309, --Tailoring
				[51] = 3273, --First Aid
				[52] = 3274, --First Aid
				[53] = 7924, --First Aid
				[54] = 10846, --First Aid
				[55] = 27028, --First Aid
				[56] = 45542, --First Aid
				[57] = 2550, --Cooking
				[58] = 3102, --Cooking
				[59] = 3413, --Cooking
				[60] = 18260, --Cooking
				[61] = 185, --Cooking
				[62] = 2656, --Smelting
				[63] = 73318, --cata Jewelcrafting
				[64] = 88053, --cata Cooking
				[65] = 74559, --cata First Aid
				[66] = 88424, --cata Smelting
				[67] = 75156, --cata Tailoring
				[68] = 81199, --cata Leatherworking
				[69] = 86008, --cata Inscription
				[70] = 82774, --cata Engineering
				[71] = 74258, --cata Enchanting
				[72] = 76666, --cata Blacksmithing
				[73] = 80731, --cata Alchemy
			}
			local blockprof = {
				[4620674] = true,
				[4620680] = true,
				[4620675] = true,
				[4620679] = true,
				[441139] = true,
			}
			_G["ElvUI_ContainerFrame"]:HookScript("OnShow", function()
				if not _G["ElvUI_ContainerFrame"].numButtons then
					if InCombatLockdown() then return end
					_G["ElvUI_ContainerFrame"].numButtons = 0
					if E.Retail then
						for _,v in ipairs{GetProfessions()} do
							local name, icon, _, _, _, spelloffset = GetProfessionInfo(v)
							if name then
								if not _G["EltruismProfession"..v.."BagButton"] then
									if not blockprof[icon] then
										--[[
											local _,_,spellID = GetSpellBookItemName(name)
											print("original: ",name,icon,spellID)
											if spellID == 264532 then --jewelcrafting
												spellID = 195116
											elseif spellID == 264475 then --engineering
												if IsSpellKnown(195112) then
													spellID = 195112
												elseif IsSpellKnown(264481) then
													spellID = 264481
												elseif IsSpellKnown(264478) then
													spellID = 264478
												elseif IsSpellKnown(4036) then
													spellID = 4036
												end
											elseif spellID == 264494 then --inscription
												spellID = 195115
											elseif spellID == 264577 then --leatherworking
												spellID = 195119
											elseif spellID == 264616 then --tailoring
												if IsSpellKnown(3908) then
													spellID = 3908
												elseif IsSpellKnown(195126) then
													spellID = 195126 --doesnt work
												end
											end
											--spellID = 195128 --cooking
											--print("postfix: ",name,icon,spellID)
										]]
										_G["ElvUI_ContainerFrame"].numButtons = _G["ElvUI_ContainerFrame"].numButtons + 1
										_G["EltruismProfession"..v.."BagButton"] = CreateFrame("Button","EltruismProfession"..v.."BagButton",_G["ElvUI_ContainerFrame"],"SecureActionButtonTemplate")
										_G["EltruismProfession"..v.."BagButton"]:SetSize(21,21)
										_G["EltruismProfession"..v.."BagButton"]:SetTemplate("Transparent")
										_G["EltruismProfession"..v.."BagButton"]:CreateBackdrop('Transparent')
										_G["EltruismProfession"..v.."BagButton"].backdrop.Center:Hide()
										S:HandleButton(_G["EltruismProfession"..v.."BagButton"])
										_G["EltruismProfession"..v.."BagButton"]:SetPoint("BOTTOMLEFT", _G["ElvUI_ContainerFrameEditBox"],"TOPLEFT", (_G["ElvUI_ContainerFrame"].numButtons-1)*28, 3)
										--_G["EltruismProfession"..v.."BagButton"]:SetAttribute('type', 'spell')
										--_G["EltruismProfession"..v.."BagButton"]:SetAttribute('spell', spellID)
										_G["EltruismProfession"..v.."BagButton"]:RegisterForClicks("AnyUp")
										_G["EltruismProfession"..v.."BagButton"].icon = _G["EltruismProfession"..v.."BagButton"]:CreateTexture(nil,"ARTWORK")
										_G["EltruismProfession"..v.."BagButton"].icon:SetTexture(icon)
										_G["EltruismProfession"..v.."BagButton"].icon:SetTexCoord(0.08,0.92,0.08,0.92)
										_G["EltruismProfession"..v.."BagButton"].icon:SetAllPoints()
										--using id has issues since some characters dont actually know the key spells to cast the profession, use OnClick instead
										_G["EltruismProfession"..v.."BagButton"]:SetScript("OnClick", function()
											CastSpell(spelloffset + 1, "Spell")
										end)
									end
								end
							end
						end

						--disenchant
						if IsSpellKnown(13262) then
							if not _G["EltruismProfessionDisenchantBagButton"] then
								local name, icon = SpellInfo(13262)
								--local name, _, icon, _, _, _, spellID = GetSpellInfo(13262)
								_G["ElvUI_ContainerFrame"].numButtons = _G["ElvUI_ContainerFrame"].numButtons + 1
								_G["EltruismProfessionDisenchantBagButton"] = CreateFrame("Button","EltruismProfessionDisenchantBagButton",_G["ElvUI_ContainerFrame"],"SecureActionButtonTemplate")
								_G["EltruismProfessionDisenchantBagButton"]:SetSize(21,21)
								_G["EltruismProfessionDisenchantBagButton"]:SetTemplate("Transparent")
								_G["EltruismProfessionDisenchantBagButton"]:CreateBackdrop('Transparent')
								_G["EltruismProfessionDisenchantBagButton"].backdrop.Center:Hide()
								S:HandleButton(_G["EltruismProfessionDisenchantBagButton"])
								_G["EltruismProfessionDisenchantBagButton"]:SetPoint("BOTTOMLEFT", _G["ElvUI_ContainerFrameEditBox"],"TOPLEFT", (_G["ElvUI_ContainerFrame"].numButtons-1)*28, 3)
								_G["EltruismProfessionDisenchantBagButton"]:SetAttribute('type', 'spell')
								_G["EltruismProfessionDisenchantBagButton"]:SetAttribute('spell', name)
								_G["EltruismProfessionDisenchantBagButton"]:RegisterForClicks("AnyDown")
								_G["EltruismProfessionDisenchantBagButton"].icon = _G["EltruismProfessionDisenchantBagButton"]:CreateTexture(nil,"ARTWORK")
								_G["EltruismProfessionDisenchantBagButton"].icon:SetTexture(icon)
								_G["EltruismProfessionDisenchantBagButton"].icon:SetTexCoord(0.08,0.92,0.08,0.92)
								_G["EltruismProfessionDisenchantBagButton"].icon:SetAllPoints()
								_G["EltruismProfessionDisenchantBagButton"].isGlowing = false

								local LCG = E.Libs.CustomGlow
								_G["EltruismProfessionDisenchantBagButton"]:HookScript("OnClick",function()
									if _G["EltruismProfessionDisenchantBagButton"].isGlowing then
										LCG.PixelGlow_Stop(_G["EltruismProfessionDisenchantBagButton"])
										_G["EltruismProfessionDisenchantBagButton"].isGlowing = false
									else
										if not IsPlayerMoving() then
											LCG.PixelGlow_Start(_G["EltruismProfessionDisenchantBagButton"], {0.93, 0.44, 0.97, 1}, 7, 1, 3, 2, 2, 2, false, nil, 6)
											_G["EltruismProfessionDisenchantBagButton"].isGlowing = true
										end
									end
								end)

								--some event handling to get rid of the glow
								_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED","player")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_START","player")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED_QUIET","player")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED","player")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterEvent("PLAYER_REGEN_DISABLED")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterEvent("PLAYER_REGEN_ENABLED")
								_G["EltruismProfessionDisenchantBagButton"]:SetScript("OnEvent", function(_,event,_,_,spell)
									if event == "UNIT_SPELLCAST_FAILED_QUIET" then
										if _G["EltruismProfessionDisenchantBagButton"].isGlowing then
											LCG.PixelGlow_Stop(_G["EltruismProfessionDisenchantBagButton"])
											_G["EltruismProfessionDisenchantBagButton"].isGlowing = false
										end
									elseif event == "PLAYER_REGEN_DISABLED" then
										_G["EltruismProfessionDisenchantBagButton"]:UnregisterEvent("UNIT_SPELLCAST_FAILED_QUIET")
										_G["EltruismProfessionDisenchantBagButton"]:UnregisterEvent("UNIT_SPELLCAST_FAILED")
										_G["EltruismProfessionDisenchantBagButton"]:UnregisterEvent("UNIT_SPELLCAST_START")
										_G["EltruismProfessionDisenchantBagButton"]:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
										if _G["EltruismProfessionDisenchantBagButton"].isGlowing then
											LCG.PixelGlow_Stop(_G["EltruismProfessionDisenchantBagButton"])
											_G["EltruismProfessionDisenchantBagButton"].isGlowing = false
										end
									elseif event == "PLAYER_REGEN_ENABLED" then
										_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED_QUIET","player")
										_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED","player")
										_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_START","player")
										_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED","player")
									elseif event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_START" then
										if spell == 13262 then
											if _G["EltruismProfessionDisenchantBagButton"].isGlowing then
												LCG.PixelGlow_Stop(_G["EltruismProfessionDisenchantBagButton"])
												_G["EltruismProfessionDisenchantBagButton"].isGlowing = false
											end
										end
									elseif event == "UNIT_SPELLCAST_INTERRUPTED" then
										if spell == 13262 then
											if _G["EltruismProfessionDisenchantBagButton"].isGlowing then
												LCG.PixelGlow_Stop(_G["EltruismProfessionDisenchantBagButton"])
												_G["EltruismProfessionDisenchantBagButton"].isGlowing = false
											end
										end
									end
								end)
							end
						end

						--lockpick
						if IsSpellKnown(1804) then
							if not _G["EltruismProfessionLockpickBagButton"] then
								local name, icon = SpellInfo(1804)
								--local name, _, icon, _, _, _, spellID = GetSpellInfo(13262)
								_G["ElvUI_ContainerFrame"].numButtons = _G["ElvUI_ContainerFrame"].numButtons + 1
								_G["EltruismProfessionLockpickBagButton"] = CreateFrame("Button","EltruismProfessionLockpickBagButton",_G["ElvUI_ContainerFrame"],"SecureActionButtonTemplate")
								_G["EltruismProfessionLockpickBagButton"]:SetSize(21,21)
								_G["EltruismProfessionLockpickBagButton"]:SetTemplate("Transparent")
								_G["EltruismProfessionLockpickBagButton"]:CreateBackdrop('Transparent')
								_G["EltruismProfessionLockpickBagButton"].backdrop.Center:Hide()
								S:HandleButton(_G["EltruismProfessionLockpickBagButton"])
								_G["EltruismProfessionLockpickBagButton"]:SetPoint("BOTTOMLEFT", _G["ElvUI_ContainerFrameEditBox"],"TOPLEFT", (_G["ElvUI_ContainerFrame"].numButtons-1)*28, 3)
								_G["EltruismProfessionLockpickBagButton"]:SetAttribute('type', 'spell')
								_G["EltruismProfessionLockpickBagButton"]:SetAttribute('spell', name)
								_G["EltruismProfessionLockpickBagButton"]:RegisterForClicks("AnyDown")
								_G["EltruismProfessionLockpickBagButton"].icon = _G["EltruismProfessionLockpickBagButton"]:CreateTexture(nil,"ARTWORK")
								_G["EltruismProfessionLockpickBagButton"].icon:SetTexture(icon)
								_G["EltruismProfessionLockpickBagButton"].icon:SetTexCoord(0.08,0.92,0.08,0.92)
								_G["EltruismProfessionLockpickBagButton"].icon:SetAllPoints()
								_G["EltruismProfessionLockpickBagButton"].isGlowing = false

								local LCG = E.Libs.CustomGlow
								--some event handling to get rid of the glow
								_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED","player")
								_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED","player")
								_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_RETICLE_CLEAR","player")
								_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_RETICLE_TARGET","player")
								_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED","player")
								_G["EltruismProfessionLockpickBagButton"]:RegisterEvent("PLAYER_REGEN_DISABLED")
								_G["EltruismProfessionLockpickBagButton"]:RegisterEvent("PLAYER_REGEN_ENABLED")
								_G["EltruismProfessionLockpickBagButton"]:SetScript("OnEvent", function(_,event,_,_,spell)
									if event == "UNIT_SPELLCAST_RETICLE_CLEAR" then
										if _G["EltruismProfessionLockpickBagButton"].isGlowing then
											LCG.PixelGlow_Stop(_G["EltruismProfessionLockpickBagButton"])
											_G["EltruismProfessionLockpickBagButton"].isGlowing = false
										end
									elseif event == "PLAYER_REGEN_DISABLED" then
										_G["EltruismProfessionLockpickBagButton"]:UnregisterEvent("UNIT_SPELLCAST_RETICLE_CLEAR")
										_G["EltruismProfessionLockpickBagButton"]:UnregisterEvent("UNIT_SPELLCAST_RETICLE_TARGET")
										_G["EltruismProfessionLockpickBagButton"]:UnregisterEvent("UNIT_SPELLCAST_FAILED")
										_G["EltruismProfessionLockpickBagButton"]:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
										_G["EltruismProfessionLockpickBagButton"]:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
										if _G["EltruismProfessionLockpickBagButton"].isGlowing then
											LCG.PixelGlow_Stop(_G["EltruismProfessionLockpickBagButton"])
											_G["EltruismProfessionLockpickBagButton"].isGlowing = false
										end
									elseif event == "PLAYER_REGEN_ENABLED" then
										_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_RETICLE_CLEAR","player")
										_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_RETICLE_TARGET","player")
										_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED","player")
										_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED","player")
										_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED","player")
									elseif event == "UNIT_SPELLCAST_FAILED" then
										if spell == 1804 then
											if _G["EltruismProfessionLockpickBagButton"].isGlowing then
												LCG.PixelGlow_Stop(_G["EltruismProfessionLockpickBagButton"])
												_G["EltruismProfessionLockpickBagButton"].isGlowing = false
											end
										end
									elseif event == "UNIT_SPELLCAST_INTERRUPTED" then
										if spell == 1804 then
											if _G["EltruismProfessionLockpickBagButton"].isGlowing then
												LCG.PixelGlow_Stop(_G["EltruismProfessionLockpickBagButton"])
												_G["EltruismProfessionLockpickBagButton"].isGlowing = false
											end
										end
									elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
										if spell == 1804 then
											if _G["EltruismProfessionLockpickBagButton"].isGlowing then
												LCG.PixelGlow_Stop(_G["EltruismProfessionLockpickBagButton"])
												_G["EltruismProfessionLockpickBagButton"].isGlowing = false
											end
										end
									elseif event == "UNIT_SPELLCAST_RETICLE_TARGET" then
										if spell == 1804 then
											LCG.PixelGlow_Start(_G["EltruismProfessionLockpickBagButton"], {1, 0.96, 0.41, 1}, 7, 1, 3, 2, 2, 2, false, nil, 6)
											_G["EltruismProfessionLockpickBagButton"].isGlowing = true
										end
									end
								end)
							end
						end
					else
						for k, v in ipairs(proftable) do
							if IsSpellKnown(v) then
								if not _G["EltruismProfession"..k.."BagButton"] then
									local name, icon = SpellInfo(v)
									_G["ElvUI_ContainerFrame"].numButtons = _G["ElvUI_ContainerFrame"].numButtons + 1
									_G["EltruismProfession"..k.."BagButton"] = CreateFrame("Button","EltruismProfession"..k.."BagButton",_G["ElvUI_ContainerFrame"],"SecureActionButtonTemplate")
									_G["EltruismProfession"..k.."BagButton"]:SetSize(21,21)
									_G["EltruismProfession"..k.."BagButton"]:SetTemplate("Transparent")
									_G["EltruismProfession"..k.."BagButton"]:CreateBackdrop('Transparent')
									_G["EltruismProfession"..k.."BagButton"].backdrop.Center:Hide()
									S:HandleButton(_G["EltruismProfession"..k.."BagButton"])
									_G["EltruismProfession"..k.."BagButton"]:SetPoint("BOTTOMLEFT", _G["ElvUI_ContainerFrameEditBox"],"TOPLEFT", (_G["ElvUI_ContainerFrame"].numButtons-1)*28, 3)
									_G["EltruismProfession"..k.."BagButton"]:SetAttribute('type', 'spell')
									_G["EltruismProfession"..k.."BagButton"]:SetAttribute('spell', name)
									_G["EltruismProfession"..k.."BagButton"]:RegisterForClicks("AnyUp")
									_G["EltruismProfession"..k.."BagButton"].icon = _G["EltruismProfession"..k.."BagButton"]:CreateTexture(nil,"ARTWORK")
									_G["EltruismProfession"..k.."BagButton"].icon:SetTexture(icon)
									_G["EltruismProfession"..k.."BagButton"].icon:SetTexCoord(0.08,0.92,0.08,0.92)
									_G["EltruismProfession"..k.."BagButton"].icon:SetAllPoints()
								end
							end
						end

						--disenchant
						if IsSpellKnown(13262) then
							if not _G["EltruismProfessionDisenchantBagButton"] then
								local _, icon = SpellInfo(13262)
								_G["ElvUI_ContainerFrame"].numButtons = _G["ElvUI_ContainerFrame"].numButtons + 1
								_G["EltruismProfessionDisenchantBagButton"] = CreateFrame("Button","EltruismProfessionDisenchantBagButton",_G["ElvUI_ContainerFrame"],"SecureActionButtonTemplate")
								_G["EltruismProfessionDisenchantBagButton"]:SetSize(21,21)
								_G["EltruismProfessionDisenchantBagButton"]:SetTemplate("Transparent")
								_G["EltruismProfessionDisenchantBagButton"]:CreateBackdrop('Transparent')
								_G["EltruismProfessionDisenchantBagButton"].backdrop.Center:Hide()
								S:HandleButton(_G["EltruismProfessionDisenchantBagButton"])
								_G["EltruismProfessionDisenchantBagButton"]:SetPoint("BOTTOMLEFT", _G["ElvUI_ContainerFrameEditBox"],"TOPLEFT", (_G["ElvUI_ContainerFrame"].numButtons-1)*28, 3)
								_G["EltruismProfessionDisenchantBagButton"]:SetAttribute('type', 'spell')
								_G["EltruismProfessionDisenchantBagButton"]:SetAttribute('spell', 13262)
								_G["EltruismProfessionDisenchantBagButton"]:RegisterForClicks("AnyUp")
								_G["EltruismProfessionDisenchantBagButton"].icon = _G["EltruismProfessionDisenchantBagButton"]:CreateTexture(nil,"ARTWORK")
								_G["EltruismProfessionDisenchantBagButton"].icon:SetTexture(icon)
								_G["EltruismProfessionDisenchantBagButton"].icon:SetTexCoord(0.08,0.92,0.08,0.92)
								_G["EltruismProfessionDisenchantBagButton"].icon:SetAllPoints()
								_G["EltruismProfessionDisenchantBagButton"].isGlowing = false

								local LCG = E.Libs.CustomGlow
								_G["EltruismProfessionDisenchantBagButton"]:HookScript("OnClick",function()
									if _G["EltruismProfessionDisenchantBagButton"].isGlowing then
										LCG.PixelGlow_Stop(_G["EltruismProfessionDisenchantBagButton"])
										_G["EltruismProfessionDisenchantBagButton"].isGlowing = false
									else
										if not IsPlayerMoving() then
											LCG.PixelGlow_Start(_G["EltruismProfessionDisenchantBagButton"], {0.93, 0.44, 0.97, 1}, 7, 1, 3, 2, 2, 2, false, nil, 6)
											_G["EltruismProfessionDisenchantBagButton"].isGlowing = true
										end
									end
								end)

								--some event handling to get rid of the glow
								_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED","player")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_START","player")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED_QUIET","player")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED","player")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterEvent("PLAYER_REGEN_DISABLED")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterEvent("PLAYER_REGEN_ENABLED")
								_G["EltruismProfessionDisenchantBagButton"]:SetScript("OnEvent", function(_,event,_,_,spell)
									if event == "UNIT_SPELLCAST_FAILED_QUIET" then
										if _G["EltruismProfessionDisenchantBagButton"].isGlowing then
											LCG.PixelGlow_Stop(_G["EltruismProfessionDisenchantBagButton"])
											_G["EltruismProfessionDisenchantBagButton"].isGlowing = false
										end
									elseif event == "PLAYER_REGEN_DISABLED" then
										_G["EltruismProfessionDisenchantBagButton"]:UnregisterEvent("UNIT_SPELLCAST_FAILED_QUIET")
										_G["EltruismProfessionDisenchantBagButton"]:UnregisterEvent("UNIT_SPELLCAST_FAILED")
										_G["EltruismProfessionDisenchantBagButton"]:UnregisterEvent("UNIT_SPELLCAST_START")
										_G["EltruismProfessionDisenchantBagButton"]:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
										if _G["EltruismProfessionDisenchantBagButton"].isGlowing then
											LCG.PixelGlow_Stop(_G["EltruismProfessionDisenchantBagButton"])
											_G["EltruismProfessionDisenchantBagButton"].isGlowing = false
										end
									elseif event == "PLAYER_REGEN_ENABLED" then
										_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED_QUIET","player")
										_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED","player")
										_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_START","player")
										_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED","player")
									elseif event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_START" then
										if spell == 13262 then
											if _G["EltruismProfessionDisenchantBagButton"].isGlowing then
												LCG.PixelGlow_Stop(_G["EltruismProfessionDisenchantBagButton"])
												_G["EltruismProfessionDisenchantBagButton"].isGlowing = false
											end
										end
									elseif event == "UNIT_SPELLCAST_INTERRUPTED" then
										if spell == 13262 then
											if _G["EltruismProfessionDisenchantBagButton"].isGlowing then
												LCG.PixelGlow_Stop(_G["EltruismProfessionDisenchantBagButton"])
												_G["EltruismProfessionDisenchantBagButton"].isGlowing = false
											end
										end
									end
								end)
							end
						end

						--lockpick
						if IsSpellKnown(1804) then
							if not _G["EltruismProfessionLockpickBagButton"] then
								local _, icon = SpellInfo(1804)
								_G["ElvUI_ContainerFrame"].numButtons = _G["ElvUI_ContainerFrame"].numButtons + 1
								_G["EltruismProfessionLockpickBagButton"] = CreateFrame("Button","EltruismProfessionLockpickBagButton",_G["ElvUI_ContainerFrame"],"SecureActionButtonTemplate")
								_G["EltruismProfessionLockpickBagButton"]:SetSize(21,21)
								_G["EltruismProfessionLockpickBagButton"]:SetTemplate("Transparent")
								_G["EltruismProfessionLockpickBagButton"]:CreateBackdrop('Transparent')
								_G["EltruismProfessionLockpickBagButton"].backdrop.Center:Hide()
								S:HandleButton(_G["EltruismProfessionLockpickBagButton"])
								_G["EltruismProfessionLockpickBagButton"]:SetPoint("BOTTOMLEFT", _G["ElvUI_ContainerFrameEditBox"],"TOPLEFT", (_G["ElvUI_ContainerFrame"].numButtons-1)*28, 3)
								_G["EltruismProfessionLockpickBagButton"]:SetAttribute('type', 'spell')
								_G["EltruismProfessionLockpickBagButton"]:SetAttribute('spell', 1804)
								_G["EltruismProfessionLockpickBagButton"]:RegisterForClicks("AnyUp")
								_G["EltruismProfessionLockpickBagButton"].icon = _G["EltruismProfessionLockpickBagButton"]:CreateTexture(nil,"ARTWORK")
								_G["EltruismProfessionLockpickBagButton"].icon:SetTexture(icon)
								_G["EltruismProfessionLockpickBagButton"].icon:SetTexCoord(0.08,0.92,0.08,0.92)
								_G["EltruismProfessionLockpickBagButton"].icon:SetAllPoints()
								_G["EltruismProfessionLockpickBagButton"].isGlowing = false

								local LCG = E.Libs.CustomGlow
								_G["EltruismProfessionLockpickBagButton"]:HookScript("OnClick",function()
									if _G["EltruismProfessionLockpickBagButton"].isGlowing then
										LCG.PixelGlow_Stop(_G["EltruismProfessionLockpickBagButton"])
										_G["EltruismProfessionLockpickBagButton"].isGlowing = false
									else
										if not IsPlayerMoving() then
											LCG.PixelGlow_Start(_G["EltruismProfessionLockpickBagButton"], {1, 0.96, 0.41, 1}, 7, 1, 3, 2, 2, 2, false, nil, 6)
											_G["EltruismProfessionLockpickBagButton"].isGlowing = true
										end
									end
								end)

								--some event handling to get rid of the glow
								_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED","player")
								_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_START","player")
								_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED_QUIET","player")
								_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED","player")
								_G["EltruismProfessionLockpickBagButton"]:RegisterEvent("PLAYER_REGEN_DISABLED")
								_G["EltruismProfessionLockpickBagButton"]:RegisterEvent("PLAYER_REGEN_ENABLED")
								_G["EltruismProfessionLockpickBagButton"]:SetScript("OnEvent", function(_,event,_,_,spell)
									if event == "UNIT_SPELLCAST_FAILED_QUIET" then
										if _G["EltruismProfessionLockpickBagButton"].isGlowing then
											LCG.PixelGlow_Stop(_G["EltruismProfessionLockpickBagButton"])
											_G["EltruismProfessionLockpickBagButton"].isGlowing = false
										end
									elseif event == "PLAYER_REGEN_DISABLED" then
										_G["EltruismProfessionLockpickBagButton"]:UnregisterEvent("UNIT_SPELLCAST_FAILED_QUIET")
										_G["EltruismProfessionLockpickBagButton"]:UnregisterEvent("UNIT_SPELLCAST_FAILED")
										_G["EltruismProfessionLockpickBagButton"]:UnregisterEvent("UNIT_SPELLCAST_START")
										_G["EltruismProfessionLockpickBagButton"]:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
										if _G["EltruismProfessionLockpickBagButton"].isGlowing then
											LCG.PixelGlow_Stop(_G["EltruismProfessionLockpickBagButton"])
											_G["EltruismProfessionLockpickBagButton"].isGlowing = false
										end
									elseif event == "PLAYER_REGEN_ENABLED" then
										_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED_QUIET","player")
										_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED","player")
										_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_START","player")
										_G["EltruismProfessionLockpickBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED","player")
									elseif event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_START" then
										if spell == 1804 then
											if _G["EltruismProfessionLockpickBagButton"].isGlowing then
												LCG.PixelGlow_Stop(_G["EltruismProfessionLockpickBagButton"])
												_G["EltruismProfessionLockpickBagButton"].isGlowing = false
											end
										end
									elseif event == "UNIT_SPELLCAST_INTERRUPTED" then
										if spell == 1804 then
											if _G["EltruismProfessionLockpickBagButton"].isGlowing then
												LCG.PixelGlow_Stop(_G["EltruismProfessionLockpickBagButton"])
												_G["EltruismProfessionLockpickBagButton"].isGlowing = false
											end
										end
									end
								end)
							end
						end
					end
				end
			end)
			_G["ElvUI_ContainerFrame"].EltruismHook = true

			local combatcheck = CreateFrame("Frame")
			combatcheck:RegisterEvent("PLAYER_REGEN_DISABLED")
			combatcheck:RegisterEvent("PLAYER_REGEN_ENABLED")
			combatcheck:SetScript("OnEvent", function(_, event)
				if event == "PLAYER_REGEN_DISABLED" then
					if _G["ElvUI_ContainerFrame"].numButtons then
						if E.Retail then
							for _,v in ipairs{GetProfessions()} do
								if _G["EltruismProfession"..v.."BagButton"] then
									_G["EltruismProfession"..v.."BagButton"]:ClearAllPoints()
									_G["EltruismProfession"..v.."BagButton"]:SetParent()
									_G["EltruismProfession"..v.."BagButton"]:Hide()
								end
							end
						else
							for k, v in ipairs(proftable) do
								if IsSpellKnown(v) then
									if _G["EltruismProfession"..k.."BagButton"] then
										_G["EltruismProfession"..k.."BagButton"]:ClearAllPoints()
										_G["EltruismProfession"..k.."BagButton"]:SetParent()
										_G["EltruismProfession"..k.."BagButton"]:Hide()
									end
								end
							end
						end
						if _G["EltruismProfessionDisenchantBagButton"] then
							_G["EltruismProfessionDisenchantBagButton"]:ClearAllPoints()
							_G["EltruismProfessionDisenchantBagButton"]:SetParent()
							_G["EltruismProfessionDisenchantBagButton"]:Hide()
						end
						if _G["EltruismProfessionLockpickBagButton"] then
							_G["EltruismProfessionLockpickBagButton"]:ClearAllPoints()
							_G["EltruismProfessionLockpickBagButton"]:SetParent()
							_G["EltruismProfessionLockpickBagButton"]:Hide()
						end
						_G["ElvUI_ContainerFrame"].numButtons = 0
					end
				elseif event == "PLAYER_REGEN_ENABLED" then
					if _G["ElvUI_ContainerFrame"].numButtons then
						_G["ElvUI_ContainerFrame"].numButtons = 0
						if E.Retail then
							for _,v in ipairs{GetProfessions()} do
								local name, icon = GetProfessionInfo(v)
								if name and not blockprof[icon] then
									_G["ElvUI_ContainerFrame"].numButtons = _G["ElvUI_ContainerFrame"].numButtons + 1
									if _G["EltruismProfession"..v.."BagButton"] then
										_G["EltruismProfession"..v.."BagButton"]:SetPoint("BOTTOMLEFT", _G["ElvUI_ContainerFrameEditBox"],"TOPLEFT", (_G["ElvUI_ContainerFrame"].numButtons-1)*28, 3)
										_G["EltruismProfession"..v.."BagButton"]:SetParent(_G["ElvUI_ContainerFrame"])
										_G["EltruismProfession"..v.."BagButton"]:Show()
									end
								end
							end
						else
							for k, v in ipairs(proftable) do
								if IsSpellKnown(v) then
									if _G["EltruismProfession"..k.."BagButton"] then
										_G["ElvUI_ContainerFrame"].numButtons = _G["ElvUI_ContainerFrame"].numButtons + 1
										_G["EltruismProfession"..k.."BagButton"]:SetPoint("BOTTOMLEFT", _G["ElvUI_ContainerFrameEditBox"],"TOPLEFT", (_G["ElvUI_ContainerFrame"].numButtons-1)*28, 3)
										_G["EltruismProfession"..k.."BagButton"]:SetParent(_G["ElvUI_ContainerFrame"])
										_G["EltruismProfession"..k.."BagButton"]:Show()
									end
								end
							end
						end
						if _G["EltruismProfessionDisenchantBagButton"] then
							_G["ElvUI_ContainerFrame"].numButtons = _G["ElvUI_ContainerFrame"].numButtons + 1
							_G["EltruismProfessionDisenchantBagButton"]:SetPoint("BOTTOMLEFT", _G["ElvUI_ContainerFrameEditBox"],"TOPLEFT", (_G["ElvUI_ContainerFrame"].numButtons-1)*28, 3)
							_G["EltruismProfessionDisenchantBagButton"]:SetParent(_G["ElvUI_ContainerFrame"])
							_G["EltruismProfessionDisenchantBagButton"]:Show()
						end
						if _G["EltruismProfessionLockpickBagButton"] then
							_G["ElvUI_ContainerFrame"].numButtons = _G["ElvUI_ContainerFrame"].numButtons + 1
							_G["EltruismProfessionLockpickBagButton"]:SetPoint("BOTTOMLEFT", _G["ElvUI_ContainerFrameEditBox"],"TOPLEFT", (_G["ElvUI_ContainerFrame"].numButtons-1)*28, 3)
							_G["EltruismProfessionLockpickBagButton"]:SetParent(_G["ElvUI_ContainerFrame"])
							_G["EltruismProfessionLockpickBagButton"]:Show()
						end
					end
				end
			end)
		end
	end
end
