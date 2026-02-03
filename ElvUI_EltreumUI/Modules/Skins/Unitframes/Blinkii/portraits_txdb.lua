local E = unpack(ElvUI)

local textures = {
	circle = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_mask.tga",
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare2_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_shadow.tga",
			},
		},
	},
	thincircle = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin_circle\\thin_circle_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin_circle\\thin_circle_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin_circle\\thin_circle_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin_circle\\thin_circle_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin_circle\\thin_circle_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin_circle\\thin_circle_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin_circle\\thin_circle_mask.tga",
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare2_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_shadow.tga",
			},
		},
	},
	diamond = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_mask.tga",
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare2_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare4_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare5_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare5_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare5_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare5_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare5_shadow.tga",
			},
		},
	},
	thindiamond = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin_diamond\\thin_diamond_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin_diamond\\thin_diamond_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin_diamond\\thin_diamond_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin_diamond\\thin_diamond_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin_diamond\\thin_diamond_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin_diamond\\thin_diamond_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin_diamond\\thin_diamond_mask.tga",
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare2_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare4_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare5_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare5_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare5_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare5_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\diamond\\diamond_rare5_shadow.tga",
			},
		},
	},
	drop = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_inner.tga",
		mask = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_mask_a.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_mask_c.tga",
		},
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_shadow.tga",
			},
		},
		corner = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_border.tga",
		},
	},
	dropflip = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_inner.tga",
		mask = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_mask_b.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_mask_d.tga",
		},
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_shadow.tga",
			},
		},
		corner = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_border.tga",
		},
	},
	dropsharp = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_sharp_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_sharp_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_sharp_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_sharp_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_sharp_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_inner.tga",
		mask = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_mask_a.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_mask_c.tga",
		},
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_shadow.tga",
			},
		},
		corner = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_border.tga",
		},
	},
	dropsharpflip = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_sharp_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_sharp_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_sharp_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_sharp_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_sharp_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_inner.tga",
		mask = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_mask_b.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_mask_d.tga",
		},
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_shadow.tga",
			},
		},
		corner = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_corner_border.tga",
		},
	},
	octagon = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_mask.tga",
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare2_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare4_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare5_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare5_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare5_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare5_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\octagon\\octagon_rare5_shadow.tga",
			},
		},
	},
	pad = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_mask.tga",
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare2_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare4_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare5_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare5_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare5_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare5_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pad\\pad_rare5_shadow.tga",
			},
		},
	},
	pure = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_inner.tga",
		mask = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_mask_a.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_mask_b.tga",
		},
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_shadow.tga",
			},
		},
	},
	puresharp = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_sharp_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_sharp_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_sharp_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_sharp_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_sharp_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_inner.tga",
		mask = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_mask_a.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_mask_b.tga",
		},
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\circle\\circle_rare4_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\pure\\pure_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare2_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\drop\\drop_rare3_shadow.tga",
			},
		},
	},
	shield = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_mask.tga",
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare2_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare4_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare5_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare5_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare5_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare5_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\shield\\shield_rare5_shadow.tga",
			},
		},
	},
	square = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_mask.tga",
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare2_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare4_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare5_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare5_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare5_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare5_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\square\\square_rare5_shadow.tga",
			},
		},
	},
	thin = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_mask.tga",
		rare = {
			a = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare1_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare1_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare1_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare1_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare1_shadow.tga",
			},
			b = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare2_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare2_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare2_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare2_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare2_shadow.tga",
			},
			c = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare3_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare3_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare3_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare3_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare3_shadow.tga",
			},
			d = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare4_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare4_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare4_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare4_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare4_shadow.tga",
			},
			e = {
				texture = {
					a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare5_txa.tga",
					b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare5_txb.tga",
					c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare5_txc.tga",
				},
				border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare5_border.tga",
				shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\thin\\thin_rare5_shadow.tga",
			},
		},
	},
}

