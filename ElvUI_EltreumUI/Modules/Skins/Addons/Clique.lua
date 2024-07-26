local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local unpack = _G.unpack
local pairs = _G.pairs

--skin Clique
function ElvUI_EltreumUI:EltruismClique()
	if E.db.ElvUI_EltreumUI.skins.clique then

		local function SkinClique()
			local frames = {
				_G["CliqueUIBindingFrame"],
				_G["CliqueConfigUIBindingFrameBrowsePage"],
				_G["CliqueConfigUIBindingFrameBrowsePage"] and _G["CliqueConfigUIBindingFrameBrowsePage"].OptionsButton,
				_G["CliqueConfigUIBindingFrameBrowsePage"] and _G["CliqueConfigUIBindingFrameBrowsePage"].QuickbindMode,
				_G["CliqueConfigUIBindingFrameBrowsePage"] and _G["CliqueConfigUIBindingFrameBrowsePage"].EditButton,
				_G["CliqueConfigUIBindingFrameBrowsePage"] and _G["CliqueConfigUIBindingFrameBrowsePage"].AddButton,
				_G["CliqueConfigUISpellbookSearch"],
				_G["CliqueConfigUISpellbookFilterButton"],
				_G["CliqueConfigUIBindingFrameEditPage"],
				_G["CliqueConfigUIBindingFrameEditPage"] and _G["CliqueConfigUIBindingFrameEditPage"].changeBinding,
				_G["CliqueConfigUIBindingFrameEditPage"] and _G["CliqueConfigUIBindingFrameEditPage"].CancelButton,
				_G["CliqueConfigUIBindingFrameEditPage"] and _G["CliqueConfigUIBindingFrameEditPage"].SaveButton,
				_G["CliqueConfigUIBindingFrameEditPage"] and _G["CliqueConfigUIBindingFrameEditPage"].bindSummary,
			}

			if _G["CliqueConfigUIActionCatalogFrame"] then
				local catalogframes = {
					_G["CliqueConfigUIActionCatalogFrame"],
					_G["CliqueConfigUIActionCatalogFrame"].prev,
					_G["CliqueConfigUIActionCatalogFrame"].next,
				}
				if not _G["CliqueConfigUIActionCatalogFrame"].shadow then
					_G["CliqueConfigUIActionCatalogFrame"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G["CliqueConfigUIActionCatalogFrame"].shadow)
				end
				for _, v in pairs(catalogframes) do
					if v then
						if not v.IsSkinned then
							S:HandleFrame(v)
							v.IsSkinned = true
						end
					end
				end

				if _G["CliqueConfigUIActionCatalogFrame"].prev then
					_G["CliqueConfigUIActionCatalogFrame"].prev:SetNormalTexture(E.Media.Textures.ArrowUp)
					_G["CliqueConfigUIActionCatalogFrame"].prev:SetPushedTexture(E.Media.Textures.ArrowUp)
					_G["CliqueConfigUIActionCatalogFrame"].prev:SetDisabledTexture(E.Media.Textures.ArrowUp)
					_G["CliqueConfigUIActionCatalogFrame"].prev:GetNormalTexture():SetRotation(1.57)
					_G["CliqueConfigUIActionCatalogFrame"].prev:GetPushedTexture():SetRotation(1.57)
					_G["CliqueConfigUIActionCatalogFrame"].prev:GetDisabledTexture():SetRotation(1.57)
				end
				if _G["CliqueConfigUIActionCatalogFrame"].next then
					_G["CliqueConfigUIActionCatalogFrame"].next:SetNormalTexture(E.Media.Textures.ArrowUp)
					_G["CliqueConfigUIActionCatalogFrame"].next:SetPushedTexture(E.Media.Textures.ArrowUp)
					_G["CliqueConfigUIActionCatalogFrame"].next:SetDisabledTexture(E.Media.Textures.ArrowUp)
					_G["CliqueConfigUIActionCatalogFrame"].next:GetNormalTexture():SetRotation(-1.57)
					_G["CliqueConfigUIActionCatalogFrame"].next:GetPushedTexture():SetRotation(-1.57)
					_G["CliqueConfigUIActionCatalogFrame"].next:GetDisabledTexture():SetRotation(-1.57)
				end
			end

			if _G["CliqueSpellbookTabButton"] then
				_G["CliqueSpellbookTabButton"]:SetNormalTexture([[Interface\AddOns\Clique\images\icon_square_64]])
				_G["CliqueSpellbookTabButton"]:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
				hooksecurefunc(_G["Clique"],"ShowBindingConfig", function()
					for _, v in pairs(frames) do
						if v then
							if not v.IsSkinned then
								S:HandleFrame(v)
								v.IsSkinned = true
							end
						end
					end
				end)
				for _, v in pairs(frames) do
					if v then
						if not v.IsSkinned then
							S:HandleFrame(v)
							v.IsSkinned = true
						end
					end
				end
			end

			if _G["CliqueConfigUIScrollBar"] then
				S:HandleScrollBar(_G["CliqueConfigUIScrollBar"])
			end

			if E.db.ElvUI_EltreumUI.skins.shadow.enable then
				for _, frame in pairs(frames) do
					if frame and not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(frame.shadow)
					end
				end
			end
		end

		local function fireSkinClique()
			if _G["CliqueSpellbookTabButton"] then
				if not _G["CliqueSpellbookTabButton"].IsSkinned then
					S:HandleFrame(_G["CliqueSpellbookTabButton"])
					_G["CliqueSpellbookTabButton"]:SetNormalTexture([[Interface\AddOns\Clique\images\icon_square_64]])
					_G["CliqueSpellbookTabButton"]:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
					_G["CliqueSpellbookTabButton"].IsSkinned = true
				end
				_G["CliqueSpellbookTabButton"]:HookScript("OnClick", function()
					if not _G["CliqueSpellbookTabButton"].EltruismSkin then
						E:Delay(0.1, SkinClique)
						_G["CliqueSpellbookTabButton"].EltruismSkin = true
					end
				end)
			end
		end

		if E.Retail then
			if _G.PlayerSpellsFrame then
				_G.PlayerSpellsFrame:HookScript("OnShow", function()
					fireSkinClique()
				end)
			else
				S:AddCallbackForAddon('Blizzard_PlayerSpells', "EltruismClique", ElvUI_EltreumUI.EltruismClique)
			end
		else
			fireSkinClique()
		end
	end
end
S:AddCallbackForAddon('Clique', "EltruismClique", ElvUI_EltreumUI.EltruismClique)
--S:AddCallbackForAddon('Blizzard_PlayerSpells', "EltruismClique", ElvUI_EltreumUI.EltruismClique)
