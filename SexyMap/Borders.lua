
local _, sm = ...
sm.borders = {}

local mod = sm.borders
local L = sm.L

local textures = {}
local texturePool = {}
local rotateTextures = {}
local defaultSize = 180
local customBackdrop
local media = LibStub("LibSharedMedia-3.0")

--获取所有小地图样式
local allBorders = {};
--获取所有小地图样式的名称数组
local borderPresetsSeq = {};

local layers = {
	BACKGROUND = L["1. Background"],
	BORDER = L["2. Border"],
	ARTWORK = L["3. Artwork"],
	OVERLAY = L["4. Overlay"],
	HIGHLIGHT = L["5. Highlight"],
}
local blendModes = {
	BLEND = L["Blend (normal)"],
	DISABLE = L["Disable (opaque)"],
	ALPHAKEY = L["Alpha Key (1-bit alpha)"],
	MOD = L["Mod Blend (modulative)"],
	ADD = L["Add Blend (additive)"],
}

local presets, userPresets = {}, {}

local function RotateTexture(self, inc, set)
	if type(inc) == "string" then
		local bearing = GetPlayerFacing()
		if inc == "normal" then
			bearing = bearing * -1
		end
		bearing = bearing * 57.2957795
		RotateTexture(self, bearing, true)
	else
		self.hAngle = (set and 0 or self.hAngle or 0) - inc;
		local s = sin(self.hAngle);
		local c = cos(self.hAngle);

		self:SetTexCoord(
			0.5 - s, 0.5 + c,
			0.5 + c, 0.5 + s,
			0.5 - c, 0.5 - s,
			0.5 + s, 0.5 - c
		)
	end
end

