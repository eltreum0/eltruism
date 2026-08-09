local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local pairs = _G.pairs
local hooksecurefunc = _G.hooksecurefunc

--skin bugsack
function ElvUI_EltreumUI:EltruismBugSack()
	if E.db.ElvUI_EltreumUI.skins.bugsack then
		--frame doesnt get created at start, but with a function, hook to skin
		hooksecurefunc(_G.BugSack,"OpenSack",function()
			if not _G["BugSackFrame"].IsSkinned then
				S:HandleFrame(_G["BugSackFrame"])
				S:HandleScrollBar(_G["BugSackScrollScrollBar"])

				S:HandleButton(_G["BugSackNextButton"])
				_G["BugSackNextButton"]:ClearAllPoints()
				_G["BugSackNextButton"]:Point('BOTTOMRIGHT', _G["BugSackFrame"], 'BOTTOMRIGHT', -12, 6)
				S:HandleButton(_G["BugSackPrevButton"])
				_G["BugSackPrevButton"]:ClearAllPoints()
				_G["BugSackPrevButton"]:Point('BOTTOMLEFT', _G["BugSackFrame"], 'BOTTOMLEFT', 12, 6)
				S:HandleButton(_G["BugSackSendButton"])

				S:HandleTab(_G["BugSackTabSession"])
				_G["BugSackTabSession"]:ClearAllPoints()
				_G["BugSackTabSession"]:Point('CENTER', _G["BugSackFrame"], 'BOTTOM', 0, -16)
				S:HandleTab(_G["BugSackTabAll"])
				_G["BugSackTabAll"]:ClearAllPoints()
				_G["BugSackTabAll"]:Point('LEFT', _G["BugSackTabSession"], 'RIGHT', -5, 0)
				S:HandleTab(_G["BugSackTabLast"])
				_G["BugSackTabLast"]:ClearAllPoints()
				_G["BugSackTabLast"]:Point('RIGHT', _G["BugSackTabSession"], 'LEFT', 5, 0)


				if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
					local frames = {
						_G["BugSackFrame"],
						_G["BugSackTabAll"].backdrop,
						_G["BugSackTabSession"].backdrop,
						_G["BugSackTabLast"].backdrop,
					}
					for _, frame in pairs(frames) do
						if frame and not frame.shadow then
							frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(frame.shadow)
						end
					end
				end

				--ty luckyone for the idea, modified with ElvUI functions and Eltruism version listing
				-- Game version left of page count (top right)
				local countLabel
				for i = 1, _G["BugSackFrame"]:GetNumRegions() do
					local region = select(i, _G["BugSackFrame"]:GetRegions())
					if region and region:IsObjectType('FontString') and region:GetJustifyH() == 'RIGHT' then
						countLabel = region
						break
					end
				end

				if countLabel then
					local _, elvVersion = E:ParseVersionString('ElvUI')
					local classColor = E:ClassColor(E.myclass)
					local hex = E:RGBToHex(classColor.r, classColor.g, classColor.b, '|cff')
					local versionLabel = _G["BugSackFrame"]:CreateFontString(nil, 'ARTWORK')
					versionLabel:SetFontObject(countLabel:GetFontObject())
					versionLabel:SetTextColor(countLabel:GetTextColor())
					versionLabel:SetText(_G.format('%sElvUI:|r %s %sEltruism:|r %s %sPatch:|r %s %sPage:|r', hex, elvVersion, hex, ElvUI_EltreumUI.Version, hex, _G.GetBuildInfo(), hex))
					versionLabel:SetPoint('RIGHT', countLabel, 'LEFT', -6, 0)
				end

				_G["BugSackFrame"].IsSkinned = true

				--from addonskins
				for _, v in pairs({_G["BugSackFrame"]:GetChildren()}) do
					if (v:IsObjectType('Button') and v:GetScript('OnClick') == _G.BugSack.CloseSack) then
						S:HandleCloseButton(v)
						break
					end
				end
			end
		end)
	end
end
S:AddCallbackForAddon('BugSack', "EltruismBugSack", ElvUI_EltreumUI.EltruismBugSack)
