-- full credit to EmeraldLockdown for this code. Taken with permission.

if unsupported then return end

TEXTURE_ROUND_CORNER = get_texture_info("round_corner")

---@param text string
---@param x integer
---@param y integer
---@param scale integer
function djui_hud_print_colored_text(text, x, y, scale, opacity, reset)
    -- failsafe
    text = tostring(text)
	local inSlash = false
    local hex = ""
    if opacity == nil then opacity = 255 end

    -- get old color for restoration later
    local c = djui_hud_get_color()

	-- loop thru each character in the string and render that char
	for i = 1, #text do
        -- get character
		local c = text:sub(i,i)
        -- if character is a backslash, then switch inslash
		if c == "\\" then
			-- we are now in (or out) of the slash, set variable accordingly
			inSlash = not inSlash
            -- reset hex if needed
            if inSlash then
                hex = ""
            end
        elseif inSlash then
            -- set hex var
            hex = hex .. c
		elseif not inSlash then
            if hex:len() == 7 then
                -- get rgb
                local r, g, b = hex_to_rgb(hex)
                -- set color to rgb
                djui_hud_set_color(r, g, b, opacity)
            end
            -- print character
            djui_hud_print_text(c, x, y, scale)
            -- increase position
            x = x + (djui_hud_measure_text(c) * scale)
		end
	end

    -- restore old color
    if reset == false then djui_hud_set_color(c.r, c.g, c.b, c.a) end
end

---@param x number|integer
---@param y number|integer
---@param width number|integer
---@param height number|integer
---@param cornerRaidus number|integer
function djui_hud_render_rect_rounded(x, y, width, height, cornerRaidus)
    if cornerRaidus > width then cornerRaidus = width end
    if cornerRaidus > height then cornerRaidus = height end
    -- it's called black magic
    djui_hud_render_rect(x + (cornerRaidus / 2), y, width - cornerRaidus, height)
    djui_hud_render_rect(x, y + (cornerRaidus / 2), cornerRaidus / 2, height - cornerRaidus)
    djui_hud_render_rect(x + width - cornerRaidus / 2, y + (cornerRaidus / 2), cornerRaidus / 2, height - cornerRaidus)
    -- render corners
    local circleDimensions = (1 / 64) * cornerRaidus / 2
    -- top left corner
    djui_hud_render_texture(TEXTURE_ROUND_CORNER, x, y, circleDimensions, circleDimensions)
    -- bottom left corner
    djui_hud_set_rotation(0x4000, 0, 0)
    djui_hud_render_texture(TEXTURE_ROUND_CORNER, x, y + height, circleDimensions, circleDimensions)
    -- top right corner
    djui_hud_set_rotation(-0x4000, 0, 0)
    djui_hud_render_texture(TEXTURE_ROUND_CORNER, x + width, y, circleDimensions, circleDimensions)
    -- bottom right corner
    djui_hud_set_rotation(0x8000, 0, 0)
    djui_hud_render_texture(TEXTURE_ROUND_CORNER, x + width, y + height, circleDimensions, circleDimensions)
    djui_hud_set_rotation(0, 0, 0)
end

function djui_hud_render_rect_outlined(x, y, width, height, oR, oG, oB, thickness, opacity)
    if opacity == nil then opacity = 255 end
    -- render main rect
    djui_hud_render_rect(x, y, width, height)
    -- set outline color to, well, outline color
    djui_hud_set_color(oR, oG, oB, opacity)
    -- render rect outside of each side
    djui_hud_render_rect(x - thickness, y - thickness, thickness, height + thickness * 2)
    djui_hud_render_rect(x + (width - thickness) + thickness, y, thickness, height + thickness)
    djui_hud_render_rect(x, y - thickness, width + thickness, thickness)
    djui_hud_render_rect(x, y + (height - thickness) + thickness, width, thickness)
end

