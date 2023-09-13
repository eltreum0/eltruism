local E = unpack(ElvUI)
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local CreateFrame = _G.CreateFrame
local InCombatLockdown = _G.InCombatLockdown
local HasNewMail = _G.HasNewMail
local PlaySoundFile = _G.PlaySoundFile

local EltruismMailArrive = CreateFrame("FRAME","EltruismMailArrive")
EltruismMailArrive:SetSize(40,40)
EltruismMailArrive.MailArriveTexture = EltruismMailArrive:CreateTexture(nil, "ARTWORK")
EltruismMailArrive.MailArriveTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Mail\\MailArrive.tga")
EltruismMailArrive.MailArriveTexture:SetSize(52, 52)
EltruismMailArrive.MailArriveTexture:SetAllPoints(EltruismMailArrive)
EltruismMailArrive.MailArriveTexture:SetParentKey("EltruismMailArriveFlipBook")
EltruismMailArrive.MailArriveAnim = EltruismMailArrive:CreateAnimationGroup()
--EltruismMailArrive.MailArriveAnim:SetLooping("REPEAT")
EltruismMailArrive.MailArriveFlipBook = EltruismMailArrive.MailArriveAnim:CreateAnimation("FlipBook")
EltruismMailArrive.MailArriveFlipBook:SetFlipBookColumns(4)
EltruismMailArrive.MailArriveFlipBook:SetFlipBookRows(5)
EltruismMailArrive.MailArriveFlipBook:SetFlipBookFrames(19)
EltruismMailArrive.MailArriveFlipBook:SetFlipBookFrameHeight(101)
EltruismMailArrive.MailArriveFlipBook:SetFlipBookFrameWidth(105)
EltruismMailArrive.MailArriveFlipBook:SetChildKey("EltruismMailArriveFlipBook")
EltruismMailArrive.MailArriveFlipBook:SetDuration(1.3)
--EltruismMailArrive.MailArriveFlipBook:SetSmoothing("OUT")
EltruismMailArrive.MailArriveFlipBook:SetOrder(1)
EltruismMailArrive:SetAlpha(0)

local EltruismMailExists = CreateFrame("FRAME","EltruismMailExists")
EltruismMailExists:SetSize(40,40)
EltruismMailExists.MailExistsTexture = EltruismMailExists:CreateTexture(nil, "ARTWORK")
EltruismMailExists.MailExistsTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Mail\\MailExists.tga")
EltruismMailExists.MailExistsTexture:SetSize(52, 52)
EltruismMailExists.MailExistsTexture:SetAllPoints(EltruismMailExists)
EltruismMailExists.MailExistsTexture:SetParentKey("EltruismMailExistsFlipBook")
EltruismMailExists.MailExistsAnim = EltruismMailExists:CreateAnimationGroup()
--EltruismMailExists.MailExistsAnim:SetLooping("REPEAT")
EltruismMailExists.MailExistsFlipBook = EltruismMailExists.MailExistsAnim:CreateAnimation("FlipBook")
EltruismMailExists.MailExistsFlipBook:SetFlipBookColumns(4)
EltruismMailExists.MailExistsFlipBook:SetFlipBookRows(3)
EltruismMailExists.MailExistsFlipBook:SetFlipBookFrames(12)
EltruismMailExists.MailExistsFlipBook:SetFlipBookFrameHeight(101)
EltruismMailExists.MailExistsFlipBook:SetFlipBookFrameWidth(105)
EltruismMailExists.MailExistsFlipBook:SetChildKey("EltruismMailExistsFlipBook")
EltruismMailExists.MailExistsFlipBook:SetDuration(1)
--EltruismMailExists.MailExistsFlipBook:SetSmoothing("OUT")
EltruismMailExists.MailExistsFlipBook:SetOrder(1)
EltruismMailExists:SetAlpha(0)