local selectedPreset
local options = {
	type = "group",
	name = L["Borders"],
	childGroups = "tab",
	args = {
		hideBlizzard = {
			type = "toggle",
			name = L["Hide default border"],
			desc = L["Hide the default border on the minimap."],
			get = function() return mod.db.hideBlizzard end,
			set = function(info, v) mod.db.hideBlizzard = v; mod:UpdateBorder() end,
		},
		currentGroup = {
			type = "group",
			name = L["Current Borders"],
			args = {
				shape = sm.shapes:GetShapeOptions(),
				newDesc = {
					type = "description",
					name = L["Enter a name to create a new border. The name can be anything you like to help you identify that border."],
					order = 1
				},
				new = {
					type = "input",
					name = L["Create a new border"],
					order = 2,
					width = "full",
					set = function(info, v)
						mod:NewBorder(v)
					end
				},
				clear = {
					name = L["Clear & start over"],
					desc = L["Clear the current borders and start fresh"],
					order = 3,
					type = "execute",
					func = function()
						mod:Clear()
					end
				},
				borders = {
					name = L["Borders"],
					type = "group",
					args = {
						default = {
							type = "group",
							name = L["Background/edge"],
							args = {
								explain = {
									type = "description",
									name = L["You can set a background and edge file for the minimap like you would with any frame. This is useful when you want to create static square backdrops for your minimap."]
								},
								show = {
									type = "toggle",
									name = L["Enable"],
									order = 2,
									desc = L["Enable a backdrop and border for the minimap. This will let you set square borders more easily."],
									get = function()
										return mod.db.backdrop.show
									end,
									set = function(info, v)
										mod.db.backdrop.show = v
										mod:UpdateBackdrop()
									end
								},
								scale = {
									type = "range",
									name = L["Scale"],
									order = 3,
									min = 0.5,
									max = 5,
									step = 0.01,
									bigStep = 0.01,
									width = "full",
									disabled = function()
										return not mod.db.backdrop.show
									end,
									get = function()
										return mod.db.backdrop.scale or 1
									end,
									set = function(info, v)
										mod.db.backdrop.scale = v
										mod:UpdateBackdrop()
									end
								},
								alpha = {
									type = "range",
									name = L["Opacity"],
									order = 4,
									min = 0,
									max = 1,
									step = 0.05,
									bigStep = 0.05,
									width = "full",
									disabled = function()
										return not mod.db.backdrop.show
									end,
									get = function()
										return mod.db.backdrop.alpha or 1
									end,
									set = function(info, v)
										mod.db.backdrop.alpha = v
										mod:UpdateBackdrop()
									end
								},
								texture = {
									type = "group",
									name = L["Background Texture"],
									disabled = function()
										return not mod.db.backdrop.show
									end,
									args = {
										texture = {
											type = "input",
											name = L["Texture"],
											order = 10,
											width = 2,
											get = function()
												return mod.db.backdrop.settings.bgFile
											end,
											set = function(info, v)
												mod.db.backdrop.settings.bgFile = v
												mod:UpdateBackdrop()
											end
										},
										openTexBrowser = {
											type = "execute",
											name = function()
												if select(2, GetAddOnInfo("TexBrowser")) then
													return L["Open TexBrowser"]
												else
													return L["TexBrowser Not Installed"]
												end
											end,
											order = 11,
											width = "full",
											func = function()
												if not IsAddOnLoaded("TexBrowser") then
													EnableAddOn("TexBrowser")
													LoadAddOn("TexBrowser")
												end
												TexBrowser:OnEnable()
											end,
											disabled = function()
												return not select(2, GetAddOnInfo("TexBrowser"))
											end
										},
										textureSelect = {
											type = "select",
											name = L["SharedMedia Texture"],
											order = 12,
											width = "full",
											dialogControl = 'LSM30_Background',
											values = AceGUIWidgetLSMlists.background,
											get = function()
												return mod.db.backdrop.settings.bgFile
											end,
											set = function(info, v)
												mod.db.backdrop.settings.bgFile = media:Fetch("background", v)
												mod:UpdateBackdrop()
											end
										},
										tile = {
											type = "toggle",
											name = L["Tile Background"],
											order = 13,
											get = function()
												return mod.db.backdrop.settings.tile
											end,
											set = function(info, v)
												mod.db.backdrop.settings.tile = v
												mod:UpdateBackdrop()
											end
										},
										tileSize = {
											type = "range",
											name = L["Tile Size"],
											order = 14,
											min = 0,
											max = 500,
											step = 1,
											bigStep = 1,
											width = "full",
											disabled = function()
												return not mod.db.backdrop.settings.tile
											end,
											get = function()
												return mod.db.backdrop.settings.tileSize
											end,
											set = function(info, v)
												mod.db.backdrop.settings.tileSize = v
												mod:UpdateBackdrop()
											end
										},
										textureColor = {
											type = "color",
											name = L["Backdrop Color"],
											order = 13,
											hasAlpha = true,
											get = function()
												local c = mod.db.backdrop.textureColor
												local r, g, b, a = c.r or 0, c.g or 0, c.b or 0, c.a or 1
												return r, g, b, a
											end,
											set = function(info, r, g, b, a)
												local c = mod.db.backdrop.textureColor
												c.r, c.g, c.b, c.a = r, g, b, a
												mod:UpdateBackdrop()
											end
										},
										inset = {
											type = "range",
											name = L["Backdrop Insets"],
											order = 15,
											min = 0,
											max = 20,
											step = 1,
											bigStep = 1,
											width = 2,
											get = function()
												return mod.db.backdrop.settings.insets.left
											end,
											set = function(info, v)
												mod.db.backdrop.settings.insets.left = v
												mod.db.backdrop.settings.insets.top = v
												mod.db.backdrop.settings.insets.bottom = v
												mod.db.backdrop.settings.insets.right = v
												mod:UpdateBackdrop()
											end
										},
									}
								},
								border = {
									type = "group",
									name = L["Border Texture"],
									disabled = function()
										return not mod.db.backdrop.show
									end,
									args = {
										border = {
											type = "input",
											name = L["Border Texture"],
											order = 20,
											width = "full",
											get = function()
												return mod.db.backdrop.settings.edgeFile
											end,
											set = function(info, v)
												mod.db.backdrop.settings.edgeFile = v
												mod:UpdateBackdrop()
											end
										},
										openTexBrowser = {
											type = "execute",
											name = function()
												if select(2, GetAddOnInfo("TexBrowser")) then
													return L["Open TexBrowser"]
												else
													return L["TexBrowser Not Installed"]
												end
											end,
											order = 21,
											width = "full",
											func = function()
												if not IsAddOnLoaded("TexBrowser") then
													EnableAddOn("TexBrowser")
													LoadAddOn("TexBrowser")
												end
												TexBrowser:OnEnable()
											end,
											disabled = function()
												return not select(2, GetAddOnInfo("TexBrowser"))
											end
										},
										textureSelect = {
											type = "select",
											name = L["SharedMedia Border"],
											order = 22,
											width = "full",
											dialogControl = 'LSM30_Border',
											values = AceGUIWidgetLSMlists.border,
											get = function()
												return mod.db.backdrop.settings.edgeFile
											end,
											set = function(info, v)
												mod.db.backdrop.settings.edgeFile = media:Fetch("border", v)
												mod:UpdateBackdrop()
											end
										},
										borderColor = {
											type = "color",
											order = 23,
											name = L["Border Color"],
											hasAlpha = true,
											get = function()
												local c = mod.db.backdrop.borderColor
												local r, g, b, a = c.r or 1, c.g or 1, c.b or 1, c.a or 1
												return r, g, b, a
											end,
											set = function(info, r, g, b, a)
												local c = mod.db.backdrop.borderColor
												c.r, c.g, c.b, c.a = r, g, b, a
												mod:UpdateBackdrop()
											end
										},
										edgeSize = {
											type = "range",
											name = L["Border Edge Size"],
											order = 25,
											min = 6,
											max = 48,
											step = 1,
											bigStep = 1,
											width = 2,
											get = function()
												return mod.db.backdrop.settings.edgeSize
											end,
											set = function(info, v)
												mod.db.backdrop.settings.edgeSize = v
												mod:UpdateBackdrop()
											end
										},
									}
								}
							}
						}
					}
				}
			}
		},
		presets = {
			type = "group",
			name = L["Preset"],
			args = {
				saveas = {
					name = L["Save current settings as preset..."],
					order = 1,
					type = "input",
					width = "full",
					get = function() return "" end,
					set = function(info, v)
						mod:SavePresetAs(v)
						selectedPreset = v
					end
				},
				preset = {
					type = "select",
					name = L["Select preset to load"],
					desc = L["Select a preset to load settings from. This will erase any of your current borders."],
					order = 2,
					confirm = true,
					confirmText = L["This will wipe out any current settings!"],
					values = presets,
					get = function()
						return selectedPreset
					end,
					set = function(info, v)
						selectedPreset = v
						mod:ApplyPreset(v)
					end
				},
				delete = {
					name = L["Delete"],
					type = "select",
					confirm = true,
					order = 3,
					disabled = function()
						for k, v in pairs(userPresets) do
							return false
						end
						return true
					end,
					confirmText = L["Really delete this preset? This can't be undone."],
					values = userPresets,
					get = function(info, v)
						return nil
					end,
					set = function(info, v)
						if selectedPreset == v then
							mod:ApplyPreset("Blue Rune Circles")
						end
						mod.presets[v] = nil
						userPresets[v] = nil
						presets[v] = nil
					end
				},
			}
		}
	}
}

