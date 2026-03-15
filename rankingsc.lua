-- XP Ranking System (Simple & Standalone)

TEX_XP_BAR = get_texture_info("xp_bar")

local ceil = math.ceil
local random = math.random

-- =========================
-- VARIABLES
-- =========================

local rankPoints = 0
local lastBarValue = nil
local lastRankIndex = nil
local xpEnabled = true -- ACTIVADO POR DEFECTO

-- 10 segundos = 30 fps * 10 = 300 frames
local XP_INTERVAL = 300
local XP_PER_INTERVAL = 10

-- =========================
-- RANK DATA
-- =========================

local RANKS = {
    { name = "Absolute Noob", min = 0, max = 150 },
    { name = "Swimmer", min = 150, max = 300 },
    { name = "Rafter", min = 300, max = 550 },
    { name = "Boater", min = 550, max = 900 },
    { name = "\"Yachter\"", min = 900, max = 1350 },
    { name = "Flood Private", min = 1350, max = 1900 },
    { name = "Flood Corporal", min = 1900, max = 2550 },
    { name = "Flood Sergeant", min = 2550, max = 3300 },
    { name = "Flood Lieutenant", min = 3300, max = 4150 },
    { name = "Chad", min = 4150, max = 5100 },
    { name = "GIGACHAD", min = 5100, max = 6150 },
    { name = "ABSOLUTE GIGACHAD", min = 6150, max = 7300 },
    { name = "DaMemes", min = 7300, max = 8550 },
    { name = "Noah", min = 8550, max = 9900 },
    { name = "Poseidon", min = 9900, max = 11350 },
    { name = "Probably God.", min = 11350, max = 12900 },
    { name = "john flood the second", min = 12900, max = 14550 },
    { name = "john flood the first", min = 14550, max = 16300 },
    { name = "no lifer", min = 16300, max = 18150 },
    { name = "TRUE no lifer", min = 18150, max = 20100 },
    { name = "TRUE Noah", min = 20100, max = 42150 },
    { name = "The End.", min = 42150, max = 42150 }
}

-- =========================
-- LOAD SAVE
-- =========================

local saved = mod_storage_load_number("rank_points")
if saved then
    rankPoints = saved
end

local savedToggle = mod_storage_load_number("xp_enabled")
if savedToggle ~= nil then
    xpEnabled = (savedToggle == 1)
end

-- =========================
-- RANK LOGIC
-- =========================

local function get_current_rank_index()
    for i = 1, #RANKS do
        local rank = RANKS[i]
        if rankPoints >= rank.min and
           (rankPoints < rank.max or rank.min == rank.max) then
            return i
        end
    end
    return #RANKS
end

-- =========================
-- AUTO XP SYSTEM
-- =========================

local function mario_update(m)
    if m ~= gMarioStates[0] then return end

    if get_global_timer() % XP_INTERVAL == 0 then
        rankPoints = rankPoints + XP_PER_INTERVAL
        mod_storage_save_number("rank_points", rankPoints)
    end

    local currentRank = get_current_rank_index()

    if lastRankIndex == nil then
        lastRankIndex = currentRank
    elseif lastRankIndex ~= currentRank then
        local_play(sLevelUp, m.pos, 1)
        lastRankIndex = currentRank
    end
end

-- =========================
-- HUD
-- =========================

local function render_xp_bar()
    if not xpEnabled then return end

    local scale = 4
    local screenW = djui_hud_get_screen_width()
    local screenH = djui_hud_get_screen_height()

    local barWidth = 122
    local barHeight = 8

    -- Corrección horizontal estilo Flood
    local scaleX = scale / 15.5
    local scaleY = scale

    -- ✅ Centrado REAL
    local totalWidth = barWidth * scaleX
    local totalHeight = barHeight * scaleY

    local x = screenW * 0.4 - (barWidth * scaleX)
    local y = screenH - (barHeight * scaleY) - 2

    local rank = RANKS[get_current_rank_index()]
    local range = rank.max - rank.min

    local progress = 0
    if range > 0 then
        progress = clampf(
            math.floor((rankPoints - rank.min) / range * barWidth),
            0,
            barWidth
        )
    end

    -- Fondo
    djui_hud_render_texture_tile(
        TEX_XP_BAR,
        x, y,
        scaleX, scaleY,
        0, 0,
        barWidth, barHeight
    )

    -- Progreso
    if progress > 0 then
        djui_hud_render_texture_tile(
            TEX_XP_BAR,
            x, y,
            scaleX, scaleY,
            0, 8,
            progress, barHeight
        )
    end

    -- Sonido cuando aumenta
    if lastBarValue and progress > lastBarValue then
        if random(1,2) == 1 then
            local_play(sOrb1, gMarioStates[0].pos, 0.25)
        else
            local_play(sOrb2, gMarioStates[0].pos, 0.25)
        end
    end

    lastBarValue = progress
end

local function draw_shadow_text(text, x, y)
    djui_hud_set_color(0,0,0,255)
    djui_hud_print_text(text, x+2, y+2, 1)

    djui_hud_set_color(255,255,255,255)
    djui_hud_print_text(text, x, y, 1)
end

local function render_rank_name()
    if not xpEnabled then return end

    local name = RANKS[get_current_rank_index()].name
    draw_shadow_text(
        name,
        djui_hud_get_screen_width() * 0.5 - djui_hud_measure_text(name) * 0.5,
        djui_hud_get_screen_height() - 92
    )
end

-- =========================
-- COMMAND
-- =========================

local function xp_command(msg)
    if msg == "on" then
        xpEnabled = true
        mod_storage_save_number("xp_enabled", 1)
        djui_chat_message_create("XP Bar activada.")
        return true
    elseif msg == "off" then
        xpEnabled = false
        mod_storage_save_number("xp_enabled", 0)
        djui_chat_message_create("XP Bar desactivada.")
        return true
    else
        djui_chat_message_create("Uso: /xp on  |  /xp off")
        return true
    end
end

hook_chat_command("xp", "[on|off] Activa o desactiva la barra de XP", xp_command)

-- =========================
-- HOOKS
-- =========================

hook_event(HOOK_MARIO_UPDATE, mario_update)

hook_event(HOOK_ON_HUD_RENDER_BEHIND, function()
    if not xpEnabled then return end
    if isPaused then return end
    if djui_is_playerlist_open() then return end

    djui_hud_set_resolution(RESOLUTION_DJUI)
    djui_hud_set_font(FONT_SPECIAL)

    render_xp_bar()
    render_rank_name()
end)