-- currently only viable with coopdx
---@param x number|integer
---@param y number|integer
---@param width number|integer
---@param height number|integer
---@param oR number|integer
---@param oG number|integer
---@param oB number|integer
---@param thickness number|integer
---@param opacity number|integer|nil
function djui_hud_render_rect_rounded_outlined(x, y, width, height, oR, oG, oB, thickness, opacity)
    if opacity == nil then opacity = 255 end
    local cornerRaidus = thickness
    -- render rounded rect using those saved colors
    djui_hud_render_rect(x, y, width, height)
    -- render rect outside of each side
    djui_hud_set_color(oR, oG, oB, opacity)
    djui_hud_render_rect(x - thickness, y, thickness, height)
    djui_hud_render_rect(x + (width - thickness) + thickness, y, thickness, height)
    djui_hud_render_rect(x, y - thickness, width, thickness)
    djui_hud_render_rect(x, y + (height - thickness) + thickness, width, thickness)
    -- render outline corners
    local circleDimensions = (1 / 64) * cornerRaidus
    -- top left corner
    djui_hud_render_texture(TEXTURE_ROUND_CORNER, x - thickness, y - thickness, circleDimensions, circleDimensions)
    -- bottom left corner
    djui_hud_set_rotation(0x4000, 0, 0)
    djui_hud_render_texture(TEXTURE_ROUND_CORNER, x - thickness, y + height + thickness, circleDimensions, circleDimensions)
    -- top right corner
    djui_hud_set_rotation(-0x4000, 0, 0)
    djui_hud_render_texture(TEXTURE_ROUND_CORNER, x + width + thickness, y - thickness, circleDimensions, circleDimensions)
    -- bottom right corner
    djui_hud_set_rotation(0x8000, 0, 0)
    djui_hud_render_texture(TEXTURE_ROUND_CORNER, x + width + thickness, y + height + thickness, circleDimensions, circleDimensions)
    djui_hud_set_rotation(0, 0, 0)
end

function wrap_text(text, maxLength)
    local lines = {}

    local paragraphs = {}
    local start = 1
    local splitStart, splitEnd = string.find(text, "\n", start)

    while splitStart do
        table.insert(paragraphs, string.sub(text, start, splitStart - 1))
        start = splitEnd + 1
        splitStart, splitEnd = string.find(text, "\n", start)
    end
    table.insert(paragraphs, string.sub(text, start))

    for _, paragraph in ipairs(paragraphs) do
        if paragraph == "" then
            table.insert(lines, "")
        else
            local line = ""

            for word in paragraph:gmatch("%S+") do
                if #line + #word < maxLength then
                    line = line .. word .. " "
                else
                    if #line > 0 then
                        table.insert(lines, line:sub(1, -2))
                    end
                    line = word .. " "

                    if #word >= maxLength then
                        table.insert(lines, word)
                        line = ""
                    end
                end
            end

            if #line > 0 then
                table.insert(lines, line:sub(1, -2))
            end
        end
    end
    
    return lines
end

function string_without_hex(name)
    local s = ''
    local inSlash = false
    for i = 1, #name do
        local c = name:sub(i,i)
        if c == '\\' then
            inSlash = not inSlash
        elseif not inSlash then
            s = s .. c
        end
    end
    return s
end

-- Head render function entirely made by EmilyEmmi. Thank you so much Emily!

local HEAD_HUD = get_texture_info("hud_head_recolor")
local WING_HUD = get_texture_info("hud_wing")

local defaultIcons = {
    [gTextures.mario_head] = true,
    [gTextures.luigi_head] = true,
    [gTextures.toad_head] = true,
    [gTextures.waluigi_head] = true,
    [gTextures.wario_head] = true,
}

local PART_ORDER = {
    SKIN,
    HAIR,
    CAP,
}