local function getLeaf(info)
	return info.options.args[info[1]].args[info[2]].args[info[3]]
end

local function getTextureAndDB(info)
	local key = getLeaf(info).arg
	return textures[key]
end

local borderOptions = {
	header1 = {
		type = "header",
		name = L["Entry Options"],
		order = 1
	},
	name = {
		type = "input",
		name = L["Name"],
		order = 2,
		get = function(info)
			return getLeaf(info).name
		end,
		set = function(info, name)
			getLeaf(info).name = name
			local tex = getTextureAndDB(info)
			tex.settings.name = name
		end
	},
	delete = {
		type = "execute",
		name = L["Delete"],
		confirm = true,
		confirmText = L["Really delete this border?"],
		order = 3,
		func = function(info)
			local index = getLeaf(info).arg
			for k, v in ipairs(mod.db.borders) do
				if v == textures[index].settings then
					tremove(mod.db.borders, k)
					break
				end
			end
			info.options.args[info[1]].args[info[2]].args[index] = nil
			rotateTextures[textures[index]] = nil
			tinsert(texturePool, textures[index])
			textures[index]:Hide()
			textures[index] = nil
		end
	},
	header2 = {
		type = "header",
		name = L["Texture Path"],
		order = 50
	},
	textureText = {
		type = "description",
		name = L["Enter the full path to a texture to use. It's recommended that you use something like |cffff6600TexBrowser|r to find textures to use."],
		order = 51
	},
	openTexBrowser = {
		type = "execute",
		name = function()
			if select(2, GetAddOnInfo("TexBrowser")) then
				return L["Open TexBrowser"]
			else
				return L["TexBrowser Not Installed"]
			end
		end,
		order = 52,
		width = "full",
		func = function()
			if not IsAddOnLoaded("TexBrowser") then
				EnableAddOn("TexBrowser")
				LoadAddOn("TexBrowser")
			end
			TexBrowser:OnEnable()
		end,
		disabled = function()
			return not select(2, GetAddOnInfo("TexBrowser"))
		end
	},
	texture = {
		type = "input",
		name = L["Texture Path"],
		order = 53,
		width = "full",
		get = function(info)
			local tex = getTextureAndDB(info)
			return tostring(tex.settings.texture) -- Have to tostring FileIDs for the editbox to display it
		end,
		set = function(info, v)
			local tex = getTextureAndDB(info)
			local num = tonumber(v)
			-- If true, assume it's a FileID and save it as a number.
			if num then v = num end
			tex.settings.texture = v
			tex:SetTexture(v)
		end
	},
	header3 = {
		type = "header",
		name = L["Texture Options"],
		order = 99
	},
	scale = {
		type = "range",
		name = L["Scale"],
		min = 0.2,
		max = 3.0,
		step = 0.01,
		bigStep = 0.01,
		width = "full",
		order = 116,
		get = function(info)
			local tex = getTextureAndDB(info)
			return tex.settings.scale or 1
		end,
		set = function(info, v)
			local tex = getTextureAndDB(info)
			tex.settings.scale = v
			tex:SetWidth((tex.settings.width or defaultSize) * v)
			tex:SetHeight((tex.settings.height or defaultSize) * v)
		end
	},
	rotation = {
		type = "range",
		name = L["Rotation Speed (seconds)"],
		desc = L["The time it takes (in seconds) to complete one rotation. A setting of 0 turns off rotation."],
		min = -300,
		max = 300,
		step = 1,
		bigStep = 1,
		order = 114,
		disabled = function(info)
			local tex = getTextureAndDB(info)
			return tex.settings.disableRotation or type(rotateTextures[tex]) == "string"
		end,
		width = "full",
		get = function(info)
			local tex = getTextureAndDB(info)
			return tex.settings.rotSpeed or 0
		end,
		set = function(info, v)
			local tex = getTextureAndDB(info)
			tex.settings.rotSpeed = v
			tex.rotSpeed = v
			if v == 0 then
				local getAnim = tex:GetAnimationGroups()
				if getAnim then
					getAnim:Stop()
				end
				rotateTextures[tex] = nil
			else
				rotateTextures[tex] = v
				mod:StartRotations()
			end
		end
	},
	staticRotation = {
		type = "range",
		name = L["Static Rotation"],
		desc = L["A static amount to rotate the texture by."],
		min = 0,
		max = 360,
		order = 115,
		disabled = function(info)
			local tex = getTextureAndDB(info)
			return tex.settings.disableRotation or type(rotateTextures[tex]) == "string"
		end,
		step = 1,
		bigStep = 1,
		width = "full",
		get = function(info)
			local tex = getTextureAndDB(info)
			return tex.settings.rotation or 0
		end,
		set = function(info, v)
			local tex = getTextureAndDB(info)
			tex.settings.rotation = v
			RotateTexture(tex, v, true)
			tex.rotSpeed = 0
			tex.settings.rotSpeed = 0
			rotateTextures[tex] = nil
		end
	},
	--[[playerRotation = {
		type = "multiselect",
		name = L["Match player rotation"],
		values = {
			normal = L["Normal rotation"],
			reverse = L["Reverse rotation"],
			none = L["Do not match player rotation"],
		},
		order = 113,
		get = function(info, v)
			local tex = getTextureAndDB(info)
			return rotateTextures[tex] == v or (not rotateTextures[tex] and v == "none")
		end,
		set = function(info, v)
			local tex = getTextureAndDB(info)
			if v ~= "none" then
				rotateTextures[tex] = v
			else
				rotateTextures[tex] = nil
			end
			tex.settings.playerRotation = v
		end
	},]]
	color = {
		type = "color",
		name = L["Texture Tint"],
		order = 109,
		width = "full",
		hasAlpha = true,
		get = function(info)
			local tex = getTextureAndDB(info)
			return tex.settings.r or 1, tex.settings.g or 1, tex.settings.b or 1, tex.settings.a or 1
		end,
		set = function(info, r, g, b, a)
			local tex = getTextureAndDB(info)
			tex.settings.r, tex.settings.g, tex.settings.b, tex.settings. a = r, g, b, a
			tex:SetVertexColor(r,g,b,a)
		end
	},
	hNudge = {
		type = "range",
		name = L["Horizontal Nudge"],
		min = -100,
		max = 100,
		step = 1,
		bigStep = 1,
		order = 149,
		get = function(info)
			local tex = getTextureAndDB(info)
			return tex.settings.hNudge or 0
		end,
		set = function(info, v)
			local tex = getTextureAndDB(info)
			tex:ClearAllPoints()
			tex.settings.hNudge = v
			tex:SetPoint("CENTER", Minimap, "CENTER", tex.settings.hNudge or 0, tex.settings.vNudge or 0)
		end
	},
	vNudge = {
		type = "range",
		name = L["Vertical Nudge"],
		min = -100,
		max = 100,
		step = 1,
		bigStep = 1,
		order = 150,
		get = function(info)
			local tex = getTextureAndDB(info)
			return tex.settings.vNudge or 0
		end,
		set = function(info, v)
			local tex = getTextureAndDB(info)
			tex:ClearAllPoints()
			tex.settings.vNudge = v
			tex:SetPoint("CENTER", Minimap, "CENTER", tex.settings.hNudge or 0, tex.settings.vNudge or 0)
		end
	},
	width = {
		type = "range",
		name = L["Width"],
		min = 1,
		max = 500,
		step = 1,
		bigStep = 1,
		order = 151,
		width = "full",
		get = function(info)
			local tex = getTextureAndDB(info)
			return tex.settings.width or 180
		end,
		set = function(info, v)
			local tex = getTextureAndDB(info)
			tex.settings.width = v ~= 180 and v or nil
			tex:SetWidth(v * (tex.settings.scale or 1))
		end
	},
	height = {
		type = "range",
		name = L["Height"],
		min = 1,
		max = 500,
		step = 1,
		bigStep = 1,
		order = 152,
		width = "full",
		get = function(info)
			local tex = getTextureAndDB(info)
			return tex.settings.height or 180
		end,
		set = function(info, v)
			local tex = getTextureAndDB(info)
			tex.settings.height = v ~= 180 and v or nil
			tex:SetHeight(v * (tex.settings.scale or 1))
		end
	},
	layer = {
		type = "select",
		name = L["Layer"],
		values = layers,
		order = 110,
		get = function(info)
			local tex = getTextureAndDB(info)
			return tex:GetDrawLayer()
		end,
		set = function(info, v)
			local tex = getTextureAndDB(info)
			tex.settings.drawLayer = v
			tex:SetDrawLayer(v)
		end
	},
	blend = {
		type = "select",
		name = L["Blend Mode"],
		values = blendModes,
		order = 111,
		get = function(info)
			local tex = getTextureAndDB(info)
			return tex:GetBlendMode()
		end,
		set = function(info, v)
			local tex = getTextureAndDB(info)
			tex.settings.blendMode = v
			tex:SetBlendMode(v)
		end
	},
	disableRotation = {
		type = "toggle",
		name = L["Disable Rotation"],
		desc = L["Force a square texture. Fixed distortion on square textures."],
		get = function(info)
			local tex = getTextureAndDB(info)
			return tex.settings.disableRotation
		end,
		width = "full",
		order = 112,
		set = function(info, v)
			local tex = getTextureAndDB(info)
			tex.settings.disableRotation = v
			RotateTexture(tex, tex.settings.rotation or 0, true)
			local getAnim = tex:GetAnimationGroups()
			if v then
				if getAnim then
					getAnim:Stop()
				end
				rotateTextures[tex] = nil
			else
				if getAnim then
					getAnim:Play()
				end
				rotateTextures[tex] = tex.settings.rotSpeed
			end
		end
	}
}

