local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

local ReloadUI = ReloadUI
local format = string.format

-- Set version & reload on "Skip" and "Finished"
local function InstallComplete()
	E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
	ReloadUI()
end


-- Installer Steps
ElvUI_EltreumUI.InstallerData = {
	Title =  ElvUI_EltreumUI.Name,
	Name = ElvUI_EltreumUI.Name,
	tutorialImage = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logo.tga',
	Pages = {
		[1] = function()	
			 -- Welcome Page or SLE/WT warning
                if (not IsAddOnLoaded("ElvUI_WindTools")) and (not IsAddOnLoaded("ElvUI_SLE")) then  
                    PluginInstallFrame.SubTitle:SetFormattedText("WARNING")
                    PluginInstallFrame.Desc1:SetText("Make sure to install Shadow and Light and Windtools before starting this installation process")
                    PluginInstallFrame.Next:Disable()
                else
					PluginInstallFrame.Next:Enable()
                    PluginInstallFrame.SubTitle:SetFormattedText("Welcome")
                    PluginInstallFrame.Desc1:SetText('This prompt will help you install ' ..ElvUI_EltreumUI.Name.. ' and import the settings needed')
                    PluginInstallFrame.Desc2:SetText('Please read the instructions to avoid issues')
                    PluginInstallFrame.Option1:Show()
                    PluginInstallFrame.Option1:SetScript("OnClick", InstallComplete)
                    PluginInstallFrame.Option1:SetText('Skip Process')
                end
		end,
		[2] = function()
			PluginInstallFrame.SubTitle:SetFormattedText('CVars')
			PluginInstallFrame.Desc1:SetText('This button will apply my CVars, which are listed in the menu')
			PluginInstallFrame.Desc2:SetText('Importance: |c4682B4ffOptional|r')
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupCVars() end)
			PluginInstallFrame.Option1:SetText('Setup CVars')
		end,
		[3] = function()
			PluginInstallFrame.SubTitle:SetText('Project Azilroka')
			PluginInstallFrame.Desc1:SetText('This button will import my settings for Project Azilroka')
			PluginInstallFrame.Desc2:SetText('Importance: |c4682B4ffOptional|r')
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupPA() end)
			PluginInstallFrame.Option1:SetText('Setup Project Azilroka')
		end,
		[4] = function()
			PluginInstallFrame.SubTitle:SetText('Layouts')
			PluginInstallFrame.Desc1:SetText('Please select the role for your character, this will create a new profile')
			PluginInstallFrame.Desc2:SetText('Importance: |c4682B4ffVery High|r')
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() E.data:SetProfile('Eltreum DPS/Tank') ElvUI_EltreumUI:SetupLayout('dps') ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:SetupStyleFilters() end)
			PluginInstallFrame.Option1:SetText('DPS/Tank')
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript('OnClick', function() E.data:SetProfile('Eltreum Healer') ElvUI_EltreumUI:SetupLayout('healer') ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:SetupStyleFilters() end)
			PluginInstallFrame.Option2:SetText('Healing')
		end,
		[5] = function()
			PluginInstallFrame.SubTitle:SetFormattedText('GladiusEx')
			PluginInstallFrame.Desc1:SetText('This button will import my GladiusEx profile')
			PluginInstallFrame.Desc2:SetText('You will need to change the profile in GladiusEx options')
			PluginInstallFrame.Desc3:SetText('|cffff0000Your current settings will be lost, please back them up|r')
			PluginInstallFrame.Desc4:SetText('Importance: |c4682B4ffHigh|r')
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupGladiusEx() end)
			PluginInstallFrame.Option1:SetText('Import GladiusEx')
		end,
		[6] = function()
			PluginInstallFrame.SubTitle:SetFormattedText('Details')
			PluginInstallFrame.Desc1:SetText('This button will import my profile dual profile for Details! Damage Meter')
			PluginInstallFrame.Desc2:SetText('Importance: |c4682B4ffHigh|r')
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDT() end)
			PluginInstallFrame.Option1:SetText('Setup Details')
		end,
		[7] = function()
			PluginInstallFrame.SubTitle:SetFormattedText('Boss Mods')
			PluginInstallFrame.Desc1:SetText('Choose between DBM and BigWigs')
			PluginInstallFrame.Desc2:SetText('I recommend using DBM VEM or BigWigs Voice along with these profiles')
			PluginInstallFrame.Desc3:SetText('Importance: |c4682B4ffOptional|r')
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDBM() end)
			PluginInstallFrame.Option1:SetText('DBM')
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupBW() end)
			PluginInstallFrame.Option2:SetText('BigWigs')
		end,
		[8] = function()
			PluginInstallFrame.SubTitle:SetFormattedText('Exorsus Raid Tools')
			PluginInstallFrame.Desc1:SetText('This will import my ExRT profile with Raid CDs and Note positions')
			PluginInstallFrame.Desc2:SetText('Overwrite will erase settings, while Copy will open a Dialog.')
			PluginInstallFrame.Desc3:SetText('|cffff0000Your current settings will be lost with overwrite, please back them up|r')
			PluginInstallFrame.Desc4:SetText('Importance: |c4682B4ffOptional|r')
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupExRT() end)
			PluginInstallFrame.Option1:SetText('Overwrite')
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'EXRTP1TN1wVTnUs4)kf(LZlcgKususyHEioxCd200a7KnhGMffQw02cvw0qsoPPg()(zgEvoPB2ZdlW5a0wueRHC4C5BMHIC0519TIDB(xDV78)9SBdib7Nu03xlMj6Y3pVVTOViF07VC67hDiywrv5PRfl(A((j7wUSt)CF7orWmrr5Zk6Rel7Z58XzKWucjJhfghpy6lAl2iUTAJO9IIsrE0GP0s6gzFLSzWaxux091Z)22CwWStV)ZFOQPkFzrDN4LsD(IIAronIoyIBLBZJZIhNKXJjPjPzeEWCrt5Cr9sT4lR6k(sT4QlMPPVxuSv2CEZI157pCi4pQ6Uw2lY3xIiX(9J4eYzNFA45zNs5K4SqgNXbSXmXKZjtsGj4KSW4q6OGSqqiDp3S4ZAbaukVhq3UTIf4ZWJFIZ(ZCkj4t8q9VSyI9bQzMi7agw4X2bmpW52bsSpKAFiZ8a3kwoiwwm(aQzo(Gv1onHAGXWhSsMBLm3kzUvYjgjB)LsmUuc1oGrbjm7agfL4CA3moFZ51gtioXycXPk5cW5ZBHOEqpGK3k)9Q66tAkQF(7ICgzWG6GlMoqPHJzeskNZZYa3tLWs5SKXj8mselJNMgOZLYibNuVDDbOhsWz6eLz3RfLObPk1ehvOe8XM6NVS5u5MVu0RM)qGohAsDXIVEDHkKFWTOjNC6VpD2hV76ZgfCYUE5vYIsCETHLfnolnIgXP0ukM8wV8wX36Zhnk4IQVPv)h31xx1im2cA6tafLtcqoP5JEhytBXYQUlKTBG67QMv)aV4czt)8QVJ1qbZlEuCsD91IN0ZDvrx)DBHCybA)Grxx99Vx0woAacPCVxWi6hUrWSDaQPSSiEejl4(QY(15HC6yc8Vqsmnjon4CLnD)ArZmXcr1JIbXosu44OmgHhdbQeTgZ3dyH6)hEPjOuiycVxuTADFEkntPjoKlgdGj6WA35YMEr7YIfIhE4KYYp209WdNx)4Dx(zZ(J3D5dp8brzvXdpGlcM(3R28frBT45XY(LJcotSulPBGABjKb(U5YDnLD6SHBALBGmGst2WLnpwbgNuwNV)EzBzx(Ok1qVBJ4DgnQZfmluJaWYMaBRzsQuBhFw1YLy5RHVzfnFf3Ne(bsXuC5(deiKY(Bx3k6wlRlb2(aGtIwCuC)iabXh)GOFTSmF0Qw5UTJScwN0os7nt3vvxATbqHua3LDD3x0VyTOnFVuNRDwXMIvIPTfBxRzEjge6UE3gq3gEUr2vPzUQZ4wMzEVOaYPxny5q5YIVcdPL78TI66o1gQFOOfD3Auein6gxvbg2E97SMIUcWq1MTY2E1(frbBBLlRQfAjC)A5n7QXcbmFvUAfwGSxxCeVD7vIvGjnSIX96IHfqglzsbGbZxlF6LrGHXIJ3XylOCCVQwCRnhXNBvzTWqQTcstPJXDSIsJvzV6cISKX0iwkJbBxZXul81k9)rL4jmuCQSw2cL0xjF6Y6hR5PXM3DAN4AP6vDkl79vLaD)LniOPhYZgOnKZPInDVCQxpMrDVKX)OaE6UTRAXx9RSJdbN)TtpJzXAJwx1m9UlpdcntuiWYD1GJYoeSRt0E2emgDk8oyS65tJGnsII(TOr)zo8sSrXrPEISKiotrbVeBeLKeNq(nMzsAAcCKahjNMLLPOOaflJY5kQqKvAm8cpNynck0qgstn6e5LdNXWj0y4fzmfftlgssQBDGqt5ERtpPthzSqUIvCsgjjeSUiR1bhVi1zRMvA1jdEprk1tsYICQmIm0l4PzPoFmmmnJ(BXgfQrJiNg4WBGCSIsH6KcylkkCgifKryoZonlXGIXEa3Al8WypwOJuHUifk0Jqu6XwTDoJrAINjKefzScg4HHuh2RGbhRqwINtJD5sAYuOGk8byPtZAij0d6ykHl7bTrRe4qoyO3z0Gh1BX(qdggDsmdoAJ3e1Y3bwrzeQxKz8eQp0XOjPHSJJ40HO8XPJEuwLg74mIPEoYfoOggJIJc1qEKpcy9hfgXoo6eoColycz0eJdQQP4uRghGNwJjdU6qQR2W4Gup2Gj8wsT5XmMhOeilWk2iYaVhTMHvcHdNWd8QWL1f01HwKaoQVb3rk1EnSbWxOXgut4sTZ8v8kH53pcooINp9woXw9s5jKyFTJQIWvaQ8yR207)CSb72Yrd62fIgPnoQJXwgdPW9vucj2bIUmtsklLmyNkfc5cK6yU1W1Ljw8xBBo1JjJwGgMI53trRrMxJ0H1RjjChoP3uXv8gLeACJyhYytJn5nhVs6r(OBlonqf6mNmFO1elSGJQw3L7OkPCjQQkARmZ8BBLerC7TQxInLYuf633p2eVSjv2eBDkGR0ctXCfeAqWh94MDOh4z26vZUD0JWeNRHbi7umgnMZgGcW9znzbWBI3wcinXFYCqPJdJG7ofZH8Hi9jwiJjqygkTjrWDRctcvxRaF)DT0E9(fY65c4CBhFcGL4f6NkAeTfMtruTq2ahg8zZzbHl2C00BuhBT7OX(cEza8uHhnkU0DTIF0yN0ub3oYDupLkhY2s4O)hDxRhR6Q(svDv)ZVIVJhaDh9TDsiQPNVUOeoHO5qq)S488SFMD(4)FZ5)NZn)XW4VC3FYC3F5H)Yd)Lh()Ep0W48nsz)6xWUzovxzW2eJn6RP8Kf9vpkMLtSoRQTUMUb1Ss8wR9uPSg0EdUAf2or0)Kq0Cf4GDWHq)V1F)Xs)mXYID19trbHc3i1WbsX0A(jtFTCWoaJRWAJtZ1N)6FO2((JZcmqi2dWMp2C6z)9ap6DMvPS26k75JTXCmC4xfC06K)I0H3Y7Ny8EDx(zVsL3VUQBRO9yVq22RnYBXMa(3RKz4xJ5TcLZYF9zGDROUORZkXb1p1YNmFOhJzz5X79oTor2wkA1(OoN5KMfRbdr23l38Ay1Po6WJRbxc1QRx9bDEZyjcYVP))xZWW40BZXuphxuv)gPYUe4B1CdJFTSDdqXg96sOtAHtS4HDSJW2V0Z5LReDVg8Sguo9WHGBARKTG0mTOnF)NIsItJ)t9Y(K6QVwcDxSSuaFmhHUdpok8MVorKKLfzju9(1lpwi3sO6UHLq3hGbchUiRFUWmVIW7I7PWgB44t1AtVmWwc4SDSRdoc)Au9u1zRHXEHP6NRtyy7i92d2(w3IWUP49wM)XmIJj91)hiBItAQR37NXJCypV8aN6JQAiu9hWbJEJmjH7rgSHqdWZeVfJO2aenJh5enpEqWpLR(8YAQKiN0WUR4ycCFNGv9hBGfq9odnnmzOOtgGaQoj6eo2)oNav93WbirPdZKiEejImiUX9ezCwO36idxVQ3MdWh1Nl3ycyZHDtHFcapcB9Vd4xR9IIhXpn1H)Zp') 	end)
			PluginInstallFrame.Option2:SetText('Copy')
		end,
		[9] = function()
			PluginInstallFrame.SubTitle:SetFormattedText('Combat Text')
			PluginInstallFrame.Desc1:SetText('Choose between NameplateSCT or ElvUI Floating Combat Text')
			PluginInstallFrame.Desc2:SetText('Importance: |c4682B4ffOptional|r')
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupNameplateSCT() end)
			PluginInstallFrame.Option1:SetText('NameplateSCT')
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupFCT() end)
			PluginInstallFrame.Option2:SetText('FCT')
		end,
		[10] = function()
			PluginInstallFrame.SubTitle:SetText('Immersion')
			PluginInstallFrame.Desc1:SetText('This will import my Immersion profile which fits the UI')
			PluginInstallFrame.Desc2:SetText('Importance: |c4682B4ffOptional|r')
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupImmersion() end)
			PluginInstallFrame.Option1:SetText('Import Immersion')
		end,
		[11] = function()
			PluginInstallFrame.SubTitle:SetFormattedText('Dynamic Cam')
			PluginInstallFrame.Desc1:SetText('This will import my DynamicCam profile')
			PluginInstallFrame.Desc2:SetText('Overwrite will erase settings, while Copy will open a Dialog which you can import tinto DynamicCam settings')
			PluginInstallFrame.Desc3:SetText('|cffff0000Your current settings will be lost with overwrite, please back them up|r')
			PluginInstallFrame.Desc4:SetText('Importance: |c4682B4ffOptional|r')
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDynamicCam() end)
			PluginInstallFrame.Option1:SetText('Overwrite')
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'dmIvbaGnvvZKkYSPGBtQSxSBsPFQs0We)McnuvkgUQWXizPQIwSkPwov1dvv6PkltfpNIAIurnvIPlDrsvpJsxNQSrvQAZQkMgvy0Qu5KQKCAvPRrroVkHltLomP4VQuAuiSh(g)8AWfHz(TEA6RrTMry2yrOmvSiuwowekl5hHYS5GqzXArOS8hekl5GqzQeek7KGqzQCqOSykiuwokekZgfcLLycHYIvHqzNOqOS8RqOSefcLLJdeklMuiuwIdekZMGqz5eekl2GqzQOqOSyDGqPSpV(M7tpTCnL1lE4YC(7T388Y7VYj9mTA05Y0BO(UE6yA86Dg9z6nuFxpDuaa') 	end)
			PluginInstallFrame.Option2:SetText('Copy')
		end,
		[12] = function()
			PluginInstallFrame.SubTitle:SetFormattedText('WeakAuras')
			PluginInstallFrame.Desc1:SetText('I dont really make class based Weakauras, but you can check the ones I make there.')
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://wago.io/p/Eltreum') 	end)
			PluginInstallFrame.Option1:SetText('Wago.io')
		end,
		[13] = function()
			PluginInstallFrame.SubTitle:SetText('Installation Complete')
			PluginInstallFrame.Desc1:SetText('You have completed the installation process, please click "Finished" to reload the UI')
			PluginInstallFrame.Desc2:SetText('Importance: |c4682B4ffVery High|r')
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', InstallComplete)
			PluginInstallFrame.Option1:SetText('Finished')
		end,
	},
	StepTitles = {
		[1] = 'Welcome',
		[2] = 'CVars',
		[3] = 'ProjectAzilroka',
		[4] = 'Layouts',
		[5] = 'GladiusEx',
		[6] = 'Details',
		[7] = 'Boss Mods',
		[8] = 'Exorsus Raid Tools',
		[9] = 'Combat Text',
		[10] = 'Immersion',
		[11] = 'Dynamic Cam',
		[12] = 'WeakAuras',
		[13] = 'Installation Complete',
	},
	StepTitlesColor = {1, 1, 1},
	StepTitlesColorSelected = {70/255, 130/255, 180/255},
	StepTitleWidth = 200,
	StepTitleButtonWidth = 180,
	StepTitleTextJustification = 'CENTER',
}
