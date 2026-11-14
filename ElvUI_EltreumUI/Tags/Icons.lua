local E, L = unpack(ElvUI)
local _G = _G
local tostring = _G.tostring
local string = _G.string
local stringlower = string.lower
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
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local UnitHealth = _G.UnitHealth
local format = _G.format
local escapeSequence = ":0:0:0:0"
local cached_deadtexture, cached_ghosttexture, cached_dctexture
local combatTextureCache = {
	["DEFAULT"] = [[|TInterface\CharacterFrame\UI-StateIcon:0:0:0:0:64:64:34:59:6:29|t]],
	["PLATINUM"] = [[|TInterface\Challenges\ChallengeMode_Medal_Platinum:0:0:0:0|t]],
	["ATTACK"] = [[|TInterface\CURSOR\Attack:0:0:0:0|t]],
	["ALERT"] = [[|TInterface\DialogFrame\UI-Dialog-Icon-AlertNew:0:0:0:0|t]],
	["ALERT2"] = [[|TInterface\OptionsFrame\UI-OptionsFrame-NewFeatureIcon:0:0:0:0|t]],
	["ARTHAS"] = [[|TInterface\LFGFRAME\UI-LFR-PORTRAIT:0:0:0:0|t]],
	["SKULL"] = [[|TInterface\LootFrame\LootPanel-Icon:0:0:0:0|t]],
	["COMBAT"] = [[|TInterface\AddOns\ElvUI\Game\Shared\Media\Textures\Combat:0:0:0:0|t]],
}
local raidMarkerTextures = {
	[1] = [[|TInterface\TargetingFrame\UI-RaidTargetingIcon_1:0:0:0:0|t]],
	[2] = [[|TInterface\TargetingFrame\UI-RaidTargetingIcon_2:0:0:0:0|t]],
	[3] = [[|TInterface\TargetingFrame\UI-RaidTargetingIcon_3:0:0:0:0|t]],
	[4] = [[|TInterface\TargetingFrame\UI-RaidTargetingIcon_4:0:0:0:0|t]],
	[5] = [[|TInterface\TargetingFrame\UI-RaidTargetingIcon_5:0:0:0:0|t]],
	[6] = [[|TInterface\TargetingFrame\UI-RaidTargetingIcon_6:0:0:0:0|t]],
	[7] = [[|TInterface\TargetingFrame\UI-RaidTargetingIcon_7:0:0:0:0|t]],
	[8] = [[|TInterface\TargetingFrame\UI-RaidTargetingIcon_8:0:0:0:0|t]],
}
local cached_releaf

local function UpdateIconTagTextures()
	if E.db and E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.otherstuff then
		local stuff = E.db.ElvUI_EltreumUI.otherstuff
		cached_deadtexture = format([[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Dead\dead%s%s|t]], tostring(stuff.deadtagicon), escapeSequence)
		cached_ghosttexture = format([[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Ghost\ghost%s%s|t]], tostring(stuff.ghosttagicon), escapeSequence)
		cached_dctexture = format([[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Disconnect\dc%s%s|t]], tostring(stuff.dctagicon), escapeSequence)
	end
	if E.myClassColor then
		local color = E.myClassColor
		cached_releaf = format([[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\releaftag:0:0:0:3:128:128:0:128:0:128:%d:%d:%d|t]], math.floor(color.r*255), math.floor(color.g*255), math.floor(color.b*255))
	end
end