local defaults = {
	backdrop = {
		scale = 1,
		show = false,
		textureColor = {},
		borderColor = {},
		settings = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			insets = {left = 4, top = 4, right = 4, bottom = 4},
			edgeSize = 16,
			tile = false
		}
	}
}

function mod:OnInitialize(profile)
	if type(profile.borders) ~= "table" then
		profile.borders = {
			hideBlizzard = true,
			borders = {},
			applyPreset = "Blue Rune Circles",
			backdrop = {
				scale = 1,
				show = false,
				textureColor = {},
				borderColor = {},
				settings = {
					bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
					edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
					insets = {left = 4, top = 4, right = 4, bottom = 4},
					edgeSize = 16,
					tile = false
				}
			}
		}
	end
	self.db = profile.borders
	if (self.db.borderName == nil) then
		self.db.borderName = "Blue Rune Circles"
	end

	if type(SexyMap2DB.presets) ~= "table" then
		SexyMap2DB.presets = {}
	end
	self.presets = SexyMap2DB.presets
end

function mod:OnEnable()
	sm.core:RegisterModuleOptions("Borders", options, L["Borders"])

	local args = sm.core.options.args
	args.defaultPresets = sm.core.deepCopyHash(options.args.presets.args.preset)
	if args.defaultPresets then
		args.defaultPresets.name = L["Default Presets"]
		args.defaultPresets.order = 11
		args.defaultPresets.width = nil
		args.defaultPresets.values = function()
			local tbl = {}
			for k,v in pairs(presets) do
				if not k:find("by") then
					tbl[k]=k
				end
			end
			return tbl
		end
	end
	args.userPresets = sm.core.deepCopyHash(options.args.presets.args.preset)
	if args.userPresets then
		args.userPresets.name = L["User-Submitted Presets"]
		args.userPresets.order = 13
		args.userPresets.width = nil
		args.userPresets.values = function()
			local tbl = {}
			for k,v in pairs(presets) do
				if k:find("by") then
					tbl[k]=k
				end
			end
			return tbl
		end
	end

	customBackdrop = CreateFrame("Frame", "SexyMapCustomBackdrop", Minimap)
	customBackdrop:SetFrameStrata("BACKGROUND")
	customBackdrop:SetPoint("CENTER")
	customBackdrop:SetWidth(Minimap:GetWidth())
	customBackdrop:SetHeight(Minimap:GetHeight())

	self:RebuildPresets()

	if mod.db.applyPreset then
		self:ApplyPreset(mod.db.applyPreset)
		mod.db.applyPreset = false
	else
		self:ApplySettings()
	end

