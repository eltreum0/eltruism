local E, L = unpack(ElvUI)
local _G = _G
local tostring = _G.tostring
local string = _G.string
local UnitClass = _G.UnitClass
local math = _G.math
local GetRaidTargetIndex = _G.GetRaidTargetIndex
local UnitEffectiveLevel = _G.UnitEffectiveLevel
local UnitLevel = _G.UnitLevel
local UnitIsDead = _G.UnitIsDead
local UnitIsGhost = _G.UnitIsGhost
local UnitIsGroupAssistant = _G.UnitIsGroupAssistant
local GetPartyAssignment = _G.GetPartyAssignment
local UnitIsPlayer = _G.UnitIsPlayer
local UnitIsConnected = _G.UnitIsConnected
local UnitIsGroupLeader = _G.UnitIsGroupLeader
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitClassification = _G.UnitClassification
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local UnitIsFeignDeath = _G.UnitIsFeignDeath
local escapeSequence = ":0:0:0:0"

--show class icons on all targets
E:AddTag("eltruism:class:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("RELEAF",classes,false,"64")
end)
E:AddTagInfo('eltruism:class:all', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."Releaf.tga:0:0:0:0|t "..L["Shows Class Icons recolored by Releaf on all targets"])

--show class icons only on players, ty repooc!
E:AddTag("eltruism:class:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("RELEAF",classes,false,"64")
end)
E:AddTagInfo('eltruism:class:player', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."Releaf.tga:0:0:0:0|t "..L["Shows Class Icons recolored by Releaf on Player targets"])

--alternate class icons on all targets
E:AddTag("eltruism:blizz:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("BLIZZARD",classes,false,"64")
end)
E:AddTagInfo('eltruism:blizz:all', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass)))..".tga:0:0:0:0|t "..L["Shows Class Icons by Blizzard on all targets"])

--alternate class icons on players
E:AddTag("eltruism:blizz:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("BLIZZARD",classes,false,"64")
end)
E:AddTagInfo('eltruism:blizz:player', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass)))..".tga:0:0:0:0|t "..L["Shows Class Icons by Blizzard only on Player targets"])

--alternate class icons on all targets
E:AddTag("eltruism:ReleafBorder:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("BORDER",classes,false,"64")
end)
E:AddTagInfo('eltruism:ReleafBorder:all', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."IconReleaf.tga:0:0:0:0|t "..L["Shows Class Icons with borders recolored by Releaf on all targets"])

--alternate class icons on players
E:AddTag("eltruism:ReleafBorder:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("BORDER",classes,false,"64")
end)
E:AddTagInfo('eltruism:ReleafBorder:player', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."IconReleaf.tga:0:0:0:0|t "..L["Shows Class Icons with borders recolored by Releaf on Player targets"])

--class icons with outlines on all targets
E:AddTag("eltruism:IconOutline:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("SHADOW",classes,false,"64")
end)
E:AddTagInfo("eltruism:IconOutline:all", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."Shadow.tga:0:0:0:0|t ".."Shows Class Icons with Outlines all targets")

