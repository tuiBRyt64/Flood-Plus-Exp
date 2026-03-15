--------------------------------------------------
-- SAVE DATA
--------------------------------------------------

gGlobalSyncTable.forceGreenAmb = gGlobalSyncTable.forceGreenAmb or false

--------------------------------------------------
-- LOCALIZE
--------------------------------------------------

local math_lerp, math_round, set_lighting_color, set_vertex_color, set_fog_color, set_lighting_dir,
      get_lighting_color, djui_hud_set_resolution, djui_hud_set_color,
      djui_hud_get_screen_width, djui_hud_get_screen_height,
      djui_hud_render_rect, find_poison_gas_level =
      math.lerp, math.round, set_lighting_color, set_vertex_color, set_fog_color, set_lighting_dir,
      get_lighting_color, djui_hud_set_resolution, djui_hud_set_color,
      djui_hud_get_screen_width, djui_hud_get_screen_height,
      djui_hud_render_rect, find_poison_gas_level

--------------------------------------------------
-- LEVEL TABLES
--------------------------------------------------

RED_COLOR = {
    LEVEL_SMW_RETRO,
    LEVEL_HELL
}

BLUE_COLOR = {
    LEVEL_AVALANCHE,
    LEVEL_FCS,
    LEVEL_TEST
}

GREEN_COLOR = {
    LEVEL_CASINO,
    LEVEL_CONSTRUCT,
    LEVEL_UP,
    LEVEL_NS,
    LEVEL_LOBBY,
    LEVEL_LB
}

SL_COLOR = {
    LEVEL_SL
}

--------------------------------------------------
-- PALETTES
--------------------------------------------------

local RED_PALETTE = {
    color = { r = 255, g = 192, b = 192 },
    lightingDir = { x = 0, y = 1, z = 0 }
}

local BLUE_PALETTE = {
    color = { r = 195, g = 195, b = 255 },
    lightingDir = { x = 0, y = 1, z = 0 }
}

local GREEN_PALETTE = {
    color = { r = 255, g = 255, b = 255 },
    lightingDir = { x = 0, y = 1, z = 0 }
}

local SL_PALETTE = {
    color = { r = 225, g = 255, b = 255 },
    lightingDir = { x = 0, y = 1, z = 0 }
}

--------------------------------------------------
-- WATER / POISON
--------------------------------------------------

local COLOR_WATER  = { r = 0,   g = 60,  b = 200 }
local COLOR_POISON = { r = 150, g = 200, b = 0   }

--------------------------------------------------
-- UTILS
--------------------------------------------------

local function lerp_round(a, b, t)
    return math_round(math_lerp(a, b, t))
end

local function color_mul(a, b)
    return {
        r = a.r * (b.r / 255.0),
        g = a.g * (b.g / 255.0),
        b = a.b * (b.b / 255.0)
    }
end

local function level_in_table(level, tbl)
    for i = 1, #tbl do
        if tbl[i] == level then
            return true
        end
    end
    return false
end

--------------------------------------------------
-- PALETTE DETECTION
--------------------------------------------------

local function get_palette_for_level(level)

    -- FORCE MODE
    if gGlobalSyncTable.forceGreenAmb then

        if level_in_table(level, RED_COLOR) then
            return RED_PALETTE
        end

        if level_in_table(level, BLUE_COLOR) then
            return BLUE_PALETTE
        end

        if level_in_table(level, SL_COLOR) then
            return SL_PALETTE
        end

        return GREEN_PALETTE
    end

    -- NORMAL MODE
    if level_in_table(level, RED_COLOR) then
        return RED_PALETTE
    end

    if level_in_table(level, BLUE_COLOR) then
        return BLUE_PALETTE
    end

    if level_in_table(level, GREEN_COLOR) then
        return GREEN_PALETTE
    end

    if level_in_table(level, SL_COLOR) then
        return SL_PALETTE
    end

    return nil
end

--------------------------------------------------
-- APPLY WORLD
--------------------------------------------------

local function set_world_properties(color, lightingDir)

    set_lighting_color(0, color.r)
    set_lighting_color(1, color.g)
    set_lighting_color(2, color.b)

    set_vertex_color(0, color.r)
    set_vertex_color(1, color.g)
    set_vertex_color(2, color.b)

    set_fog_color(0, color.r)
    set_fog_color(1, color.g)
    set_fog_color(2, color.b)

    set_lighting_dir(0, lightingDir.x)
    set_lighting_dir(1, lightingDir.y)
    set_lighting_dir(2, lightingDir.z)
end

--------------------------------------------------
-- UPDATE
--------------------------------------------------

local function update()
    local level = gNetworkPlayers[0].currLevelNum
    local palette = get_palette_for_level(level)

    if palette ~= nil then
        set_world_properties(palette.color, palette.lightingDir)
    else
        -- restore default white
        set_lighting_color(0, 255)
        set_lighting_color(1, 255)
        set_lighting_color(2, 255)

        set_vertex_color(0, 255)
        set_vertex_color(1, 255)
        set_vertex_color(2, 255)

        set_fog_color(0, 255)
        set_fog_color(1, 255)
        set_fog_color(2, 255)
    end
end

--------------------------------------------------
-- HUD OVERLAY
--------------------------------------------------

local function on_hud_render_behind()
    local m = gMarioStates[0]

    if gLakituState.pos.y < m.waterLevel then
        djui_hud_set_resolution(RESOLUTION_DJUI)

        local lightingColor = {
            r = get_lighting_color(0),
            g = get_lighting_color(1),
            b = get_lighting_color(2)
        }

        local color = color_mul(COLOR_WATER, lightingColor)
        djui_hud_set_color(color.r, color.g, color.b, 90)
        djui_hud_render_rect(0, 0,
            djui_hud_get_screen_width(),
            djui_hud_get_screen_height()
        )

    elseif gLakituState.pos.y < find_poison_gas_level(m.pos.x, m.pos.z) then
        djui_hud_set_resolution(RESOLUTION_DJUI)
        djui_hud_set_color(COLOR_POISON.r, COLOR_POISON.g, COLOR_POISON.b, 100)
        djui_hud_render_rect(0, 0,
            djui_hud_get_screen_width(),
            djui_hud_get_screen_height()
        )
    end
end

--------------------------------------------------
-- CHAT COMMAND
--------------------------------------------------

local function fpamb_command(msg)

    if msg == "on" then
        gGlobalSyncTable.forceGreenAmb = true
        djui_chat_message_create("\\#00ff00\\Ambient +: ON")

    elseif msg == "off" then
        gGlobalSyncTable.forceGreenAmb = false
        djui_chat_message_create("\\#ff0000\\Ambient +: OFF")

    else
        djui_chat_message_create("Usage: /fpamb [on/off]")
    end

    return true
end

hook_chat_command("fpamb", "[on/off] Active Ambient +", fpamb_command)

--------------------------------------------------
-- HOOKS
--------------------------------------------------

hook_event(HOOK_UPDATE, update)
hook_event(HOOK_ON_HUD_RENDER_BEHIND, on_hud_render_behind)