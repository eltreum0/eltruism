local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local CreateFrame = _G.CreateFrame
local GetSpellInfo = _G.GetSpellInfo

--add profession shortcuts to the ElvUI bags, suggested by Xheno
function ElvUI_EltreumUI:BagProfessions()
	if E.db.ElvUI_EltreumUI.otherstuff.bagProfessionIcons then
		if _G["ElvUI_ContainerFrame"] and not _G["ElvUI_ContainerFrame"].EltruismHook then
			_G["ElvUI_ContainerFrame"]:HookScript("OnShow", function()
				if not _G["ElvUI_ContainerFrame"].numButtons then
					_G["ElvUI_ContainerFrame"].numButtons = 0
					if E.Retail then
						local blockprof = {
							[4620674] = true,
							[4620680] = true,
							[4620675] = true,
							[4620679] = true,
							[441139] = true,
						}
						for _,v in ipairs{GetProfessions()} do
							local name, icon, _, _, _, spelloffset = GetProfessionInfo(v)
							if name then
								if not _G["EltruismProfession"..v.."BagButton"] then
									if not blockprof[icon] then
									--[[
										local _,_,spellID =  GetSpellBookItemName(name)
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
										_G["EltruismProfession"..v.."BagButton"]:SetSize(25,25)
										_G["EltruismProfession"..v.."BagButton"]:SetTemplate("Transparent")
										_G["EltruismProfession"..v.."BagButton"]:CreateBackdrop('Transparent')
										S:HandleButton(_G["EltruismProfession"..v.."BagButton"])
										_G["EltruismProfession"..v.."BagButton"]:SetPoint("TOPLEFT", _G["ElvUI_ContainerFrame"],"TOPLEFT", 11+((_G["ElvUI_ContainerFrame"].numButtons-1)*28), -3)
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

						if IsSpellKnown(13262) then
							if not _G["EltruismProfessionDisenchantBagButton"] then
								local _, _, icon = GetSpellInfo(13262)
								_G["ElvUI_ContainerFrame"].numButtons = _G["ElvUI_ContainerFrame"].numButtons + 1
								_G["EltruismProfessionDisenchantBagButton"] = CreateFrame("Button","EltruismProfessionDisenchantBagButton",_G["ElvUI_ContainerFrame"],"SecureActionButtonTemplate")
								_G["EltruismProfessionDisenchantBagButton"]:SetSize(25,25)
								_G["EltruismProfessionDisenchantBagButton"]:SetTemplate("Transparent")
								_G["EltruismProfessionDisenchantBagButton"]:CreateBackdrop('Transparent')
								S:HandleButton(_G["EltruismProfessionDisenchantBagButton"])
								_G["EltruismProfessionDisenchantBagButton"]:SetPoint("TOPLEFT", _G["ElvUI_ContainerFrame"],"TOPLEFT", 11+((_G["ElvUI_ContainerFrame"].numButtons-1)*28), -3)
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
										LCG.PixelGlow_Start(_G["EltruismProfessionDisenchantBagButton"], {0.93, 0.44, 0.97, 1}, 7, 1, 3, 2, 2, 2, false, nil, 6)
										_G["EltruismProfessionDisenchantBagButton"].isGlowing = true
									end
								end)

								--some event handling to get rid of the glow
								_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED","player")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_START","player")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_RETICLE_CLEAR","player")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterEvent("PLAYER_REGEN_DISABLED")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterEvent("PLAYER_REGEN_ENABLED")
								_G["EltruismProfessionDisenchantBagButton"]:SetScript("OnEvent", function(_,event,_,_,spell)
									if event == "UNIT_SPELLCAST_RETICLE_CLEAR" then
										if _G["EltruismProfessionDisenchantBagButton"].isGlowing then
											LCG.PixelGlow_Stop(_G["EltruismProfessionDisenchantBagButton"])
											_G["EltruismProfessionDisenchantBagButton"].isGlowing = false
										end
									elseif event == "PLAYER_REGEN_DISABLED" then
										_G["EltruismProfessionDisenchantBagButton"]:UnregisterEvent("UNIT_SPELLCAST_RETICLE_CLEAR")
										_G["EltruismProfessionDisenchantBagButton"]:UnregisterEvent("UNIT_SPELLCAST_FAILED")
										_G["EltruismProfessionDisenchantBagButton"]:UnregisterEvent("UNIT_SPELLCAST_START")
										if _G["EltruismProfessionDisenchantBagButton"].isGlowing then
											LCG.PixelGlow_Stop(_G["EltruismProfessionDisenchantBagButton"])
											_G["EltruismProfessionDisenchantBagButton"].isGlowing = false
										end
									elseif event == "PLAYER_REGEN_ENABLED" then
										_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_RETICLE_CLEAR","player")
										_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED","player")
										_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_START","player")
									elseif event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_START" then
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
					else
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
						}
						for k, v in ipairs(proftable) do
							if IsSpellKnown(v) then
								if not _G["EltruismProfession"..k.."BagButton"] then
									local name, _, icon = GetSpellInfo(v)
									_G["ElvUI_ContainerFrame"].numButtons = _G["ElvUI_ContainerFrame"].numButtons + 1
									_G["EltruismProfession"..k.."BagButton"] = CreateFrame("Button","EltruismProfession"..k.."BagButton",_G["ElvUI_ContainerFrame"],"SecureActionButtonTemplate")
									_G["EltruismProfession"..k.."BagButton"]:SetSize(25,25)
									_G["EltruismProfession"..k.."BagButton"]:SetTemplate("Transparent")
									_G["EltruismProfession"..k.."BagButton"]:CreateBackdrop('Transparent')
									S:HandleButton(_G["EltruismProfession"..k.."BagButton"])
									_G["EltruismProfession"..k.."BagButton"]:SetPoint("TOPLEFT", _G["ElvUI_ContainerFrame"],"TOPLEFT", 11+((_G["ElvUI_ContainerFrame"].numButtons-1)*28), -3)
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

						if IsSpellKnown(13262) then
							if not _G["EltruismProfessionDisenchantBagButton"] then
								local _, _, icon = GetSpellInfo(13262)
								_G["ElvUI_ContainerFrame"].numButtons = _G["ElvUI_ContainerFrame"].numButtons + 1
								_G["EltruismProfessionDisenchantBagButton"] = CreateFrame("Button","EltruismProfessionDisenchantBagButton",_G["ElvUI_ContainerFrame"],"SecureActionButtonTemplate")
								_G["EltruismProfessionDisenchantBagButton"]:SetSize(25,25)
								_G["EltruismProfessionDisenchantBagButton"]:SetTemplate("Transparent")
								_G["EltruismProfessionDisenchantBagButton"]:CreateBackdrop('Transparent')
								S:HandleButton(_G["EltruismProfessionDisenchantBagButton"])
								_G["EltruismProfessionDisenchantBagButton"]:SetPoint("TOPLEFT", _G["ElvUI_ContainerFrame"],"TOPLEFT", 11+((_G["ElvUI_ContainerFrame"].numButtons-1)*28), -3)
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
										LCG.PixelGlow_Start(_G["EltruismProfessionDisenchantBagButton"], {0.93, 0.44, 0.97, 1}, 7, 1, 3, 2, 2, 2, false, nil, 6)
										_G["EltruismProfessionDisenchantBagButton"].isGlowing = true
									end
								end)

								--some event handling to get rid of the glow
								_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED","player")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_START","player")
								_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED_QUIET","player")
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
										if _G["EltruismProfessionDisenchantBagButton"].isGlowing then
											LCG.PixelGlow_Stop(_G["EltruismProfessionDisenchantBagButton"])
											_G["EltruismProfessionDisenchantBagButton"].isGlowing = false
										end
									elseif event == "PLAYER_REGEN_ENABLED" then
										_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED_QUIET","player")
										_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_FAILED","player")
										_G["EltruismProfessionDisenchantBagButton"]:RegisterUnitEvent("UNIT_SPELLCAST_START","player")
									elseif event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_START" then
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
					end
				end
			end)
			_G["ElvUI_ContainerFrame"].EltruismHook = true
		end
	end
end