end

function mod:OnDisable()
	self:ClearWidgets()
end

function mod:RebuildPresets()
	for k, v in pairs(self.presets) do
		userPresets[k] = k
		presets[k] = k
	end
	for k, v in pairs(sm.borderPresets) do
		presets[k] = k
	end
end

function mod:Clear()
	sm.core.db.shape = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga"
	mod.db.borders = {} -- leaky
	mod.db.backdrop = sm.core.deepCopyHash(defaults.backdrop) -- leaky
	return self:ApplySettings()
end

function mod:ApplyPreset(preset)
	mod.db.borderName = preset;
	MinimapStyleShowString:SetText(preset);
	local preset = self.presets[preset] or sm.borderPresets[preset]

	mod.db.borders = sm.core.deepCopyHash(preset.borders)
	mod.db.backdrop = preset.backdrop and sm.core.deepCopyHash(preset.backdrop) or sm.core.deepCopyHash(defaults.backdrop)
	sm.core.db.shape = preset.shape

	return self:ApplySettings()
end

function mod:NewBorder(name)
	local t = {name = name}
	tinsert(mod.db.borders, t)
	self:CreateBorderFromParams(t)
end

function mod:SavePresetAs(name)
	self.presets[name] = {
		borders = sm.core.deepCopyHash(mod.db.borders),
		backdrop = sm.core.deepCopyHash(mod.db.backdrop),
		shape = sm.shapes:GetShape()
	}
	self:RebuildPresets()