--class icons with otlines on players
E:AddTag("eltruism:IconOutline:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("SHADOW",classes,false,"64")
end)
E:AddTagInfo("eltruism:IconOutline:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."Shadow.tga:0:0:0:0|t ".."Shows Class Icons with Outlines on Player targets")

--class icons with outlines on all targets
E:AddTag("eltruism:ReleafIconOutline:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("OUTLINE",classes,false,"64")
end)
E:AddTagInfo("eltruism:ReleafIconOutline:all", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."1.tga:0:0:0:0|t ".."Shows Class Icons with Outlines by Releaf all targets")

--class icons with otlines on players
E:AddTag("eltruism:ReleafIconOutline:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("OUTLINE",classes,false,"64")
end)
E:AddTagInfo("eltruism:ReleafIconOutline:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."1.tga:0:0:0:0|t ".."Shows Class Icons with Outlines by Releaf on Player targets")

--greyscale class icons on all targets
E:AddTag("eltruism:greyscaleclass:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("BW",classes,false,"64")
end)
E:AddTagInfo("eltruism:greyscaleclass:all", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."BW.tga:0:0:0:0|t ".."Shows Greyscale Class Icons on all targets")

--greyscale class icons on players
E:AddTag("eltruism:greyscaleclass:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("BW",classes,false,"64")
end)
E:AddTagInfo("eltruism:greyscaleclass:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."BW.tga:0:0:0:0|t ".."Shows Greyscale Class Icons on Player targets")

--reverse greyscale class icons on all targets
E:AddTag("eltruism:reversegreyscaleclass:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("BW",classes,true,"64")
end)
E:AddTagInfo("eltruism:reversegreyscaleclass:all", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."BW.tga:0:0:0:0:64:64:64:0:0:64|t ".."Shows Flipped Greyscale Icons on all targets")

--reverse greyscale class icons on players
E:AddTag("eltruism:reversegreyscaleclass:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("BW",classes,true,"64")
end)
E:AddTagInfo("eltruism:reversegreyscaleclass:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."BW.tga:0:0:0:0:64:64:64:0:0:64|t ".."Shows Flipped Greyscale Class Icons on Player targets")

--show class icons on all targets
E:AddTag("eltruism:reverseclass:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("RELEAF",classes,true,"64")
end)
E:AddTagInfo('eltruism:reverseclass:all', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."Releaf.tga:0:0:0:0:64:64:64:0:0:64|t "..L["Shows Flipped Class Icons recolored by Releaf on all targets"])

--show class icons only on players, ty repooc!
E:AddTag("eltruism:reverseclass:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("RELEAF",classes,true,"64")
end)
E:AddTagInfo('eltruism:reverseclass:player', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."Releaf.tga:0:0:0:0:64:64:64:0:0:64|t "..L["Shows Flipped Class Icons recolored by Releaf on Player targets"])

--alternate class icons on all targets
E:AddTag("eltruism:reverseblizz:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("BLIZZARD",classes,true,"64")
end)
E:AddTagInfo('eltruism:reverseblizz:all', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass)))..".tga:0:0:0:0:64:64:64:0:0:64|t "..L["Shows Flipped Class Icons by Blizzard on all targets"])

--alternate class icons on players
E:AddTag("eltruism:reverseblizz:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("BLIZZARD",classes,true,"64")
end)
E:AddTagInfo('eltruism:reverseblizz:player', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass)))..".tga:0:0:0:0:64:64:64:0:0:64|t "..L["Shows Flipped Class Icons by Blizzard only on Player targets"])

--alternate class icons on all targets
E:AddTag("eltruism:reverseReleafBorder:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("BORDER",classes,true,"64")
end)
E:AddTagInfo('eltruism:reverseReleafBorder:all', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."IconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t "..L["Shows Flipped Class Icons with borders recolored by Releaf on all targets"])

--alternate class icons on players
E:AddTag("eltruism:reverseReleafBorder:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("BORDER",classes,true,"64")
end)
E:AddTagInfo('eltruism:reverseReleafBorder:player', ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."IconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t "..L["Shows Flipped Class Icons with borders recolored by Releaf on Player targets"])

--class icons with outlines on all targets
E:AddTag("eltruism:reverseIconOutline:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("SHADOW",classes,true,"64")
end)
E:AddTagInfo("eltruism:reverseIconOutline:all", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."Shadow.tga:0:0:0:0:64:64:64:0:0:64|t ".."Shows Flipped Class Icons with Outlines all targets")