local old_textures = {
	CI = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\circle\\old_circle_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\circle\\old_circle_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\circle\\old_circle_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\circle\\old_circle_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\circle\\old_circle_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\circle\\old_circle_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\circle\\old_circle_mask.tga",
		rare = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\circle\\old_circle_rare_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\circle\\old_circle_rare_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\circle\\old_circle_rare_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\circle\\old_circle_rare_border.tga",
			shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\circle\\old_circle_rare_shadow.tga",
		},
	},
	RA = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\diamond\\old_diamond_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\diamond\\old_diamond_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\diamond\\old_diamond_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\diamond\\old_diamond_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\diamond\\old_diamond_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\diamond\\old_diamond_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\diamond\\old_diamond_mask.tga",
		rare = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\diamond\\old_diamond_rare_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\diamond\\old_diamond_rare_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\diamond\\old_diamond_rare_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\diamond\\old_diamond_rare_border.tga",
			shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\diamond\\old_diamond_rare_shadow.tga",
		},
	},
	RO = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_inner.tga",
		mask = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_mask_a.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_mask_c.tga",
		},
		rare = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_border.tga",
			shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_shadow.tga",
		},
		corner = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_border.tga",
		},
	},
	ROT = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_inner.tga",
		mask = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_mask_b.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_mask_d.tga",
		},
		rare = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_border.tga",
			shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_shadow.tga",
		},
		corner = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_border.tga",
		},
	},
	SQ = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_sharp_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_sharp_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_sharp_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_sharp_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_sharp_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_inner.tga",
		mask = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_mask_a.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_mask_c.tga",
		},
		rare = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_border.tga",
			shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_shadow.tga",
		},
		corner = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_border.tga",
		},
	},
	SQT = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_sharp_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_sharp_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_sharp_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_sharp_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_sharp_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_inner.tga",
		mask = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_mask_b.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_mask_d.tga",
		},
		rare = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_border.tga",
			shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_rare_shadow.tga",
		},
		corner = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\drop\\old_drop_corner_border.tga",
		},
	},
	MO = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\moon\\old_moon_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\moon\\old_moon_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\moon\\old_moon_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\moon\\old_moon_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\moon\\old_moon_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\circle\\old_circle_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\circle\\old_circle_mask.tga",
		rare = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\moon\\old_moon_rare_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\moon\\old_moon_rare_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\moon\\old_moon_rare_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\moon\\old_moon_rare_border.tga",
			shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\moon\\old_moon_rare_shadow.tga",
		},
	},
	PI = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\pad\\old_pad_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\pad\\old_pad_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\pad\\old_pad_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\pad\\old_pad_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\pad\\old_pad_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\pad\\old_pad_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\pad\\old_pad_mask.tga",
		rare = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\pad\\old_pad_rare_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\pad\\old_pad_rare_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\pad\\old_pad_rare_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\pad\\old_pad_rare_border.tga",
			shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\pad\\old_pad_rare_shadow.tga",
		},
	},
	QA = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\square\\old_square_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\square\\old_square_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\square\\old_square_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\square\\old_square_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\square\\old_square_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\square\\old_square_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\square\\old_square_mask.tga",
		rare = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\square\\old_square_rare_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\square\\old_square_rare_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\square\\old_square_rare_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\square\\old_square_rare_border.tga",
			shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\square\\old_square_rare_shadow.tga",
		},
	},
	TH = {
		texture = {
			a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\thin\\old_thin_txa.tga",
			b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\thin\\old_thin_txb.tga",
			c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\thin\\old_thin_txc.tga",
		},
		border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\thin\\old_thin_border.tga",
		shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\thin\\old_thin_shadow.tga",
		inner = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\thin\\old_thin_inner.tga",
		mask = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\thin\\old_thin_mask.tga",
		rare = {
			texture = {
				a = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\thin\\old_thin_rare_txa.tga",
				b = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\thin\\old_thin_rare_txb.tga",
				c = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\thin\\old_thin_rare_txc.tga",
			},
			border = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\thin\\old_thin_rare_border.tga",
			shadow = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\old\\thin\\old_thin_rare_shadow.tga",
		},
	},
}

