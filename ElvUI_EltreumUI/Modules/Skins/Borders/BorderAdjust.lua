local E = unpack(ElvUI)
local _G = _G
local GetPhysicalScreenSize = _G.GetPhysicalScreenSize

--automatically adjust things if borders is enabled
function ElvUI_EltreumUI:BorderAdjust()
	if E.db.ElvUI_EltreumUI.borders.borderautoadjust then
		--if not using one of my profiles then disable auto adjust to prevent overwriting settings and return
		if E.private.ElvUI_EltreumUI.install_version and not (ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") or ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer")) then
			E.db.ElvUI_EltreumUI.borders.borderautoadjust = false
		else
			local width = GetPhysicalScreenSize()
			if E.db.ElvUI_EltreumUI.borders.borders then
				if not E.db.movers then E.db.movers = {} end

				--transparency doesnt work well with borders due to the .backdrop/twopixels thing on UF
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha = 1
				end

				--general border settings for both profiles
				E.db.ElvUI_EltreumUI.borders.texture = "Eltreum-Border-1"
				--E.db.ElvUI_EltreumUI.borders.classcolor = true
				E.db.ElvUI_EltreumUI.borders.auraborder = true
				E.db.ElvUI_EltreumUI.borders.aurasizex = 54
				E.db.ElvUI_EltreumUI.borders.aurasizey = 54
				E.db.ElvUI_EltreumUI.borders.chatborder = true
				E.db.ElvUI_EltreumUI.borders.leftchatborderx = 432
				if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then
					E.db.ElvUI_EltreumUI.borders.leftchatbordery = 201
					E.db.ElvUI_EltreumUI.borders.rightchatbordery = 201
				else
					E.db.ElvUI_EltreumUI.borders.leftchatbordery = 224
					E.db.ElvUI_EltreumUI.borders.rightchatbordery = 224
				end
				E.db.ElvUI_EltreumUI.borders.rightchatborderx = 432
				E.db.ElvUI_EltreumUI.borders.partyborders = true
				E.db.ElvUI_EltreumUI.borders.raidborders = true
				E.db.ElvUI_EltreumUI.borders.playertargetsize = 20
				E.db.ElvUI_EltreumUI.borders.baredgesize = 13
				E.db.ElvUI_EltreumUI.borders.playertargetcastsize = 20
				E.db.ElvUI_EltreumUI.borders.petsize = 20
				E.db.ElvUI_EltreumUI.borders.totembar = true
				E.db.ElvUI_EltreumUI.borders.groupsize = 14
				E.db.ElvUI_EltreumUI.borders.focussize = 20
				E.db.ElvUI_EltreumUI.borders.bosssize = 20
				E.db.ElvUI_EltreumUI.borders.minimapsize = 15
				E.db.ElvUI_EltreumUI.borders.chatsize = 13
				E.db.ElvUI_EltreumUI.borders.aurasize = 13
				E.db.ElvUI_EltreumUI.borders.powerbarborder = false
				E.db.ElvUI_EltreumUI.borders.powerbarsize = 4
				E.db.ElvUI_EltreumUI.borders.xpowerbar = 138.8
				E.db.ElvUI_EltreumUI.borders.ypowerbar = 12
				E.db.ElvUI_EltreumUI.borders.minimapborder = true
				E.db.ElvUI_EltreumUI.borders.petborder = true
				E.db.ElvUI_EltreumUI.borders.petsizex = 188
				E.db.ElvUI_EltreumUI.borders.playerborder = true
				E.db.ElvUI_EltreumUI.borders.xplayer = 302
				E.db.ElvUI_EltreumUI.borders.yplayer = 75
				E.db.ElvUI_EltreumUI.borders.playercastborder = true
				E.db.ElvUI_EltreumUI.borders.yplayercast = 58
				E.db.ElvUI_EltreumUI.borders.targetborder = true
				E.db.ElvUI_EltreumUI.borders.xtarget = 302.8
				E.db.ElvUI_EltreumUI.borders.ytarget = 75
				E.db.ElvUI_EltreumUI.borders.targetcastborder = true
				E.db.ElvUI_EltreumUI.borders.xcasttarget = 272
				E.db.ElvUI_EltreumUI.borders.ycasttarget = 58
				E.db.ElvUI_EltreumUI.borders.targettargetborder = true
				E.db.ElvUI_EltreumUI.borders.ytargettarget = 75
				E.db.ElvUI_EltreumUI.borders.focusborder = true
				E.db.ElvUI_EltreumUI.borders.xfocus = 224
				E.db.ElvUI_EltreumUI.borders.yfocus = 72
				E.db.ElvUI_EltreumUI.borders.bossborder = true
				E.db.ElvUI_EltreumUI.borders.minimapsizex = 225
				E.db.ElvUI_EltreumUI.borders.focuscastborder = true
				E.db.ElvUI_EltreumUI.borders.xcastfocus = 365
				E.db.ElvUI_EltreumUI.borders.ycastfocus = 62

				if not E.db.datatexts.panels.MinimapPanel.backdrop or not E.db.datatexts.panels.MinimapPanel.enable then
					E.db.ElvUI_EltreumUI.borders.minimapsizey = 225
				else
					E.db.ElvUI_EltreumUI.borders.minimapsizey = 247
				end
				E.db.ElvUI_EltreumUI.borders.stancexborder = 49
				E.db.ElvUI_EltreumUI.borders.stanceyborder = 42
				E.db.ElvUI_EltreumUI.borders.petactionedgesize = 13
				E.db["actionbar"]["stanceBar"]["buttonSpacing"] = 5
				if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then
					E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,-1,22"
					E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,0,22"
				else
					E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,-1,-1"
					E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,1,-1"
				end
				E.db["movers"]["MinimapMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-4"

				if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") then

					if not E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA then
						E.db["actionbar"]["bar1"]["buttonSpacing"] = 4
						E.db["actionbar"]["bar2"]["buttonSpacing"] = 5
						E.db["actionbar"]["bar3"]["buttonSpacing"] = 5
						E.db["actionbar"]["bar4"]["buttonSpacing"] = 5
						E.db["actionbar"]["bar5"]["buttonSpacing"] = 5
						E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,221"
						E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,187"
						E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,154"
						E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,121"
						E.db["ElvUI_EltreumUI"]["borders"]["bar1xborder"] = 65
						E.db["ElvUI_EltreumUI"]["borders"]["bar1yborder"] = 56
						E.db["ElvUI_EltreumUI"]["borders"]["bar2xborder"] = 56
						E.db["ElvUI_EltreumUI"]["borders"]["bar2yborder"] = 50
						E.db["ElvUI_EltreumUI"]["borders"]["bar3xborder"] = 56
						E.db["ElvUI_EltreumUI"]["borders"]["bar3yborder"] = 50
						E.db["ElvUI_EltreumUI"]["borders"]["bar4xborder"] = 56
						E.db["ElvUI_EltreumUI"]["borders"]["bar4yborder"] = 50
						E.db["ElvUI_EltreumUI"]["borders"]["bar5xborder"] = 56
						E.db["ElvUI_EltreumUI"]["borders"]["bar5yborder"] = 50
					else
						E.db["ElvUI_EltreumUI"]["borders"]["bar1xborder"] = 62
						E.db["ElvUI_EltreumUI"]["borders"]["bar1yborder"] = 56
						E.db["ElvUI_EltreumUI"]["borders"]["bar2xborder"] = 62
						E.db["ElvUI_EltreumUI"]["borders"]["bar2yborder"] = 56
						E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,260"
					end

					if not E.db.ElvUI_EltreumUI.otherstuff.alternativegroups then
						E.db["movers"]["ElvUF_Raid1Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-4"
						E.db["movers"]["ElvUF_Raid2Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-4"
						E.db["movers"]["ElvUF_Raid3Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-4"
						E.db["unitframe"]["units"]["raid1"]["verticalSpacing"] = 7
						E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 3
						E.db["unitframe"]["units"]["raid2"]["verticalSpacing"] = 6
						E.db["unitframe"]["units"]["raid2"]["groupsPerRowCol"] = 3
						E.db["unitframe"]["units"]["raid3"]["verticalSpacing"] = 6
						E.db["unitframe"]["units"]["raid3"]["groupsPerRowCol"] = 3
					end
					E.db["ElvUI_EltreumUI"]["borders"]["xplayercast"] = 272
					E.db["ElvUI_EltreumUI"]["borders"]["xtargettarget"] = 132.8

					E.db.ElvUI_EltreumUI.borders.partysizex = 222
					E.db.ElvUI_EltreumUI.borders.partysizey = 98

					E.db.ElvUI_EltreumUI.borders.raidsizex = 140
					E.db.ElvUI_EltreumUI.borders.raidsizey = 61
					E.db.ElvUI_EltreumUI.borders.raid2sizex = 141
					E.db.ElvUI_EltreumUI.borders.raid2sizey = 62
					E.db.ElvUI_EltreumUI.borders.raid40sizex = 143
					E.db.ElvUI_EltreumUI.borders.raid40sizey = 61

					E.db.ElvUI_EltreumUI.borders.xboss = 250
					E.db.ElvUI_EltreumUI.borders.yboss = 87
					E.db.ElvUI_EltreumUI.borders.xcasttarget = 272
					E.db.ElvUI_EltreumUI.borders.ycasttarget = 58
					E.db.ElvUI_EltreumUI.borders.petsizex = 192
					E.db.ElvUI_EltreumUI.borders.totemxborder = 44
					E.db.ElvUI_EltreumUI.borders.totemyborder = 44
					E.db.ElvUI_EltreumUI.borders.petactionxborder = 49
					E.db.ElvUI_EltreumUI.borders.petactionyborder = 44

					if E.Wrath then
						E.db["actionbar"]["totemBar"]["spacing"] = 5
						E.db["movers"]["TotemBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,94"
					end
					if not E.Retail then
						E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,97"
					end
				elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
					if not E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA then
						E.db["actionbar"]["bar1"]["buttonSpacing"] = 5
						E.db["actionbar"]["bar2"]["buttonSpacing"] = 5
						E.db["actionbar"]["bar3"]["buttonSpacing"] = 5
						E.db["actionbar"]["bar4"]["buttonSpacing"] = 5
						E.db["actionbar"]["bar5"]["buttonSpacing"] = 5
						E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,307"
						E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,278"
						E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,311,249"
						E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,249"
						E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-311,249"
						E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,-303,309"
						if width == 1920 then
							E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,307"
							E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,278"
							E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,320,248"
							E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,249"
							E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-320,248"
							E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,-303,309"
						end
					else
						E.db["ElvUI_EltreumUI"]["borders"]["bar1xborder"] = 62
						E.db["ElvUI_EltreumUI"]["borders"]["bar1yborder"] = 56
						E.db["ElvUI_EltreumUI"]["borders"]["bar2xborder"] = 62
						E.db["ElvUI_EltreumUI"]["borders"]["bar2yborder"] = 56
						E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,260"
					end
					E.db["ElvUI_EltreumUI"]["borders"]["xplayercast"] = 294
					E.db["ElvUI_EltreumUI"]["borders"]["xtargettarget"] = 162
					E.db["ElvUI_EltreumUI"]["borders"]["bar1xborder"] = 61
					E.db["ElvUI_EltreumUI"]["borders"]["bar1yborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar2xborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar2yborder"] = 46
					E.db["ElvUI_EltreumUI"]["borders"]["bar3xborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar3yborder"] = 46
					E.db["ElvUI_EltreumUI"]["borders"]["bar4xborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar4yborder"] = 46
					E.db["ElvUI_EltreumUI"]["borders"]["bar5xborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar5yborder"] = 46
					E.db.ElvUI_EltreumUI.borders.partysizex = 173
					E.db.ElvUI_EltreumUI.borders.partysizey = 98
					E.db.ElvUI_EltreumUI.borders.raidsizex = 182
					E.db.ElvUI_EltreumUI.borders.raidsizey = 63
					E.db.ElvUI_EltreumUI.borders.raid2sizex = 152
					E.db.ElvUI_EltreumUI.borders.raid2sizey = 62
					E.db.ElvUI_EltreumUI.borders.raid40sizex = 122
					E.db.ElvUI_EltreumUI.borders.raid40sizey = 63
					E.db.ElvUI_EltreumUI.borders.xboss = 248
					E.db.ElvUI_EltreumUI.borders.yboss = 78
					E.db.ElvUI_EltreumUI.borders.xcasttarget = 296
					E.db.ElvUI_EltreumUI.borders.ycasttarget = 58
					E.db.ElvUI_EltreumUI.borders.petsizex = 130
					E.db.ElvUI_EltreumUI.borders.totemxborder = 44
					E.db.ElvUI_EltreumUI.borders.totemyborder = 44
					E.db.ElvUI_EltreumUI.borders.petactionxborder = 50
					E.db.ElvUI_EltreumUI.borders.petactionyborder = 37
					E.db.ElvUI_EltreumUI.borders.stancexborder = 45

					if E.Wrath then
						E.db["actionbar"]["totemBar"]["spacing"] = 5
					end
				end
			elseif not E.db.ElvUI_EltreumUI.borders.borders then
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha = 0.8
				end

				if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then
					E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,-1,22"
					E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,0,22"
				else
					E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,-1,0"
					E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,1,0"
				end
				E.db["movers"]["MinimapMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-6,-3"
				E.db["actionbar"]["stanceBar"]["buttonSpacing"] = 3

				if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") then
					if not E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA then
						E.db["actionbar"]["bar1"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar2"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar3"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar4"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar5"]["buttonSpacing"] = 3
						E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,223"
						E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,191"
						E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,159"
						E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,127"
						E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,106"
						if width == 1920 then
							E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,158"
							E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,125"
							E.db["actionbar"]["bar2"]["buttonSpacing"] = 2
							E.db["actionbar"]["bar3"]["buttonSpacing"] = 2
							E.db["actionbar"]["bar4"]["buttonSpacing"] = 2
							E.db["actionbar"]["bar5"]["buttonSpacing"] = 2
							E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,103"
						end
					end
					if not E.db.ElvUI_EltreumUI.otherstuff.alternativegroups then
						E.db["movers"]["ElvUF_Raid1Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,1,-1"
						E.db["movers"]["ElvUF_Raid2Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,1,-1"
						E.db["movers"]["ElvUF_Raid3Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,1,-1"
						E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 4
						E.db["unitframe"]["units"]["raid1"]["verticalSpacing"] = 3
						E.db["unitframe"]["units"]["raid2"]["groupsPerRowCol"] = 4
						E.db["unitframe"]["units"]["raid2"]["verticalSpacing"] = 3
						E.db["unitframe"]["units"]["raid3"]["groupsPerRowCol"] = 4
						E.db["unitframe"]["units"]["raid3"]["verticalSpacing"] = 3
					end
					if E.Wrath then
						E.db["actionbar"]["totemBar"]["spacing"] = 3
						E.db["movers"]["TotemBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,100"
					end
				elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
					if not E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA then
						E.db["actionbar"]["bar1"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar2"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar3"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar4"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar5"]["buttonSpacing"] = 3
						E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,307"
						E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,280"
						E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,308,253"
						E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,253"
						E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-308,253"
						E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,-308,308"
					end
					if E.Wrath then
						E.db["actionbar"]["totemBar"]["spacing"] = 3
					end
				end
			end

			if E.private.actionbar.enable then
				E:UpdateActionBars()
			end

			--wrath shaman compatibility
			if not (E.Wrath) then
				E:UpdateMoverPositions()
			elseif (E.Wrath) then
				if E.myclass ~= 'SHAMAN' then
					E:UpdateMoverPositions()
				elseif E.myclass == 'SHAMAN' then
					E:Delay(1, function()
						E:UpdateMoverPositions()
					end)
				end
			end
		end
	end
end