--class icons with otlines on players
E:AddTag("eltruism:reverseIconOutline:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("SHADOW",classes,true,"64")
end)
E:AddTagInfo("eltruism:reverseIconOutline:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."Shadow.tga:0:0:0:0:64:64:64:0:0:64|t ".."Shows Flipped Class Icons with Outlines on Player targets")

--class icons with outlines on all targets
E:AddTag("eltruism:reverseReleafIconOutline:all", "UNIT_NAME_UPDATE", function(unit)
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("OUTLINE",classes,true,"64")
end)
E:AddTagInfo("eltruism:reverseReleafIconOutline:all", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."1.tga:0:0:0:0:64:64:64:0:0:64|t ".."Shows Flipped Class Icons with Outlines by Releaf all targets")

--class icons with outlines on players
E:AddTag("eltruism:reverseReleafIconOutline:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _ , classes = UnitClass(unit)
	if not classes then return end
	return ElvUI_EltreumUI:GetClassIcons("OUTLINE",classes,true,"64")
end)
E:AddTagInfo("eltruism:reverseReleafIconOutline:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."1.tga:0:0:0:0:64:64:64:0:0:64|t ".."Shows Flipped Class Icons with Outlines by Releaf on Player targets")

--gradient releaf icons
E:AddTag("eltruism:Releafgradient:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _, englishClass = UnitClass(unit)
	if not englishClass then return end
	return ElvUI_EltreumUI:GetClassIcons("GRADIENT",englishClass,false,"64")
end)
E:AddTagInfo("eltruism:Releafgradient:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."Gradient.tga:0:0:0:0|t ".."Shows Releaf Icons with Gradient Colors")

--gradient releaf icons reversed
E:AddTag("eltruism:reverseReleafgradient:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _,englishClass = UnitClass(unit)
	if not englishClass then return end
	return ElvUI_EltreumUI:GetClassIcons("GRADIENT",englishClass,true,"64")
end)
E:AddTagInfo("eltruism:reverseReleafgradient:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."Gradient.tga:0:0:0:0:64:64:64:0:0:64|t ".."Shows Reversed Releaf Icons with Gradient Colors")

--new class symbols
E:AddTag("eltruism:classSymbols:player", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _,englishClass = UnitClass(unit)
	if not englishClass then return end
	return ElvUI_EltreumUI:GetClassIcons("SYMBOLS",englishClass,false,"64")
end)
E:AddTagInfo("eltruism:classSymbols:player", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass)))..".tga:0:0:0:0|t ".."Shows Eltruism Class Symbol")

--gradient releaf icons for all
E:AddTag("eltruism:Releafgradient:all", "UNIT_NAME_UPDATE", function(unit)
	local _,englishClass = UnitClass(unit)
	if not englishClass then return end
	return ElvUI_EltreumUI:GetClassIcons("GRADIENT",englishClass,false,"64")
end)
E:AddTagInfo("eltruism:Releafgradient:all", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass)))..".tga:0:0:0:0|t ".."Shows Releaf Icons with Gradient Colors for All")

--gradient releaf icons reversed for all
E:AddTag("eltruism:reverseReleafgradient:all", "UNIT_NAME_UPDATE", function(unit)
	local _,englishClass = UnitClass(unit)
	if not englishClass then return end
	return ElvUI_EltreumUI:GetClassIcons("GRADIENT",englishClass,true,"64")
end)
E:AddTagInfo("eltruism:reverseReleafgradient:all", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\32\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."Gradient.tga:0:0:0:0:64:64:64:0:0:64|t ".."Shows Reversed Releaf Icons with Gradient Colors for All")

--U.GG class icons
E:AddTag("eltruism:classIcon:ugg", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _,englishClass = UnitClass(unit)
	if not englishClass then return end
	return ElvUI_EltreumUI:GetClassIcons("UGG",englishClass,false,"64")
end)
E:AddTagInfo("eltruism:classIcon:ugg", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."UGG.tga:0:0:0:0|t ".."Shows U.GG Class Icons")