end

local inc = 0
function mod:CreateBorderFromParams(t)
	inc = inc + 1
	local tex = tremove(texturePool) or Minimap:CreateTexture()
	tex:SetTexture(t.texture)
	tex:SetBlendMode(t.blendMode or "ADD")
	tex:SetVertexColor(t.r or 1, t.g or 1, t.b or 1, t.a or 1)
	tex:SetPoint("CENTER", Minimap, "CENTER", t.hNudge or 0, t.vNudge or 0)
	tex:SetWidth((t.width or defaultSize) * (t.scale or 1))
	tex:SetHeight((t.height or defaultSize) * (t.scale or 1))
	tex:SetDrawLayer(t.drawLayer or "ARTWORK")

	tex.rotSpeed = t.rotSpeed or 0
	tex.settings = t
	tex:Show()
	if t.disableRotation then
		tex:SetTexCoord(0, 1, 0, 1)
	else
		if t.playerRotation and t.playerRotation ~= "none" then
			rotateTextures[tex] = t.playerRotation
		else
			rotateTextures[tex] = t.rotSpeed ~= 0 and t.rotSpeed or nil
		end
		RotateTexture(tex, t.rotation or 0, true)
	end

	local r,g,b,a = t.r or 1, t.g or 1, t.b or 1, t.a or 1
	tex:SetVertexColor(r,g,b,a)
	textures["tex" .. inc] = tex

	options.args.currentGroup.args.borders.args["tex" .. inc] = {
		type = "group",
		name = t.name or ("Border #" .. inc),
		arg = "tex" .. inc,
		args = borderOptions
	}
	return tex
end

function mod:ClearWidgets()
	for k, v in pairs(options.args.currentGroup.args.borders.args) do
		if k ~= "default" then
			-- Leaky, but we don't care too much
			options.args.currentGroup.args.borders.args[k] = nil
		end
	end
	for k, v in pairs(textures) do
		tinsert(texturePool, v)
		v:Hide()
		textures[k] = nil
	end
	for k, v in pairs(rotateTextures) do
		local getAnim = k:GetAnimationGroups()
		if getAnim then
			getAnim:Stop()
		end
		rotateTextures[k] = nil
	end
end

function mod:StartRotations()
	if next(rotateTextures) then
		for k, v in pairs(rotateTextures) do
			if type(v) == "number" then
				local getAnim = k:GetAnimationGroups()
				if getAnim then
					getAnim:Stop()
					local anim = getAnim:GetAnimations()
					if v > 0 then
						anim:SetDegrees(-360)
						anim:SetDuration(v)
						getAnim:Play()
					elseif v < 0 then
						anim:SetDegrees(360)
						anim:SetDuration(-v)
						getAnim:Play()
					end
				else
					local animgroup = k:CreateAnimationGroup()
					local anim = animgroup:CreateAnimation("Rotation")
					anim:SetOrder(1)
					animgroup:SetLooping("REPEAT")
					if v > 0 then
						anim:SetDegrees(-360)
						anim:SetDuration(v)
						animgroup:Play()
					elseif v < 0 then
						anim:SetDegrees(360)
						anim:SetDuration(-v)
						animgroup:Play()
					end
				end
			end
		end
	end
end

function mod:ApplySettings()
	self:ClearWidgets()

	if sm.core.db.shape then
		sm.shapes:ApplyShape(sm.core.db.shape)
	end

	for _, v in ipairs(mod.db.borders) do
		self:CreateBorderFromParams(v)
	end

	self:StartRotations()

	self:UpdateBorder()
	self:UpdateBackdrop()
