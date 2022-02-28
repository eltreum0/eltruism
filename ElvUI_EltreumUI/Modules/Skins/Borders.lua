local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G

--Borders on frames
function ElvUI_EltreumUI:Borders()
	--print("border spam")
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif not E.private.ElvUI_EltreumUI then
		return
	end
	if E.db.ElvUI_EltreumUI.borders.borders then

		--borders not nice with transparent power
		if E.db["unitframe"]["units"]["player"]["power"]["width"] == "spaced" then
			E.db["unitframe"]["colors"]["transparentPower"] = false
		end

		-- and doesnt look nice with shadows either
		--[[if _G["ElvUF_Player_HealthBar"].shadow then
			_G["ElvUF_Player_HealthBar"].shadow:Hide()
		end

		if _G["ElvUF_Target_HealthBar"].shadow then
			_G["ElvUF_Target_HealthBar"].shadow:Hide()
		end

		if _G["ElvUF_TargetTarget_HealthBar"].shadow then
			_G["ElvUF_TargetTarget_HealthBar"].shadow:Hide()
		end]]

		local bordertexture
		if E.db.ElvUI_EltreumUI.borders.texture then
			bordertexture = E.LSM:Fetch("border", E.db.ElvUI_EltreumUI.borders.texture)
			if bordertexture == nil then --the border was not found so apply the default
				bordertexture = E.LSM:Fetch("border", "Eltreum-Border-1")
				E.db.ElvUI_EltreumUI.borders.texture = "Eltreum-Border-1"
				--bordertexture = "Interface\\Addons\\ElvUI_EltreumUI\\Media\border\\Eltreum-Border-1.tga"
			end
		else --use default if value is nil
			bordertexture = "Interface\\Addons\\ElvUI_EltreumUI\\Media\border\\Eltreum-Border-1.tga"
		end
		local classcolor
		if E.db.ElvUI_EltreumUI.borders.classcolor then
				classcolor = E:ClassColor(E.myclass, true)
		end
		if not E.db.ElvUI_EltreumUI.borders.classcolor then
			classcolor = {
				r = E.db.ElvUI_EltreumUI.bordercolors.r,
				g = E.db.ElvUI_EltreumUI.bordercolors.g,
				b = E.db.ElvUI_EltreumUI.bordercolors.b
			}
		end

		local playertargetsize = E.db.ElvUI_EltreumUI.borders.playertargetsize
		local baredgesize = E.db.ElvUI_EltreumUI.borders.baredgesize
		local xbar = E.db.ElvUI_EltreumUI.borders.bar1xborder
		local ybar = E.db.ElvUI_EltreumUI.borders.bar1yborder
		local xbar2 = E.db.ElvUI_EltreumUI.borders.bar2xborder
		local ybar2 = E.db.ElvUI_EltreumUI.borders.bar2yborder
		local xbar3 = E.db.ElvUI_EltreumUI.borders.bar3xborder
		local ybar3 = E.db.ElvUI_EltreumUI.borders.bar3yborder
		local xbar4 = E.db.ElvUI_EltreumUI.borders.bar4xborder
		local ybar4 = E.db.ElvUI_EltreumUI.borders.bar4yborder
		local xbar5 = E.db.ElvUI_EltreumUI.borders.bar5xborder
		local ybar5 = E.db.ElvUI_EltreumUI.borders.bar5yborder
		local xbar6 = E.db.ElvUI_EltreumUI.borders.bar6xborder
		local ybar6 = E.db.ElvUI_EltreumUI.borders.bar6yborder

		--elvui unitframes
		if E.private.unitframe.enable then

			if E.db.ElvUI_EltreumUI.borders.playerborder and E.db.unitframe.units.player.enable then
				local playerborder = CreateFrame("Frame", "EltruismPlayerBorder", _G.ElvUF_Player_HealthBar, BackdropTemplateMixin and "BackdropTemplate")
				playerborder:SetSize(E.db.ElvUI_EltreumUI.borders.xplayer, E.db.ElvUI_EltreumUI.borders.yplayer)
				playerborder:SetPoint("CENTER", _G.ElvUF_Player_HealthBar, "CENTER", 0, 0)
				playerborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = playertargetsize,
				})
				playerborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				playerborder:SetFrameStrata("LOW")
			end

			if E.db.ElvUI_EltreumUI.borders.playercastborder and E.db.unitframe.units.player.castbar.enable  then
				local playercastbarborder = CreateFrame("Frame", "EltruismPlayerCastBarBorder", _G.ElvUF_Player_CastBar, BackdropTemplateMixin and "BackdropTemplate")
				local isattachedplayer = E.db.unitframe.units.player.castbar.iconAttached
				if isattachedplayer == false then
					playercastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xplayercast + E.db.unitframe.units.player.castbar.iconSize, E.db.ElvUI_EltreumUI.borders.yplayercast)
					playercastbarborder:SetPoint("CENTER", _G["ElvUF_Player_CastBar"], "CENTER", -E.db.unitframe.units.player.castbar.iconSize/2, 0)
				elseif isattachedplayer == true then
					playercastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xplayercast, E.db.ElvUI_EltreumUI.borders.yplayercast)
					playercastbarborder:SetPoint("CENTER", _G["ElvUF_Player_CastBar"], "CENTER", -E.db.unitframe.units.player.castbar.iconSize/2, 0)
				end
				--playercastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xplayercast, E.db.ElvUI_EltreumUI.borders.yplayercast)
				--playercastbarborder:SetPoint("CENTER", _G.ElvUF_Player_CastBar, "CENTER", 0, 0)
				playercastbarborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = playertargetsize,
				})
				playercastbarborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				playercastbarborder:SetFrameStrata("HIGH")
			end

			if E.db.ElvUI_EltreumUI.borders.targetborder and E.db.unitframe.units.target.enable then
				local targetborder = CreateFrame("Frame", "EltruismTargetBorder", _G.ElvUF_Target_HealthBar, BackdropTemplateMixin and "BackdropTemplate")
				targetborder:SetSize(E.db.ElvUI_EltreumUI.borders.xtarget, E.db.ElvUI_EltreumUI.borders.ytarget)
				targetborder:SetPoint("CENTER", _G.ElvUF_Target_HealthBar, "CENTER", 0 ,0)
				targetborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = playertargetsize,
				})
				targetborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				targetborder:SetFrameStrata("LOW")
			end

			if E.db.ElvUI_EltreumUI.borders.targetcastborder and E.db.unitframe.units.target.castbar.enable then
				local targetcastbarborder = CreateFrame("Frame", "EltruismTargetCastBarBorder", _G.ElvUF_Target_CastBar, BackdropTemplateMixin and "BackdropTemplate")
				local isattachedtarget = E.db.unitframe.units.target.castbar.iconAttached
				if isattachedtarget == false then
					targetcastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xcasttarget + E.db.unitframe.units.target.castbar.iconSize, E.db.ElvUI_EltreumUI.borders.ycasttarget)
					targetcastbarborder:SetPoint("CENTER", _G["ElvUF_Target_CastBar"], "CENTER", -E.db.unitframe.units.target.castbar.iconSize/2, 0)
				elseif isattachedtarget == true then
					targetcastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xcasttarget, E.db.ElvUI_EltreumUI.borders.ycasttarget)
					targetcastbarborder:SetPoint("CENTER", _G["ElvUF_Target_CastBar"], "CENTER", -E.db.unitframe.units.target.castbar.iconSize/2, 0)
				end
				--targetcastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xcasttarget, E.db.ElvUI_EltreumUI.borders.ycasttarget)
				--targetcastbarborder:SetPoint("CENTER", _G.ElvUF_Target_CastBar, "CENTER", 0, 0)
				targetcastbarborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = playertargetsize,
				})
				targetcastbarborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				targetcastbarborder:SetFrameStrata("HIGH")
			end

			if E.db.ElvUI_EltreumUI.borders.targettargetborder and E.db.unitframe.units.targettarget.enable then
				local targettargetborder = CreateFrame("Frame", "EltruismTargetTargetBorder", _G.ElvUF_TargetTarget_HealthBar, BackdropTemplateMixin and "BackdropTemplate")
				targettargetborder:SetSize(E.db.ElvUI_EltreumUI.borders.xtargettarget, E.db.ElvUI_EltreumUI.borders.ytargettarget)
				targettargetborder:SetPoint("CENTER", _G.ElvUF_TargetTarget_HealthBar, "CENTER", 0 ,0)
				targettargetborder:SetBackdrop({
					edgeFile = bordertexture,
					edgeSize = playertargetsize,
				})
				targettargetborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
				targettargetborder:SetFrameStrata("LOW")
			end
		end

		--elvui action bars
		--[[local elvuiab = E.private.actionbarenable
		if elvuiab == nil then
			elvuiab = true
		end
		if elvuiab then]]
		if E.private.actionbar.enable then
			--action bar 1
			if E.db.ElvUI_EltreumUI.borders.bar1borders and E.db.actionbar.bar1.enabled then
				local borders1 = {}
				for i = 1,12 do
					table.insert(borders1, _G["ElvUI_Bar1Button"..i])
				end
				local function createbar1borders()
					for _,v in pairs(borders1) do
						local barborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						barborder:SetSize(xbar, ybar)
						barborder:SetPoint("CENTER", v, "CENTER")
						barborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize,
						})
						barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					end
				end
				createbar1borders()
			end

			--bar2
			if E.db.ElvUI_EltreumUI.borders.bar2borders and E.db.actionbar.bar2.enabled then
				local borders2 = {}
				for i = 1,12 do
					table.insert(borders2, _G["ElvUI_Bar2Button"..i])
				end
				local function createbar2borders()
					for _,v in pairs(borders2) do
						local barborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						barborder:SetSize(xbar2, ybar2)
						barborder:SetPoint("CENTER", v, "CENTER")
						barborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize,
						})
						barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					end
				end
				createbar2borders()
			end

			--bar3
			if E.db.ElvUI_EltreumUI.borders.bar3borders and E.db.actionbar.bar3.enabled then
				local borders3 = {}
				for i = 1,12 do
					table.insert(borders3, _G["ElvUI_Bar3Button"..i])
				end
				local function createbar3borders()
					for _,v in pairs(borders3) do
						local barborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						barborder:SetSize(xbar3, ybar3)
						barborder:SetPoint("CENTER", v, "CENTER")
						barborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize,
						})
						barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					end
				end
				createbar3borders()
			end

			--bar4
			if E.db.ElvUI_EltreumUI.borders.bar4borders and E.db.actionbar.bar4.enabled then
				local borders4 = {}
				for i = 1,12 do
					table.insert(borders4, _G["ElvUI_Bar4Button"..i])
				end
				local function createbar4borders()
					for _,v in pairs(borders4) do
						local barborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						barborder:SetSize(xbar4, ybar4)
						barborder:SetPoint("CENTER", v, "CENTER")
						barborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize,
						})
						barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					end
				end
				createbar4borders()
			end

			--bar5
			if E.db.ElvUI_EltreumUI.borders.bar5borders and E.db.actionbar.bar5.enabled then
				local borders5 = {}
				for i = 1,12 do
					table.insert(borders5, _G["ElvUI_Bar5Button"..i])
				end
				local function createbar5borders()
					for _,v in pairs(borders5) do
						local barborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						barborder:SetSize(xbar5, ybar5)
						barborder:SetPoint("CENTER", v, "CENTER")
						barborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize,
						})
						barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					end
				end
				createbar5borders()
			end

			--bar6
			if E.db.ElvUI_EltreumUI.borders.bar6borders and E.db.actionbar.bar6.enabled then
				local borders6 = {}
				for i = 1,12 do
					table.insert(borders6, _G["ElvUI_Bar6Button"..i])
				end
				local function createbar6borders()
					for _,v in pairs(borders6) do
						local barborder = CreateFrame("Frame", nil, v, BackdropTemplateMixin and "BackdropTemplate")
						barborder:SetSize(xbar6, ybar6)
						barborder:SetPoint("CENTER", v, "CENTER")
						barborder:SetBackdrop({
						edgeFile = bordertexture,
						edgeSize = baredgesize,
						})
						barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					end
				end
				createbar6borders()
			end
		end

		--nameplate power bar
		local powerbarsize = E.db.ElvUI_EltreumUI.borders.powerbarsize
		--[[if powerbarsize == nil then
			powerbarsize = 4
		end]]
		local EltruismPowerBar = _G.EltruismPowerBar
		if E.db.ElvUI_EltreumUI.borders.powerbarborder then
			local powerbarborder = CreateFrame("Frame", "EltruismPowerBarBorder", EltruismPowerBar, BackdropTemplateMixin and "BackdropTemplate")
			powerbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xpowerbar, E.db.ElvUI_EltreumUI.borders.ypowerbar)
			powerbarborder:SetPoint("CENTER", EltruismPowerBar, "CENTER", 0, 0)
			powerbarborder:SetBackdrop({
				edgeFile = bordertexture,
				edgeSize = powerbarsize,
			})
			powerbarborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			powerbarborder:SetFrameStrata("HIGH")
		end
	end
end
