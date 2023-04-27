local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local unpack = _G.unpack
local pairs = _G.pairs

--skin Clique
function ElvUI_EltreumUI:EltruismClique()
	if E.db.ElvUI_EltreumUI.skins.clique then
		local frames = {
			_G["CliqueSpellTab"],
			_G["CliqueConfig"],
			_G["CliqueDialog"],
			_G["CliqueConfigPage1"],
			_G["CliqueScrollFrame"],
			--_G["CliqueRowDropdown"], --doesn't seem to work
			--_G["CliqueOptionsButtonDropdown"], --doesn't seem to work
		}
		for _, v in pairs(frames) do
			S:HandleFrame(v)
		end
		_G["CliqueSpellTab"]:SetNormalTexture([[Interface\AddOns\Clique\images\icon_square_64]])
		_G["CliqueSpellTab"]:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		S:HandleScrollBar(_G["CliqueScrollFrameScrollBar"])

		local buttons = {
			_G["CliqueConfigPage1Column1"],
			_G["CliqueConfigPage1Column2"],
			_G["CliqueConfigPage1ButtonOther"],
			_G["CliqueConfigPage1ButtonSpell"],
			_G["CliqueConfigPage1ButtonOptions"],
			_G["CliqueConfigPage2ButtonBinding"],
			_G["CliqueConfigPage2ButtonSave"],
			_G["CliqueConfigPage2ButtonCancel"],
			_G["CliqueDialogButtonBinding"],
			_G["CliqueDialogButtonAccept"],
		}
		for _, v in pairs(buttons) do
			S:HandleButton(v)
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
end
S:AddCallbackForAddon('Clique', "EltruismClique", ElvUI_EltreumUI.EltruismClique)
