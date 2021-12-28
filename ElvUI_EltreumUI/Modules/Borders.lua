local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local table = _G.table
local pairs = _G.pairs

--Beta borders on frames
function ElvUI_EltreumUI:Borders()
	local bordertexture
	if E.db.ElvUI_EltreumUI.borders.texture then
		bordertexture =  E.LSM:Fetch("border", E.db.ElvUI_EltreumUI.borders.texture)
	else
		bordertexture = "Interface\\Addons\\ElvUI_EltreumUI\\Media\border\\better-blizzard-border-small-alternate.tga"
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
	local powerbarsize = E.db.ElvUI_EltreumUI.borders.powerbarsize

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


	--[[SetBackdrop({
		bgFile = "file",
		edgeFile = "file",
		tile = true,
		tileSize = size,
		edgeSize = size,
		insets = { left = X, right = X, top = X, bottom = X }
	})]]--

	if E.db.ElvUI_EltreumUI.borders.borders then
		if E.db.ElvUI_EltreumUI.borders.playerborder then
			local playerborder = CreateFrame("Frame", "EltruismPlayerBorder", _G.ElvUF_Player, BackdropTemplateMixin and "BackdropTemplate")
			playerborder:SetSize(E.db.ElvUI_EltreumUI.borders.xplayer, E.db.ElvUI_EltreumUI.borders.yplayer)
			playerborder:SetPoint("CENTER", _G.ElvUF_Player, "CENTER", 0, 0)
			playerborder:SetBackdrop({
				edgeFile = bordertexture,
				edgeSize = playertargetsize,
			})
			playerborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			playerborder:SetFrameStrata("LOW")
		end

		if E.db.ElvUI_EltreumUI.borders.playercastborder then
			local playercastbarborder = CreateFrame("Frame", "EltruismPlayerCastBarBorder", _G.ElvUF_Player_CastBar, BackdropTemplateMixin and "BackdropTemplate")
			playercastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xplayercast, E.db.ElvUI_EltreumUI.borders.yplayercast)
			playercastbarborder:SetPoint("CENTER", _G.ElvUF_Player_CastBar, "CENTER", 0, 0)
			playercastbarborder:SetBackdrop({
				edgeFile = bordertexture,
				edgeSize = playertargetsize,
			})
			playercastbarborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			playercastbarborder:SetFrameStrata("HIGH")
		end

		if E.db.ElvUI_EltreumUI.borders.targetborder then
			local targetborder = CreateFrame("Frame", "EltruismTargetBorder", _G.ElvUF_Target, BackdropTemplateMixin and "BackdropTemplate")
			targetborder:SetSize(E.db.ElvUI_EltreumUI.borders.xtarget, E.db.ElvUI_EltreumUI.borders.ytarget)
			targetborder:SetPoint("CENTER", _G.ElvUF_Target)
			targetborder:SetBackdrop({
				edgeFile = bordertexture,
				edgeSize = playertargetsize,
			})
			targetborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			targetborder:SetFrameStrata("LOW")
		end

		if E.db.ElvUI_EltreumUI.borders.targetcastborder then
			local targetcastbarborder = CreateFrame("Frame", "EltruismTargetCastBarBorder", _G.ElvUF_Target_CastBar, BackdropTemplateMixin and "BackdropTemplate")
			targetcastbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xcasttarget, E.db.ElvUI_EltreumUI.borders.ycasttarget)
			targetcastbarborder:SetPoint("CENTER", _G.ElvUF_Target_CastBar, "CENTER", 0, 0)
			targetcastbarborder:SetBackdrop({
				edgeFile = bordertexture,
				edgeSize = playertargetsize,
			})
			targetcastbarborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			targetcastbarborder:SetFrameStrata("HIGH")
		end

		--action bar 1
		if E.db.ElvUI_EltreumUI.borders.bar1borders then
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
		if E.db.ElvUI_EltreumUI.borders.bar2borders then
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
		if E.db.ElvUI_EltreumUI.borders.bar3borders then
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
		if E.db.ElvUI_EltreumUI.borders.bar4borders then
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
		if E.db.ElvUI_EltreumUI.borders.bar5borders then
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
		if E.db.ElvUI_EltreumUI.borders.bar6borders then
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

		--nameplate power bar
		if E.db.ElvUI_EltreumUI.borders.powerbarborder then
			local powerbarborder = CreateFrame("Frame", "EltruismPowerBarBorder", _G.EltruismPowerBar, BackdropTemplateMixin and "BackdropTemplate")
			powerbarborder:SetSize(E.db.ElvUI_EltreumUI.borders.xpowerbar, E.db.ElvUI_EltreumUI.borders.ypowerbar)
			powerbarborder:SetPoint("CENTER", _G.EltruismPowerBar, "CENTER", 0, 0)
			powerbarborder:SetBackdrop({
				edgeFile = bordertexture,
				edgeSize = powerbarsize,
			})
			powerbarborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			powerbarborder:SetFrameStrata("HIGH")
		end

	--[[
		--bar7
		local borders7 = {}
		for i = 1,12 do
			table.insert(borders7, _G["ElvUI_Bar7Button"..i])
		end
		local function createbar7borders()
			for _,v in pairs(borders7) do
				local barborder = CreateFrame("Frame", nil, v, "BackdropTemplate")
				barborder:SetSize(xbar7, ybar7)
				barborder:SetPoint("CENTER", v, "CENTER")
				barborder:SetBackdrop( {
				edgeFile = bordertexture,
				edgeSize = baredgesize,
				})
				barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			end
		end
		createbar7borders()

		--bar8
		local borders8 = {}
		for i = 1,12 do
			table.insert(borders8, _G["ElvUI_Bar8Button"..i])
		end
		local function createbar8borders()
			for _,v in pairs(borders8) do
				local barborder = CreateFrame("Frame", nil, v, "BackdropTemplate")
				barborder:SetSize(xbar8, ybar8)
				barborder:SetPoint("CENTER", v, "CENTER")
				barborder:SetBackdrop( {
				edgeFile = bordertexture,
				edgeSize = baredgesize,
				})
				barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			end
		end
		createbar8borders()

		--bar9
		local borders9 = {}
		for i = 1,12 do
			table.insert(borders9, _G["ElvUI_Bar9Button"..i])
		end
		local function createbar9borders()
			for _,v in pairs(borders9) do
				local barborder = CreateFrame("Frame", nil, v, "BackdropTemplate")
				barborder:SetSize(xbar9, ybar9)
				barborder:SetPoint("CENTER", v, "CENTER")
				barborder:SetBackdrop( {
				edgeFile = bordertexture,
				edgeSize = baredgesize,
				})
				barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			end
		end
		createbar9borders()

		--bar10
		local borders10 = {}
		for i = 1,12 do
			table.insert(borders10, _G["ElvUI_Bar10Button"..i])
		end
		local function createbar10borders()
			for _,v in pairs(borders10) do
				local barborder = CreateFrame("Frame", nil, v, "BackdropTemplate")
				barborder:SetSize(xbar10, ybar10)
				barborder:SetPoint("CENTER", v, "CENTER")
				barborder:SetBackdrop( {
				edgeFile = bordertexture,
				edgeSize = baredgesize,
				})
				barborder:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
			end
		end
		createbar10borders()]]--
	end
end