local bg_textures = {
	[1] = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\bg_1.tga",
	[2] = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\bg_2.tga",
	[3] = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\bg_3.tga",
	[4] = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\bg_4.tga",
	[5] = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\bg_5.tga",
	empty = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\empty.tga",
	unknown = "Interface\\Addons\\ElvUI_mMediaTag\\media\\portraits\\unknown.tga",
}

local old = {
	SQ = true,
	RO = true,
	CI = true,
	PI = true,
	RA = true,
	QA = true,
	MO = true,
	SQT = true,
	ROT = true,
	TH = true,
}

local corner = {
	SQ = true,
	RO = true,
	SQT = true,
	ROT = true,
	drop = true,
	dropsharp = true,
	dropflip = true,
	dropsharpflip = true,
}

local extraMask = {
	SQ = true,
	RO = true,
	SQT = true,
	ROT = true,
	drop = true,
	dropsharp = true,
	dropflip = true,
	dropsharpflip = true,
	pure = true,
	puresharp = true,
}

local fliped = {
	SQT = true,
	ROT = true,
	dropflip = true,
	dropsharpflip = true,
}

local styleOKCheck = {
	a = true,
	b = true,
	c = true,
}
local function OldSytleCheck()
	local style = E.db.ElvUI_EltreumUI.unitframes.portraits.general.style
	if style == "flat" then
		E.db.ElvUI_EltreumUI.unitframes.portraits.general.style = "a"
	elseif style == "smooth" then
		E.db.ElvUI_EltreumUI.unitframes.portraits.general.style = "b"
	elseif style == "metal" then
		E.db.ElvUI_EltreumUI.unitframes.portraits.general.style = "c"
	elseif not styleOKCheck[style] then
		E.db.ElvUI_EltreumUI.unitframes.portraits.general.style = "a"
	end
end