-- Function used for rendering the player head
--- @param index integer
--- @param x integer
--- @param y integer
--- @param scaleX number
--- @param scaleY number
function render_player_head(index, x, y, scaleX, scaleY, noSpecial, alwaysCap, alpha_)
    local m = gMarioStates[index]
    local np = gNetworkPlayers[index]

    local alpha = alpha_ or 255
    if (not noSpecial) and (m.marioBodyState.modelState & MODEL_STATE_NOISE_ALPHA) ~= 0 and (m.flags & MARIO_VANISH_CAP) ~= 0 then
        alpha = math.max(alpha - 155, 0) -- vanish effect
    end

    if charSelectExists then
        djui_hud_set_color(255, 255, 255, alpha)
        local TEX_CS_ICON = charSelect.character_get_life_icon(index)
        if TEX_CS_ICON and not defaultIcons[TEX_CS_ICON] then
            djui_hud_render_texture(TEX_CS_ICON, x, y, scaleX / (TEX_CS_ICON.width * 0.0625),
                scaleY / (TEX_CS_ICON.width * 0.0625))
            if (not noSpecial) and m.marioBodyState.capState == MARIO_HAS_WING_CAP_ON then
                djui_hud_render_texture(WING_HUD, x, y, scaleX, scaleY) -- wing
            end
            return
        elseif TEX_CS_ICON == nil then
            djui_hud_set_font(FONT_HUD)
            djui_hud_print_text("?", x, y, scaleX)
            if (not noSpecial) and m.marioBodyState.capState == MARIO_HAS_WING_CAP_ON then
                djui_hud_render_texture(WING_HUD, x, y, scaleX, scaleY) -- wing
            end
            return
        end
    end
    local isMetal = false
    local capless = false

    local tileY = m.character.type
    for i = 1, #PART_ORDER do
        local color = { r = 255, g = 255, b = 255 }
        if (not noSpecial) and (m.marioBodyState.modelState & MODEL_STATE_METAL) ~= 0 then -- metal
            color = network_player_get_override_palette_color(np, METAL)
            djui_hud_set_color(color.r, color.g, color.b, alpha)
            isMetal = true

            if (not (noSpecial or alwaysCap)) and m.marioBodyState.capState == MARIO_HAS_DEFAULT_CAP_OFF then
                capless = true
                djui_hud_render_texture_tile(HEAD_HUD, x, y, scaleX, scaleY, 7 * 16, tileY * 16, 16, 16) -- capless metal
            else
                djui_hud_render_texture_tile(HEAD_HUD, x, y, scaleX, scaleY, 5 * 16, tileY * 16, 16, 16)
            end
            break
        end

        local part = PART_ORDER[i]
        if (not (noSpecial or alwaysCap)) and part == CAP and m.marioBodyState.capState == MARIO_HAS_DEFAULT_CAP_OFF then -- capless check
            capless = true
            part = HAIR
        elseif tileY == 2 or tileY == 7 then
            if part == CAP and capless then return end
            tileY = 7 -- use alt toad
            if part == HAIR then -- toad doesn't use hair except when cap is off
                if (not (noSpecial or alwaysCap)) and m.marioBodyState.capState == MARIO_HAS_DEFAULT_CAP_OFF then
                    capless = true
                    part = HAIR
                else
                    part = GLOVES
                end
            end
        end
        color = network_player_get_override_palette_color(np, part)

        djui_hud_set_color(color.r, color.g, color.b, alpha)
        if capless then
            djui_hud_render_texture_tile(HEAD_HUD, x, y, scaleX, scaleY, 6 * 16, tileY * 16, 16, 16) -- render hair instead of cap
        else
            djui_hud_render_texture_tile(HEAD_HUD, x, y, scaleX, scaleY, (i - 1) * 16, tileY * 16, 16, 16)
        end
    end

    if not isMetal then
        djui_hud_set_color(255, 255, 255, alpha)
        --djui_hud_render_texture(HEAD_HUD, x, y, scaleX, scaleY)
        djui_hud_render_texture_tile(HEAD_HUD, x, y, scaleX, scaleY, (#PART_ORDER) * 16, tileY * 16, 16, 16)

        if not capless then
            djui_hud_render_texture_tile(HEAD_HUD, x, y, scaleX, scaleY, (#PART_ORDER + 1) * 16, tileY * 16, 16, 16) -- hat emblem
            if (not noSpecial) and m.marioBodyState.capState == MARIO_HAS_WING_CAP_ON then
                djui_hud_render_texture(WING_HUD, x, y, scaleX, scaleY)                                        -- wing
            end
        end
    elseif m.marioBodyState.capState == MARIO_HAS_WING_CAP_ON then
        djui_hud_set_color(109, 170, 173, alpha)                -- blueish green
        djui_hud_render_texture(WING_HUD, x, y, scaleX, scaleY) -- wing
    end
end