end

function mod:UpdateBorder()
	if mod.db.hideBlizzard then
		MinimapBorder:Hide()
	else
		MinimapBorder:Show()
	end
end

function mod:UpdateBackdrop()
	if mod.db.backdrop.show then
		customBackdrop:Show()
		customBackdrop:SetScale(mod.db.backdrop.scale or 1)
		customBackdrop:SetAlpha(mod.db.backdrop.alpha or 1)
		customBackdrop:SetBackdrop(mod.db.backdrop.settings)
		local t = mod.db.backdrop.textureColor
		customBackdrop:SetBackdropColor(t.r or 0, t.g or 0, t.b or 0, t.a or 1)
		t = mod.db.backdrop.borderColor
		customBackdrop:SetBackdropBorderColor(t.r or 1, t.g or 1, t.b or 1, t.a or 1)
	else
		customBackdrop:Hide()
	end
end


function mod:GetSequenceOfBorderPresets(borderPresets)
	local tbl = {};
	for i in pairs(borderPresets) do
		if i then
			table.insert(tbl, i);
		end
	end
	
	return tbl;
end

--创建淡入动画
local function CreateFadeInAnimation(object)
	object.fadeIn = object:CreateAnimationGroup();
	local alphaAnimIn = object.fadeIn:CreateAnimation("Alpha")
	alphaAnimIn:SetOrder(1)
	alphaAnimIn:SetDuration(0.2)
	alphaAnimIn:SetFromAlpha(0)
	alphaAnimIn:SetToAlpha(1)
	object.fadeIn:SetToFinalAlpha(true)
end

--创建淡出动画
local function CreateFadeOutAnimation(object)
	object.fadeOut = object:CreateAnimationGroup();
	local alphaAnimOut = object.fadeOut:CreateAnimation("Alpha")
	alphaAnimOut:SetOrder(1)
	alphaAnimOut:SetDuration(0.2)
	alphaAnimOut:SetFromAlpha(1)
	alphaAnimOut:SetToAlpha(0)
	alphaAnimOut:SetStartDelay(1)
	object.fadeOut:SetToFinalAlpha(true)
end

function AllFadeIn(tbl)
	for _,v in pairs(tbl) do
		if v.fadeIn and v.fadeOut then
			v.fadeIn:Stop();
			v.fadeOut:Stop();
			v.fadeIn:Play();
		end
	end
end

function AllFadeOut(tbl)
	for _,v in pairs(tbl) do
		if v.fadeIn and v.fadeOut then
			v.fadeIn:Stop();
			v.fadeOut:Stop();
			v.fadeOut:Play();
		end
	end
end

local function AllStop(tbl)
	for _,v in pairs(tbl) do
		v.fadeIn:Stop();
		v.fadeOut:Stop();
	end
end

function StyleChangePrevButton_OnClick(...)
	if mod and mod.db and mod.db.borderName then
		local currPos;
		for i,v in pairs(borderPresetsSeq) do
			if v == mod.db.borderName then
				currPos = i;
				break;
			end
		end
		
		if currPos then
			currPos = currPos - 1;
			if currPos < 1 then
				currPos = currPos + #borderPresetsSeq;
			end
			local prevBorderName = borderPresetsSeq[currPos];
			mod:ApplyPreset(prevBorderName);
		end
	end
end