function ElvUI_EltreumUI:GetTextures(style)
	local tmp_db = {}

	if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable then
		tmp_db.texture = E.db.ElvUI_EltreumUI.unitframes.portraits.custom.texture
		tmp_db.border = E.db.ElvUI_EltreumUI.unitframes.portraits.custom.border
		tmp_db.shadow = E.db.ElvUI_EltreumUI.unitframes.portraits.custom.shadow
		tmp_db.inner = E.db.ElvUI_EltreumUI.unitframes.portraits.custom.inner
		tmp_db.extraMask = true
		tmp_db.mask = {
			a = E.db.ElvUI_EltreumUI.unitframes.portraits.custom.mask,
			b = (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.maskb ~= "") and E.db.ElvUI_EltreumUI.unitframes.portraits.custom.maskb or E.db.ElvUI_EltreumUI.unitframes.portraits.custom.mask,
		}
		tmp_db.rare = {
			texture = E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extra,
			border = E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extraborder,
			shadow = E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extrashadow,
		}
		tmp_db.elite = {
			texture = E.db.ElvUI_EltreumUI.unitframes.portraits.custom.elite,
			border = E.db.ElvUI_EltreumUI.unitframes.portraits.custom.eliteborder,
			shadow = E.db.ElvUI_EltreumUI.unitframes.portraits.custom.eliteshadow,
		}
		tmp_db.boss = {
			texture = E.db.ElvUI_EltreumUI.unitframes.portraits.custom.boss,
			border = E.db.ElvUI_EltreumUI.unitframes.portraits.custom.bossborder,
			shadow = E.db.ElvUI_EltreumUI.unitframes.portraits.custom.bossshadow,
		}
	elseif ElvUI_EltreumUI.Media.CustomPortraits[style] then
		tmp_db.texture = ElvUI_EltreumUI.Media.CustomPortraits[style].texture
		tmp_db.border = ElvUI_EltreumUI.Media.CustomPortraits[style].border
		tmp_db.shadow = ElvUI_EltreumUI.Media.CustomPortraits[style].shadow
		tmp_db.inner = ElvUI_EltreumUI.Media.CustomPortraits[style].inner

		if ElvUI_EltreumUI.Media.CustomPortraits[style].maskb then
			tmp_db.extraMask = true
			tmp_db.mask = {
				a = ElvUI_EltreumUI.Media.CustomPortraits[style].mask,
				b = ElvUI_EltreumUI.Media.CustomPortraits[style].maskb ~= "" and E.db.ElvUI_EltreumUI.unitframes.portraits.custom.maskb or E.db.ElvUI_EltreumUI.unitframes.portraits.custom.mask,
			}
		else
			tmp_db.extraMask = false
			tmp_db.mask = ElvUI_EltreumUI.Media.CustomPortraits[style].mask
		end

		tmp_db.rare = {
			texture = ElvUI_EltreumUI.Media.CustomPortraits[style].rare,
			border = ElvUI_EltreumUI.Media.CustomPortraits[style].rareborder,
			shadow = ElvUI_EltreumUI.Media.CustomPortraits[style].rareshadow,
		}
		tmp_db.elite = {
			texture = ElvUI_EltreumUI.Media.CustomPortraits[style].elite,
			border = ElvUI_EltreumUI.Media.CustomPortraits[style].eliteborder,
			shadow = ElvUI_EltreumUI.Media.CustomPortraits[style].eliteshadow,
		}
		tmp_db.boss = {
			texture = ElvUI_EltreumUI.Media.CustomPortraits[style].boss,
			border = ElvUI_EltreumUI.Media.CustomPortraits[style].bossborder,
			shadow = ElvUI_EltreumUI.Media.CustomPortraits[style].bossshadow,
		}
	else
		OldSytleCheck()

		-- prevent nil erorr if the providing addon is not loaded
		if not (ElvUI_EltreumUI.Media.CustomPortraits[style] or old_textures[style] or textures[style]) then style = "drop" end

		local variant = E.db.ElvUI_EltreumUI.unitframes.portraits.general.style
		local textures_source = old[style] and old_textures or textures

		tmp_db.texture = textures_source[style].texture[variant]
		tmp_db.border = textures_source[style].border
		tmp_db.shadow = textures_source[style].shadow
		tmp_db.inner = textures_source[style].inner
		tmp_db.flip = fliped[style]

		if extraMask[style] then
			tmp_db.extraMask = true
			tmp_db.mask = {
				a = textures_source[style].mask.a,
				b = textures_source[style].mask.b,
			}
		else
			tmp_db.extraMask = false
			tmp_db.mask = textures_source[style].mask
		end

		if E.db.ElvUI_EltreumUI.unitframes.portraits.general.corner and corner[style] then
			tmp_db.corner = {
				texture = textures_source[style].corner.texture[variant],
				border = textures_source[style].corner.border,
			}
		else
			tmp_db.corner = false
		end

		if old[style] then
			tmp_db.rare = {
				texture = textures_source[style].rare.texture[variant],
				border = textures_source[style].rare.border,
				shadow = textures_source[style].rare.shadow,
			}
			tmp_db.elite = {
				texture = textures_source[style].rare.texture[variant],
				border = textures_source[style].rare.border,
				shadow = textures_source[style].rare.shadow,
			}
			tmp_db.boss = {
				texture = textures_source[style].rare.texture[variant],
				border = textures_source[style].rare.border,
				shadow = textures_source[style].rare.shadow,
			}
		else
			local rareStyle = E.db.ElvUI_EltreumUI.unitframes.portraits.extra.rare
			local eliteStyle = E.db.ElvUI_EltreumUI.unitframes.portraits.extra.elite
			local bossStyle = E.db.ElvUI_EltreumUI.unitframes.portraits.extra.boss

			tmp_db.rare = {
				texture = textures_source[style].rare[rareStyle].texture[variant],
				border = textures_source[style].rare[rareStyle].border,
				shadow = textures_source[style].rare[rareStyle].shadow,
			}
			tmp_db.elite = {
				texture = textures_source[style].rare[eliteStyle].texture[variant],
				border = textures_source[style].rare[eliteStyle].border,
				shadow = textures_source[style].rare[eliteStyle].shadow,
			}
			tmp_db.boss = {
				texture = textures_source[style].rare[bossStyle].texture[variant],
				border = textures_source[style].rare[bossStyle].border,
				shadow = textures_source[style].rare[bossStyle].shadow,
			}
		end
	end
	return tmp_db
end
