local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local pairs = _G.pairs
local hooksecurefunc = _G.hooksecurefunc

--skin bugsack
function ElvUI_EltreumUI:EltruismBugSack()
	if E.db.ElvUI_EltreumUI.skins.bugsack then
		--frame doesnt get created at start, but with a function, hook to skin
		hooksecurefunc(BugSack,"OpenSack",function()
			if not _G["BugSackFrame"].IsSkinned then
				S:HandleFrame(_G["BugSackFrame"])

				S:HandleTab(_G["BugSackTabAll"])
				S:HandleTab(_G["BugSackTabSession"])
				S:HandleTab(_G["BugSackTabLast"])

				S:HandleButton(_G["BugSackPrevButton"])
				S:HandleButton(_G["BugSackSendButton"])
				S:HandleButton(_G["BugSackNextButton"])

				S:HandleScrollBar(_G["BugSackScrollScrollBar"])

				--from addonskins
				for _, v in pairs({_G["BugSackFrame"]:GetChildren()}) do
					if (v:IsObjectType('Button') and v:GetScript('OnClick') == BugSack.CloseSack) then
						S:HandleCloseButton(v)
						break
					end
				end

				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
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

				_G["BugSackFrame"].IsSkinned = true
			end
		end)
	end
end
S:AddCallbackForAddon('BugSack', "EltruismBugSack", ElvUI_EltreumUI.EltruismBugSack)