function StyleChangeNextButton_OnClick(...)
	if mod and mod.db and mod.db.borderName then
		local currPos;
		for i,v in pairs(borderPresetsSeq) do
			if v == mod.db.borderName then
				currPos = i;
				break;
			end
		end
		
		if currPos then
			currPos = currPos + 1;
			if currPos > (#borderPresetsSeq) then
				currPos = currPos - #borderPresetsSeq;
			end
			local nextBorderName = borderPresetsSeq[currPos];
			mod:ApplyPreset(nextBorderName);
		end
	end
end


function CreateSelectionButton()
	--获取所有小地图样式
	allBorders = sm.borderPresets;
	
	--获取所有小地图样式的名称数组
	borderPresetsSeq = mod:GetSequenceOfBorderPresets(allBorders);
	
	--把任务跟踪模块往下调
	if ObjectiveTrackerFrame then
		ObjectiveTrackerFrame:ClearAllPoints()
		ObjectiveTrackerFrame:SetPoint('TOPRIGHT', Minimap, 'BOTTOMRIGHT', -20, -60)
	end
	
	--创建切换样式区域
	local showRegion = CreateFrame("Frame", "MinimapStyleShowRegion", Minimap);
	showRegion:SetHeight(40);
	showRegion:SetWidth(250);
	showRegion:SetPoint("TOP",Minimap,"BOTTOM",31,-6)
	-- showRegion:SetPoint("RIGHT",Minimap,"LEFT",-35,0)
	showRegion:SetFrameLevel(8);
	showRegion:SetAlpha(0);
	CreateFadeInAnimation(showRegion);
	CreateFadeOutAnimation(showRegion);
	
	--创建向前切换图标
	local prevButton = CreateFrame("Button", "MinimapStyleChangePrevButton");
	prevButton:SetWidth(10);
	prevButton:SetHeight(10);
	prevButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up");
	prevButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down");
	prevButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled");
	prevButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight");
	prevButton:SetPoint("RIGHT", showRegion, "LEFT", 65, 0);
	prevButton:RegisterForClicks("LeftButtonUp" ,"RightButtonUp");
	prevButton:SetScript("OnClick", StyleChangePrevButton_OnClick);
	showRegion.prevButton = prevButton;
	prevButton:SetAlpha(0);
	prevButton:SetFrameLevel(8);
	CreateFadeInAnimation(prevButton);
	CreateFadeOutAnimation(prevButton);
	
	--创建向后切换图标
	local nextButton = CreateFrame("Button", "MinimapStyleChangeNextButton");
	nextButton:SetWidth(10);
	nextButton:SetHeight(10);
	nextButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up");
	nextButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down");
	nextButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled");
	nextButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight");
	nextButton:SetPoint("LEFT", showRegion, "RIGHT", -65, 0);
	nextButton:RegisterForClicks("LeftButtonUp" ,"RightButtonUp");
	nextButton:SetScript("OnClick", StyleChangeNextButton_OnClick);
	showRegion.nextButton = nextButton;
	nextButton:SetAlpha(0);
	nextButton:SetFrameLevel(8);
	CreateFadeInAnimation(nextButton);
	CreateFadeOutAnimation(nextButton);
	
	--设置淡入淡出动画
	prevButton.leaveButton = false;
	nextButton.leaveButton = false;
	showRegion.leaveText = false;
	
	showRegion:SetScript("OnEnter", function()
		if (leaveButton) then
			AllStop({showRegion, prevButton, nextButton})
			showRegion:SetAlpha(1);
			prevButton:SetAlpha(1);
			nextButton:SetAlpha(1);
		else
			AllFadeIn({showRegion, prevButton, nextButton})
		end
		prevButton.leaveButton = false;
		nextButton.leaveButton = false;
		showRegion.leaveText = false;
	end)
	showRegion:SetScript("OnLeave", function()
		showRegion.leaveText = true;
		AllFadeOut({showRegion, prevButton, nextButton})
	end)
	prevButton:SetScript("OnEnter", function()
		if (leaveText) then
			AllStop({showRegion, prevButton, nextButton})
			showRegion:SetAlpha(1);
			prevButton:SetAlpha(1);
			nextButton:SetAlpha(1);
		else
			AllFadeIn({showRegion, prevButton, nextButton})
		end
		
		prevButton.leaveButton = false;
		nextButton.leaveButton = false;
		showRegion.leaveText = false;
	end)
	prevButton:SetScript("OnLeave", function()
		prevButton.leaveButton = true;
		AllFadeOut({showRegion, prevButton, nextButton})
	end)
	nextButton:SetScript("OnEnter", function()
		if (leaveText) then
			AllStop({showRegion, prevButton, nextButton})
			showRegion:SetAlpha(1);
			prevButton:SetAlpha(1);
			nextButton:SetAlpha(1);
		else
			AllFadeIn({showRegion, prevButton, nextButton})
		end
		
		prevButton.leaveButton = false;
		nextButton.leaveButton = false;
		showRegion.leaveText = false;
	end)
	nextButton:SetScript("OnLeave", function()
		nextButton.leaveButton = true;
		AllFadeOut({showRegion, prevButton, nextButton})
	end)
	
	ffff = mod.db;
	local showString = showRegion:CreateFontString("MinimapStyleShowString", "OVERLAY");
	showString:SetFont("Fonts\\ARKai_T.TTF", 12);
	showString:SetPoint("CENTER", showRegion, "CENTER",0 ,0);
	showString:SetWidth(80);
	showString:SetHeight(24);
	showString:SetText(mod.db.borderName);	--显示当前小地图样式
	showRegion.showString = showString;
	
	-- showRegion.bg = showRegion:CreateTexture(showRegion:GetName().."Border","BACKGROUND")
	-- showRegion.bg:SetTexture([[Interface\AddOns\BFGadgets\res\gpsborder]])
	-- showRegion.bg:SetTexCoord(0,1,0,1)
	-- showRegion.bg:SetWidth(80);
	-- showRegion.bg:SetHeight(24);
	-- showRegion.bg:SetPoint("CENTER", showString, "CENTER",0 ,-24)
	-- showRegion.bg:SetAllPoints(showRegion)
	-- showRegion.bg:Show()
	
end