function ElvUI_EltreumUI:LoadIconTags()
	UpdateIconTagTextures()
	local myClassFormatted = tostring(ElvUI_EltreumUI:firstToUpper(stringlower(E.myclass)))
	local tagCategory = ElvUI_EltreumUI.Name.." "..L["Icons"]

	--show class icons on all targets
	E:AddTag("eltruism:class:all", "UNIT_NAME_UPDATE", function(unit)
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("RELEAF",classes,false,"64")
	end)
	E:AddTagInfo('eltruism:class:all', tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[Releaf:0:0:0:0|t ]]..L["Shows Class Icons recolored by Releaf on all targets"])

	--show class icons only on players, ty repooc!
	E:AddTag("eltruism:class:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("RELEAF",classes,false,"64")
	end)
	E:AddTagInfo('eltruism:class:player', tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[Releaf:0:0:0:0|t ]]..L["Shows Class Icons recolored by Releaf on Player targets"])

	--alternate class icons on all targets
	E:AddTag("eltruism:blizz:all", "UNIT_NAME_UPDATE", function(unit)
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("BLIZZARD",classes,false,"64")
	end)
	E:AddTagInfo('eltruism:blizz:all', tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[:0:0:0:0|t ]]..L["Shows Class Icons by Blizzard on all targets"])

	--alternate class icons on players
	E:AddTag("eltruism:blizz:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("BLIZZARD",classes,false,"64")
	end)
	E:AddTagInfo('eltruism:blizz:player', tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[:0:0:0:0|t ]]..L["Shows Class Icons by Blizzard only on Player targets"])

	--alternate class icons on all targets
	E:AddTag("eltruism:ReleafBorder:all", "UNIT_NAME_UPDATE", function(unit)
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("BORDER",classes,false,"64")
	end)
	E:AddTagInfo('eltruism:ReleafBorder:all', tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[IconReleaf:0:0:0:0|t ]]..L["Shows Class Icons with borders recolored by Releaf on all targets"])

	--alternate class icons on players
	E:AddTag("eltruism:ReleafBorder:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("BORDER",classes,false,"64")
	end)
	E:AddTagInfo('eltruism:ReleafBorder:player', tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[IconReleaf:0:0:0:0|t ]]..L["Shows Class Icons with borders recolored by Releaf on Player targets"])

	--class icons with outlines on all targets
	E:AddTag("eltruism:IconOutline:all", "UNIT_NAME_UPDATE", function(unit)
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("SHADOW",classes,false,"64")
	end)
	E:AddTagInfo("eltruism:IconOutline:all", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[Shadow:0:0:0:0|t ]].."Shows Class Icons with Outlines all targets")

	--class icons with otlines on players
	E:AddTag("eltruism:IconOutline:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("SHADOW",classes,false,"64")
	end)
	E:AddTagInfo("eltruism:IconOutline:player", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[Shadow:0:0:0:0|t ]].."Shows Class Icons with Outlines on Player targets")

	--class icons with outlines on all targets
	E:AddTag("eltruism:ReleafIconOutline:all", "UNIT_NAME_UPDATE", function(unit)
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("OUTLINE",classes,false,"64")
	end)
	E:AddTagInfo("eltruism:ReleafIconOutline:all", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[1:0:0:0:0|t ]].."Shows Class Icons with Outlines by Releaf all targets")

	--class icons with otlines on players
	E:AddTag("eltruism:ReleafIconOutline:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("OUTLINE",classes,false,"64")
	end)
	E:AddTagInfo("eltruism:ReleafIconOutline:player", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[1:0:0:0:0|t ]].."Shows Class Icons with Outlines by Releaf on Player targets")

	--greyscale class icons on all targets
	E:AddTag("eltruism:greyscaleclass:all", "UNIT_NAME_UPDATE", function(unit)
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("BW",classes,false,"64")
	end)
	E:AddTagInfo("eltruism:greyscaleclass:all", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[BW:0:0:0:0|t ]].."Shows Greyscale Class Icons on all targets")

	--greyscale class icons on players
	E:AddTag("eltruism:greyscaleclass:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("BW",classes,false,"64")
	end)
	E:AddTagInfo("eltruism:greyscaleclass:player", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[BW:0:0:0:0|t ]].."Shows Greyscale Class Icons on Player targets")

	--reverse greyscale class icons on all targets
	E:AddTag("eltruism:reversegreyscaleclass:all", "UNIT_NAME_UPDATE", function(unit)
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("BW",classes,true,"64")
	end)
	E:AddTagInfo("eltruism:reversegreyscaleclass:all", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[BW:0:0:0:0:64:64:64:0:0:64|t ]].."Shows Flipped Greyscale Icons on all targets")

	--reverse greyscale class icons on players
	E:AddTag("eltruism:reversegreyscaleclass:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("BW",classes,true,"64")
	end)
	E:AddTagInfo("eltruism:reversegreyscaleclass:player", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[BW:0:0:0:0:64:64:64:0:0:64|t ]].."Shows Flipped Greyscale Class Icons on Player targets")

	--show class icons on all targets
	E:AddTag("eltruism:reverseclass:all", "UNIT_NAME_UPDATE", function(unit)
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("RELEAF",classes,true,"64")
	end)
	E:AddTagInfo('eltruism:reverseclass:all', tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[Releaf:0:0:0:0:64:64:64:0:0:64|t ]]..L["Shows Flipped Class Icons recolored by Releaf on all targets"])

	--show class icons only on players, ty repooc!
	E:AddTag("eltruism:reverseclass:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("RELEAF",classes,true,"64")
	end)
	E:AddTagInfo('eltruism:reverseclass:player', tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[Releaf:0:0:0:0:64:64:64:0:0:64|t ]]..L["Shows Flipped Class Icons recolored by Releaf on Player targets"])

	--alternate class icons on all targets
	E:AddTag("eltruism:reverseblizz:all", "UNIT_NAME_UPDATE", function(unit)
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("BLIZZARD",classes,true,"64")
	end)
	E:AddTagInfo('eltruism:reverseblizz:all', tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[:0:0:0:0:64:64:64:0:0:64|t ]]..L["Shows Flipped Class Icons by Blizzard on all targets"])

	--alternate class icons on players
	E:AddTag("eltruism:reverseblizz:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("BLIZZARD",classes,true,"64")
	end)
	E:AddTagInfo('eltruism:reverseblizz:player', tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[:0:0:0:0:64:64:64:0:0:64|t ]]..L["Shows Flipped Class Icons by Blizzard only on Player targets"])

	--alternate class icons on all targets
	E:AddTag("eltruism:reverseReleafBorder:all", "UNIT_NAME_UPDATE", function(unit)
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("BORDER",classes,true,"64")
	end)
	E:AddTagInfo('eltruism:reverseReleafBorder:all', tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[IconReleaf:0:0:0:0:64:64:64:0:0:64|t ]]..L["Shows Flipped Class Icons with borders recolored by Releaf on all targets"])

	--alternate class icons on players
	E:AddTag("eltruism:reverseReleafBorder:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("BORDER",classes,true,"64")
	end)
	E:AddTagInfo('eltruism:reverseReleafBorder:player', tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[IconReleaf:0:0:0:0:64:64:64:0:0:64|t ]]..L["Shows Flipped Class Icons with borders recolored by Releaf on Player targets"])

	--class icons with outlines on all targets
	E:AddTag("eltruism:reverseIconOutline:all", "UNIT_NAME_UPDATE", function(unit)
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("SHADOW",classes,true,"64")
	end)
	E:AddTagInfo("eltruism:reverseIconOutline:all", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[Shadow:0:0:0:0:64:64:64:0:0:64|t ]].."Shows Flipped Class Icons with Outlines all targets")

	--class icons with otlines on players
	E:AddTag("eltruism:reverseIconOutline:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("SHADOW",classes,true,"64")
	end)
	E:AddTagInfo("eltruism:reverseIconOutline:player", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[Shadow:0:0:0:0:64:64:64:0:0:64|t ]].."Shows Flipped Class Icons with Outlines on Player targets")

	--class icons with outlines on all targets
	E:AddTag("eltruism:reverseReleafIconOutline:all", "UNIT_NAME_UPDATE", function(unit)
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("OUTLINE",classes,true,"64")
	end)
	E:AddTagInfo("eltruism:reverseReleafIconOutline:all", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[1:0:0:0:0:64:64:64:0:0:64|t ]].."Shows Flipped Class Icons with Outlines by Releaf all targets")

	--class icons with outlines on players
	E:AddTag("eltruism:reverseReleafIconOutline:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _ , classes = UnitClass(unit)
		if not classes then return end
		if not E:NotSecretValue(classes) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("OUTLINE",classes,true,"64")
	end)
	E:AddTagInfo("eltruism:reverseReleafIconOutline:player", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[1:0:0:0:0:64:64:64:0:0:64|t ]].."Shows Flipped Class Icons with Outlines by Releaf on Player targets")

	--gradient releaf icons
	E:AddTag("eltruism:Releafgradient:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _, englishClass = UnitClass(unit)
		if not englishClass then return end
		if not E:NotSecretValue(englishClass) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("GRADIENT",englishClass,false,"64")
	end)
	E:AddTagInfo("eltruism:Releafgradient:player", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[Gradient:0:0:0:0|t ]].."Shows Releaf Icons with Gradient Colors")

	--gradient releaf icons reversed
	E:AddTag("eltruism:reverseReleafgradient:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _,englishClass = UnitClass(unit)
		if not englishClass then return end
		if not E:NotSecretValue(englishClass) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("GRADIENT",englishClass,true,"64")
	end)
	E:AddTagInfo("eltruism:reverseReleafgradient:player", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[Gradient:0:0:0:0:64:64:64:0:0:64|t ]].."Shows Reversed Releaf Icons with Gradient Colors")

	--new class symbols
	E:AddTag("eltruism:classSymbols:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _,englishClass = UnitClass(unit)
		if not englishClass then return end
		if not E:NotSecretValue(englishClass) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("SYMBOLS",englishClass,false,"64")
	end)
	E:AddTagInfo("eltruism:classSymbols:player", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\]]..myClassFormatted..[[:0:0:0:0|t ]].."Shows Eltruism Class Symbol")

	--gradient releaf icons for all
	E:AddTag("eltruism:Releafgradient:all", "UNIT_NAME_UPDATE", function(unit)
		local _,englishClass = UnitClass(unit)
		if not englishClass then return end
		if not E:NotSecretValue(englishClass) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("GRADIENT",englishClass,false,"64")
	end)
	E:AddTagInfo("eltruism:Releafgradient:all", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[Gradient:0:0:0:0|t ]].."Shows Releaf Icons with Gradient Colors for All")

	--gradient releaf icons reversed for all
	E:AddTag("eltruism:reverseReleafgradient:all", "UNIT_NAME_UPDATE", function(unit)
		local _,englishClass = UnitClass(unit)
		if not englishClass then return end
		if not E:NotSecretValue(englishClass) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("GRADIENT",englishClass,true,"64")
	end)
	E:AddTagInfo("eltruism:reverseReleafgradient:all", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Classes\32\]]..myClassFormatted..[[Gradient:0:0:0:0:64:64:64:0:0:64|t ]].."Shows Reversed Releaf Icons with Gradient Colors for All")

	--U.GG class icons
	E:AddTag("eltruism:classIcon:ugg", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _,englishClass = UnitClass(unit)
		if not englishClass then return end
		if not E:NotSecretValue(englishClass) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("UGG",englishClass,false,"64")
	end)
	E:AddTagInfo("eltruism:classIcon:ugg", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\]]..myClassFormatted..[[UGG:0:0:0:0|t ]].."Shows U.GG Class Icons")

	--U.GG class icons, but black and white instead
	E:AddTag("eltruism:classIcon:uggbw", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) and not (E.Retail and UnitInPartyIsAI(unit)) then return end
		local _,englishClass = UnitClass(unit)
		if not englishClass then return end
		if not E:NotSecretValue(englishClass) then --secret class so do something else
			return
		end
		return ElvUI_EltreumUI:GetClassIcons("UGGGREY",englishClass,false,"64")
	end)
	E:AddTagInfo("eltruism:classIcon:uggbw", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\ClassSymbols\]]..myClassFormatted..[[UGG:0:0:0:0|t ]].."Shows U.GG Class Icons, but in greyscale")

	-- Releaf Logo
	E:AddTag("releaf", "UNIT_NAME_UPDATE", function()
		if not cached_releaf then
			local color = E.myClassColor
			cached_releaf = format([[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\releaftag:0:0:0:3:128:128:0:128:0:128:%d:%d:%d|t]], math.floor(color.r*255), math.floor(color.g*255), math.floor(color.b*255))
		end
		return cached_releaf
	end)
	E:AddTagInfo("releaf", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\releaftag:0:0:0:3|t ]].."Shows Releaf's Icon")

	-- Target Marker tag
	E:AddTag("eltruism:raidmarker", 'RAID_TARGET_UPDATE', function(unit)
		local index = GetRaidTargetIndex(unit)
		if index and E:NotSecretValue(index) then
			return raidMarkerTextures[index] or format([[|TInterface\TargetingFrame\UI-RaidTargetingIcon_%s:0:0:0:0|t]], index)
		elseif index then
			return format([[|TInterface\TargetingFrame\UI-RaidTargetingIcon_%s:0:0:0:0|t]], index)
		end
	end)
	E:AddTagInfo("eltruism:raidmarker", tagCategory, [[|TInterface\TargetingFrame\UI-RaidTargetingIcon_1:0:0:0:0|t ]]..L["Shows raid target marker"])

	E:AddTag("eltruism:levelskull", "UNIT_TARGET UNIT_NAME_UPDATE", function(unit)
		local level
		if E.Modern then
			level = UnitEffectiveLevel(unit)
		else
			level = UnitLevel(unit)
		end
		local diff = level - UnitLevel("player")
		local classification = UnitClassification(unit)
		if diff > 8 or classification == "worldboss" then
			return [[|TInterface\TargetingFrame\UI-TargetingFrame-Skull:0:0:0:0|t]]
		else
			return level
		end
	end)
	E:AddTagInfo("eltruism:levelskull", tagCategory, [[|TInterface\TargetingFrame\UI-TargetingFrame-Skull:0:0:0:0|t ]]..L["Shows the Unit Level, or a skull if the level is too high"])

	E:AddTag("eltruism:levelskull2", "UNIT_TARGET UNIT_NAME_UPDATE", function(unit)
		local level
		if E.Modern then
			level = UnitEffectiveLevel(unit)
		else
			level = UnitLevel(unit)
		end
		local diff = level - UnitLevel("player")
		local classification = UnitClassification(unit)
		if diff > 8 or classification == "worldboss" then
			return [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Nameplates\skull10:0:0:0:0|t]]
		else
			return level
		end
	end)
	E:AddTagInfo("eltruism:levelskull2", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Nameplates\skull10:0:0:0:0|t ]]..L["Shows the Unit Level, or a skull if the level is too high"])

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
			return [[|TInterface\TargetingFrame\UI-TargetingFrame-Skull:0:0:0:0|t]]
		elseif(c == 'minus') then
			return '-'
		end
	end)
	E:AddTagInfo("eltruism:shortclassification", tagCategory, L["Displays the unit's classification in short form (e.g. '+' for ELITE and 'R' for RARE and a Skull for Boss)"])

	--Tag for dead based on elvui tag for health with user input
	E:AddTag("eltruism:dead", "UNIT_HEALTH UNIT_FLAGS PARTY_MEMBER_ENABLE PARTY_MEMBER_DISABLE", function(unit)
		if (UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))) and not UnitIsFeignDeath(unit) then
			if UnitIsGhost(unit) then
				if E.db.ElvUI_EltreumUI.otherstuff.ghosttagicon ~= "NONE" then
					return cached_ghosttexture
				else
					return ElvUI_EltreumUI:SpellInfoShapeshift(8326)
				end
			else
				local hp = UnitHealth(unit)
				if UnitIsDead(unit) or UnitIsDeadOrGhost(unit) or (hp and E:NotSecretValue(hp) and hp <= 0) then
					if E.db.ElvUI_EltreumUI.otherstuff.deadtagicon ~= "NONE" then
						return cached_deadtexture
					else
						return L["Dead"]
					end
				end
			end
		end
	end)
	E:AddTagInfo("eltruism:dead", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Dead\dead1:0:0:0:0|t ]]..L["Displays a dead symbol when unit is dead. Can be customized in Eltruism > Media"])

	--Tag for dc based on elvui tag for health
	E:AddTag("eltruism:dc", "UNIT_CONNECTION PARTY_MEMBER_ENABLE PARTY_MEMBER_DISABLE", function(unit)
		if not UnitIsConnected(unit) and (UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))) then
			if E.db.ElvUI_EltreumUI.otherstuff.dctagicon ~= "NONE" then
				return cached_dctexture
			else
				return L["Offline"]
			end
		end
	end)
	E:AddTagInfo("eltruism:dc", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Disconnect\dc1:0:0:0:0|t ]].. L["Displays a disconnect symbol when unit is disconnected. Can be customized in Eltruism > Media"])

	E:AddTag("eltruism:leader", "GROUP_ROSTER_UPDATE PARTY_LEADER_CHANGED", function(unit)
		if not unit or not E:NotSecretValue(unit) then return end
		local leader = UnitIsGroupLeader(unit)
		local assist = UnitIsGroupAssistant(unit)
		local isTank = GetPartyAssignment("MAINTANK", unit)
		local isMainAssist = GetPartyAssignment("MAINASSIST", unit)
		local icons = ""
		if E:NotSecretValue(leader) and leader then
			icons = [[|TInterface\GroupFrame\UI-Group-LeaderIcon:0:0:0:0|t]]
		elseif E:NotSecretValue(assist) and assist then
			icons = [[|TInterface\GroupFrame\UI-Group-AssistantIcon:0:0:0:0|t]]
		end
		if E:NotSecretValue(isTank) and isTank then
			icons = icons..[[|TInterface\GroupFrame\UI-Group-MainTankIcon:0:0:0:0|t]]
		end
		if E:NotSecretValue(isMainAssist) and isMainAssist then
			icons = icons..[[|TInterface\GroupFrame\UI-Group-MainAssistIcon:0:0:0:0|t]]
		end
		if icons ~= "" then
			return icons
		end
	end)
	E:AddTagInfo("eltruism:leader", tagCategory, [[|TInterface\GroupFrame\UI-Group-LeaderIcon:0:0:0:0|t ]]..L["Shows the Leader Icon or Assist icon if the unit is Leader or Assist"])

	E:AddTag("eltruism:leader:emoji", "GROUP_ROSTER_UPDATE PARTY_LEADER_CHANGED", function(unit)
		if not unit or not E:NotSecretValue(unit) then return end
		local leader = UnitIsGroupLeader(unit)
		if E:NotSecretValue(leader) and leader then
			return [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Leader\Leader1:0:0:0:0|t]]
		end
	end)
	E:AddTagInfo("eltruism:leader:emoji", tagCategory, [[|TInterface\AddOns\ElvUI_EltreumUI\Media\Textures\Leader\Leader1:0:0:0:0|t]]..L["Shows the Leader Icon as an Emoji Crown"])

	--combat icon idea for other units
	E:AddTag("eltruism:combatindicator", 'UNIT_HEALTH PLAYER_FLAGS_CHANGED', function(unit)
		if UnitAffectingCombat(unit) then
			local texture = E.db.unitframe.units.player.CombatIcon.texture
			if combatTextureCache[texture] then
				return combatTextureCache[texture]
			else
				return E:TextureString(E.Media.CombatIcons[texture], ':20:20')
			end
		end
	end)
	E:AddTagInfo("eltruism:combatindicator", tagCategory, [[|TInterface\CharacterFrame\UI-StateIcon:0:0:0:0:64:64:34:59:6:29|t ]]..L["Displays an icon when the unit is in combat, uses player icon"])
end