local mailthrottle = 0
local M = E:GetModule('Minimap')
function ElvUI_EltreumUI:BlizzMail()
	if HasNewMail() then

		if E.db.ElvUI_EltreumUI.otherstuff.mailAnimation then
			EltruismMailArrive.MailArriveAnim:Play()
			EltruismMailArrive:SetAlpha(1)

			EltruismMailArrive.MailArriveAnim:SetScript("OnPlay", function()
				EltruismMailArrive:SetAlpha(1)
				EltruismMailExists.MailExistsAnim:SetLooping("NONE")
				EltruismMailExists:SetAlpha(0)
				EltruismMailExists.MailExistsAnim:Pause()
			end)

			EltruismMailArrive.MailArriveAnim:SetScript("OnFinished", function()
				EltruismMailArrive:SetAlpha(0)
				EltruismMailExists:SetAlpha(1)
				EltruismMailExists.MailExistsAnim:Play()
				EltruismMailExists.MailExistsAnim:SetLooping("REPEAT")
			end)

			EltruismMailExists.MailExistsAnim:SetScript("OnPause", function()
				EltruismMailExists:SetAlpha(0)
				EltruismMailExists.MailExistsAnim:SetLooping("NONE")
			end)

			--SetParent on flipbook crashes the game, so have to do a workaround
			local ArriveAlpha = 0
			local ExistsAlpha = 0
			_G.Minimap:HookScript("OnHide", function()
				ArriveAlpha = EltruismMailArrive:GetAlpha()
				ExistsAlpha = EltruismMailExists:GetAlpha()
				EltruismMailArrive:SetAlpha(0)
				EltruismMailExists:SetAlpha(0)
			end)
			_G.Minimap:HookScript("OnShow", function()
				EltruismMailArrive:SetAlpha(ArriveAlpha)
				EltruismMailExists:SetAlpha(ExistsAlpha)
			end)

			hooksecurefunc(_G.Minimap,'SetAlpha', function(_,alpha)
				if alpha == 0 then
					EltruismMailArrive:SetAlpha(0)
					EltruismMailExists:SetAlpha(0)
				else
					EltruismMailArrive:SetAlpha(ArriveAlpha)
					EltruismMailExists:SetAlpha(ExistsAlpha)
				end
			end)
		end

		if E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable and not InCombatLockdown() and mailthrottle == 0 then
			if E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype == "tts" and E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice then
				--C_VoiceChat.SpeakText(voiceID, text, destination, rate, volume)
				C_VoiceChat.SpeakText(E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice, E.db.ElvUI_EltreumUI.otherstuff.mailsoundttstext, Enum.VoiceTtsDestination.LocalPlayback, 0, E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoicevolume)
			elseif E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype == "sharedmedia" then
				PlaySoundFile(E.LSM:Fetch("sound", E.db.ElvUI_EltreumUI.otherstuff.mailsound) , "Master")
			end

			mailthrottle = 1
			E:Delay(2, function()
				mailthrottle = 0
			end)
		end
	else
		EltruismMailExists:SetAlpha(0)
		EltruismMailArrive:SetAlpha(0)
	end
end

--hook position/scale and erase texture
function ElvUI_EltreumUI:ElvUIMailTexture()
	if E.db.ElvUI_EltreumUI.otherstuff.mailAnimation then
		_G.MiniMapMailIcon:SetTexture()
		EltruismMailExists:SetScale(E.db.general.minimap.icons.mail.scale)
		EltruismMailArrive:SetScale(E.db.general.minimap.icons.mail.scale)
		if not EltruismMailArrive.hassetpoint then
			EltruismMailArrive:ClearAllPoints()
			EltruismMailArrive:SetPoint("CENTER", _G.MiniMapMailIcon, "CENTER", 0, 3) --  -3
			EltruismMailArrive:SetFrameStrata("HIGH")

			EltruismMailExists:ClearAllPoints()
			EltruismMailExists:SetPoint("CENTER", _G.MiniMapMailIcon, "CENTER", 0, 0)
			EltruismMailExists:SetFrameStrata("HIGH")

			EltruismMailArrive.hassetpoint = true

			if _G.MinimapCluster and _G.MinimapCluster.IndicatorFrame and _G.MinimapCluster.IndicatorFrame.MailFrame then
				_G.MinimapCluster.IndicatorFrame.MailFrame:SetAlpha(0)
			end
		end
	end
end
hooksecurefunc(M,"UpdateSettings", ElvUI_EltreumUI.ElvUIMailTexture)
