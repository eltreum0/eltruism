local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local ReloadUI = _G.ReloadUI
local IsAddOnLoaded = _G.IsAddOnLoaded

-- Set version & reload on "Skip" and "Finished"
local function InstallComplete()
	E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
	ReloadUI()
end

local myclass = E.myclass
if ElvUI_EltreumUI.Retail then
	-- Installer Steps Retail
	ElvUI_EltreumUI.InstallerData = {
		Title =  ElvUI_EltreumUI.Name,
		Name = ElvUI_EltreumUI.Name,
		tutorialImage = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logo.tga',
		Pages = {
			[1] = function()
				 -- Welcome Page and addon installed check
				 	if (not IsAddOnLoaded("ElvUI_SLE")) and (not IsAddOnLoaded("ElvUI_WindTools")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0)..L[" and "]..E:TextGradient(L["WindTools"], 0.000, 0.592, 0.902, 0.000, 0.659, 1.000).. L[" before starting this installation process"])
						PluginInstallFrame.Desc2:SetText(L["Curse doesn't allow selective dependencies for addons when it comes to World of Warcraft versions"])
						PluginInstallFrame.Desc3:SetText(E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0)..L[" and "]..E:TextGradient(L["WindTools"], 0.000, 0.592, 0.902, 0.000, 0.659, 1.000)..L[" are required for Retail but not Classic that's why you are seeing this screen"])
						PluginInstallFrame.Desc4:SetText(L["Download them before continuing"])
						PluginInstallFrame.Next:Disable()
					elseif (not IsAddOnLoaded("ElvUI_SLE")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0)..L[" before starting this installation process"])
						PluginInstallFrame.Next:Disable()
					elseif (not IsAddOnLoaded("AddOnSkins")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..L["AddOnSkins"]..L[" before starting this installation process"])
						PluginInstallFrame.Next:Disable()
					elseif (not IsAddOnLoaded("ProjectAzilroka")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..L["ProjectAzilroka"]..L[" before starting this installation process"])
						PluginInstallFrame.Next:Disable()
					elseif (not IsAddOnLoaded("ElvUI_WindTools")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..E:TextGradient(L["WindTools"], 0.000, 0.592, 0.902, 0.000, 0.659, 1.000)..L[" before starting this installation process"])
						PluginInstallFrame.Next:Disable()
					elseif (not IsAddOnLoaded("ElvUI_SLE")) and (not IsAddOnLoaded("AddOnSkins")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0)..L[" and "]..L["AddOnSkins"]..L[" before starting this installation process"])
						PluginInstallFrame.Next:Disable()
					elseif (not IsAddOnLoaded("ElvUI_SLE")) and (not IsAddOnLoaded("ProjectAzilroka")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0)..L[" and "]..L["ProjectAzilroka"]..L[" before starting this installation process"])
						PluginInstallFrame.Next:Disable()
					elseif (not IsAddOnLoaded("ElvUI_WindTools")) and (not IsAddOnLoaded("AddOnSkins")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..E:TextGradient(L["WindTools"], 0.000, 0.592, 0.902, 0.000, 0.659, 1.000)..L[" and "]..L["AddOnSkins"]..L[" before starting this installation process"])
						PluginInstallFrame.Next:Disable()
					elseif (not IsAddOnLoaded("ElvUI_WindTools")) and (not IsAddOnLoaded("ProjectAzilroka")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..E:TextGradient(L["WindTools"], 0.000, 0.592, 0.902, 0.000, 0.659, 1.000)..L[" and "]..L["ProjectAzilroka"]..L[" before starting this installation process"])
						PluginInstallFrame.Next:Disable()
					elseif (not IsAddOnLoaded("AddOnSkins")) and (not IsAddOnLoaded("ProjectAzilroka")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..L["AddOnSkins"]..L[" and "]..L["ProjectAzilroka"]..L[" before starting this installation process"])
						PluginInstallFrame.Next:Disable()
					elseif (not IsAddOnLoaded("ElvUI_WindTools")) and (not IsAddOnLoaded("ElvUI_SLE")) and (not IsAddOnLoaded("AddOnSkins")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0)..", "..E:TextGradient(L["WindTools"], 0.000, 0.592, 0.902, 0.000, 0.659, 1.000)..L[" and "]..L["AddOnSkins"]..L[" before starting this installation process"])
						PluginInstallFrame.Next:Disable()
					elseif (not IsAddOnLoaded("ElvUI_WindTools")) and (not IsAddOnLoaded("ElvUI_SLE")) and (not IsAddOnLoaded("ProjectAzilroka")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0)..", "..E:TextGradient(L["WindTools"], 0.000, 0.592, 0.902, 0.000, 0.659, 1.000)..L[" and "]..L["ProjectAzilroka"]..L[" before starting this installation process"])
						PluginInstallFrame.Next:Disable()
					elseif (not IsAddOnLoaded("ElvUI_SLE")) and (not IsAddOnLoaded("ProjectAzilroka")) and (not IsAddOnLoaded("AddOnSkins")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0)..", "..L["ProjectAzilroka"]..L[" and "]..L["AddOnSkins"]..L[" before starting this installation process"])
						PluginInstallFrame.Next:Disable()
					else
						PluginInstallFrame.Next:Enable()
						PluginInstallFrame.SubTitle:SetFormattedText(L["Welcome"])
						PluginInstallFrame.Desc1:SetText(L["This prompt will help you install "]..ElvUI_EltreumUI.Name..L[" and import its settings"])
						PluginInstallFrame.Desc2:SetText(L["Please read the instructions to avoid issues"])
						PluginInstallFrame.Option1:Show()
						PluginInstallFrame.Option1:SetScript("OnClick", InstallComplete)
						PluginInstallFrame.Option1:SetText(L["Skip Install"])
					end
			end,
			[2] = function()
				PluginInstallFrame.SubTitle:SetText(L["Layouts"])
				PluginInstallFrame.Desc1:SetText(L["Please select the role for your character, which will create a new profile"])
				PluginInstallFrame.Desc2:SetText(L["This process can take a few seconds"])
				if myclass == 'PRIEST' or myclass == 'DRUID' or myclass == 'MONK' or myclass == 'SHAMAN' or myclass == 'PALADIN' then
					PluginInstallFrame.Desc3:SetText('|cff82B4ff'..L["You can support the group with your class, if you select DPS/Tank then its recommended to click Alt Frames after clicking DPS/Tank"]..'|r')
				end
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High"]..'|r')
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupChat() ElvUI_EltreumUI:AddonSetupPA() E.data:SetProfile('Eltreum DPS/Tank') ElvUI_EltreumUI:SetupLayout('dps') ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:ResolutionOutline() end)
				PluginInstallFrame.Option1:SetText('DPS/Tank')
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:SetupChat() ElvUI_EltreumUI:AddonSetupPA() E.data:SetProfile('Eltreum Healer') ElvUI_EltreumUI:SetupLayout('healer') ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:ResolutionOutline() end)
				PluginInstallFrame.Option2:SetText('Healing')
				if myclass == 'PRIEST' or myclass == 'DRUID' or myclass == 'MONK' or myclass == 'SHAMAN' or myclass == 'PALADIN' then
					PluginInstallFrame.Option3:SetText('Alt Frames')
					PluginInstallFrame.Option3:Show()
					PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AlternativeGroupsDPS() end)
				end
			end,
			[3] = function()
				PluginInstallFrame.SubTitle:SetText(L["Fonts"])
				PluginInstallFrame.Desc1:SetText(L["Eltruism uses Kimberley as the default font"])
				PluginInstallFrame.Desc2:SetText(L["You can replace it with one of the following:"])
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				--PluginInstallFrame.Option2:SetFont(E.LSM:Fetch('font', db.font), db.size, db.outline)
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsRoboto() end)
				PluginInstallFrame.Option1:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\roboto:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsExo2() end)
				PluginInstallFrame.Option2:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\exo2:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsGotham() end)
				PluginInstallFrame.Option3:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\gotham:14:112:0:1:128:64:0:128:0:16|t')
			end,
			[4] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('GladiusEx')
				PluginInstallFrame.Desc1:SetText(L["Import GladiusEx profile, remember to disable ElvUI Arena Frames"])
				PluginInstallFrame.Desc2:SetText(L["You will need to change the profile in /gex profile options"])
				PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost, please back them up"]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupGladiusEx() end)
				PluginInstallFrame.Option1:SetText(L["Import "]..'GladiusEx')
				if (not IsAddOnLoaded("GladiusEx")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("GladiusEx"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["GladiusEx adds many features not available on Elvui Arena frames"])
					PluginInstallFrame.Desc3:SetText(L["Such as diminishing cooldowns, enemy cast tracker, cooldown tracker"])
					PluginInstallFrame.Desc4:SetText('')
					PluginInstallFrame.Option1:Disable()
			   	end
			end,
			[5] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Details')
				PluginInstallFrame.Desc1:SetText(L["Import Details! profile with dual panels"])
				PluginInstallFrame.Desc2:SetText(L["You can right click the bottom right arrow to toggle the Details! Window"])
				PluginInstallFrame.Desc3:SetText(L["Remember to swap the second window to Healing Done or Tiny Threat"])
				PluginInstallFrame.Desc4:SetText('|cffff0000'..L["Make sure to run Details! install before importing"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDT() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option1:SetText(L["Import "]..'Details v1')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDTReleaf() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option2:SetText(L["Import "]..'Details v2')
				if (not IsAddOnLoaded("Details")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Details"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Details is an advanced combat parser"])
					PluginInstallFrame.Desc3:SetText(L["It uses less memory and is more efficient than alternatives"])
					PluginInstallFrame.Desc4:SetText(L["And has many plugins to choose from"])
					PluginInstallFrame.Option1:Disable()
			   	end
			end,
			[6] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Boss Mods"])
				PluginInstallFrame.Desc1:SetText(L["Import DBM or Bigwigs profiles"])
				PluginInstallFrame.Desc2:SetText(L["These profiles are setup with DBM English Calanon and Bigwigs Voice"])
				PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDBM() end)
				PluginInstallFrame.Option1:SetText('DBM')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupBW() end)
				PluginInstallFrame.Option2:SetText('BigWigs')
				if (not IsAddOnLoaded("DBM-Core")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["DBM is not installed or enabled so BigWigs will be used"])
					PluginInstallFrame.Desc2:SetText(L["BigWigs uses BigWigs voice in its profile"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option1:Disable()
			   	end
			   	if (not IsAddOnLoaded("BigWigs")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["BigWigs is not installed or enabled so DBM will be used"])
					PluginInstallFrame.Desc2:SetText(L["DBM uses DBM English by Calanon as a voice pack"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option2:Disable()
			   	end
			   	if (not IsAddOnLoaded("DBM-Core")) and (not IsAddOnLoaded("BigWigs")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Both DBM and BigWigs are not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["No boss mods found"])
					PluginInstallFrame.Desc3:SetText(L["Boss mods are highly recommended for modern encounters"])
					PluginInstallFrame.Desc4:SetText('')
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
			   	end
			end,
			[7] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Method Raid Tools"])
				PluginInstallFrame.Desc1:SetText(L["Import MRT profile with raid cooldowns and other settings"])
				PluginInstallFrame.Desc2:SetText(L["You will need to swap to this profile in MRT"])
				PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupMRT() end)
				PluginInstallFrame.Option1:SetText(L["Overwrite"])
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'EXRTP1T332YnsYvI9o(ksthAAsTaOrHcxBfCwbsaEreKGlaAsnt3tmrbGea1WcvcvxiB0S5g6FWp5iSFWp6WH)k0FI(s85CYmRklGIxMvRdVoKMnw1OQ825(TmRK98Ic4XRExiR3FC44Ivk(4rorrE8H8WdFCuuGtKZH7D25NE2EpvCOJ7SJxYNE3HpEu885HYFhfeZloK7mBd9CF(8OdB0OC7k2TQuPDJA21RB08jboR4JDxXdoXzg)WAgnjNPRfrUcFJxCINt4D9(Y6dRwC4X3(Zx667E4ChVq(2Z6OPoE8dTQzz0WyX6dR3UE5MTBuVsRMTAxPrXrC)zJ4EZLt)m3qNjE8(Nmu(8TCN1c)E(txE4JFAVEZNZNg5uAuKiyvGZc(E)0HwnTQ2QEXpTxx(u38B5s3WqxpEyoT(0tfVXn8kre)WhNHu3hFCVgvQ0Tx3toQshRgw2qVAuT2EfB1c6B4g)P)SSFFs2VJT71(yRgvQ32UAJQnGj(XiGEEOAO2TRwmeWqEWH7nKV2XnWekEQinl9QCsxRo1OzPAJwWQLolQj2ozw2LgOMLSWs9gn3EwQ3O9BzwoQxLJAcdPrL221TTmXilRMnB1SzYSKdH9jGkrcuGaB4A(u83Wp)uJQajVsXp1Ww(VvRxr)dlvl10Vq1Lg11Vq9Jgn0VOP(hT0)OT6hn0tBdyARwh)bUYnWFOx6KvcxHQvXFON5g6zUHEMBON5MQzw)VwvuOutl9lulqZQ6xOwOMjiDslj4wcwRaH6nvGq9w08cKZnRbQFrKjmwCHRNxhFhVnFLFy1kf74TEPd0RkfrDRwTQwg4ZwTb(gG7svW2nk2xOvF7k1VgER8XmMuksglSAv1UCB7k1Rz1UnqCg47T5C)JfRM4erd6PIs1LJ8CME3voe7DVJ(fh)7aZwyt7v8)O841GyOaiwSJf3Z9D8JmFxNtojtxw6eXgfbwsZ8wWCxi7mhppZ3EItWkZNp3pCAG7A0uP5R7ZxaVH1jiYDUZ0ml(1bI5Cq5bA(mrWSmalyNG9DSJC8C8NYzI5SRfpWdm7X4ah)WvIf7aiF0FsG4oUp7y3GPEzM1o(BEWzty5YLZah3FnqCwTM13nm6zBGv1SPrR58zaYDp3Z1FrMweX(ZcnFZzIhyrcgAWa)xbimXSyRPMzIa2Iar8Ayajo(GF3j05oNhCyl5EqtFYgud27sXA29HSBfZadvAP2J6C8fNoCWhVQ7Ef7ehj6lCMD4JvTB3Qy1AwW)JDlB4xGtg4)Pk()uhBa(LD724VAIVRzXpbA007)u1w6FzRE3tkTI21k3UvnRAGrWwwOxlV5J5Fj6W92R4jUFrPnH6BhbAfhcQJqJwhUhBVIGGhOXnt1fN75D88UI)G85(oHrFCn4rHJAsj(i2R4G4iG6YvoDf(rJC)k6oL(TSVN7hXdabl(N)CNzZg4h(5p3Z7(pE(N)8L8zUoF(ZyxHxEMa0rxh7xokcKTV1Dw0YdTR0UCf4)ABvVE1M2f7ra5Tl5(d5t5U3Rw4uZlK2Ek0IM1p8rPtUgTSAxu9tWntYpR3m5NT0)Szfl7KFwRHUdnRMmmyC6oybMb1)SAl8NGb0wTAO)zBa(t(PCEXFcgxt(jqWu)SEB1WSRuRzd1BBA3qnd2vRuvpSM1Quj5Nwvt6qd7K3wp9NjGtZAnLtw7AnuZaa6TTTiKVg8ayALEBTAOFE6NGzwi0mQdvAAdoxFISKdUoSld9QsJ61Q2UzXZ4UlwcrYbsReNa8O(PXpiya7jKZMJnwMDc(pSjIWWISiGvYw75SHT0Dg)7c587yZIdafw23(205W)vPY85xx9BFlOCHcMVIMrl49FGX0n0UTT9zN3Th8w2e(sxqBMA5KwNCsJARbFsobyBMRaozZN3ZjiCTNBue((rldC53rlPXep8JxXg8XX44FWnAzMrpDPWtm1bTSsd7XXp9yeyJ)jJLFm8C4hWHZmM1t6CmbUgDePm4RaJlBy7BSmh5Hy0OhCxZH2pOGCjmh64oxDbB0TDUghpy6Yeg)IJ)IyxFhcfpYncNJYp((XpLdDfP3FyBKVZTD(bcUczoslIS5bIv5c6bOjwK7YceIvLZWH6oO7PP4Se6gbMHdyGB)7WXxw2up7kwvSgnUZpGeE2Gty9hmchiyI25EH7SFLCqAM0yXZb6cu0H56hce3iWnWDGudFw5F6NkcIYld4CtH5IsrbBwSV7FkgAIhfIUcplgmPTYXhH0zCWbd2TScW3cImCPUaje)mIAoazmCDaKBYosDJaGe0x4bBJN9hmyup2ORh2Rtxf5Yd9nZM5Scc(1a1vten)HlfrpNAgB)lDcwic4m6fhSdeJ(3UMnAqNlsfWLt(nUtDfXHS(X(lKICGe3Bu5aLKzdUkJSsLk2LQHVbyqtVJO2gR2FWzXcWRpep0dHVK8nB)Jaec(DugmAqgvMrlHSnPvq3zOxfnbWpc05JpomHipfSEjEWVSzFU48(93sdxoX4l)xnWRQvsrRxJkzsK6DDNHDgVTvedq(5K1ZaMD7DsVRgD(nacrcnzTEm0Dng2KNMM(4za4TeKS5bzmaDg9QDGXZ61Pp7JxVfiQNuMZSzFJmzphfXCJyG840LaPphy(X3FwECuB2(NXNgh5g(CIOgkvUZzoZN75oncKvMSjJ8618Oa35BqRiquHE)kLyVCWnBZiuGLsgjGVccY3CbpoioCjz0ks4ZnfbqzxYUZa)8S64WU3bmZfTbLqv2i(o5GzR4tx647on8Ln6KHajnyOPrgcM)RwKK5gNGzHP2EHihdCyDe9uMvk)A24Vr4boFG1V3Vaj1lDvYGueMbcNGeQFKJx5NtWg4yrGanpc4yBBt)4l2wEfa5QBXfI4oRwbregURS9PEXraPhnsDPRdy2wXQa3aKe(SDcd418HaIXz4Wc)W4vKXVcMkoVKEJ81qm4UsqEBJ)5c0tD89frgaoQS8Rq69fcF40aXdKobAgh94uu7K3GQx3q61CnvSkL3btcMh40uemrZvwiNYhwIIjiQGZbSSg6cSlJ9ICljvhKbrob(5STG3tetbsthFxjLXzIleBWMYqgTqcH(rGFvOfMhMDizHVgBkkbc5YeecE)PWwK83LQykG0l(nOyXA9maYUUOx51CTsMYYRsk4biYbGLaUyEE4ca601TiSWtb14qC5wcPKohhmee1gqV3ZlRyyV(96aEF6C15x2HMP5PZK2skg8GZCi9lWM67cFEWOOSN(BWI3G2FxiaJVotqlv22)gMaGHGhCdre9rxyz(GDJw1AvTXtBjMRwEaw6YdDdiRz7JYASKgp4dVs0XVf5rWzzj7uHTTccO3xwlcLRTXiQucqf4LhuKzvQQXiLDptFTTlHSBS3zmj9c5aCRtWAqkuI3HBV4nAKoHYysmPJ1FE64rcSW6ZsyvQOYZIsFGLJAwamQPu9vclZYIBnASZO6CZGZj)(t8eIzS1cbOxeHfBkCTderJ5YANGm5UWG3Cx08oe2Rbmymzs9kxFOxqFcfoO5ImeKwppbbI69vidsbkiG17GvhZTeuT2sWsdQsKfnaLfbTZfb3IgnbCPekXf5mKbfA(8Oa8WuWcsGt0Vkg7li8L7mwMncP2Hq47WIw1K4aSOqAnzmZxdtZVeJ8SlbZJZ5GkIYnDg44IZpo1oEY6pJVsM7B2P8mNaFEiAFE0AWRp56yRzJcpUm7nBvqhJfylg7pAGeSmrAvVQyEMyCaZEHgir(8fvChG5Wa0L0dONH0GqYODVZQLefuQC2oQb8VS2tGvynuLJzs5saF43Vb1MYw4eUpef2dyDtUWH79oy(ahwHMA4kz3KOxYnHUoW8(mrkRZyzDGRia8AMrV6C)5XHknQV3SHbtNIEMLzCKPLBC8)tXUHljMF2M6eg6egsQ0zB4exap35TDHaEJwkOebEJ1M54a3vyvCpXloiyZ32kRNJ(4WrPH7Ulmzqv)92Puvmz(xwJ4MyVfobSJW4B)wIZGDPuz9VqzU3)hmYD3Suvgugjf4xrDMqxPBHNPSfIz(Dz0tYpZB85CD5oeIjkycpiPeyK6ieS7Bjw3xkhXEGTdC)fOIeJTLgLOoGGCe)MXDqwu2muLlZ1aVYCzKWVsQgcs6iHmXeszntG8vQ8pvpvea5kF32W)waFIc63E(exRY2)3xR(VPiRDLFZUQIQs5OtYz3IAsLsazgzwRxlvSJ8C(kLYzCavugD(xSFVb2cMrWM4GxRfBYtDdW)S19Xyf6TcKgyW6izi4MRGvNtNRiRWJZwhMj7GXWK(DSCQwYq(erGpySsW9D)c2i6(6VvP)CjCSFpJpBb9AkbahnXwbJ9hClODEX5usPLZua2)TP3akZbBGm)dCVlPESY0C2PwJLzFuwKrDU9K0jwOevVqACCW9Uqq7yHxLd6nxZXCRkBeKlsiUpERL1lkZagoyBTOUq6d(HYq)gZL1A)brWkAzPYzlJwctNq5x9xtTYFP0t92SEPkVJOG4KYlSfdeeCj1iXQjGnIjXGtFrC0ZvLqWljOduQzEkMyL)UDWWlpBq)Ep)crO7grCgjV5UFHIWqv1lZk8FCWMqune3nvGhdK)viH)G88HdgoaiRuT8GUJ7mC4pa5g2LHCj2GtozlPFkX7qoFM2MQynKeKBe8s3zjY)LFjmgd)kWbYFMbErMEN3g58llApo1afocefK1CP8VoNbJUEWywowuvHZdPvdoZrlyAC4fQliqHkLLiPmrP007477U01t76ITo2dY9HsU31NySyj8dnrppoyWWtzmJWUXjfgitbIjYVMQr7DHYeoT1i4s8D4IqMFrybFTSOgRCWcFWCyqOJRLHgARAYwQWJ)Wf3C1vUYTOhBvBROhAxGsN3r((zUC5(THLGesfbNCSbiZSfoeEAM4MUEjVK5Jc9UhnEPwetHlvbqw6gLjU06MbqvmLeGrWcstCexygRx3oxDCp21N1zuVVT1(rbEebH7ZVI9dd(4qMSJOmdo)RKz(nzdTcgWLNCJhH02(2w(i1Pu4mDQiygsAqPBfVackygDghWnfszBj8FxSBvPcvMYC9m0nM7brZal(qxq18f3UomCEpp2rs2zhpWfWbBtXYBBiICUpqSZobKjAwvmNbU8zoVlnnAfmI1CEIWlIDJWZJVzBY6jdo(JJiZqx9Xl2UU4DJJCNh7X6efbb0cg72E0BhupzhDTtqeLgDgZ)qEb3XgYN6cgp)wInvfjYss292CWRX02L2qzyInHhGH8PDGOYdobZYg4WwvaU39GJuWVC6MG9S7lLEH7cK23ctuYAiEikdOfImX9KndGT2lgpAnz0KYu1)TG7RdaVbitQxq8AT9Xme3QgexJz90oJpR3qW4whXo89aKsfWgXdUxY11XZ9sKJVJjr03mD5k378CIdFoct1xLWifE7o42R2AMVHd2PaZL0(1Sig49kC41eVY4Gl)DTl)5oV9zaOiQQ4ywuAUFafEDsCKPBDu3RhXMIhVvYOwzgEe90fkUoOEbKIaucoiTU2jmfv0jlrhf9DjnISLvrNGcQO6MXcNvv5ghrYjZ3sjoW0PA3Z7bw0rl7J7)dPgdKO8LCpopHyLAGqVvm7EKosIee07aY5Q1BpLdDaLXzBnNKJf8D(q8RBLmqiBvm4vf(xWGCO7epWf8mXSfBTWN44rzhomEc0L0vvLlGC3RnGJGCHJDtPss(h5rUVOnEtwA1xntO3gJQEkFAwmLnHXAFQlOQcU(dJubZT9M7KtgwjhgKiMhpZ2GG71D6Qrs3YdNtygzzNaiOYzPb0NnHl5e97ZKLAX8wF5(WiLUDKYd40SDH9XUQcotcmYdVbS6InP5LzMwg3FQiMcAH8pzglwimvrpWXd3e21W0t9e0rvyxWk5EV7SyqCzJ6KqfjGuIGKJEMA2DkILq0zx444PIN9shF8iDCKhghS0ElBKGID8dfSEZBEbeapeYeKU(muGTiaIX(trH4fEoibl1bSbbgb8VrPfwT8Rj7ktSX9RCLbl1(GpbHBq8yEegV2ZdrLlyNzjE26oCDShevQlvDJlbJPIaTYs2Yf5KUZQlf0EqWN9SaCg)ch3VxNB6LNJbYOT(40EQWZ1jA532k4kPxfT)k3iu7iRIrMIm(MvSrOAOSqruAgzdMe81kRQT(WJLtzsnzq7U1UgLWy3Gxo3mle5zYl3sle(GBaeMyyMuKYX39c8WgTbRzWSz7upRJh0VFVJvhokCtCPk19Dg9G1Tx)ZVP3qLOMXedXZGbYpe0Ja1m6WDKFyhAnTtdCcxMQTLhsLHm7gUYDk7JRXA3ldfn1on4nf3gixFdRR)FDnZ32Qyu(wyMnc2dCWfiwVgFRy(CdKbLBnwqthLev9eDTPElRcTl5zSDBP24UTKY1k80mBamgEnWGxk9awed9Xs5nRd9c5Pzv65ZuJu7NlR8mwyZTDnQpINuuBPvbJizga(eosvUZxqmCGA)k6z0z0KnYbZ(oKLvfeaJClfIwS(iWnKsKwpbANmFhRkiKfhPoJrGRZ0OKdDxf7bOhxeh6T5zotK54m8zCNLtX1EZo1NgtN0Y5mR3BRlCI8OMMJokqoKlQkC3GyFQ(hIyQOlHRHK7ER7N0veoEg53)BBzC)z9kT1G0rJS2zRnsAyVUF84DkwFCWmi2a5EFhAigccpKIpUBvl8bHM)ZS4WTcg9yi0lF6Lx7i3sl9rTktsGyzRX80ZXymE4MvlEU2JVEWOZhF(GRy3E(4Zy4h7aB8a2TDKtu280pI2huWk80DCR(Rg1nKxQIzsagyPEO4Xr4hFIRmSXNth6BBBuh57aWF0GrKtuaJNkRkf8lQoxW6mZLNR6fvpwJYXEf)bKELzZthcr9e47ktxphboq7lDR)2wY78vRD2nFIC1vuCvzQ9FhlpFvxcsnotLhrhCl)LNMHKDx7nlEO3F1JDM44PZpido35Qt719Bzn1sHbT9mzmdiGaEaIaw5QWCp)DiRalj9r9hmOl7YZhoCG2HppCQZ6DpMZNHLYDNTi4xt2tx0R31SH9UCWWRoVJmyljMLtQHuPuaFto3ZZBJIEMZ9)oLy72aqEph1xDvNYJ(LOMYYzHFbNC1l14BzCYjpplw2vTQx)jtJkob(YcFZYUbPwjJpD421R2Y2Y(PxaPK1R45QEVU49zKinZJvAfCcUQsQc4PYzohpXgoHMoh2U8wJw6ebA3zGK8K1(3MC1UQ35PvFIdYnpXLoLmFBlhkMNLlimxvIsQDqatIAwmeolgiuYXiPCENP3)2nbK34hcX4kLc2E3VgmwvAl6BfHQNeU7KitjCTikeLmFRkDVGaBTNtGTrvRAMcCJMcMD)wAHlyxW5RbrIizOOj7eHgiP9cJsJxE8jZdPtRjqHl2e464JFiXEEFWUsZwnQ)uHJ9WC9lXk0hpmcWKuI94LcncdtgVDt859NToeLVzpouSiMRICKp3Urt6fqtqw(UESsfUgSiYX55AhiFaxFvFTBnzsB1ROj6wNa8O7iBEA92onMQE1(RVFnUyfa3ttdeEcqzrd34xrwTe4(vbBKqEqkWXEe0Mw54R7xJ5ZMkFd2NeiVloRSl8XaIuWNT1m72MVxcFuitN4W1GxTkTAujLSIij(bxiNKwnA1Kpt9kIgCjWLKTzZN2G7CPKRzIwDdIDNPP3nNuPn9cA0Dbh1(Qa2K9WPA15tBz(EtCptpBpRAtR0(OX9cfUbcMy5MGemQrJ2vnWiiUiWeYtY)Xaq3H9)I8xUuy65frio37LBfl2xPmmeG1cWR1yAx5lu46aEPJXI2DMdGiSVhttPeDyM)yh4Pole(BG)9yraEeTg1h(F6ocIrcYxW2qHeCq)9m21JOMVe7j(9EmueX2pHbFa2LUN2N9pXgd2IVJhf((HotDX9C97zxoeJpFf77luGuANbMpyXRlM0GQYVWAag3hnemW6pt8qyrwSpgsiMOAD2OrYcSfdovGbc654Plxa5JcM0lG)3NwZJkoL((X)j63)E5buOiyAfDQ(tSWLIh(D03Pi09od6zqKgXPu2iYHmR2NHI9Vwp58esuK3Fg0botIUWRUzm((8PfqlZIxTgGdYfhSgxoSSKOiNC0kmSwXRlx4JaEc)eFt3aQSXiDhgIN4b2Y1jabAWdNowOV7AUusqNKyj2pI1Zc(V3)lcykuVVW4a8KZSDR0Bl0xm1XRlFo3pC3Uy2OCP2YMck4cJI(8RNrBmSN805FVJhg5nU7zc)c7k2JQzBB38FMmJCg3BfmLdPkgGFPUSO4aFzK9E8jborIGnS)umOXHskPFi9fkCBa(nLJJDkyxiI1a)47xTMClGbsqrDKoGYgnJNvuq8tMk)9UoKhM0UcbldXYd5Sjx4q15Vhg084asPFgpc0550jqyRXEPkj)tbBvyT)p1deJdb48mHVaDJtrymggePHnhgd3hboCRFOmEJr39RJLNUx2Iy6eF4tFXbG8Wsavvtfm795lW93aNFKZ5ePoBr4HeGkObWDAPR5zxjdcCVpEPlEin8XVfLzOqGapHbixD(Cx8G6jLwbsi1luTS)jDXpZh8vZKQNlHyN1FQPLrwO8ytKDXy0NzpFXgjbHePHOUdsWNzPGTSW7awDcNl5SGbanfRk7i5LsW5H4XvpLcbOZpaafTncgehSG1G9I1ECkgIWubPq1hWIN6UhqYEFqUFBmh3vy)rji96dqPAMaTLmqrxxiSUva4JDpBtxdUha(WmEqr43brSb(O4aWNjP2J1tOHy6aiB6GeHVIiycAfbCzmZifc0sCbGAfwqkwhgiBfqF9M6XO4SUyyD49McA1sQ8eYdOtyceEKRh(v6Z40XdzoKgS8ZSPO8SppJ7DpT7hQJyHhMTEyCafZjsz2rVQdeugImK967DHjePgbOsobkRde3dS(xqzjmrB5iUhsD6m9pf7IFHmqFCux8fgA1tXza69OLGzZz4boQeR3xC8I0clrBRErKfIfh5ChGpIvC1jJjepLLqCqbsQgrlqlrSVc6fBRxkvgbkJEmjsZotW(GWlU2GiK7c8snHeTioaEpmekjbWcrtozKfRe7PcVzaUJFs(ZbXgi)LUGBJq5BcWpB1U81rldlCQpa4b8fo(fg68vrayRM1v8GFy6Jxe4e7vy0uiwlEK0eDYtGrC0FwWMc4XRu8WChGFIEOkmMl5GZzDG8DE3sN7UZjOWh9WI06xGkxS(6cbm6qFTYPa3O1aVcIccOjGXKcDroh8KhJchtsdgSiGJq5c(CSzWwC4QTXbYuXsH3kEHBbPuuy7yWgta00pg79U5GZeN7qd)qVadRG8i(8zAVqd5Z9KF5ISF7Vn91Hy9FlCTlvlXroq(5foowUfW4lsxtajLvjhDghY(TGNux5H9dzPtvEpavyiLqcGwehepHyIQ8HqNLdtmmHo4so4J4u0v4Tg3v3sSXIGiHNhyAvzJjTJ0LG07cz3IYPLsECu8614wILDgpgeCGEkDW0X)obE2e09Kzav3kc8WyneRZav3iCNruI9V0z676GLk(7rjGVi8pWeKGmpXEDsmyXy)RC(6VaKamWskacCwpiZQHxQy7UyJb9pkOsSmJRuryUeXGVNnM7blV5IIO3y0JX(DD(kgFX3FnycAgWVe(lMi(YwDLoIrsTK9hcHrRV1B681dkyazAVs7aChJ18Gifd(cRpczWV3)s(S7DxcgEeru0cbgRkTIDMek8IrU9(Ja3yGet8Q7DrpEBbFdMawGbw9(h5burF84k99OdJfle3z01RfEBwjcwUE5u0U5AqobTpUFNGP4ot89qEWrmS2mgJ5eUxPir80L4gisbFUFhW6nEovUfv3XyzpN(wcCH3YUHhTmq8vJjyCqCiT7JryCY7FHtGZ3Jx(l3Vee8oXa3niKdIKFViPZsFN7DdxsNBivejhfJF7Zap4mMbzdv)pIdq1(KSDiWolDcyCyj7paPDT5GcfgdP(ao4EhrHhHBQHdeI3Q3Hwpj7)Gdr2kbAjM6zyb5fptY7l8hW4zXJXYgJkqPUCfWVpJc4X3B33EcOtcrLS971BeXe6IjsZrNHtrOq61edlcIyNAaGcFzzlGgCJ0FOPGaPhIbGRLq(ubmtfWKEPnxd9TjGaniSyF9yKbAlDdhkZ)dKGOOldPnkfw13HFr(G7hcCoOq3luZ3w0okDeC10LFhNsmnx0RheMc(DMOOk9qilzEGo6QigsOddxE7jFFj4KqvG5eJfOiI9Ra7yYGxKJhpLM4zeJSBQVuRqdzIGWcjrfbePUqSOGPrqqyRWxl8SvPaVzHqkhkxUB5du3ouuJ5uDc1Lzh18oL65i8dBYNorcf2P2fxaP4cgednQmgERirFDLiEHVVaDEUoJhiCNINTR39hC44ENG(cwnr5AAbKa3Bd9mlZg4zL7NSsVkULtLhoEZup3PoEVg2viNcPOV9(ED62jKyg7pUl)C3stDsCeUSugNgO6PiQUf6NqI3VARdEfSNTVv9dEnsalLjIhyLG1E8mCwGDKSKwno4LLh2h7GQYrQRLl9O2QQDWO2uc1Sa9shfc1(GxMMcDbNQNRCyJ3q2VC82EEHbjfi)JSRLhz)xJj0UvfnrhPa7pdnbGFMchiv2EdISS2nQyQFSpOGCWBqKe0rSGUBgGX(B4OL6dEnbwyOTQujHbOjIW)NIxKo9VfgIUNVilPKTDLF1SKsS2vRui1(3FKjJy7FHsy9vyokabTXnGoTI4lTAxH9QuwRQVgXHv9TrAywVDSEsYOSQbi9TsNIdp60Wxt9TuUQMVrXVsMcWh5jlD)Flw0ixy0fViGes4gdd3dIeB1gv(sXryUqysxOp1sMxYJfKeE0faKTJaltAbjFgE1FG)a3BAGZCmo0cQ6ObVhCpVaYKuURyNkMaHSwqXKXiUWCYcxrhE0ffiyhtn2hpHiY3rbbKcK98C)c4FxbHsAb0SQ42picWynlqUsXsyXdMW(o2L0NNsHUNH5NaDGEcfrO1Ya8WSvjIuAsrStHMM9A85NLHcb26ea54nnwP6E0jDW0uHGq6qFCiqoL)IJVBHs58Ffmm(CM7m09Bsaiy19WRmZtXZH33ET4hWVSIvpGBEmyoxx5Hsj32MYjFB7(fUbAo4xGyuthXzq8(jDpN9naVoIXfmNHsjJPgAUy7Vf(pdBMBFvGctl2dtIcvNkAtIpNI4tGF(Lqo1Oikeahnm2TK01odJoawJ4(8fIqv)pJJnatYp66xQZxXkz7UZ4Szi(Pg4hy7FcMH(micsvD8oOaK7ZscCiyzF7km55uXiMPYhSZ8shJ7Sd9dS(XtDX8CGWkxaYxdP0r95FjsDyD2zwQBGvFGqQBDdXBejKkcc00h)8oJQbHtBV4FY6Na1FzDPwbYBqGaxnymeGVm3fmpL(Nm8awkX4tv)jM(lSwZ2YFq7acnZa40KqxNhYl7i5EGSl(xEN5PvEKrsGgVmvMeTlY3ghX4LoEarog)8OaLeGGZbQVaS2DHV4bp6W1T)wfbNLuX3d2foSQq00CNxKWEKiqDfiHYNycBDcjBxJ2a2HDaEUtGuHvswhIFmL6QO4SgV9pk0xazg7IxztcH)ueMWoB)tS(U4N9bOUDnpyUSet7cGKEtoR24hCPSRjU3UdR6ZmSoyA5C2y0dXBHrzzNhNAeNFNEl0bBi3bRZUCmlPUs4sxVzUbsXC8(zjNEwpBphI3gB871RWO7D88PplMCgAJSdfzADyNqF5bN4kRG(GzBaPsK9CnOEasSsxgGXGl4B2DgBMDgXrJ3qa42kIqujgUnBNIxXdQ1bR4LJhwtuh1D0bM3U8iKjtEvwDOsm1osecmKOYmiLEfeo8ADg0GjiY18oqvEAmqq2((AQeEbwe7LJMJfP6STDdPzdv14tRz2(xjI21mqE6hi9e0v9ILLAhicenHhhK7KuEBlUFavbOC(XdbdOTGfwn)LFhNcvYtOCBpruictXTzhlcoyAV0mahO6znXL20b0JYnG3JvqubG5EgvFlajL5txi0ZDnEBqJZypF1ooFJ7cx56arPGQGbjLUb1VnY8ou5fHboCw54vacwA2d4hvp2ienZ9UYsxmdlBjiBeSaw6LYLEfU5Z05oYjyLiOqaFngDnwXeAnbbYPGHj)cY)li2NtLrITqUVGdgcde09dDXD6DM4Hssda62lSFNRgpy4hhXg258USRgm8Yo9HS3ke6es1tBMRZebSK4(zV2rEdFGZkNc6BkUJiyMeHtxka2amXtDHwk46JFZJ4X4t46JNvxyfbpVGRDMEbLRfXC26gbN8PdsxlDxHfe3QCIhvSWZy9OUZxAmwaImCV5LzNNzRdXMPYSHnwKAXH0PWT5nDZ4MkOVD5iHWJ0(OBMaCJFQw(8f(yfoXp73qAkDyaHJKqlI7tjwyA5xsnDOUPsEbk14RXnitoA5IXxnjWzQQiv4hAFquSVB0MKn3bwq7YKCfVm6bNReXkI795dSqQK0qNQvwHLaTwOUXh4Czz8EGkgyO26b0l13u0g9ExsDd7)AvutuTeXVPB5gusWVSAA4y8XBaXiPLlAJCrYnMoaUTW1bBwGv8aczxeGBWAOMfbCh)y86)iuEqYJY2V1uqgqNasvrIQlneQgTgUCLFZMi9CLZgq2bNg9eJyUBu5uqiz40X6arudzeA(j5aeC0VvT9WtiDzP1xjWNie0qVaRIdPBvXjk7ky9qPnIdTCuefT5EH8K1rc80oydgsHjQjmr0nRxO6aBtFXxyhOhHGOwHxnH6W9WDehJLDnW9WVna5eVcJxq6JHphbw1EOsYLRf(s(hnw66eHg1sDeYWR5RWTrJ2m7a29UtblCOYesDNOMFjfclTkT5LfPDFhyAC9a2O7UAJIrSRfilaPkhgZtP(3PdctoJZPRBq6QuWnCQ7ACVk)DjkQg6Xe8VE5MqSac0Pab3zxP(lmAjZsYPKfQxPsMO)VLIFcaHZl2UC3z1sl0r5ePBsWKMsjSI9h)WmCK73QEDirss(G(UXmT2aVDviT32an5c5BCqZgRCj8wUf1Y)vAkaseNKWKYloQBfc05qIehE(v9Lgf2vAg1nK2Wc12iuNLlbEylW)okuKfVQCzy84ElGH45i14b0fmsJydUFeZwhIFjRPeqYyIQfqQ9Fg)ZYWeXSnptRxjKu6ZGGhyDXj7Cs5GUB22O3bbF59(I64CC(7wH7Uce8470Zvz9F9hkkVVkbdZpakOaXb9JSbeLlHbM4bc3fzH3rB2ockRb3kCC)7DWBYIq6f4UblL4I9FameJNoGv4bfGoBdHAJDKSS8AmHmdi11OpEfFozGXbHKvBKNVJIVaHme)JYbOfdYrVJVY8kq3Zb3RdNYyy(rWqikaGK0ii0HahzHmU8A2F9p)FHrLw59yXuEFxqLbTXqPYlZ4VCbOF0r0YOFY2LLQbAVB2whcdtWOAouy8OtHKJ4lXTYLJNoGW4WdOLvvHG339I3lVzwy7piaIZXN0gP4WmxMdkm4bp667hhSCp)vG471bHrlPA2kOoX14qE)Pqk20F7o2DSNeGoQLyLCGN4Ib(aluPT7Q8WaK2tzZpdqPQkKUVxCYXS9ViM25z2X0H1plDqwWkD3pcdYxEM(PE1ZNIaIjlQ27p6sw2(F9zDVG6OjntpNDVaA)A2(aN9441UZswFml1OD69UcbfUaeN2yaoNqhBpj9obbKqYT97MbV00btPIB7pcw787HedlCPAAi6DEZXL0CKtZjtW1B3EgX2(SrSUsOGASNxc11Cz6pQBvJEzUeVNLrWd7QT5eMLLzoPsjff9SedubYkTuUWh9bv(n5kgMOWuyircKAE5sdg2V7Z0bjCm860ji7IKDAUU7l2n1KXJKvPD)rtfIjByDfINrstovkSy8Y4fQ(HvrukeMPhJMsQY0(7K2LSqIw67YUgsw7yo6wWMxPmTMN0(Txok)jrrpUvzrmtpYiC1dYJXjfPi1fdg344GjIe2)wckBPp13fcdfIG)ydPLmMRqukJc5ZIxNOG7D6Cgy)ghzDpctxstExkwCgjDP4g93w26ms4u1AUsNJw7ofWRL43DSVbXkXmRs9kJzDWE9xXEVZOsTJNR7GUoYVL5B1NPoSavyU4JINOeTZDCG0PpDug1lKM9a2lq)74FKNK8n1aUr4br0PL8jJUpG3BQ4rwZlca5(o3Rfn(NrfJDMOD9ZScsyLUj5s5ieeNYl(dX0zQiReNgtY4P4eIVSLb8DzoJVTRSQM3sroTqEB4G4peJ5dW7aAcUpjgWqx0heIVyPmm087EMrNU9wsQ52BZ3XGYZW2TQbQraF3Gha9l19QSLB3cD1GFYzPmuX3HE(YmC989Cm6c6Uc5N8bvh1HYKCrKGrB9x)Z)xdLrYUMlWJMivp2zOibef4LIRrO)SZ)WBa4jHwQJhjeRUZ1pLSQThQwdhVqHXcrFYAYvdIecWBgwcNRfRJXRFe8ibdG47f0DZ2Kjq6iUYQVaCtFNv8pGlGPijyryBdvi6Vt0uS9PkrOcSdVzMXdqKuknsgCFiEYIcPLbZs(V(N)VHz8gA0ZW)6F()U8q2q3npuOCHfYAK9dFqjtxIj9DIgFmS2M2TE(iFeLlVJ9Esuc1NMrYFuCo7oJQoDgydSqN5bUykBWSgLQXbD(Ai3GhuDuV5JQP9hbpHVNLvh1y6t6UgGHGMHM7ENXsVgwAiiVK3NoM10hkbNV7GuRo2yEJu18o271DCiDY1FoBqj9sTZSPkIyt3UfHq7mJkQYVGcJPtJQVQ)bPXx64B0ENGvOclsFvTBgYa0HeqyRv7ci1uEo9tz8eHETROTJyH6U8K7tdssRqDSvfoYjAvgaupVAKwU6yi3jZscOPCflJdF3M1Anxj8lj76bGlpoh3NUTHmj3ez)u2cgTNmDqOfkHDTrR09u1KpUVuNHSwB(GcCkmcVWw8ZW63N01vJi53QLrPcIN8s1gFG85BXoFbb0kQWso)UnSRCcEWzPhZuhvd3j8mPW6X0U7RSaGH4)EicNfGAxKP4BF5XxqDabuK8ZWlYt21ckuY0(Q6K6FEXOmu9ofBXIVFhDAf0Aj5fstYWa)65oQEGNyxNjEINBek8zyik(rj2cIeuYbVNLKBBkUmAT(0yOOAJsZfExKiT3K0Ds6VBdeB1pmbT0LubHPPMTtt0G6xEenkjCPAC)U8qvGqjDQ6wDPZ8572fCBuWkFJRvcnndTsxZGm9ylezuAw8q3sBunr5hwhkJ6TRCdXms5HjlPcUt7i8FNTzsG7mTZSTcZpL8rA5kr4HxoY0EJMDJybwfMDBsLz2LxB2wYz1b7eL)q6QPDjHPpu4KRPLt)odXkI4ERucqz1lJeGr6ROXcfNmDc6EhEiBwGxCv(SEG27s8YBMLJt6uAOIgKooWVaKrIxg1gYgZoJrh8F24OYqV2wNSJ)cU3oMCtXaTHASMvSURvMQXmLZfHP1HY32yr3MG(JG7vxEoMpizGDaXH9ZmBM6zd73nNMYP4dqNuyIssd7kLfDkNnJS0TsXLSnLK3mMF5UTcEOU9smE63dj)SYzxx)ABW3svgAhzkTaE185yKymnN5ZJ1lsYau2rNMXOyIpZT5kGQW6mIcQ5JYWgJscsqHYQ6djoEs0yWXRZsWjkNq)sKZZM9bEhpTTu9o2qahA3Z3TFzTBTv(RFqfoLk2D50QIcsJmkoDHotJOBmq2c8ikr5i8HcYOPlYaeUilRBYISBXxQDivKrbOxKbHZwKLe)i8mg92(HIGihzu9JUUxVUS(9UPx)ZV6uyH98Op6LcDV8uwPVhGQzGLsue57zDJdV7beEGFFQiyHWN(5yS6ec8RWLodJDV8e8TJCXROV1U(0qpdSveojWHgWTIU4rrasuvnrbzNjcWEV8aosfEI(t58(w1B20(a2pm40tzx2B4X)qHD7tJ2vBd9bfePVhQ87rRdytCPDJkNouRD9QwhWOZmi(vLKFxSBCaKthi1pfVgyYPpw4F171ZZdswEoDRAdBRMhW(OxuGZxCz4JTK)jq78KlosLEf(hY(cfEC9h0NSu8V4BWl)qLpuXQ4OJh9bBB8ptXFW6jMUlfE89RFc94r7gbm6fvR9e7uARjyvPDoPgJ29ZhF)c8VxvlSSRN0bl8Yhh7tDZ(ibV9bCtFfhqlRXIUF1DA7p4ChFZ6c7BVtl4zN8EWm1(12PP(GOONRBH9RVtt)ri(JqbmQgplyi)lSqIM0u8J8e3iiAZw9L73jTP3NZWImarkd5RJxhPU8a5hdSCi)cUlD4(15j3T1R735h6n8Nh3z4P9g)ZhFgDZhXKxVBQTwsU73rG)j8oqM2Fk6Vu1mh8VHSr4x6Em91sRQksep12504a6Zvb)7QnE5iXPDpu2vqZCjwuRu4cWN9819Cp9NfdUtv7nfAxSAp8AS6maEaTrCpcXT27CwOdEVP7gkp0eRdetGyG3O(6NrJv4wopBgUPzY7WhCh8VQZL9(za7h37N)4vNp(N70TBVUVhVPKUbiaiwMqLKNBbrzwh5XmGMtaXv7BRIYEhERgqKaQae0TvaTfTqpL9qA5mbbz05sVit7Wbh7ehSMpro0b9bpReIvCAp7PTR)DHmjrSqbaFkuixCyhmtJt5YQlu4woUj642fQ(Q9uCKjeDlq4rFHwPtQu4W4RHwkFGqUPmII65M8bahWlCuSSqw4baI4N45W5UYybWGMFhULW02k)WD0ffLNyH7u677xnx(0FPhW1uTsLzNJtgUrUKae(NdafLucLGAd(xkE992q96CE96xs34u0Pv1FMJ8dgOqj2Xkzv1NA3OnG03k49JMY9HEjcluIQuzHsQbIhY4KVP)JxshyZf4jPcCCa9by)qg(rE4d4bXgVusUfrGoPFX6Y979sSnC67mOh42vEi6aV)ob46FCaEPfmeCdVI(4slOot705rKhHpg48GhDUQon21BwbQghKm1P0w6It9q8q2G3lcQ7SkKquVovD0a5hWx3ahUV87LQedVk4KFgme(4HtXPOHF8ItBF9f6aDgWoGM9vI7LFyWlDPlGK1qwiUHQRBA4FwJznJ0RnGcaWwHOQIOBee6mIXkGh9SnSJeFj7Sr7zEiB)RhcYYxDkUwK9C86NcchbPzY)UpGNd17Goou2Pl3aQntz4xDRKyIxO6Ri6S(sEq93KPvAIpIYF8CCS8a8ViZDKxmwSZeXHCSdalg4V0j5bciGo3lC685hMfMHa6KCUlX7pcJr1Di(sxF3vXRyxF)1G2bFL8ZRhXl1LyYi6qRCsm(9LUj1DPAp))PF6j5FO6XVJJpsgIrJRh(4EQJuFj6tifVt13R4)F57WZ3)Fh)I3kzshzWBA2YDoEQyQmeEyVo0QbeWunRk2TEQ45q8GWRfcVdF8w0eXH7TxXoXrcW0Ykre)WOGyo2RJ2as4rYhr1n8BufMPIQ(n0X)UdRwe)NWdFK6vY)daaGXo86ynep2zq3KF0n4B5b0kI)8sWfOy2H7rH9TNEIrPEQld892q290WaSGwGscy18wNi88DE4Jc609h2LUFDpnWz9szNPR)1WRIxbRTQpxRVi1a1yfAPAbZecmMymCDefY5L2ucajF6PIOPz4x4DBi9mIg4FfcGhiIKmM0dF0DfE0khVzn)WAfHixMJCuAe3UuCDmURl4q6lOR0MdFKtFu31xVw(9IkHc5l7FYqZhLudfKCKdqdgTu8W2CatEbDTp4C4END(PNTxr8pPquu6hAvj9HFoajy4R6ZNhDyRwwLB3UA1ATQBxh45JfRH2A3SSvTQTQwTAJ6nqjj8Axj6gx(diRG(SMD)kVV4HZ9U3RrR6ho3bcUPOUHRe4hNLexod8xELi6CFKOjFvA3Gvd75P8vHB30UVtTCB3XBWRrHpUEbEvqjHJNk27lh3TQMwRw1f(N(XZ7cSMpTxh)fl3ewcCxENZE)0HvRBx8t7DbENicshoLuxSi4FJ0H5e6qJgq7xhVyrPr3T5bOx4GOxI3e(35SWPevdvWruGpoGMvG26c2)9NJx5hOkU60ydnwVLf0ki8)x(FZl9VeZ9EhE(2PMQw3Qy347C(kkoxVvrLgp8BCXUWdcIzMdVKktEi2BFAq1Hgh6croTQuxHyfKcpWOr4gXliLzWJ)V4uI(GYsq3XGuLByPlOLp(RoZGwSQudruCloXRo8syDsof3qiAuTG2g9x(FC)F5)b4Bf)s2mrQMvHwLh1mq5lW1RuNVghWxbHGLmyi6doV0LoEBwisjeK1SPy5)dl9JGJwWXRtq4sv7xdtcDEsb2yJ6YU7ZNc2AaQaF00a8Z8vr5qIWxC5i9rGxzfhfqh(VLcbIanqi8AqhmgyYlDkDfe(wOln2gnPjg46o4XSJhyIzsy)M)Y)ZV8LTi8s4)mhoW8krxw6yXAOjSsr93RRKjCkE0PlDI8dqCfqwtO2dHyLxc))LWt)VpWELRzBeydaJlzaLg1ibvp3vZebqe2BXb67Gba7P6xNzoEyLKfBjKrcNJWafdxdwALIUpi8MtRajlj(fN7kn2bdAoze)OG7MpLLAUx4S)Y)lsOqEjcrybsxVb)Wu8D95LWVejNe5YXIPOYwhWlLNU)i9Sd(NY6sDWVtjxhImH9(goKzXkbQDsvYbV)tvuAGfeVY5RQguexcMgap)vWKViClg6tfX)WB29i0Y8vcdltD7Dm6U8t71OwLA1(D1qUmmrw2vRvP9VRQ6X61AL2w7M1AuLEcfWSQ0SEZkj90QvZg1tFSHv72YPbX0QTTA0GEcXW61RABtpHmplR6vB0kfaKtRT6rBRwkiahzJMTANmW6wvQxLEQQCAQ0SvY4GjTvJuyv2yYA0UQDdQRyJvR00gG1AAyTsJkTsGC1itWYkTQA3kfeqYJvsBnA1U1VRUcwRvXePOM0eaB7wTTOownLKxldLRwY63OvnRKrItA66bqk9ek8bYZvRunbPA1UPIIBWC0eNg21tPusUQECYjTMAsj6TLMrjrcnVODkidtFZkntESQvdBBReot1kTnKVaswtZbIWvIawBIOqcEvTSsWujjXoLLGcmBXsQRGscKRPFa4p2g4w9wkz7QPKwRu8rpLsrGK1RD9MgGSC1tiL1AxXkDfA3OPvldmxr0PhSA2YUQXA0ov0Hyij6CKCDkq3UDJAPaD7gqQWjcGvRuXQLjgskpjtBTQjCpjB2s1XA1Rz3kHmP4SAkHeHtPVuJ2QgjgJMlbksvu0gAGnS0lPbJkdsMQrq8cnG3UvfL6sk0zRXrjHZkLbGAK6hL9nLEGcIAaOwLuQQ0euDtSiXwHuckroNSoKsWju0ubupoAssLliPj7eAiojAYnsvsKjR2WqeHSGu1GFPXAQHS6O6XO0fQNGVjsQserpfs1gnXGe4SZY40CCixk7ggIdTSm7RCw1TkTSyNI2nRu3qybnFGp1uHpAoJ0qUM80SwLe7FqlvnSwybD0kJ2DRkjsg2wTTRNQ8H66jIjKsBQShXosKmLGzwYM2gpXh3YuzwJS2kesQAwBVmA06jvkjALHmzyzlzgB20G8vRPDJQMyRLHXsjyM4kGePswCKDQhNCXswbjZvtRj9oRKPSHsrJKjQAvpZYtkL6LqITAzyLTfd7G2wPmMAnRBO0iz2ADg10MmrsCoHjsYEAUOvBiDSMjsnQhtAfYtRPHMQ8XQzFCRotYTqyqRNbSNkYOFWC)akrz7ATHC6Aag4QjtsSs5kaSd2TQuRzJ22nTloY5Eog8eEWmLdgcjFehsvoBsxZHyb5QYIjFdEzPd5FVrL(n)lrzAEfvPGWmVBIhDl2fMTN4qHKdY7DDW)enfLKDnTKMDBUWpAqmD5vkFX9UHUYIqUt)Y(ceDU1Dw0smatSz5wORZ78Vxq(gT)7zKV()rd5)3p0mFY4)aD)7m09FGH)dm8FGH))Emu1XrReIOLB1DvBuHWpcWb5MH2H(Bn7WdROr2oERx6OkaV)c(ln2Jfcpy19Xrt02JK)5KTpEjFdrg)wX38N9U854feZP4eHtUAwTnMfCBxbZShD6UZdU7w4i0W4PjWiY)Wv5qzaz0wPUh9hCn8pF6F(ZDMnt4h(5p)F6c8mO7m2zb8Wk8NF(Z4aGNU4YXLUWf)Ee84BklIMV3ZiwOOP4(W4pW)4UVoNarx1OiW3ZvhWSwia5pPJcI1U5ZiF8sKJJuy)i3VYX92z7L82L4rxmilwicIKa5yCJyE9fziGlViVffCEXoKaMsX8xL6H9Nu78epqBXwkaGxw(AamZeDeES)cKecPish6ykDKiksSkdfqp(ucTEeitbOJvmJ7dsd9vuCo6zXFtXwvpoX1Bhb1bOGApV7)45F(Zxkfrhl7n8(RebRGNQUNeOGviELFykjHa6esI1U6vDcGWysTLH7m3rEUF9RobZ6nBbpCx5snyFO1tpv8A8mdcZgM33XD7D4JFQA1w1Q(tYH9jlRwvSBL(ewLl9tuPDtAQHLXdTQz3Ow6OWcsOFswcAJNQ0mPJvA0YoPjSuf6FdPCxTLXd2ns7vZKXtLgq)awkG0vPrfdKOrRAjRImd9KzRz72jWTSIbjDKQ3zsBu9qsAZyDTQun59u((gepBRkjnHLglDmyvdsFclcv6C02GCrvmkbAR1kbyBKYZSTb8n5bRw1Ryq5AvpLjzdu1KMWk6K8qBdshw1v9tuTltwECVnmqB7uqOr90zMkBSjU1m5jSOwPTG1Enf4WstLapTA2UAkeL2awzOugu9MnnxNwvmi9ntjBTBu12quTPPeyZMP8R2nQLkALc0Y9Wifcmyc1A2SvkkuTDZeIDJukvRgnQNI1uzKtMmRuXFGQLkY3SwcUq1hn5H0jcRywk2Jfs3GwyzqMQaqzcWuRsgL7kjnqvQmLibIR1n6yLMPsbyLZsqGQTSsEOzRgPeaQM0jpqBGtkeHvBZarQyWhX92kHiIBFxAlGurkTgR)vkSxTQHIbymkDYXASL(uR6gcG02niF6PIdwhDIZ94r(4P)p)') 	end)
				PluginInstallFrame.Option2:SetText(L["Copy"])
				if (not IsAddOnLoaded("MRT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Method Raid Tools"]..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["MRT is a suite of tools for raiding"])
					PluginInstallFrame.Desc3:SetText(L["Includes tracking raid cooldowns and creating notes"])
					PluginInstallFrame.Desc4:SetText(L["Alongside attendance and other features"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
			   	end
			end,
			[8] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Combat Text"])
				PluginInstallFrame.Desc1:SetText(L["Import profiles for NameplateSCT or ElvUI Floating Combat Text"])
				PluginInstallFrame.Desc2:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupNameplateSCT() end)
				PluginInstallFrame.Option1:SetText('NameplateSCT')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupFCT() end)
				PluginInstallFrame.Option2:SetText('FCT')
				if (not IsAddOnLoaded("NameplateSCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("NameplateSCT"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["FCT profile will be used"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option1:Disable()
			   	end
			   	if (not IsAddOnLoaded("ElvUI_FCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("FCT"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["NameplateSCT profile will be used"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option2:Disable()
			   	end
			   	if (not IsAddOnLoaded("ElvUI_FCT")) and (not IsAddOnLoaded("NameplateSCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["NameplateSCT and FCT are not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Combat text addons enhance the default Blizzard Combat Text"])
					PluginInstallFrame.Desc3:SetText(L["NameplateSCT and FCT make the combat text float from the nameplate/frame"])
					PluginInstallFrame.Desc4:SetText(L["And add effects to them with minimal memory usage"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
			   	end
			end,
			[9] = function()
				PluginInstallFrame.SubTitle:SetText('Immersion')
				PluginInstallFrame.Desc1:SetText(L["Import "]..'Immersion '..L["settings configured for "]..'Eltruism')
				PluginInstallFrame.Desc2:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupImmersion() end)
				PluginInstallFrame.Option1:SetText(L["Import "]..'Immersion')
				if (not IsAddOnLoaded("Immersion")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Immersion"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Immersion is an addon that changes the quest dialog with npcs"])
					PluginInstallFrame.Desc3:SetText(L["It transforms them into a talking head with dialog options on the side"])
					PluginInstallFrame.Desc4:SetText(L["Including the ability to press number keys to select an option"])
					PluginInstallFrame.Option1:Disable()
			   	end
			end,
			[10] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Dynamic Cam')
				PluginInstallFrame.Desc1:SetText(L["Import Dynamic Cam profile"])
				PluginInstallFrame.Desc2:SetText(L["You might need to swap profiles in DynamicCam settings"])
				PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDynamicCam() end)
				PluginInstallFrame.Option1:SetText(L["Overwrite"])
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'dmIvbaGnvvZKkYSPGBtQSxSBsPFQs0We)McnuvkgUQWXizPQIwSkPwov1dvv6PkltfpNIAIurnvIPlDrsvpJsxNQSrvQAZQkMgvy0Qu5KQKCAvPRrroVkHltLomP4VQuAuiSh(g)8AWfHz(TEA6RrTMry2yrOmvSiuwowekl5hHYS5GqzXArOS8hekl5GqzQeek7KGqzQCqOSykiuwokekZgfcLLycHYIvHqzNOqOS8RqOSefcLLJdeklMuiuwIdekZMGqz5eekl2GqzQOqOSyDGqPSpV(M7tpTCnL1lE4YC(7T388Y7VYj9mTA05Y0BO(UE6yA86Dg9z6nuFxpDuaa') 	end)
				PluginInstallFrame.Option2:SetText(L["Copy"])
				if (not IsAddOnLoaded("DynamicCam")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Dynamic Cam"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["DynamicCam is addon that modifies the behavior of the camera"])
					PluginInstallFrame.Desc3:SetText(L["The profile uses some effects while questing"])
					PluginInstallFrame.Desc4:SetText(L["But in instances the effects are disabled"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
			   	end
			end,
			--[[[11] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('WeakAuras')
				PluginInstallFrame.Desc1:SetText('I recommend the following WeakAura with this UI:')
				PluginInstallFrame.Desc2:SetText('Nameplate Power Bar')
				PluginInstallFrame.Desc3:SetText('Direct links can be found in the Eltruism menu')
				PluginInstallFrame.Desc4:SetText('or you can click the button for a link to my profile')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://wago.io/p/Eltreum') 	end)
				PluginInstallFrame.Option1:SetText('Wago.io')
			end,]]--
			[11] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Discord')
				PluginInstallFrame.Desc1:SetText(L["Join the Discord if you have any questions or issues (English Support)"])
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://discord.gg/cXfA56gmYW') 	end)
				PluginInstallFrame.Option1:SetText('Discord')
			end,
			[12] = function()
				PluginInstallFrame.SubTitle:SetText(L["Installation Complete"])
				PluginInstallFrame.Desc1:SetText(L["You have completed the installation process, please click Finished to reload the UI"])
				PluginInstallFrame.Desc2:SetText(L["Importance: "].."|cff82B4ff"..L["Very High"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', InstallComplete)
				PluginInstallFrame.Option1:SetText(L["Finished"])
			end,
		},
		StepTitles = {
			[1] = L["Welcome"],
			[2] = L["Layouts"],
			[3] = L["Fonts"],
			[4] = 'GladiusEx',
			[5] = 'Details',
			[6] = L["Boss Mods"],
			[7] = L["Method Raid Tools"],
			[8] = L["Combat Text"],
			[9] = 'Immersion',
			[10] = 'Dynamic Cam',
			--[11] = 'Weakauras',
			[11] = 'Discord',
			[12] = L["Installation Complete"],
		},
		StepTitlesColor = {1, 1, 1},
		StepTitlesColorSelected = {70/255, 130/255, 180/255},
		StepTitleWidth = 200,
		StepTitleButtonWidth = 180,
		StepTitleTextJustification = 'CENTER',
	}
elseif ElvUI_EltreumUI.Classic then
	-- Installer Steps Classic
	ElvUI_EltreumUI.InstallerData = {
		Title =  ElvUI_EltreumUI.Name,
		Name = ElvUI_EltreumUI.Name,
		tutorialImage = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logo.tga',
		Pages = {
			[1] = function()
					if (not IsAddOnLoaded("AddOnSkins")) and (not IsAddOnLoaded("ProjectAzilroka")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..L["AddOnSkins"]..L[" and "]..L["ProjectAzilroka"]..L[" before starting this installation process"])
						PluginInstallFrame.Next:Disable()
					else
						PluginInstallFrame.Next:Enable()
						PluginInstallFrame.SubTitle:SetFormattedText(L["Welcome"])
						PluginInstallFrame.Desc1:SetText(L["This prompt will help you install "]..ElvUI_EltreumUI.Name..L[" and import its settings"])
						PluginInstallFrame.Desc2:SetText(L["Please read the instructions to avoid issues"])
						PluginInstallFrame.Option1:Show()
						PluginInstallFrame.Option1:SetScript("OnClick", InstallComplete)
						PluginInstallFrame.Option1:SetText(L["Skip Install"])
					end
			end,
			[2] = function()
				PluginInstallFrame.SubTitle:SetText(L["Layouts"])
				PluginInstallFrame.Desc1:SetText(L["Please select the role for your character, which will create a new profile"])
				PluginInstallFrame.Desc2:SetText(L["This process can take a few seconds"])
				if myclass == 'PRIEST' or myclass == 'DRUID' or myclass == 'MONK' or myclass == 'SHAMAN' or myclass == 'PALADIN' then
					PluginInstallFrame.Desc3:SetText('|cff82B4ff'..L["You can support the group with your class, if you select DPS/Tank then its recommended to click Alt Frames after clicking DPS/Tank"]..'|r')
				end
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High"]..'|r')
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupChatClassic() ElvUI_EltreumUI:AddonSetupPA() E.data:SetProfile('Eltreum DPS/Tank') ElvUI_EltreumUI:SetupLayout('dps') ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:ResolutionOutline() end)
				PluginInstallFrame.Option1:SetText('DPS/Tank')
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:SetupChatClassic() ElvUI_EltreumUI:AddonSetupPA() E.data:SetProfile('Eltreum Healer') ElvUI_EltreumUI:SetupLayout('healer') ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:ResolutionOutline() end)
				PluginInstallFrame.Option2:SetText('Healing')
				if myclass == 'PRIEST' or myclass == 'DRUID' or myclass == 'MONK' or myclass == 'SHAMAN' or myclass == 'PALADIN' then
					PluginInstallFrame.Option3:SetText('Alt Frames')
					PluginInstallFrame.Option3:Show()
					PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AlternativeGroupsDPS() end)
				end
			end,
			[3] = function()
				PluginInstallFrame.SubTitle:SetText(L["Fonts"])
				PluginInstallFrame.Desc1:SetText(L["Eltruism uses Kimberley as the default font"])
				PluginInstallFrame.Desc2:SetText(L["You can replace it with one of the following:"])
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				--PluginInstallFrame.Option2:SetFont(E.LSM:Fetch('font', db.font), db.size, db.outline)
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsRoboto() end)
				PluginInstallFrame.Option1:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\roboto:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsExo2() end)
				PluginInstallFrame.Option2:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\exo2:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsGotham() end)
				PluginInstallFrame.Option3:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\gotham:14:112:0:1:128:64:0:128:0:16|t')
			end,
			[4] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Details')
				PluginInstallFrame.Desc1:SetText(L["Import Details! profile with dual panels"])
				PluginInstallFrame.Desc2:SetText(L["You can right click the bottom right arrow to toggle the Details! Window"])
				PluginInstallFrame.Desc3:SetText(L["Remember to swap the second window to Healing Done or Tiny Threat"])
				PluginInstallFrame.Desc4:SetText('|cffff0000'..L["Make sure to run Details! install before importing"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDT() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option1:SetText(L["Import "]..'Details v1')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDTReleaf() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option2:SetText(L["Import "]..'Details v2')
				if (not IsAddOnLoaded("Details")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Details"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Details is an advanced combat parser"])
					PluginInstallFrame.Desc3:SetText(L["It uses less memory and is more efficient than alternatives"])
					PluginInstallFrame.Desc4:SetText(L["And has many plugins to choose from"])
					PluginInstallFrame.Option1:Disable()
			   	end
			end,
			[5] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Boss Mods"])
				PluginInstallFrame.Desc1:SetText(L["Import DBM or Bigwigs profiles"])
				PluginInstallFrame.Desc2:SetText(L["These profiles are setup with DBM English Calanon and Bigwigs Voice"])
				PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDBM() end)
				PluginInstallFrame.Option1:SetText('DBM')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupBW() end)
				PluginInstallFrame.Option2:SetText('BigWigs')
				if (not IsAddOnLoaded("DBM-Core")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["DBM is not installed or enabled so BigWigs will be used"])
					PluginInstallFrame.Desc2:SetText(L["BigWigs uses BigWigs voice in its profile"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option1:Disable()
			   	end
			   	if (not IsAddOnLoaded("BigWigs")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["BigWigs is not installed or enabled so DBM will be used"])
					PluginInstallFrame.Desc2:SetText(L["DBM uses DBM English by Calanon as a voice pack"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option2:Disable()
			   	end
			   	if (not IsAddOnLoaded("DBM-Core")) and (not IsAddOnLoaded("BigWigs")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Both DBM and BigWigs are not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["No boss mods found"])
					PluginInstallFrame.Desc3:SetText(L["Boss mods are highly recommended for modern encounters"])
					PluginInstallFrame.Desc4:SetText('')
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
			   	end
			end,
			[6] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Combat Text"])
				PluginInstallFrame.Desc1:SetText(L["Import profiles for NameplateSCT or ElvUI Floating Combat Text"])
				PluginInstallFrame.Desc2:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupNameplateSCT() end)
				PluginInstallFrame.Option1:SetText('NameplateSCT')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupFCT() end)
				PluginInstallFrame.Option2:SetText('FCT')
				if (not IsAddOnLoaded("NameplateSCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("NameplateSCT"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["FCT profile will be used"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option1:Disable()
			   	end
			   	if (not IsAddOnLoaded("ElvUI_FCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("FCT"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["NameplateSCT profile will be used"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option2:Disable()
			   	end
			   	if (not IsAddOnLoaded("ElvUI_FCT")) and (not IsAddOnLoaded("NameplateSCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["NameplateSCT and FCT are not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Combat text addons enhance the default Blizzard Combat Text"])
					PluginInstallFrame.Desc3:SetText(L["NameplateSCT and FCT make the combat text float from the nameplate/frame"])
					PluginInstallFrame.Desc4:SetText(L["And add effects to them with minimal memory usage"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
			   	end
			end,
			[7] = function()
				PluginInstallFrame.SubTitle:SetText('Immersion')
				PluginInstallFrame.Desc1:SetText(L["Import "]..'Immersion '..L["settings configured for "]..'Eltruism')
				PluginInstallFrame.Desc2:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupImmersion() end)
				PluginInstallFrame.Option1:SetText(L["Import "]..'Immersion')
				if (not IsAddOnLoaded("Immersion")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Immersion"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Immersion is an addon that changes the quest dialog with npcs"])
					PluginInstallFrame.Desc3:SetText(L["It transforms them into a talking head with dialog options on the side"])
					PluginInstallFrame.Desc4:SetText(L["Including the ability to press number keys to select an option"])
					PluginInstallFrame.Option1:Disable()
			   	end
			end,
			[8] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Dynamic Cam')
				PluginInstallFrame.Desc1:SetText(L["Import Dynamic Cam profile"])
				PluginInstallFrame.Desc2:SetText(L["You might need to swap profiles in DynamicCam settings"])
				PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDynamicCam() end)
				PluginInstallFrame.Option1:SetText(L["Overwrite"])
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'dmIvbaGnvvZKkYSPGBtQSxSBsPFQs0We)McnuvkgUQWXizPQIwSkPwov1dvv6PkltfpNIAIurnvIPlDrsvpJsxNQSrvQAZQkMgvy0Qu5KQKCAvPRrroVkHltLomP4VQuAuiSh(g)8AWfHz(TEA6RrTMry2yrOmvSiuwowekl5hHYS5GqzXArOS8hekl5GqzQeek7KGqzQCqOSykiuwokekZgfcLLycHYIvHqzNOqOS8RqOSefcLLJdeklMuiuwIdekZMGqz5eekl2GqzQOqOSyDGqPSpV(M7tpTCnL1lE4YC(7T388Y7VYj9mTA05Y0BO(UE6yA86Dg9z6nuFxpDuaa') 	end)
				PluginInstallFrame.Option2:SetText(L["Copy"])
				if (not IsAddOnLoaded("DynamicCam")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Dynamic Cam"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["DynamicCam is addon that modifies the behavior of the camera"])
					PluginInstallFrame.Desc3:SetText(L["The profile uses some effects while questing"])
					PluginInstallFrame.Desc4:SetText(L["But in instances the effects are disabled"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
			   	end
			end,
			[9] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Questie')
				PluginInstallFrame.Desc1:SetText(L["Import Questie profile"])
				PluginInstallFrame.Desc2:SetText(L["You will need to reload and wait for questie to rebuild the database"])
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupQuestie() end)
				PluginInstallFrame.Option1:SetText(L["Import "])
				if (not IsAddOnLoaded("Questie")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Questie is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Questie is an addon that modifies the objective tracker"])
					PluginInstallFrame.Desc3:SetText(L["As such Questie adds a lot of features to it not available by default"])
					PluginInstallFrame.Desc4:SetText(L["Including TomTom support"])
					PluginInstallFrame.Option1:Disable()
			   	end
			end,
			[10] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Discord')
				PluginInstallFrame.Desc1:SetText(L["Join the Discord if you have any questions or issues (English Support)"])
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://discord.gg/cXfA56gmYW') 	end)
				PluginInstallFrame.Option1:SetText('Discord')
			end,
			[11] = function()
				PluginInstallFrame.SubTitle:SetText(L["Installation Complete"])
				PluginInstallFrame.Desc1:SetText(L["You have completed the installation process, please click Finished to reload the UI"])
				PluginInstallFrame.Desc2:SetText(L["Importance: "].."|cff82B4ff"..L["Very High"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', InstallComplete)
				PluginInstallFrame.Option1:SetText(L["Finished"])
			end,
		},
		StepTitles = {
			[1] = L["Welcome"],
			[2] = L["Layouts"],
			[3] = L["Fonts"],
			[4] = 'Details',
			[5] = L["Boss Mods"],
			[6] = L["Combat Text"],
			[7] = 'Immersion',
			[8] = 'Dynamic Cam',
			[9] = 'Questie',
			[10] = 'Discord',
			[11] = L["Installation Complete"],
		},
		StepTitlesColor = {1, 1, 1},
		StepTitlesColorSelected = {70/255, 130/255, 180/255},
		StepTitleWidth = 200,
		StepTitleButtonWidth = 180,
		StepTitleTextJustification = 'CENTER',
	}
elseif ElvUI_EltreumUI.TBC then
	-- Installer Steps Burning Crusade
	ElvUI_EltreumUI.InstallerData = {
		Title =  ElvUI_EltreumUI.Name,
		Name = ElvUI_EltreumUI.Name,
		tutorialImage = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logo.tga',
		Pages = {
			[1] = function()
					if (not IsAddOnLoaded("AddOnSkins")) and (not IsAddOnLoaded("ProjectAzilroka")) then
						PluginInstallFrame.SubTitle:SetFormattedText(L["WARNING"])
						PluginInstallFrame.Desc1:SetText(L["Make sure to install "]..L["AddOnSkins"]..L[" and "]..L["ProjectAzilroka"]..L[" before starting this installation process"])
						PluginInstallFrame.Next:Disable()
					else
						PluginInstallFrame.Next:Enable()
						PluginInstallFrame.SubTitle:SetFormattedText(L["Welcome"])
						PluginInstallFrame.Desc1:SetText(L["This prompt will help you install "]..ElvUI_EltreumUI.Name..L[" and import its settings"])
						PluginInstallFrame.Desc2:SetText(L["Please read the instructions to avoid issues"])
						PluginInstallFrame.Option1:Show()
						PluginInstallFrame.Option1:SetScript("OnClick", InstallComplete)
						PluginInstallFrame.Option1:SetText(L["Skip Install"])
					end
			end,
			[2] = function()
				PluginInstallFrame.SubTitle:SetText(L["Layouts"])
				PluginInstallFrame.Desc1:SetText(L["Please select the role for your character, which will create a new profile"])
				PluginInstallFrame.Desc2:SetText(L["This process can take a few seconds"])
				if myclass == 'PRIEST' or myclass == 'DRUID' or myclass == 'MONK' or myclass == 'SHAMAN' or myclass == 'PALADIN' then
					PluginInstallFrame.Desc3:SetText('|cff82B4ff'..L["You can support the group with your class, if you select DPS/Tank then its recommended to click Alt Frames after clicking DPS/Tank"]..'|r')
				end
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High"]..'|r')
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupChatClassic() ElvUI_EltreumUI:AddonSetupPA() E.data:SetProfile('Eltreum DPS/Tank') ElvUI_EltreumUI:SetupLayout('dps') ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:ResolutionOutline() end)
				PluginInstallFrame.Option1:SetText('DPS/Tank')
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:SetupChatClassic() ElvUI_EltreumUI:AddonSetupPA() E.data:SetProfile('Eltreum Healer') ElvUI_EltreumUI:SetupLayout('healer') ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:ResolutionOutline() end)
				PluginInstallFrame.Option2:SetText('Healing')
				if myclass == 'PRIEST' or myclass == 'DRUID' or myclass == 'MONK' or myclass == 'SHAMAN' or myclass == 'PALADIN' then
					PluginInstallFrame.Option3:SetText('Alt Frames')
					PluginInstallFrame.Option3:Show()
					PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AlternativeGroupsDPS() end)
				end
			end,
			[3] = function()
				PluginInstallFrame.SubTitle:SetText(L["Fonts"])
				PluginInstallFrame.Desc1:SetText(L["Eltruism uses Kimberley as the default font"])
				PluginInstallFrame.Desc2:SetText(L["You can replace it with one of the following:"])
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				--PluginInstallFrame.Option2:SetFont(E.LSM:Fetch('font', db.font), db.size, db.outline)
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsRoboto() end)
				PluginInstallFrame.Option1:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\roboto:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsExo2() end)
				PluginInstallFrame.Option2:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\exo2:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsGotham() end)
				PluginInstallFrame.Option3:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\gotham:14:112:0:1:128:64:0:128:0:16|t')
			end,
			[4] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Details')
				PluginInstallFrame.Desc1:SetText(L["Import Details! profile with dual panels"])
				PluginInstallFrame.Desc2:SetText(L["You can right click the bottom right arrow to toggle the Details! Window"])
				PluginInstallFrame.Desc3:SetText(L["Remember to swap the second window to Healing Done or Tiny Threat"])
				PluginInstallFrame.Desc4:SetText('|cffff0000'..L["Make sure to run Details! install before importing"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDT() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option1:SetText(L["Import "]..'Details v1')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDTReleaf() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option2:SetText(L["Import "]..'Details v2')
				if (not IsAddOnLoaded("Details")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Details"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Details is an advanced combat parser"])
					PluginInstallFrame.Desc3:SetText(L["It uses less memory and is more efficient than alternatives"])
					PluginInstallFrame.Desc4:SetText(L["And has many plugins to choose from"])
					PluginInstallFrame.Option1:Disable()
			   	end
			end,
			[5] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Boss Mods"])
				PluginInstallFrame.Desc1:SetText(L["Import DBM or Bigwigs profiles"])
				PluginInstallFrame.Desc2:SetText(L["These profiles are setup with DBM English Calanon and Bigwigs Voice"])
				PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDBM() end)
				PluginInstallFrame.Option1:SetText('DBM')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupBW() end)
				PluginInstallFrame.Option2:SetText('BigWigs')
				if (not IsAddOnLoaded("DBM-Core")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["DBM is not installed or enabled so BigWigs will be used"])
					PluginInstallFrame.Desc2:SetText(L["BigWigs uses BigWigs voice in its profile"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option1:Disable()
			   	end
			   	if (not IsAddOnLoaded("BigWigs")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["BigWigs is not installed or enabled so DBM will be used"])
					PluginInstallFrame.Desc2:SetText(L["DBM uses DBM English by Calanon as a voice pack"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option2:Disable()
			   	end
			   	if (not IsAddOnLoaded("DBM-Core")) and (not IsAddOnLoaded("BigWigs")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Both DBM and BigWigs are not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["No boss mods found"])
					PluginInstallFrame.Desc3:SetText(L["Boss mods are highly recommended for modern encounters"])
					PluginInstallFrame.Desc4:SetText('')
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
			   	end
			end,
			[6] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Arenas"])
				PluginInstallFrame.Desc1:SetText(L["Import profiles for Gladius or Gladdy"])
				PluginInstallFrame.Desc2:SetText('|cffff0000'..L["You might need to swap profiles to Eltreum in their settings"]..'|r')
				PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupGladius() end)
				PluginInstallFrame.Option1:SetText('Gladius')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:SetupGladdy() end)
				PluginInstallFrame.Option2:SetText('Gladdy')
				if (not IsAddOnLoaded("Gladius")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Gladius is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Gladdy profile will be used"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["You might need to swap profiles to Eltreum in their settings"]..'|r')
					PluginInstallFrame.Desc4:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Option1:Disable()
				end
				if (not IsAddOnLoaded("Gladdy")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Gladdy is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Gladius profile will be used"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["You might need to swap profiles to Eltreum in their settings"]..'|r')
					PluginInstallFrame.Desc4:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Option2:Disable()
				end
				if (not IsAddOnLoaded("Gladius")) and (not IsAddOnLoaded("Gladdy")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Gladdy and Gladius are not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Arena unitframes enhance the default Blizzard unitframes"])
					PluginInstallFrame.Desc3:SetText(L["Giving them additional features like DR tracking, trinket tracking, buffs and cooldowns"])
					PluginInstallFrame.Desc4:SetText(L["Being used by players for many years since 2008"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
				end
			end,
			[7] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Combat Text"])
				PluginInstallFrame.Desc1:SetText(L["Import profiles for NameplateSCT or ElvUI Floating Combat Text"])
				PluginInstallFrame.Desc2:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupNameplateSCT() end)
				PluginInstallFrame.Option1:SetText('NameplateSCT')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupFCT() end)
				PluginInstallFrame.Option2:SetText('FCT')
				if (not IsAddOnLoaded("NameplateSCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("NameplateSCT"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["FCT profile will be used"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option1:Disable()
			   	end
			   	if (not IsAddOnLoaded("ElvUI_FCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("FCT"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["NameplateSCT profile will be used"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option2:Disable()
			   	end
			   	if (not IsAddOnLoaded("ElvUI_FCT")) and (not IsAddOnLoaded("NameplateSCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["NameplateSCT and FCT are not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Combat text addons enhance the default Blizzard Combat Text"])
					PluginInstallFrame.Desc3:SetText(L["NameplateSCT and FCT make the combat text float from the nameplate/frame"])
					PluginInstallFrame.Desc4:SetText(L["And add effects to them with minimal memory usage"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
			   	end
			end,
			[8] = function()
				PluginInstallFrame.SubTitle:SetText('Immersion')
				PluginInstallFrame.Desc1:SetText(L["Import "]..'Immersion '..L["settings configured for "]..'Eltruism')
				PluginInstallFrame.Desc2:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupImmersion() end)
				PluginInstallFrame.Option1:SetText(L["Import "]..'Immersion')
				if (not IsAddOnLoaded("Immersion")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Immersion"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Immersion is an addon that changes the quest dialog with npcs"])
					PluginInstallFrame.Desc3:SetText(L["It transforms them into a talking head with dialog options on the side"])
					PluginInstallFrame.Desc4:SetText(L["Including the ability to press number keys to select an option"])
					PluginInstallFrame.Option1:Disable()
			   	end
			end,
			[9] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Dynamic Cam')
				PluginInstallFrame.Desc1:SetText(L["Import Dynamic Cam profile"])
				PluginInstallFrame.Desc2:SetText(L["You might need to swap profiles in DynamicCam settings"])
				PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDynamicCam() end)
				PluginInstallFrame.Option1:SetText(L["Overwrite"])
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'dmIvbaGnvvZKkYSPGBtQSxSBsPFQs0We)McnuvkgUQWXizPQIwSkPwov1dvv6PkltfpNIAIurnvIPlDrsvpJsxNQSrvQAZQkMgvy0Qu5KQKCAvPRrroVkHltLomP4VQuAuiSh(g)8AWfHz(TEA6RrTMry2yrOmvSiuwowekl5hHYS5GqzXArOS8hekl5GqzQeek7KGqzQCqOSykiuwokekZgfcLLycHYIvHqzNOqOS8RqOSefcLLJdeklMuiuwIdekZMGqz5eekl2GqzQOqOSyDGqPSpV(M7tpTCnL1lE4YC(7T388Y7VYj9mTA05Y0BO(UE6yA86Dg9z6nuFxpDuaa') 	end)
				PluginInstallFrame.Option2:SetText(L["Copy"])
				if (not IsAddOnLoaded("DynamicCam")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Dynamic Cam"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["DynamicCam is addon that modifies the behavior of the camera"])
					PluginInstallFrame.Desc3:SetText(L["The profile uses some effects while questing"])
					PluginInstallFrame.Desc4:SetText(L["But in instances the effects are disabled"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
			   	end
			end,
			[10] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Questie')
				PluginInstallFrame.Desc1:SetText(L["Import Questie profile"])
				PluginInstallFrame.Desc2:SetText(L["You will need to reload and wait for questie to rebuild the database"])
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupQuestie() end)
				PluginInstallFrame.Option1:SetText(L["Import "])
				if (not IsAddOnLoaded("Questie")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Questie is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Questie is an addon that modifies the objective tracker"])
					PluginInstallFrame.Desc3:SetText(L["As such Questie adds a lot of features to it not available by default"])
					PluginInstallFrame.Desc4:SetText(L["Including TomTom support"])
					PluginInstallFrame.Option1:Disable()
			   	end
			end,
			[11] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Discord')
				PluginInstallFrame.Desc1:SetText(L["Join the Discord if you have any questions or issues (English Support)"])
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://discord.gg/cXfA56gmYW') 	end)
				PluginInstallFrame.Option1:SetText('Discord')
			end,
			[12] = function()
				PluginInstallFrame.SubTitle:SetText(L["Installation Complete"])
				PluginInstallFrame.Desc1:SetText(L["You have completed the installation process, please click Finished to reload the UI"])
				PluginInstallFrame.Desc2:SetText(L["Importance: "].."|cff82B4ff"..L["Very High"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', InstallComplete)
				PluginInstallFrame.Option1:SetText(L["Finished"])
			end,
		},
		StepTitles = {
			[1] = L["Welcome"],
			--[[[2] = 'ProjectAzilroka',]]--
			[2] = L["Layouts"],
			[3] = L["Fonts"],
			[4] = 'Details',
			[5] = L["Boss Mods"],
			[6] = L["Arenas"],
			[7] = L["Combat Text"],
			[8] = 'Immersion',
			[9] = 'Dynamic Cam',
			[10] = 'Questie',
			[11] = 'Discord',
			[12] = L["Installation Complete"],
		},
		StepTitlesColor = {1, 1, 1},
		StepTitlesColorSelected = {70/255, 130/255, 180/255},
		StepTitleWidth = 200,
		StepTitleButtonWidth = 180,
		StepTitleTextJustification = 'CENTER',
	}
end