--U.GG class icons, but black and white instead
E:AddTag("eltruism:classIcon:uggbw", "UNIT_NAME_UPDATE", function(unit)
	if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
	local _,englishClass = UnitClass(unit)
	if not englishClass then return end
	return ElvUI_EltreumUI:GetClassIcons("UGGGREY",englishClass,false,"64")
end)
E:AddTagInfo("eltruism:classIcon:uggbw", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\"..tostring(ElvUI_EltreumUI:firstToUpper(string.lower(E.myclass))).."UGG.tga:0:0:0:0|t ".."Shows U.GG Class Icons, but in greyscale")

-- Releaf Logo
E:AddTag("releaf", "UNIT_NAME_UPDATE", function()
	local color = E.myClassColor
	local red = math.floor(color.r*255)
	local blue = math.floor(color.b*255)
	local green = math.floor(color.g*255)
	local releaf = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\releaftag.tga:0:0:0:3:128:128:0:128:0:128:" .. red .. ":" .. green .. ":" .. blue .. "|t"
	--local releaf = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Releaf-Orange.tga"..escapeSequence.."|t"
	return releaf
end)
E:AddTagInfo("releaf", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\releaftag.tga:0:0:0:3|t ".."Shows Releaf's Icon")

-- Target Marker tag
E:AddTag("eltruism:raidmarker", 'RAID_TARGET_UPDATE', function(unit)
	local index = GetRaidTargetIndex(unit)
	local mark
	if index then
		mark = "|TINTERFACE\\TARGETINGFRAME\\UI-RaidTargetingIcon_"..index..".blp:0:0:0:0|t"
	end
	return mark
end)
E:AddTagInfo("eltruism:raidmarker", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TINTERFACE\\TARGETINGFRAME\\UI-RaidTargetingIcon_1.blp:0:0:0:0|t".." "..L["Shows raid target marker"])

E:AddTag("eltruism:levelskull", "UNIT_TARGET UNIT_NAME_UPDATE", function(unit)
	local level
	if E.Retail then
		level = UnitEffectiveLevel(unit)
	else
		level = UnitLevel(unit)
	end
	local diff = level - UnitLevel("player")
	local classification = UnitClassification(unit)
	if diff > 8 or classification == "worldboss" then
		return "|TInterface\\TARGETINGFRAME\\UI-TARGETINGFRAME-SKULL.BLP:0:0:0:0|t"
	else
		return level
	end
end)
E:AddTagInfo("eltruism:levelskull", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\TARGETINGFRAME\\UI-TARGETINGFRAME-SKULL.BLP:0:0:0:0|t "..L["Shows the Unit Level, or a skull if the level is too high"])

E:AddTag("eltruism:levelskull2", "UNIT_TARGET UNIT_NAME_UPDATE", function(unit)
	local level
	if E.Retail then
		level = UnitEffectiveLevel(unit)
	else
		level = UnitLevel(unit)
	end
	local diff = level - UnitLevel("player")
	local classification = UnitClassification(unit)
	if diff > 8 or classification == "worldboss" then
		return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull10.tga"..escapeSequence.."|t"
	else
		return level
	end
end)
E:AddTagInfo("eltruism:levelskull2", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull10.tga:0:0:0:0|t "..L["Shows the Unit Level, or a skull if the level is too high"])

--Short classification, but with a skull for boss instead of B for Nekator
E:AddTag("eltruism:shortclassification", "UNIT_NAME_UPDATE", function(unit)
	local c = UnitClassification(unit)
	if(c == 'rare') then
		return 'R'
	elseif(c == 'rareelite') then
		return 'R+'
	elseif(c == 'elite') then
		return '+'
	elseif(c == 'worldboss') then
		return "|TInterface\\TARGETINGFRAME\\UI-TARGETINGFRAME-SKULL.BLP:0:0:0:0|t"
	elseif(c == 'minus') then
		return '-'
	end
end)
E:AddTagInfo("eltruism:shortclassification", ElvUI_EltreumUI.Name.." "..L["Icons"], L["Displays the unit's classification in short form (e.g. '+' for ELITE and 'R' for RARE and a Skull for Boss)"])

--Tag for dead based on elvui tag for health with user input
E:AddTag("eltruism:dead", "UNIT_HEALTH", function(unit)
	if UnitIsDead(unit) and UnitIsPlayer(unit) and not UnitIsFeignDeath(unit) then
		if E.db.ElvUI_EltreumUI.otherstuff.deadtagicon ~= "NONE" then
			return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead"..tostring(E.db.ElvUI_EltreumUI.otherstuff.deadtagicon)..".tga"..escapeSequence.."|t"
		else
			return L["Dead"]
		end
	elseif UnitIsGhost(unit) then
		if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
			return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Ghost\\ghost"..tostring(E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon)..".tga"..escapeSequence.."|t"
		else
			return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
		end
	end
end)
E:AddTagInfo("eltruism:dead", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Dead\\dead1.tga:0:0:0:0|t "..L["Displays a dead symbol when unit is dead. Can be customized in Eltruism > Media"])

--Tag for dc based on elvui tag for health
E:AddTag("eltruism:dc", "UNIT_CONNECTION", function(unit)
	if not UnitIsConnected(unit) and UnitIsPlayer(unit) then
		if E.db.ElvUI_EltreumUI.otherstuff.dctagicon ~= "NONE" then
			return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc"..tostring(E.db.ElvUI_EltreumUI.otherstuff.dctagicon)..".tga"..escapeSequence.."|t"
		else
			return L["Dead"]
		end
	end
end)
E:AddTagInfo("eltruism:dc", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Disconnect\\dc1.tga:0:0:0:0|t ".. L["Displays a disconnect symbol when unit is disconnected. Can be customized in Eltruism > Media"])

E:AddTag("eltruism:leader", "GROUP_ROSTER_UPDATE", function(unit)
	local leader = UnitIsGroupLeader(unit)
	local assist = UnitIsGroupAssistant(unit)
	local isTank = GetPartyAssignment("MAINTANK", unit)
	local isMainAssist = GetPartyAssignment("MAINASSIST", unit)
	if leader and not assist and not isTank and not isMainAssist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-LEADERICON.BLP:0:0:0:0|t"
	elseif assist and not leader and not isTank and not isMainAssist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-ASSISTANTICON.BLP:0:0:0:0|t"
	elseif isTank and isMainAssist and not leader and not assist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-MAINTANKICON.BLP:0:0:0:0|t".."|TInterface\\GROUPFRAME\\UI-GROUP-MAINASSISTICON.BLP:0:0:0:0|t"
	elseif isTank and not isMainAssist and not leader and not assist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-MAINTANKICON.BLP:0:0:0:0|t"
	elseif isMainAssist and not isTank and not leader and not assist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-MAINASSISTICON.BLP:0:0:0:0|t"
	elseif leader and isTank then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-LEADERICON.BLP:0:0:0:0|t".."|TInterface\\GROUPFRAME\\UI-GROUP-MAINTANKICON.BLP:0:0:0:0|t"
	elseif assist and isTank and not isMainAssist and not leader then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-ASSISTANTICON.BLP:0:0:0:0|t".."|TInterface\\GROUPFRAME\\UI-GROUP-MAINTANKICON.BLP:0:0:0:0|t"
	end
end)
E:AddTagInfo("eltruism:leader", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\GROUPFRAME\\UI-GROUP-LEADERICON.BLP:0:0:0:0|t "..L["Shows the Leader Icon or Assist icon if the unit is Leader or Assist"])

E:AddTag("eltruism:leader:emoji", "GROUP_ROSTER_UPDATE", function(unit)
	local leader = UnitIsGroupLeader(unit)
	if leader then
		return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Leader\\Leader1.tga"..escapeSequence.."|t"
	end
end)
E:AddTagInfo("eltruism:leader:emoji", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Leader\\Leader1.tga:0:0:0:0|t"..L["Shows the Leader Icon as an Emoji Crown"])

--combat icon idea for other units
E:AddTag("eltruism:combatindicator", 'UNIT_HEALTH PLAYER_FLAGS_CHANGED', function(unit)
	if UnitAffectingCombat(unit) then
		if E.db.unitframe.units.player.CombatIcon.texture == "DEFAULT" then
			return "|TInterface\\CharacterFrame\\UI-StateIcon:0:0:0:0:64:64:34:59:6:29|t"
		elseif E.db.unitframe.units.player.CombatIcon.texture == "PLATINUM" then
			return "|TInterface\\Challenges\\ChallengeMode_Medal_Platinum:0:0:0:0|t"
		elseif E.db.unitframe.units.player.CombatIcon.texture == "ATTACK" then
			return "|TInterface\\CURSOR\\Attack:0:0:0:0|t"
		elseif E.db.unitframe.units.player.CombatIcon.texture == "ALERT" then
			return "|TInterface\\DialogFrame\\UI-Dialog-Icon-AlertNew:0:0:0:0|t"
		elseif E.db.unitframe.units.player.CombatIcon.texture == "ALERT2" then
			return "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0:0:0:0|t"
		elseif E.db.unitframe.units.player.CombatIcon.texture == "ARTHAS" then
			return "|TInterface\\LFGFRAME\\UI-LFR-PORTRAIT:0:0:0:0|t"
		elseif E.db.unitframe.units.player.CombatIcon.texture == "SKULL" then
			return "|TInterface\\LootFrame\\LootPanel-Icon:0:0:0:0|t"
		elseif E.db.unitframe.units.player.CombatIcon.texture == "COMBAT" then
			return "|TInterface\\Addons\\ElvUI\\Core\\Media\\Textures\\Combat.tga"..escapeSequence.."|t"
		else
			return E:TextureString(E.Media.CombatIcons[E.db.unitframe.units.player.CombatIcon.texture],':20:20')-- "|T"..E.Media.CombatIcons[texture]..":0:0:0|t"
		end
	end
end)
E:AddTagInfo("eltruism:combatindicator", ElvUI_EltreumUI.Name.." "..L["Icons"], "|TInterface\\CharacterFrame\\UI-StateIcon:0:0:0:0:64:64:34:59:6:29|t "..L["Displays an icon when the unit is in combat, uses player icon"])
