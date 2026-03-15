if unsupported then return end

-- Fallback: rgb_to_hex fail
if not rgb_to_hex then
    rgb_to_hex = function(r, g, b)
        return string.format("%02X%02X%02X", r or 0, g or 0, b or 0)
    end
end

-- Fallback: get_selected_theme with an random fail xd
if not get_selected_theme then
    get_selected_theme = function()
        return {
            name                 = "Default",
            builtin              = true,
            primaryColor         = 0x4A90D9FF,
            secondaryColor       = 0x1A3A5CFF,
            textColor            = 0xFFFFFFFF,
            highlightColor       = 0xFFD700FF,
            pauseBackground      = { r = 0,   g = 0,   b = 0,   a = 180 },
            background           = { r = 20,  g = 20,  b = 40,  a = 220 },
            backgroundOutline    = { r = 74,  g = 144, b = 217, a = 255 },
            border               = { r = 74,  g = 144, b = 217, a = 255 },
            text                 = { r = 255, g = 255, b = 255, a = 255 },
            selectedText         = { r = 255, g = 215, b = 0,   a = 255 },
            disabledText         = { r = 120, g = 120, b = 120, a = 255 },
            highlight            = { r = 255, g = 215, b = 0,   a = 255 },
            rect                 = { r = 30,  g = 30,  b = 60,  a = 200 },
            rectOutline          = { r = 74,  g = 144, b = 217, a = 255 },
            hoverRect            = { r = 74,  g = 144, b = 217, a = 230 },
            hoverRectOutline     = { r = 150, g = 200, b = 255, a = 255 },
            leaderboard          = { r = 10,  g = 10,  b = 30,  a = 210 },
            leaderboardOutline   = { r = 74,  g = 144, b = 217, a = 255 },
            minimap              = { r = 10,  g = 10,  b = 30,  a = 210 },
            minimapOutline       = { r = 74,  g = 144, b = 217, a = 255 },
            welcomeMessage       = { r = 10,  g = 10,  b = 30,  a = 210 },
            welcomeMessageOutline= { r = 74,  g = 144, b = 217, a = 255 },
        }
    end
end

-- Fallback: gGlobalSyncTable fields
if gGlobalSyncTable then
    if gGlobalSyncTable.damage        == nil then gGlobalSyncTable.damage        = 1     end
    if gGlobalSyncTable.roundStyle    == nil then gGlobalSyncTable.roundStyle    = 0     end
    if gGlobalSyncTable.roundState    == nil then gGlobalSyncTable.roundState    = 0     end
    if gGlobalSyncTable.gamemode      == nil then gGlobalSyncTable.gamemode      = 1     end
    if gGlobalSyncTable.speedMultiplier == nil then gGlobalSyncTable.speedMultiplier = 1 end
    if gGlobalSyncTable.autoMode      == nil then gGlobalSyncTable.autoMode      = false end
    if gGlobalSyncTable.playerInteractions == nil then gGlobalSyncTable.playerInteractions = false end
    if gGlobalSyncTable.floodGravity  == nil then gGlobalSyncTable.floodGravity  = false end
    if gGlobalSyncTable.floodInteractions == nil then gGlobalSyncTable.floodInteractions = false end
    if gGlobalSyncTable.lobbyPowerups == nil then gGlobalSyncTable.lobbyPowerups = false end
    if gGlobalSyncTable.lobbyPlayerInteractions == nil then gGlobalSyncTable.lobbyPlayerInteractions = false end
    if gGlobalSyncTable.lobbyBosses   == nil then gGlobalSyncTable.lobbyBosses   = false end
    if gGlobalSyncTable.nametags      == nil then gGlobalSyncTable.nametags      = true  end
    if gGlobalSyncTable.popups        == nil then gGlobalSyncTable.popups        = true  end
    if gGlobalSyncTable.respawn       == nil then gGlobalSyncTable.respawn       = true  end
    if gGlobalSyncTable.quicksand     == nil then gGlobalSyncTable.quicksand     = false end
    if gGlobalSyncTable.slopejumps    == nil then gGlobalSyncTable.slopejumps    = false end
    if gGlobalSyncTable.roundFadeout  == nil then gGlobalSyncTable.roundFadeout  = false end
    if gGlobalSyncTable.killInactive  == nil then gGlobalSyncTable.killInactive  = false end
    if gGlobalSyncTable.autodoors     == nil then gGlobalSyncTable.autodoors     = false end
    if gGlobalSyncTable.coinCount     == nil then gGlobalSyncTable.coinCount     = 0     end
    if gGlobalSyncTable.modif         == nil then gGlobalSyncTable.modif         = {}    end
    if gGlobalSyncTable.totalRoundRestarts == nil then gGlobalSyncTable.totalRoundRestarts = 0 end
    if gGlobalSyncTable.level         == nil then gGlobalSyncTable.level         = 1     end
end

-- Fallback: varef fixed by tuiBRyt64 xd
if not varef then
    varef = function(t, key)
        return t, key
    end
end

-- Fallback: booltggle but good
if not booltggle then
    booltggle = function(t, key)
        if type(t) == "table" and key then
            t[key] = not t[key]
        end
    end
end

-- Fallback: create_popup fixed with fallback aaaa
if not create_popup then
    create_popup = function(msg)
        -- sem implementacao, apenas evita o crash
    end
end

-- Fallback: selectedTheme and floodThemes
if not floodThemes then
    floodThemes = { get_selected_theme() }
end
if selectedTheme == nil then
    selectedTheme = 1
end
if not builtinThemes then
    builtinThemes = #floodThemes
end

-- Fallback: gModifiers
if not gModifiers then
    gModifiers = {}
end

-- Fallback: table.contains and table.poselement
if not table.contains then
    table.contains = function(t, value)
        for _, v in ipairs(t) do
            if v == value then return true end
        end
        return false
    end
end
if not table.poselement then
    table.poselement = function(t, value)
        for i, v in ipairs(t) do
            if v == value then return i end
        end
        return nil
    end
end
if not table.copy then
    table.copy = function(t)
        local copy = {}
        for k, v in pairs(t) do
            copy[k] = v
        end
        return copy
    end
end

-- idk
local function safe_varef(t, key)
    if varef then return varef(t, key) end
    return t, key
end
local function safe_booltggle(t, key)
    if booltggle then
        booltggle(t, key)
    elseif type(t) == "table" and key then
        t[key] = not t[key]
    end
end
local function safe_create_popup(msg)
    if create_popup then create_popup(msg) end
end

-- Fallback: modifiers ts gonna be fire
if not modifiers then
    modifiers = {}
end

-- Fallback: gamemodes
if not gamemodes then
    gamemodes = {
        { name = "Normal" },
        { name = "Hard Mode" },
        { name = "Red / Green Light" },
        { name = "Flood Royale" },
    }
end

-- Fallback: eFloodVariables
if not eFloodVariables then
    eFloodVariables = {
        customMusic    = false,
        spectatorMode  = 0,
        welcomeMessage = false,
        scrollTexture  = false,
        holidayEvents  = false,
    }
end

-- Fallback: constantes de estado da rodada (brasil papa)
if ROUND_STATE_ACTIVE  == nil then ROUND_STATE_ACTIVE  = 1 end
if ROUND_STATE_VOTING  == nil then ROUND_STATE_VOTING  = 0 end

-- Fallback: spectator
if SPECTATOR_MODE_NORMAL == nil then SPECTATOR_MODE_NORMAL = 0 end
if SPECTATOR_MODE_FOLLOW == nil then SPECTATOR_MODE_FOLLOW = 1 end
if SPECTATOR_MODE_GHOST  == nil then SPECTATOR_MODE_GHOST  = 2 end

-- Fallback: fonts
if FONT_MENU        == nil then FONT_MENU        = 0 end
if FONT_HUD         == nil then FONT_HUD         = 1 end
if FONT_ALIASED     == nil then FONT_ALIASED     = 2 end
if FONT_NORMAL      == nil then FONT_NORMAL      = 3 end
if FONT_TINY        == nil then FONT_TINY        = 4 end
if FONT_SPECIAL     == nil then FONT_SPECIAL     = 5 end
if FONT_RECOLOR_HUD == nil then FONT_RECOLOR_HUD = 6 end
if FONT_CUSTOM_HUD  == nil then FONT_CUSTOM_HUD  = 7 end

-- Fallback: FLOOD_LEVEL_COUNT
if FLOOD_LEVEL_COUNT == nil then FLOOD_LEVEL_COUNT = 0 end

-- Fallback: A
if gGlobalSyncTable then
    local modif_fields = {
        "modif_powerups","modif_instakill","modif_deathcoin","modif_winboost",
        "modif_speed","modif_bbc","modif_zbc","modif_coinrush","modif_tripping",
        "modif_lowgravity","modif_highgravity","modif_flashflood","modif_blj",
        "modif_capless","modif_fly","modif_slippery","modif_hard","modif_fog",
        "modif_inverted","modif_tornadoes","modif_firsties","modif_stj",
        "modif_earthquake","modif_megaform","modif_miniform","modif_random",
    }
    for _, f in ipairs(modif_fields) do
        if gGlobalSyncTable[f] == nil then gGlobalSyncTable[f] = false end
    end
end

-- another Fallback
if eHudVariables == nil then
    eHudVariables = {
        modifiersDisplay      = true,
        timerDisplay          = true,
        leaderboard           = true,
        healthMeter           = true,
        coinCounter           = true,
        minimap               = true,
        outlines              = true,
        flagRadar             = true,
        tips                  = true,
        musicDisplay          = true,
        typeDisplay           = true,
        currentLevelIndicator = true,
        nextLevelIndicator    = true,
        gamemodeText          = true,
        dialogs               = true,
        font                  = 0,
        levelScale            = 0.20,
        modifierScale         = 0.15,
    }
end

-- Fallback
if not name_of_level then
    name_of_level = function(level, area, name, entry)
        if name and name ~= "" then
            return name
        end
        return "Level " .. tostring(level) .. "-" .. tostring(area)
    end
end

-- Fallback: INTERMISSION_DOWNTIME failed
if INTERMISSION_DOWNTIME == nil then
    INTERMISSION_DOWNTIME = 10 * 30 -- idk
end

showSettings = false

-- settings, width and height
local bgWidth = 1000
local bgHeight = djui_hud_get_screen_height() - 200
local selection = 1
local scrollOffset = 0
local scrollEntry = 12

-- inputs
INPUT_A = 0
INPUT_JOYSTICK = 1

-- cursor
local TEX_HAND_OPEN = get_texture_info("hand_open")
local TEX_HAND_CLOSED = get_texture_info("hand_closed")

local moved_cursor = false
local selectionLockedToMouse = true
local offset = 0
local cursorScale = 2
local prev_mouse_x, prev_mouse_y = 0, 0
local mouse_x, mouse_y = 0, 0
local prev_raw_x, prev_raw_y = 0, 0

-- permissions
PERMISSION_NONE = 0
PERMISSION_SERVER = 1
PERMISSION_MODERATORS = 2

local function on_off_text(bool)
    if bool then return "On" else return "Off" end
end

local function has_permission(perm)
    if perm == PERMISSION_NONE then return true end
    if perm == PERMISSION_SERVER and network_is_server() then return true end
    if perm == PERMISSION_MODERATORS and (network_is_server() or network_is_moderator()) then return true end

    return false
end

local function get_controller_dir()
    -- get which direction we are facing
    local m = gMarioStates[0]
    local direction = CONT_LEFT

    if m.controller.buttonPressed & R_JPAD ~= 0
    or m.controller.stickX > 0.5 then direction = CONT_RIGHT end

    return direction
end

joystickCooldown = 0
local category = nil
local previousRgbValue = nil
local rgbValue = nil
local rgbAlphaEnabled = false
local oldTheme = nil

-- entries
local mainEntries = {}
local startEntries = {}
local gamemodeEntries = {}
local modifierEntries = {}
local settingEntries = {}
local gameEntries = {}
local generalEntries = {}
local themeEntries = {}
local themeManagerEntries = {}
local themeBuilderEntries = {}
local rgbSliderEntries = {}
local hudEntries = {}
local enemyEntries = {}

local manualEntries = {}
local creditEntries = {}
local gamemodeManualEntries = {}
local modifierManualEntries = {}
local commandEntries = {}
local devManualEntries = {}
local entries = mainEntries
local prevEntries = {}



local function toggle_powerups()
    local toggle = not gGlobalSyncTable.modif_powerups
    gGlobalSyncTable.modif_powerups = toggle
    mod_storage_save_bool("Power-Ups", toggle)
    if toggle then
        if not table.contains(modifiers, "Power-Ups") then
            table.insert(modifiers, "Power-Ups")
        end
    else
        local pos = table.poselement(modifiers, "Power-Ups")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_instakill()
    local toggle = not gGlobalSyncTable.modif_instakill
    gGlobalSyncTable.modif_instakill = toggle
    mod_storage_save_bool("Instakill", toggle)
    if toggle then
        if not table.contains(modifiers, "Instakill") then
            table.insert(modifiers, "Instakill")
        end
    else
        local pos = table.poselement(modifiers, "Instakill")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_deathcoin()
    local toggle = not gGlobalSyncTable.modif_deathcoin
    gGlobalSyncTable.modif_deathcoin = toggle
    mod_storage_save_bool("Deathcoin", toggle)
    if toggle then
        if not table.contains(modifiers, "Deathcoin") then
            table.insert(modifiers, "Deathcoin")
        end
    else
        local pos = table.poselement(modifiers, "Deathcoin")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_winboost()
    local toggle = not gGlobalSyncTable.modif_winboost
    gGlobalSyncTable.modif_winboost = toggle
    mod_storage_save_bool("Winboost", toggle)
    if toggle then
        if not table.contains(modifiers, "Winboost") then
            table.insert(modifiers, "Winboost")
        end
    else
        local pos = table.poselement(modifiers, "Winboost")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_speed()
    local toggle = not gGlobalSyncTable.modif_speed
    gGlobalSyncTable.modif_speed = toggle
    mod_storage_save_bool("Speed", toggle)
    if toggle then
        if not table.contains(modifiers, "Speed") then
            table.insert(modifiers, "Speed")
        end
    else
        local pos = table.poselement(modifiers, "Speed")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_bbc()
    local toggle = not gGlobalSyncTable.modif_bbc
    gGlobalSyncTable.modif_bbc = toggle
    mod_storage_save_bool("BBC", toggle)
    if toggle then
        if not table.contains(modifiers, "B Button Challenge") then
            table.insert(modifiers, "B Button Challenge")
        end
    else
        local pos = table.poselement(modifiers, "B Button Challenge")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_zbc()
    local toggle = not gGlobalSyncTable.modif_zbc
    gGlobalSyncTable.modif_zbc = toggle
    mod_storage_save_bool("ZBC", toggle)
    if toggle then
        if not table.contains(modifiers, "Z Button Challenge") then
            table.insert(modifiers, "Z Button Challenge")
        end
    else
        local pos = table.poselement(modifiers, "Z Button Challenge")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_coinrush()
    local toggle = not gGlobalSyncTable.modif_coinrush
    gGlobalSyncTable.modif_coinrush = toggle
    mod_storage_save_bool("Coinrush", toggle)
    if toggle then
        if not table.contains(modifiers, "Coin Rush") then
            table.insert(modifiers, "Coin Rush")
        end
    else
        local pos = table.poselement(modifiers, "Coin Rush")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_tripping()
    local toggle = not gGlobalSyncTable.modif_tripping
    gGlobalSyncTable.modif_tripping = toggle
    mod_storage_save_bool("Tripping", toggle)
    if toggle then
        if not table.contains(modifiers, "Tripping") then
            table.insert(modifiers, "Tripping")
        end
    else
        local pos = table.poselement(modifiers, "Tripping")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_lowgravity()
    local toggle = not gGlobalSyncTable.modif_lowgravity
    gGlobalSyncTable.modif_lowgravity = toggle
    mod_storage_save_bool("Lowgravity", toggle)
    if toggle then
        if not table.contains(modifiers, "Lowgravity") then
            table.insert(modifiers, "Lowgravity")
        end
    else
        local pos = table.poselement(modifiers, "Lowgravity")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_highgravity()
    local toggle = not gGlobalSyncTable.modif_highgravity
    gGlobalSyncTable.modif_highgravity = toggle
    mod_storage_save_bool("Highgravity", toggle)
    if toggle then
        if not table.contains(modifiers, "Highgravity") then
            table.insert(modifiers, "Highgravity")
        end
    else
        local pos = table.poselement(modifiers, "Highgravity")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_flashflood()
    local toggle = not gGlobalSyncTable.modif_flashflood
    gGlobalSyncTable.modif_flashflood = toggle
    mod_storage_save_bool("FlashFlood", toggle)
    if toggle then
        if not table.contains(modifiers, "FlashFlood") then
            table.insert(modifiers, "FlashFlood")
        end
    else
        local pos = table.poselement(modifiers, "FlashFlood")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_blj()
    local toggle = not gGlobalSyncTable.modif_blj
    gGlobalSyncTable.modif_blj = toggle
    mod_storage_save_bool("BLJ", toggle)
    if toggle then
        if not table.contains(modifiers, "BLJ") then
            table.insert(modifiers, "BLJ")
        end
    else
        local pos = table.poselement(modifiers, "BLJ")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_capless()
    local toggle = not gGlobalSyncTable.modif_capless
    gGlobalSyncTable.modif_capless = toggle
    mod_storage_save_bool("Capless", toggle)
    if toggle then
        if not table.contains(modifiers, "Capless") then
            table.insert(modifiers, "Capless")
        end
    else
        local pos = table.poselement(modifiers, "Capless")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_fly()
    local toggle = not gGlobalSyncTable.modif_fly
    gGlobalSyncTable.modif_fly = toggle
    mod_storage_save_bool("Fly", toggle)
    if toggle then
        if not table.contains(modifiers, "Fly") then
            table.insert(modifiers, "Fly")
        end
    else
        local pos = table.poselement(modifiers, "Fly")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_slippery_floors()
    local toggle = not gGlobalSyncTable.modif_slippery
    gGlobalSyncTable.modif_slippery = toggle
    mod_storage_save_bool("Slippery", toggle)
    if toggle then
        if not table.contains(modifiers, "Slippery Floors") then
            table.insert(modifiers, "Slippery Floors")
        end
    else
        local pos = table.poselement(modifiers, "Slippery Floors")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_hard_floors()
    local toggle = not gGlobalSyncTable.modif_hard
    gGlobalSyncTable.modif_hard = toggle
    mod_storage_save_bool("Hard", toggle)
    if toggle then
        if not table.contains(modifiers, "Hard Floors") then
            table.insert(modifiers, "Hard Floors")
        end
    else
        local pos = table.poselement(modifiers, "Hard Floors")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_fog()
    local toggle = not gGlobalSyncTable.modif_fog
    gGlobalSyncTable.modif_fog = toggle
    mod_storage_save_bool("Fog", toggle)
    if toggle then
        if not table.contains(modifiers, "Fog") then
            table.insert(modifiers, "Fog")
        end
    else
        local pos = table.poselement(modifiers, "Fog")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_inverted()
    local toggle = not gGlobalSyncTable.modif_inverted
    gGlobalSyncTable.modif_inverted = toggle
    mod_storage_save_bool("Inverted", toggle)
    if toggle then
        if not table.contains(modifiers, "Inverted") then
            table.insert(modifiers, "Inverted")
        end
    else
        local pos = table.poselement(modifiers, "Inverted")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_tornadoes()
    local toggle = not gGlobalSyncTable.modif_tornadoes
    gGlobalSyncTable.modif_tornadoes = toggle
    mod_storage_save_bool("Tornadoes", toggle)
    if toggle then
        if not table.contains(modifiers, "Tornadoes") then
            table.insert(modifiers, "Tornadoes")
        end
    else
        local pos = table.poselement(modifiers, "Tornadoes")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_firsties()
    local toggle = not gGlobalSyncTable.modif_firsties
    gGlobalSyncTable.modif_firsties = toggle
    mod_storage_save_bool("Firsties", toggle)
    if toggle then
        if not table.contains(modifiers, "Firsties") then
            table.insert(modifiers, "Firsties")
        end
    else
        local pos = table.poselement(modifiers, "Firsties")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_stj()
    local toggle = not gGlobalSyncTable.modif_stj
    gGlobalSyncTable.modif_stj = toggle
    mod_storage_save_bool("STJ", toggle)
    if toggle then
        if not table.contains(modifiers, "Special Triple Jump") then
            table.insert(modifiers, "Special Triple Jump")
        end
    else
        local pos = table.poselement(modifiers, "Special Triple Jump")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_earthquake()
    local toggle = not gGlobalSyncTable.modif_earthquake
    gGlobalSyncTable.modif_earthquake = toggle
    mod_storage_save_bool("Earthquake", toggle)
    if toggle then
        if not table.contains(modifiers, "Earthquake") then
            table.insert(modifiers, "Earthquake")
        end
    else
        local pos = table.poselement(modifiers, "Earthquake")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_megaform()
    local toggle = not gGlobalSyncTable.modif_megaform
    gGlobalSyncTable.modif_megaform = toggle
    mod_storage_save_bool("Mega Form", toggle)
    if toggle then
        if not table.contains(modifiers, "Mega Form") then
            table.insert(modifiers, "Mega Form")
        end
    else
        local pos = table.poselement(modifiers, "Mega Form")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_miniform()
    local toggle = not gGlobalSyncTable.modif_miniform
    gGlobalSyncTable.modif_miniform = toggle
    mod_storage_save_bool("Mini Form", toggle)
    if toggle then
        if not table.contains(modifiers, "Mini Form") then
            table.insert(modifiers, "Mini Form")
        end
    else
        local pos = table.poselement(modifiers, "Mini Form")
        if pos then
            table.remove(modifiers, pos)
        end
    end
end

local function toggle_random()
    local toggle = not gGlobalSyncTable.modif_random
    gGlobalSyncTable.modif_random = toggle
    mod_storage_save_bool("Random", toggle)
end

local function set_coincount()

    -- get which direction we are facing
    local m = gMarioStates[0]
    local direction = get_controller_dir()

    -- get speed
    local speed = 1

    if m.controller.buttonPressed & R_JPAD ~= 0
    or m.controller.buttonPressed & L_JPAD ~= 0 then
        speed = 4
    end

    if direction == CONT_LEFT then
        gGlobalSyncTable.coinCount = gGlobalSyncTable.coinCount - speed

        if gGlobalSyncTable.coinCount <= 0 then
            gGlobalSyncTable.coinCount = 0
        end
    else
        gGlobalSyncTable.coinCount = gGlobalSyncTable.coinCount + speed
    end
end

local function set_flood_speed()

    -- get which direction we are facing
    local m = gMarioStates[0]
    local direction = get_controller_dir()

    -- get speed
    local speed = 1 * 2

    if m.controller.buttonPressed & R_JPAD ~= 0
    or m.controller.buttonPressed & L_JPAD ~= 0 then
        speed = 1
    end

    gGlobalSyncTable.speedMultiplier = clampf(gGlobalSyncTable.speedMultiplier, 0, 99)

    if direction == CONT_LEFT then
        gGlobalSyncTable.speedMultiplier = gGlobalSyncTable.speedMultiplier - speed

        if gGlobalSyncTable.speedMultiplier <= 0 then
            gGlobalSyncTable.speedMultiplier = 0
        end
    else
        gGlobalSyncTable.speedMultiplier = gGlobalSyncTable.speedMultiplier + speed
    end
end

local function set_round_style()
    local direction = get_controller_dir()

    if direction == CONT_LEFT then
        gGlobalSyncTable.roundStyle = (gGlobalSyncTable.roundStyle - 1) % 3
    else
        gGlobalSyncTable.roundStyle = (gGlobalSyncTable.roundStyle + 1) % 3
    end

    mod_storage_save_number("roundStyle", gGlobalSyncTable.roundStyle)
end

local function set_spectator_mode()
    local direction = get_controller_dir()

    local minMode = SPECTATOR_MODE_NORMAL
    local maxMode = SPECTATOR_MODE_GHOST
    local count   = maxMode - minMode + 1
    local mode = eFloodVariables.spectatorMode - minMode

    if direction == CONT_LEFT then
        mode = (mode - 1) % count
    else
        mode = (mode + 1) % count
    end

    eFloodVariables.spectatorMode = mode + minMode
    mod_storage_save_number("spectatorMode", eFloodVariables.spectatorMode)
end

local function set_intermission_downtime()
    local m = gMarioStates[0]
    local direction = get_controller_dir()

    local speed = 30 * 2

    if m.controller.buttonPressed & R_JPAD ~= 0 or m.controller.buttonPressed & L_JPAD ~= 0 then
        speed = 30
    end

    if direction == CONT_LEFT then
        INTERMISSION_DOWNTIME = INTERMISSION_DOWNTIME - speed

        if INTERMISSION_DOWNTIME < 0 then
            INTERMISSION_DOWNTIME = 0
        end
    else
        INTERMISSION_DOWNTIME = INTERMISSION_DOWNTIME + speed

        if INTERMISSION_DOWNTIME > (32 * 30) then
            INTERMISSION_DOWNTIME = 32 * 30
        end
    end
end

local function set_flood_damage()
    -- get which direction we are facing
    local m = gMarioStates[0]
    local direction = get_controller_dir()

    -- get speed
    local speed = 1 * 2

    if m.controller.buttonPressed & R_JPAD ~= 0 or m.controller.buttonPressed & L_JPAD ~= 0 then
        speed = 1
    end

    if direction == CONT_LEFT then
        gGlobalSyncTable.damage = gGlobalSyncTable.damage - speed

        if gGlobalSyncTable.damage <= 0 then
            gGlobalSyncTable.damage = 0
        end
    else
        gGlobalSyncTable.damage = gGlobalSyncTable.damage + speed
    end
end

local function set_theme()
    local direction = get_controller_dir()

    if direction == CONT_LEFT then
        selectedTheme = selectedTheme - 1
        if floodThemes[selectedTheme] == nil then
            selectedTheme = #floodThemes
        end
    else
        selectedTheme = selectedTheme + 1
        if floodThemes[selectedTheme] == nil then
            selectedTheme = 1
        end
    end

    mod_storage_save_number("theme", selectedTheme)
end

local function set_color_value(c)
    local m = gMarioStates[0]
    local direction = get_controller_dir()
    local speed = 1

    if m.controller.buttonPressed & R_JPAD ~= 0
    or m.controller.buttonPressed & L_JPAD ~= 0 then
        speed = 10
    end

    if direction == CONT_LEFT then
        c = c - speed
        if c < 0 then c = 255 end
    else
        c = c + speed
        if c > 255 then c = 0 end
    end

    return c
end

local function create_rgb_slider(rgb, alphaEnabled)
    if alphaEnabled == nil then alphaEnabled = false end
    entries = rgbSliderEntries
    selection = 1
    rgbAlphaEnabled = alphaEnabled
    rgbValue = rgb
    previousRgbValue = table.copy(rgbValue)
end

local function reset_modifier_settings()
    local all_mods = {
        {"modif_powerups", "Power-Ups"},
        {"modif_instakill", "Instakill"},
        {"modif_deathcoin", "Deathcoin"},
        {"modif_winboost", "Winboost"},
        {"modif_speed", "Speed"},
        {"modif_bbc", "BBC"},
        {"modif_zbc", "ZBC"},
        {"modif_coinrush", "Coinrush"},
        {"modif_tripping", "Tripping"},
        {"modif_lowgravity", "Lowgravity"},
        {"modif_highgravity", "Highgravity"},
        {"modif_flashflood", "FlashFlood"},
        {"modif_blj", "BLJ"},
        {"modif_capless", "Capless"},
        {"modif_fly", "Fly"},
        {"modif_slippery", "Slippery"},
        {"modif_hard", "Hard"},
        {"modif_fog", "Fog"},
        {"modif_inverted", "Inverted"},
        {"modif_tornadoes", "Tornadoes"},
        {"modif_firsties", "Firsties"},
        {"modif_stj", "STJ"},
        {"modif_earthquake", "Earthquake"},
        {"modif_megaform", "Mega Form"},
        {"modif_miniform", "Mini Form"},
        {"modif_random", "Random"},
    }

    for _, mod in ipairs(all_mods) do
        local field, key = mod[1], mod[2]
        gGlobalSyncTable[field] = false
        mod_storage_save_bool(key, false)
    end

    modifiers = {}
    gGlobalSyncTable.coinCount = 4
end

local function reset_general_settings()
    if network_is_server()
    or network_is_moderator() then
        eFloodVariables.customMusic = true
        mod_storage_save_bool("customMusic", eFloodVariables.customMusic)
        eFloodVariables.spectatorMode = SPECTATOR_MODE_NORMAL
        mod_storage_save_number("spectatorMode", eFloodVariables.spectatorMode)
        if network_is_server() then
            gGlobalSyncTable.popups = true
            mod_storage_save_bool("popups", gGlobalSyncTable.popups)
        end
        welcomeMessage = false
        mod_storage_save_bool("welcomeMessage", welcomeMessage)
        eFloodVariables.scrollingFloodTexture = true
        mod_storage_save_bool("scrollingFloodTexture", eFloodVariables.scrollingFloodTexture)
        gGlobalSyncTable.nametags = true
        mod_storage_save_bool("nametags", gGlobalSyncTable.nametags)
    end
end

local function reset_hud_settings()
    local all_bools = {
        "modifiersDisplay",
        "timerDisplay",
        "leaderboard",
        "healthMeter",
        "coinCounter",
        "minimap",
        "outlines",
        "flagRadar",
        "tips",
        "musicDisplay",
        "typeDisplay",
        "nextLevelIndicator",
        "currentLevelIndicator",
        "gamemodeText"
    }

    for _, key in ipairs(all_bools) do
        boolst(varef(eHudVariables, key), key, true)
    end

    -- since f+ has always been with no dialogs, ill keep it false as default for compatibility reasons
    local all_bools_false = { "dialogs" }
    for _, key in ipairs(all_bools_false) do
        boolst(varef(eHudVariables, key), key, false)
    end

    eHudVariables.font = FONT_MENU
    eHudVariables.levelScale = 0.20
    eHudVariables.modifierScale = 0.15
    mod_storage_save_number("font", eHudVariables.font)
    mod_storage_save_number("levelScale", eHudVariables.levelScale)
    mod_storage_save_number("modifierScale", eHudVariables.modifierScale)
end

local function disable_hud_settings()
    local all_bools = {
        "modifiersDisplay",
        "timerDisplay",
        "leaderboard",
        "healthMeter",
        "coinCounter",
        "minimap",
        "outlines",
        "flagRadar",
        "tips",
        "musicDisplay",
        "typeDisplay",
        "nextLevelIndicator",
        "currentLevelIndicator",
        "gamemodeText",
        "dialogs"
    }

    for _, key in ipairs(all_bools) do
        boolst(varef(eHudVariables, key), key, false)
    end
end

local function reset_main_entries()
    local resetEntries = entries == mainEntries

    mainEntries = {
        {
            name = "Start",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = startEntries
                selection = 1
            end
        },
        {
            name = "Settings",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = settingEntries
                selection = 1
            end
        },
        {
            name = "Gamemodes",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = gamemodeEntries
                selection = 1
            end
        },
        {
            name = "Modifiers",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = modifierEntries
                selection = 1
            end
        },

        {
            name = "Manual",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = manualEntries
                selection = 1
            end
        },
        {
            name = "Credits",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = creditEntries
                selection = 1
            end
        },
        {
            name = "Close",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                showSettings = not showSettings
                fade_volume_scale(0, 127, 1)
            end,
        },
    }

    if resetEntries then entries = mainEntries end
end

local function reset_modifier_entries()
    local resetModifierEntries = entries == modifierEntries

    modifierEntries = {
        {
            separator = "Modifiers",
            name = "Power-Ups",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_powerups,
            valueText = on_off_text(gGlobalSyncTable.modif_powerups),
        },
        {
            name = "Instakill",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_instakill,
            valueText = on_off_text(gGlobalSyncTable.modif_instakill),
        },
        {
            name = "Deathcoin",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_deathcoin,
            valueText = on_off_text(gGlobalSyncTable.modif_deathcoin),
        },
        {
            name = "Winboost",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_winboost,
            valueText = on_off_text(gGlobalSyncTable.modif_winboost),
        },
        {
            name = "Speed",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_speed,
            valueText = on_off_text(gGlobalSyncTable.modif_speed),
        },
        {
            name = "B Button Challenge",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_bbc,
            valueText = on_off_text(gGlobalSyncTable.modif_bbc),
        },
        {
            name = "Z Button Challenge",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_zbc,
            valueText = on_off_text(gGlobalSyncTable.modif_zbc),
        },
        {
            name = "Coin Rush",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_coinrush,
            valueText = on_off_text(gGlobalSyncTable.modif_coinrush),
        },
        {
            name = "Tripping",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_tripping,
            valueText = on_off_text(gGlobalSyncTable.modif_tripping),
        },
        {
            name = "Low Gravity",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_lowgravity,
            valueText = on_off_text(gGlobalSyncTable.modif_lowgravity),
        },
        {
            name = "High Gravity",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_highgravity,
            valueText = on_off_text(gGlobalSyncTable.modif_highgravity),
        },
        {
            name = "Flash Flood",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_flashflood,
            valueText = on_off_text(gGlobalSyncTable.modif_flashflood),
        },
        {
            name = "BLJ",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_blj,
            valueText = on_off_text(gGlobalSyncTable.modif_blj),
        },
        {
            name = "Capless",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_capless,
            valueText = on_off_text(gGlobalSyncTable.modif_capless),
        },
        {
            name = "Fly",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_fly,
            valueText = on_off_text(gGlobalSyncTable.modif_fly),
        },
        {
            name = "Slippery Floors",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_slippery_floors,
            valueText = on_off_text(gGlobalSyncTable.modif_slippery),
        },
        {
            name = "Hard Floors",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_hard_floors,
            valueText = on_off_text(gGlobalSyncTable.modif_hard),
        },
        {
            name = "Fog",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_fog,
            valueText = on_off_text(gGlobalSyncTable.modif_fog),
        },
        {
            name = "Inverted Controls",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_inverted,
            valueText = on_off_text(gGlobalSyncTable.modif_inverted),
        },
        {
            name = "Tornadoes",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_tornadoes,
            valueText = on_off_text(gGlobalSyncTable.modif_tornadoes),
        },
        {
            name = "Firsties",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_firsties,
            valueText = on_off_text(gGlobalSyncTable.modif_firsties),
        },
        {
            name = "Special Triple Jump",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_stj,
            valueText = on_off_text(gGlobalSyncTable.modif_stj),
        },
        {
            name = "Earthquake",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_earthquake,
            valueText = on_off_text(gGlobalSyncTable.modif_earthquake),
        },
        {
            name = "Mega Form",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_megaform,
            valueText = on_off_text(gGlobalSyncTable.modif_megaform),
        },
        {
            name = "Mini Form",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = toggle_miniform,
            valueText = on_off_text(gGlobalSyncTable.modif_miniform),
        },
        {
            separator = "Modifier Configurations",
            name = "Power-Up Coincount",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = set_coincount,
            valueText = math.floor(gGlobalSyncTable.coinCount),
        },
        {
            name = "Reset Modifier Settings",
            permission = PERMISSION_MODERATORS,
            input = INPUT_A,
            func = reset_modifier_settings,
        },
        {
            name = "Back",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = mainEntries
                selection = 1
            end,
        },
    }

    if resetModifierEntries then
        entries = modifierEntries
    end
end

local function reset_start_entries()
    local resetEntries = entries == startEntries

    startEntries = {
        {
            name = "Random",
            permission = PERMISSION_SERVER,
            input = INPUT_A,
            func = function ()
                gGlobalSyncTable.level = math.random(#gLevels)
                if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
                    network_send(true, { restart = true })
                    gGlobalSyncTable.level = math.random(#gLevels)
                    level_restart()
                    gGlobalSyncTable.totalRoundRestarts = 0
                else
                    gGlobalSyncTable.level = math.random(#gLevels)
                    round_start()
                    gGlobalSyncTable.totalRoundRestarts = 0
                end
                showSettings = false
                fade_volume_scale(0, 127, 1)
            end
        },
        {
            name = "Trigger Voting",
            permission = PERMISSION_SERVER,
            input = INPUT_A,
            func = function()
                timer = 11 * 30
                gGlobalSyncTable.roundState = ROUND_STATE_VOTING
                showSettings = false
                fade_volume_scale(0, 127, 1)
            end
        }
    }

    local counter = 1

    for k in pairs(gLevels) do
        table.insert(startEntries, {
            name = counter .. ". " .. name_of_level(gLevels[k].level, gLevels[k].area, gLevels[k].name, gLevels[k]),
            permission = PERMISSION_SERVER,
            input = INPUT_A,
            func = function ()
                gGlobalSyncTable.level = k
                if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
                    network_send(true, { restart = true })
                    level_restart()
                    gGlobalSyncTable.totalRoundRestarts = 0
                else
                    round_start()
                    gGlobalSyncTable.totalRoundRestarts = 0
                end
                showSettings = false
            end,
            separator = gLevels[k].separator ~= nil and gLevels[k].separator or nil
        })

        if k == 1 then
            if gLevels[k].separator ~= nil then
                startEntries[#startEntries].separator = gLevels[k].separator .. " - " .. FLOOD_LEVEL_COUNT .. " Levels"
            else
                startEntries[#startEntries].separator = FLOOD_LEVEL_COUNT .. " Levels"
            end
        end
        counter = counter + 1
    end

    table.insert(startEntries, {
        name = "Back",
        permission = PERMISSION_NONE,
        input = INPUT_A,
        func = function ()
            entries = mainEntries
            selection = 1
        end
    })

    if resetEntries then entries = startEntries end
end

local function reset_previous_entries()
    local resetEntries = entries == startEntries

    prevEntries = {}

    if resetEntries then entries = startEntries end
end

local function reset_gamemode_entries()
    local resetEntries = entries == gamemodeEntries

    gamemodeEntries = {}

    for k in pairs(gamemodes) do
        table.insert(gamemodeEntries, {
            name = gamemodes[k].name,
            permission = PERMISSION_SERVER,
            input = INPUT_A,
            func = function ()
                if gGlobalSyncTable.gamemode ~= k then
                    safe_create_popup("Set Gamemode to " .. gamemodes[k].name)
                end
                gGlobalSyncTable.gamemode = k
                mod_storage_save_number("gamemode", gGlobalSyncTable.gamemode)
            end,
        })

        if k == 0 then
            gamemodeEntries[#gamemodeEntries].separator = "Gamemodes"
        end
    end

    table.insert(gamemodeEntries, {
        name = "Back",
        permission = PERMISSION_NONE,
        input = INPUT_A,
        func = function ()
            entries = mainEntries
            selection = 1
        end
    })

    if resetEntries then entries = gamemodeEntries end
end

local function reset_setting_selections()
    local resetEntries = entries == settingEntries

    settingEntries = {
        {
            separator = "Settings",
            name = "Game Settings",
            permission = PERMISSION_MODERATORS,
            input = INPUT_A,
            func = function ()
                entries = gameEntries
                selection = 1
            end,
            valueText = ">",
        },
        {
            name = "General Settings",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = generalEntries
                selection = 1
            end,
            valueText = ">",
        },
        {
            name = "Hud Settings",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = hudEntries
                selection = 1
            end,
            valueText = ">",
        },
        {
            name = "Enemy Settings",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = enemyEntries
                selection = 1
            end,
            valueText = ">",
        },
        {
            name = "Back",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = mainEntries
                selection = 1
            end,
        },
    }

    if resetEntries then entries = settingEntries end
end

local function reset_game_selections()
    local resetGameEntries = entries == gameEntries

    local floodRound_Style = {
        [0] = "Normal",
        [1] = "Random",
        [2] = "Voting"
    }

    gameEntries = {
        {
            separator = "Game Settings",
            name = "Flood Speed",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = set_flood_speed,
            valueText = math.floor(gGlobalSyncTable.speedMultiplier)
        },
        {
            name = "Round Style",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = set_round_style,
            valueText = floodRound_Style[gGlobalSyncTable.roundStyle]
        },
        {
            name = "Intermission Downtime",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = set_intermission_downtime,
            valueText = math.floor(INTERMISSION_DOWNTIME / 30)
        },	
        {
            name = "Flood Damage Multiplier",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = set_flood_damage,
            valueText = math.floor(gGlobalSyncTable.damage)
        },
        {
            name = "Auto Mode",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "autoMode")
            end,
            valueText = on_off_text(gGlobalSyncTable.autoMode)
        },
        {
            name = "Player Interactions",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "playerInteractions")
            end,
            valueText = on_off_text(gGlobalSyncTable.playerInteractions)
        },
        {
            name = "Flood Gravity",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "floodGravity")
            end,
            valueText = on_off_text(gGlobalSyncTable.floodGravity)
        },
        {
            name = "Flood Interactions",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "floodInteractions")
            end,
            valueText = on_off_text(gGlobalSyncTable.floodInteractions)
        },			
        {
            name = "Lobby Powerups",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "lobbyPowerups")
            end,
            valueText = on_off_text(gGlobalSyncTable.lobbyPowerups)
        },
        {
            name = "Lobby Player Interactions",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "lobbyPlayerInteractions")
            end,
            valueText = on_off_text(gGlobalSyncTable.lobbyPlayerInteractions)
        },			
        {
            name = "Lobby Bosses",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "lobbyBosses")
            end,
            valueText = on_off_text(gGlobalSyncTable.lobbyBosses)
        },
        {
            name = "Kill If Inactive",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "killInactive")
            end,
            valueText = on_off_text(gGlobalSyncTable.killInactive)
        },
        {
            name = "Round Fadeout",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "roundFadeout")
            end,
            valueText = on_off_text(gGlobalSyncTable.roundFadeout)
        },
        {
            name = "Respawn",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "respawn")
            end,
            valueText = on_off_text(gGlobalSyncTable.respawn)
        },
        {
            name = "Quicksand",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "quicksand")
            end,
            valueText = on_off_text(gGlobalSyncTable.quicksand)
        },
        {
            name = "Slopejumps",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "slopejumps")
            end,
            valueText = on_off_text(gGlobalSyncTable.slopejumps)
        },
        {
            name = "Autodoors",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "autodoors")
            end,
            valueText = on_off_text(gGlobalSyncTable.autodoors)
        },
        {
            name = "Back",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = settingEntries
                selection = 1
            end,
        },
    }

    if resetGameEntries then
        entries = gameEntries
    end
end

local function reset_general_selections()
    local resetGeneralEntries = entries == generalEntries

    spectatorMode = {
        [SPECTATOR_MODE_NORMAL] = "Normal",
        [SPECTATOR_MODE_FOLLOW] = "Follow",
        [SPECTATOR_MODE_GHOST] = "Ghost"
    }

    generalEntries = {
        {
            separator = "General Settings",
            name = "Custom Music",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eFloodVariables, "customMusic")
            end,
            valueText = on_off_text(eFloodVariables.customMusic)
        },
        {
            name = "Spectator Mode",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = set_spectator_mode,
            valueText = spectatorMode[eFloodVariables.spectatorMode]
        },
        {
            name = "Holiday Events",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eFloodVariables, "holidayEvents")
            end,
            valueText = on_off_text(eFloodVariables.holidayEvents)
        },
        {
            name = "Popups",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "popups")
            end,
            valueText = on_off_text(gGlobalSyncTable.popups)
        },
        {
            name = "Welcome Message",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eFloodVariables, "welcomeMessage")
            end,
            valueText = on_off_text(eFloodVariables.welcomeMessage)
        },
        {
            name = "Scrolling Flood Texture",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eFloodVariables, "scrollingFloodTexture")
            end,
            valueText = on_off_text(eFloodVariables.scrollingFloodTexture)
        },
        {
            name = "Nametags",
            permission = PERMISSION_MODERATORS,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(gGlobalSyncTable, "nametags")
            end,
            valueText = on_off_text(gGlobalSyncTable.nametags)
        },
        {
            name = "Reset General Settings",
            permission = PERMISSION_MODERATORS,
            input = INPUT_A,
            func = reset_general_settings
        },
        {
            name = "Back",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = settingEntries
                selection = 1
            end,
        },
    }

    if resetGeneralEntries then
        entries = generalEntries
    end
end

local function reset_theme_selections()
    local resetEntries = entries == themeEntries

    themeEntries = {
        {
            separator = "Themes",
            name = "Theme",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = set_theme,
            valueText = get_selected_theme().name
        },
        {
            name = "Manage Themes",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = themeManagerEntries
                selection = 1
            end
        },
        {
            name = "Back",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = mainEntries
                selection = 1
            end,
        }
    }

    if resetEntries then entries = themeEntries end
end

local function reset_theme_manager_entries()
    local resetEntries = entries == themeManagerEntries

    local builtinThemes = 0
    for _, v in ipairs(floodThemes) do
        if v.builtin then
            builtinThemes = builtinThemes + 1
        end
    end

    themeManagerEntries = {
        {
            separator = "Theme Manager",
            name = "Create a Theme",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                local prevSelectedTheme = selectedTheme
                oldTheme = nil
                selectedTheme = #floodThemes + 1
                floodThemes[selectedTheme] = table.copy(floodThemes[prevSelectedTheme])
                floodThemes[selectedTheme].builtin = false
                entries = themeBuilderEntries
                selection = 1
            end,
            disabled = #floodThemes - builtinThemes >= 5
        },
    }

    for k, theme in ipairs(floodThemes) do
        if theme.builtin then goto continue end

        table.insert(themeManagerEntries, {
            name = theme.name,
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                selectedTheme = k
                oldTheme = table.copy(floodThemes[selectedTheme])
                entries = themeBuilderEntries
                selection = 1
            end
        })

        ::continue::
    end

    table.insert(themeManagerEntries, {
        name = "Back",
        permission = PERMISSION_NONE,
        input = INPUT_A,
        func = function ()
            entries = themeEntries
            selection = 1
        end
    })

    if resetEntries then entries = themeManagerEntries end
end

local function reset_theme_builder_entries()
    local resetEntries = entries == themeBuilderEntries
    local theme = get_selected_theme()

    themeBuilderEntries = {
        {
            separator = "Create a Theme",
            name = "Name",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                requestingThemeName = selectedTheme
                create_popup_local("Type /flood [name] to input your name.")
            end,
            valueText = theme.name
        },
        {
            name = "Background",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.background) end,
            valueText = rgb_to_hex(theme.background.r, theme.background.g, theme.background.b)
        },
        {
            name = "Background Outline",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.backgroundOutline) end,
            valueText = rgb_to_hex(theme.backgroundOutline.r, theme.backgroundOutline.g, theme.backgroundOutline.b)
        },
        {
            name = "Rect",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.rect) end,
            valueText = rgb_to_hex(theme.rect.r, theme.rect.g, theme.rect.b)
        },
        {
            name = "Rect Outline",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.rectOutline) end,
            valueText = rgb_to_hex(theme.rectOutline.r, theme.rectOutline.g, theme.rectOutline.b)
        },
        {
            name = "Hover Rect",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.hoverRect) end,
            valueText = rgb_to_hex(theme.hoverRect.r, theme.hoverRect.g, theme.hoverRect.b)
        },
        {
            name = "Hover Rect Outline",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.hoverRectOutline) end,
            valueText = rgb_to_hex(theme.hoverRectOutline.r, theme.hoverRectOutline.g, theme.hoverRectOutline.b)
        },
        {
            name = "Text",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.text) end,
            valueText = rgb_to_hex(theme.text.r, theme.text.g, theme.text.b)
        },
        {
            name = "Selected Text",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.selectedText) end,
            valueText = rgb_to_hex(theme.selectedText.r, theme.selectedText.g, theme.selectedText.b)
        },
        {
            name = "Disabled Text",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.disabledText) end,
            valueText = rgb_to_hex(theme.disabledText.r, theme.disabledText.g, theme.disabledText.b)
        },
        {
            name = "Leaderboard",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.leaderboard, true) end,
            valueText = rgb_to_hex(theme.leaderboard.r, theme.leaderboard.g, theme.leaderboard.b)
        },
        {
            name = "Leaderboard Outline",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.leaderboardOutline) end,
            valueText = rgb_to_hex(theme.leaderboardOutline.r, theme.leaderboardOutline.g, theme.leaderboardOutline.b)
        },
        {
            name = "Minimap",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.minimap, true) end,
            valueText = rgb_to_hex(theme.minimap.r, theme.minimap.g, theme.minimap.b)
        },
        {
            name = "Minimap Outline",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.minimapOutline) end,
            valueText = rgb_to_hex(theme.minimapOutline.r, theme.minimapOutline.g, theme.minimapOutline.b)
        },
        {
            name = "Welcome Message",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.welcomeMessage, true) end,
            valueText = rgb_to_hex(theme.welcomeMessage.r, theme.welcomeMessage.g, theme.welcomeMessage.b)
        },
        {
            name = "Welcome Message Outline",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.welcomeMessageOutline, true) end,
            valueText = rgb_to_hex(theme.welcomeMessageOutline.r, theme.welcomeMessageOutline.g, theme.welcomeMessageOutline.b)
        },
        {
            name = "Pause Background",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function () create_rgb_slider(theme.pauseBackground, true) end,
            valueText = rgb_to_hex(theme.pauseBackground.r, theme.pauseBackground.g, theme.pauseBackground.b)
        },
        {
            name = "Save",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                save_theme(selectedTheme)
                if mod_storage_load_number("theme") ~= nil then
                    selectedTheme = mod_storage_load_number("theme")
                else
                    selectedTheme = 1
                end
                entries = themeManagerEntries
                selection = 1
            end
        },
        {
            name = "Delete",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                local builtinThemes = 0
                for k, v in ipairs(floodThemes) do
                    if v.builtin then
                        builtinThemes = builtinThemes + 1
                    else
                        mod_storage_remove("theme_" .. k - builtinThemes)
                    end
                end
                table.remove(floodThemes, selectedTheme)
                for k, v in ipairs(floodThemes) do
                    if not v.builtin then
                        save_theme(k)
                    end
                end
                if mod_storage_load_number("theme") ~= nil then
                    selectedTheme = mod_storage_load_number("theme")
                else
                    selectedTheme = 1
                end
                if floodThemes[selectedTheme] == nil then
                    selectedTheme = 1
                end
                entries = themeManagerEntries
                selection = 1
            end
        }
    }

    if oldTheme ~= nil then
        table.insert(themeBuilderEntries, {
            name = "Cancel",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                floodThemes[selectedTheme] = oldTheme
                if mod_storage_load_number("theme") ~= nil then
                    selectedTheme = mod_storage_load_number("theme")
                else
                    selectedTheme = 1
                end
                entries = themeManagerEntries
                selection = 1
            end
        })
    end

    if resetEntries then
        entries = themeBuilderEntries
    else
        requestingThemeName = nil
    end
end

local function reset_rgb_slider_entries()
    local resetEntries = entries == rgbSliderEntries

    if rgbValue == nil then return end
    if previousRgbValue == nil then return end

    rgbSliderEntries = {
        {
            name = "R",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                rgbValue.r = set_color_value(rgbValue.r)
            end,
            valueText = rgbValue.r
        },
        {
            name = "G",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                rgbValue.g = set_color_value(rgbValue.g)
            end,
            valueText = rgbValue.g
        },
        {
            name = "B",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                rgbValue.b = set_color_value(rgbValue.b)
            end,
            valueText = rgbValue.b
        },
        {
            name = "A",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                rgbValue.a = set_color_value(rgbValue.a)
            end,
            valueText = rgbValue.a,
            disabled = not rgbAlphaEnabled
        },
        {
            name = "Hex",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                requestingThemeHex = true
                create_popup_local("Type /flood [hexcode] to input your hex code.")
            end,
            valueText = rgb_to_hex(rgbValue.r, rgbValue.g, rgbValue.b),
        },
        {
            name = "Save",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = themeBuilderEntries
            end
        },
        {
            name = "Cancel",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                rgbValue.r = previousRgbValue.r
                rgbValue.g = previousRgbValue.g
                rgbValue.b = previousRgbValue.b
                rgbValue.a = previousRgbValue.a
                entries = themeBuilderEntries
            end
        },
    }

    if resetEntries then
        entries = rgbSliderEntries

        if requestingThemeHexCallback then
            local r, g, b = hex_to_rgb(requestingThemeHexCallback)
            rgbValue.r = r
            rgbValue.g = g
            rgbValue.b = b
            requestingThemeHexCallback = nil
        end
    else
        rgbValue = nil
        previousRgbValue = nil
        requestingThemeHexCallback = nil
    end
end

local function reset_hud_selections()
    local resetHudEntries = entries == hudEntries

    local fonts = {
        [FONT_MENU] = "Menu",
        [FONT_HUD] = "Hud",
        [FONT_NORMAL] = "Normal",
        [FONT_TINY] = "Tiny",
        [FONT_ALIASED] = "Aliased",
        [FONT_SPECIAL] = "Special",
        [FONT_RECOLOR_HUD] = "Recolor",
        [FONT_CUSTOM_HUD] = "Custom",
    }

    hudEntries = {
        {
            separator = "Hud Settings",
            name = "Modifier Display",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "modifiersDisplay")
            end,
            valueText = on_off_text(eHudVariables.modifiersDisplay),
        },
        {
            name = "Timer & Speed Display",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "timerDisplay")
            end,
            valueText = on_off_text(eHudVariables.timerDisplay),
        },
        {
            name = "Leaderboard",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "leaderboard")
            end,
            valueText = on_off_text(eHudVariables.leaderboard),
        },
        {
            name = "Health Meter",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "healthMeter")
            end,
            valueText = on_off_text(eHudVariables.healthMeter),
        },
        {
            name = "Font",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                local direction = get_controller_dir()

                local fontList = {
                    { font = FONT_MENU,         levelScale = 0.2,  modifierScale = 0.15 },
                    { font = FONT_HUD,          levelScale = 0.55, modifierScale = 0.4  },
                    { font = FONT_NORMAL,       levelScale = 0.4,  modifierScale = 0.3  },
                    { font = FONT_TINY,         levelScale = 0.6,  modifierScale = 0.4  },
                    { font = FONT_ALIASED,      levelScale = 0.4,  modifierScale = 0.25 },
                    { font = FONT_SPECIAL,      levelScale = 0.4,  modifierScale = 0.3  },
                    { font = FONT_RECOLOR_HUD,  levelScale = 0.55, modifierScale = 0.4  },
                    { font = FONT_CUSTOM_HUD,   levelScale = 0.55, modifierScale = 0.4  },
                }

                local currIndex = 1
                for i, fontData in ipairs(fontList) do
                    if eHudVariables.font == fontData.font then
                        currIndex = i
                        break
                    end
                end

                if direction == CONT_LEFT then 
                    currIndex = (currIndex - 2 + #fontList) % #fontList + 1
                else
                    currIndex = (currIndex % #fontList) + 1
                end

                local selected = fontList[currIndex]
                eHudVariables.font = selected.font
                eHudVariables.levelScale = selected.levelScale
                eHudVariables.modifierScale = selected.modifierScale

                mod_storage_save_number("font", eHudVariables.font)
                mod_storage_save_number("levelScale", eHudVariables.levelScale)
                mod_storage_save_number("modifierScale", eHudVariables.modifierScale)
            end,
            valueText = fonts[eHudVariables.font],
        },
        {
            name = "Coin Counter",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "coinCounter")
            end,
            valueText = on_off_text(eHudVariables.coinCounter),
        },
        {
            name = "Minimap",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "minimap")
            end,
            valueText = on_off_text(eHudVariables.minimap),
        },
        {
            name = "Outlines",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "outlines")
            end,
            valueText = on_off_text(eHudVariables.outlines),
        },
        {
            name = "Flag Radar",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "flagRadar")
            end,
            valueText = on_off_text(eHudVariables.flagRadar),
        },
        {
            name = "Tips",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "tips")
            end,
            valueText = on_off_text(eHudVariables.tips),
        },
        {
            name = "Music Display",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "musicDisplay")
            end,
            valueText = on_off_text(eHudVariables.musicDisplay),
        },
        {
            name = "Flood Type Display",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "typeDisplay")
            end,
            valueText = on_off_text(eHudVariables.typeDisplay),
        },
        {
            name = "Current Level Indicator",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "currentLevelIndicator")
            end,
            valueText = on_off_text(eHudVariables.currentLevelIndicator),
        },
        {
            name = "Next Level Indicator",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "nextLevelIndicator")
            end,
            valueText = on_off_text(eHudVariables.nextLevelIndicator),
        },
        {
            name = "Gamemode Text",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "gamemodeText")
            end,
            valueText = on_off_text(eHudVariables.gamemodeText),
        },
        {
            name = "Messages Dialogs",
            permission = PERMISSION_NONE,
            input = INPUT_JOYSTICK,
            func = function ()
                safe_booltggle(eHudVariables, "dialogs")
            end,
            valueText = on_off_text(eHudVariables.dialogs),
        },
        {
            name = "Disable All Hud",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = disable_hud_settings
        },
        {
            name = "Reset Hud Settings",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = reset_hud_settings
        },
        {
            name = "Back",
            permission = PERMISSION_NONE,
            input = INPUT_A,
            func = function ()
                entries = settingEntries
                selection = 1
            end,
        },
        separator = ""
    }

    if resetHudEntries then
        entries = hudEntries
    end
end

local function reset_enemy_selections()
    local resetEntries = entries == enemyEntries

    enemyEntries = {}

    for _, enemy in pairs(enemies) do
        table.insert(enemyEntries, {
            name = enemy.name,
            permission = PERMISSION_SERVER,
            input = INPUT_JOYSTICK,
            func = function ()
                enemy.active = not enemy.active
            end,
            valueText = on_off_text(enemy.active),
            separator = _ == 1 and "Enemy Settings" or nil
        })
    end

    table.insert(enemyEntries, {
        name = "Reset To Default",
        permission = PERMISSION_SERVER,
        input = INPUT_A,
        func = function ()
            for _, enemy in pairs(enemies) do
                enemy.active = enemy.default
            end
        end
    })

    table.insert(enemyEntries, {
        name = "Back",
        permission = PERMISSION_NONE,
        input = INPUT_A,
        func = function ()
            entries = settingEntries
            selection = 1
        end
    })

    if resetEntries then
        entries = enemyEntries
    end
end


manualEntries = {
    {
        name = "Objective",
        permission = PERMISSION_NONE,
        input = INPUT_A,
        func = function ()
            entries = {
                {
                    text = "The main goal of Flood is to reach the flag before the flood catches you. The flood can come in a ton of different variants, such as Lava, Sand, Mud, Waste, etc."
                },
                {
                    name = "Back",
                    permission = PERMISSION_NONE,
                    input = INPUT_A,
                    func = function ()
                        entries = manualEntries
                        selection = 1
                    end
                }
            }
            selection = 1
        end,
        separator = "How to Play"
    },
    {
        name = "Back",
        permission = PERMISSION_NONE,
        input = INPUT_A,
        func = function ()
            entries = mainEntries
            selection = 1
        end
    },
    {
        name = "Moderator Commands",
        permission = PERMISSION_NONE,
        input = INPUT_A,
        func = function ()
            entries = {
                {
                    text = "If you are granted moderator status by the person hosting the server in Flood +, you can affect a lot of what happens in the server. You can stop a round early and edit things like which modifiers are being used and the speed of the flood in the Flood Settings. The only things moderators can't do that the server hoster can is starting a round and restarting an ongoing round."
                },
                {
                    name = "Back",
                    permission = PERMISSION_NONE,
                    input = INPUT_A,
                    func = function ()
                        entries = manualEntries
                        selection = 1
                    end
                }
            }
            selection = 1
        end,
    },
    {
        name = "Gamemodes",
        permission = PERMISSION_NONE,
        input = INPUT_A,
        func = function ()
            entries = gamemodeManualEntries
            selection = 1
        end,
    },
    {
        name = "Modifiers",
        permission = PERMISSION_NONE,
        input = INPUT_A,
        func = function ()
            entries = modifierManualEntries
            selection = 1
        end,
    },
    {
        name = "Commands",
        permission = PERMISSION_NONE,
        input = INPUT_A,
        func = function ()
            entries = commandEntries
            selection = 1
        end,
    },
    {
        name = "Developer Info",
        permission = PERMISSION_SERVER,
        input = INPUT_A,
        func = function ()
            entries = devManualEntries
            selection = 1
        end
    },
    {

        name = "Back",
        permission = PERMISSION_NONE,
        input = INPUT_A,
        func = function ()
            entries = mainEntries
            selection = 1
        end,
        separator = ""
    },
}

table.insert(gamemodeManualEntries, {
    name = "Back",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = mainEntries
        selection = 1
    end
})

modifierManualEntries = {
    {name = "Power-Ups",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Power-Ups makes it so that when you collect 4 coins, a power up spawns for you to collect. The 4 types of items you can get are a Wing Cap, Vanish Cap, Metal Cap, and a 1-Up. You can edit the amount of coins you need to collect by using the Modifier menu."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,
    separator = "Modifiers",},
    {name = "Instakill",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Instakill makes it so that the flood instantly kills you when you're submerged in it. You're also one-shot with this modifier on, so try not to get hit by anything at all cost!"
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Deathcoin",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Deathcoin makes it so that if you touch a coin, you die! Use this with Instakill for the best possible experience."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Winboost",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Winboost makes the flood speed increase by 0.25 when you reach the flagpole. Please note that the flood speed will always be 1 with this modifier on."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Speed",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Speed makes the player's speed go 2x faster than before!"
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "B Button Challenge",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "B Button Challenge bans the B button from your controller, which means that you can no longer perform actions like Diving, Kicking, etc."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Z Button Challenge",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Z Button Challenge bans the Z trigger from your controller, which means that you can no longer perform actions like Long Jumping, Ground Pounding, etc."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Coin Rush",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Coin Rush makes it so that the more coins you get, the faster you are."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Tripping",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Tripping makes it so that you can slip and fall while you run on foot. Happens more commonly if you don't jump much."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Low Gravity",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Low Gravity decreases the gravity in every level! Put more of an emphasis on taking shortcuts than going fast to win for this modifier."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "High Gravity",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "High Gravity INCREASES the gravity in every level. Make sure to not assume you can do all the hard jumps you'll try normally in Mario 64."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Flash Flood",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Flash Flood makes it so that the speed of the flood can randomly increase from minimal to nearly 2 times faster. Make sure to stay on your toes for this modifier."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "BLJ",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "BLJ allows you to perform a Backwards Long Jump anywhere at any time."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Capless",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Capless makes it so that you never have your cap on, but you can still use cap powers like the Wing, Vanish or Metal Cap. Oh, and don't even try retrieving your cap from Klepto."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Fly",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Fly grants you power to the Wing Cap at all time."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Slippery Floors",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Slippery Floors is pretty self-explanatory. It makes the floor slippery, which makes the level harder to traverse."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Hard Floors",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Hard Floors removes slipperiness from all types of floors, making it easier to navigate through levels."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Fog",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Fog makes the level harder to see, which can trip you up at times if you're not careful."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Inverted Controls",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Inverts your left stick, making it harder to control the player."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Tornadoes",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Spawns random tornadoes that try to block your way during the round."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Firsties",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Attempting to perform Wallkicks will now require even more skill and 1 frame precision."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Special Triple Jump",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Allows you to use the hidden Special Triple Jump that Yoshi grants you at the top of the Castle."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Earthquake",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Provokes shaking on the camera."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Mega Form",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Turns everyone into bigger versions of themselves."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Mini Form",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Turns everyone into smaller versions of themselves."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = modifierManualEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "Back",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = manualEntries
        selection = 1
    end,
    separator = ""}
}

commandEntries = {
    {name = "/flood",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Opens the Flood + Menu."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = commandEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,
    separator = "Commands"},
    {name = "/start",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Starts a round in a random or specific level, you can also leave it empty for normal progression."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = commandEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end},
    {name = "/modifier",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Enables or Disables a Modifier. You can look at the modifier manual page or the README file to find available modifiers."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = commandEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end},
    {name = "/speed",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Sets the speed multiplier of the Flood."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = commandEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end},
    {name = "/damage",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Sets the damage multiplier of the Flood."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = commandEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end,},
    {name = "/intermission",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = {
            {
                text = "Sets the intermission downtime for when a match ends."
            },
            {
                name = "Back",
                permission = PERMISSION_NONE,
                input = INPUT_A,
                func = function ()
                    entries = commandEntries
                    selection = 1
                end
            }
        }
        selection = 1
    end},
    {name = "Back",
    permission = PERMISSION_NONE,
    input = INPUT_A,
    func = function ()
        entries = manualEntries
        selection = 1
    end,
    separator = ""}
}

devManualEntries = {
    {
        name = "Notes",
        permission = PERMISSION_SERVER,
        input = INPUT_A,
        func = function ()
            entries = {
                {
                    text = "This manual only includes the functions of the _G.floodPlus API, it does not directly teach you how to start making a packk, more info can be found inside the templates.md file in the mod folder."
                },
                {
                    name = "Back",
                    permission = PERMISSION_SERVER,
                    input = INPUT_A,
                    func = function ()
                        entries = devManualEntries
                        selection = 1
                    end
                }
            }
            selection = 1
        end,
        separator = "Developer Info"
    },
    {
        name = "add_level(levelData)",
        permission = PERMISSION_SERVER,
        input = INPUT_A,
        func = function ()
            entries = {
                {
                    text = "name - Level Codes (ex: name = 'lll')\nlevel - level that will be use (LEVEL_X)\narea - The area of the map (integer)\nflagPos - Position of the flag (Vec3f)\nspeed - The multiplier of how speedy will be the flood\ntype - The type/texture of the flood\nstartPos - Custom Vec3f position that players will spawn in\nfloodScale - How wide will the flood be\nunwantedBhvs - list of bhvs that will be deleted on the level\nlaunchpads - List of Vec3f coordinates that launchpads will spawn in\npipes - list of Vec3f coordinates that pipes will spawn in\nmusic - Custom music ID that will replace vanilla song\nauthor - Name of the author of the sm64 level, not the flood level\noverrideName - Overrides the level's name that appears on the menu\noverrideSlide - Turns slides into something that u can walk in\noverrideWater - Override all the water of the level\nfloodHeight - The height of the flood that will be spawned with\nact - The act that the players will spawn on\nskybox - An integer specifying which skybox you will use (see a-levels.lua)"
                },
                {
                    separator = "",
                    name = "Back",
                    permission = PERMISSION_SERVER,
                    input = INPUT_A,
                    func = function ()
                        entries = devManualEntries
                        selection = 1
                    end
                }
            }
            selection = 1
        end,
        separator = ""
    },
    {
        name = "add_lobby(lobbyData)",
        permission = PERMISSION_SERVER,
        input = INPUT_A,
        func = function ()
            entries = {
                {
                    text = "name - Level Codes (ex: name = 'lll')\nlevel - level that will be use (LEVEL_X)\narea - The area of the map (integer)\nspawn - Custom Vec3f position that players will spawn in\nunwantedBhvs - list of bhvs that will be deleted on the level\nlaunchpads - List of Vec3f coordinates that launchpads will spawn in\npipes - list of Vec3f coordinates that pipes will spawn in\noverrideName - Overrides the level's name that appears on the menu\noverrideWater - Override all the water of the level\nmusic - Custom music ID that will replace vanilla song\nskybox - An integer specifying which skybox you will use (see a-levels.lua)"
                },
                {
                    separator = "",
                    name = "Back",
                    permission = PERMISSION_SERVER,
                    input = INPUT_A,
                    func = function ()
                        entries = devManualEntries
                        selection = 1
                    end
                }
            }
            selection = 1
        end
    },
    {
        name = "get_game()",
        permission = PERMISSION_SERVER,
        input = INPUT_A,
        func = function ()
            entries = {
                {
                    text = "returns the current game that people are playing/owner is hosting"
                },
                {
                    name = "Back",
                    permission = PERMISSION_SERVER,
                    input = INPUT_A,
                    func = function ()
                        entries = devManualEntries
                        selection = 1
                    end
                }
            }
            selection = 1
        end,
    },
    {
        name = "add_lobby_song(id, name)",
        permission = PERMISSION_SERVER,
        input = INPUT_A,
        func = function ()
            entries = {
                {
                    text = "id - identifier string for the song\nname - name of the song for better recognision (mandatory)"
                },
                {
                    name = "Back",
                    permission = PERMISSION_SERVER,
                    input = INPUT_A,
                    func = function ()
                        entries = devManualEntries
                        selection = 1
                    end
                }
            }
            selection = 1
        end,
    },
    {
        name = "get_type()",
        permission = PERMISSION_SERVER,
        input = INPUT_A,
        func = function ()
            entries = {
                {
                    text = "returns the current flood type that people are running against"
                },
                {
                    name = "Back",
                    permission = PERMISSION_SERVER,
                    input = INPUT_A,
                    func = function ()
                        entries = devManualEntries
                        selection = 1
                    end
                }
            }
            selection = 1
        end,
    },
    {
        name = "get_current_level()",
        permission = PERMISSION_SERVER,
        input = INPUT_A,
        func = function ()
            entries = {
                {
                    text = "returns the current flood level that people are escaping from"
                },
                {
                    name = "Back",
                    permission = PERMISSION_SERVER,
                    input = INPUT_A,
                    func = function ()
                        entries = devManualEntries
                        selection = 1
                    end
                }
            }
            selection = 1
        end,
    },
    {
        name = "get_round_state()",
        permission = PERMISSION_SERVER,
        input = INPUT_A,
        func = function ()
            entries = {
                {
                    text = "returns the current state of flood +, inactive, active, cooldown, voting, etc.."
                },
                {
                    name = "Back",
                    permission = PERMISSION_SERVER,
                    input = INPUT_A,
                    func = function ()
                        entries = devManualEntries
                        selection = 1
                    end
                }
            }
            selection = 1
        end,
    },
    {
        name = "Back",
        permission = PERMISSION_SERVER,
        input = INPUT_A,
        func = function ()
            entries = mainEntries
            selection = 1
        end,
        separator = ""
    }
}

local function reset_credit_entries()
    local AUTHOR = 1
    local LEAD_DEV = 2
    local FLOOD_AUTHOR = 3
    local FE_AUTHOR = 4
    local DEV = 5
    local FLOOD_PORTER = 6
    local COMPOSER = 7
    local TESTER = 8
    local CONTRIBUTOR = 9
    local SPECIAL_THANKS = 10
    local categories = {
        [AUTHOR] = "Author",
        [LEAD_DEV] = "Lead Developers",
        [FLOOD_AUTHOR] = "Original Flood Author",
        [FE_AUTHOR] = "Flood Expanded Author",
        [DEV] = "Developers",
        [FLOOD_PORTER] = "Flood Porters",
        [TESTER] = "Testers",
        [COMPOSER] = "Composers",
        [CONTRIBUTOR] = "Contributors",
        [SPECIAL_THANKS] = "Special Thanks"
    }
    local players = {
        {
            name = "Lanzasol",
            categories = { AUTHOR, LEAD_DEV, FLOOD_PORTER },
            discordHandle = "zMarioRays",
            modsiteUsername = nil,
            githubHandle = nil
        },
        {
            name = "Agent X",
            categories = { FLOOD_AUTHOR, TESTER },
            discordHandle = "AgentXLP",
            modsiteUsername = "AgentX",
            githubHandle = "AgentXLP"
        },
        {
            name = "tuiBRyt64",
            categories = { LEAD_DEV, FLOOD_PORTER, COMPOSER, TESTER, CONTRIBUTOR },
            discordHandle = "tuiBRyt64",
            modsiteUsername = "tuiBRyt64",
            githubHandle = nil
        },
        {
            name = "ChatGPT",
            categories = { DEV },
            discordHandle = "ChatGPT",
            modsiteUsername = nil,
            githubHandle = "ChatGPT"
        },
        {
            name = "Flood+ Creators",
            categories = { LEAD_DEV, DEV, FLOOD_PORTER, COMPOSER, TESTER, CONTRIBUTOR },
            discordHandle = "idk",
            modsiteUsername = "idk",
            githubHandle = "idk"
        },
        {
            name = "birdekek",
            categories = { FE_AUTHOR, DEV },
            discordHandle = "birdekek",
            modsiteUsername = "birdekek",
            githubHandle = "breadekek"
        },
        {
            name = "Sunk",
            categories = { SPECIAL_THANKS, CONTRIBUTOR },
            discordHandle = "sunkly",
            modsiteUsername = nil,
            githubHandle = "Sunketchupm"
        },
        {
            name = "Error",
            categories = { SPECIAL_THANKS },
            discordHandle = "errorsm64",
            modsiteUsername = nil,
            githubHandle = nil
        }
    }

    creditEntries = {}

    for categoryIndex, categoryName in ipairs(categories) do
        local separatorAddedForCategory = false
        for _, player in ipairs(players) do
            if table.contains(player.categories, categoryIndex) then
                local separator = nil
                if not separatorAddedForCategory then
                    separatorAddedForCategory = true
                    separator = categoryName
                end
                table.insert(creditEntries, {
                    name = player.name,
                    permission = PERMISSION_NONE,
                    input = INPUT_A,
                    func = function ()
                        entries = {
                            {
                                name = "Name",
                                valueText = player.name
                            },
                            {
                                name = "Discord Handle",
                                valueText = player.discordHandle and player.discordHandle or "None"
                            },
                            {
                                name = "Modsite Username",
                                valueText = player.modsiteUsername and player.modsiteUsername or "None"
                            },
                            {
                                name = "Github Handle",
                                valueText = player.githubHandle and player.githubHandle or "None"
                            },
                            {
                                name = "Back",
                                permission = PERMISSION_NONE,
                                input = INPUT_A,
                                func = function ()
                                    entries = creditEntries
                                    selection = 1
                                end
                            }
                        }
                        selection = 1
                    end,
                    separator = separator
                })
            end
        end
    end

    table.insert(creditEntries, {
        name = "Back",
        permission = PERMISSION_NONE,
        input = INPUT_A,
        func = function ()
            entries = mainEntries
            selection = 1
        end,
        separator = ""
    })
end

-- hud stuff
local function is_entry_visible(entryIndex)
    local entryHeight = 90
    for i in pairs(entries) do
        entryHeight = entryHeight + 60
        if entries[i].separator ~= nil then
            entryHeight = entryHeight + 30
        end

        if i == entryIndex then break end
    end

    if entryHeight - scrollOffset < 30 then return false end
    if entryHeight - scrollOffset > 810 then return false end

    return true
end

local function update_cursor_pos()
    local raw_x = djui_hud_get_raw_mouse_x()
    local raw_y = djui_hud_get_raw_mouse_y()
    local timer = get_time()

    if timer > offset then
        if raw_x ~= prev_raw_x or raw_y ~= prev_raw_y then
            moved_cursor = true
            selectionLockedToMouse = true
        end
    else
        moved_cursor = false
        selectionLockedToMouse = false
    end

    prev_raw_x = raw_x
    prev_raw_y = raw_y

    prev_mouse_x = mouse_x
    prev_mouse_y = mouse_y

    if moved_cursor then
        mouse_x = djui_hud_get_mouse_x()
        mouse_y = djui_hud_get_mouse_y()
    else
        local x = (djui_hud_get_screen_width() / 2) - (bgWidth / 2)
        local y = (djui_hud_get_screen_height() - bgHeight) / 2

        local height = 90
        if entries ~= nil and selection ~= nil then
            local max_i = math.min(selection, #entries)
            for i = 1, max_i do
                if entries[i] and entries[i].separator ~= nil then
                    height = height + 90
                else
                    height = height + 60
                end
            end
        else
            height = height + 60
        end

        local entryX = x + 20
        local entryY = y + height - (scrollOffset or 0)
        local entryW = (bgWidth or 400) - 40
        local entryH = 40

        local target_x = entryX + entryW - 12
        local target_y = entryY + (entryH / 2)

        local sf = 0.3
        mouse_x = prev_mouse_x + (target_x - prev_mouse_x) * sf
        mouse_y = prev_mouse_y + (target_y - prev_mouse_y) * sf
    end

    local scroll = djui_hud_get_mouse_scroll_y()
    if scroll ~= 0 then
        selection = selection - scroll
        selectionLockedToMouse = false
        --moved_cursor = false
        --offset = timer + 1

        if selection < 1 then selection = 1 end
        if selection > #entries then selection = #entries end
    end

    hand_texture_state = (djui_hud_get_mouse_buttons_down() & 1 ~= 0)
        and entries[selection].input == INPUT_A
            and has_permission(entries[selection].permission)
                and not entries[selection].disabled
        and TEX_HAND_CLOSED or TEX_HAND_OPEN
end

local function draw_cursor()
        djui_hud_render_texture_interpolated(
            hand_texture_state,
            prev_mouse_x, prev_mouse_y, cursorScale, cursorScale,
            mouse_x, mouse_y, cursorScale, cursorScale
        )
end

local function background()
    local theme = get_selected_theme()
    local x = (djui_hud_get_screen_width() / 2) - (bgWidth / 2)
    local y = djui_hud_get_screen_height() - bgHeight
    djui_hud_set_color(theme.background.r, theme.background.g, theme.background.b, 250)
    djui_hud_render_rect_rounded_outlined(x, y / 2, bgWidth, bgHeight, theme.backgroundOutline.r, theme.backgroundOutline.g, theme.backgroundOutline.b, 10)
end

local function settings_text()
    local text = "\\#2BC3FF\\Flood \\#00ff00\\+ \\#39c5ff\\Expanded"
    local theme = get_selected_theme()
    local x = (djui_hud_get_screen_width() / 2) - (bgWidth / 2)
    local y = (djui_hud_get_screen_height() - bgHeight) / 2
    if y - scrollOffset < -5 then return end
    djui_hud_print_colored_text(text, x + ((bgWidth / 2) - djui_hud_measure_text(string_without_hex(text))), y + 50 - scrollOffset, 2, 255)
    text = version
    djui_hud_set_color(theme.text.r, theme.text.g, theme.text.b, 255)
    djui_hud_print_colored_text(text, x + (bgWidth / 2) - (djui_hud_measure_text(string_without_hex(text)) / 1), y + 105 - scrollOffset, 1, 255)
end

local function hud_render()
    if not showSettings then
        entries = mainEntries
        selection = 1
        scrollOffset = 0
        prevEntries = {}
        return
    end

    local theme = get_selected_theme()
    local screenHeight = djui_hud_get_screen_height()
    local screenWidth = djui_hud_get_screen_width()
    local optionPosY = screenHeight * 0.55

    djui_hud_set_color(theme.pauseBackground.r, theme.pauseBackground.g, theme.pauseBackground.b, theme.pauseBackground.a)
    djui_hud_render_rect(0, 0, screenWidth + 20, screenHeight)
    djui_hud_set_color(255, 255, 255, 255)

    local desiredOffset = 0

    -- get entry to start scrolling at
    scrollEntry = 12
    for i in pairs(entries) do
        if  entries[i].separator ~= nil
        and i < scrollEntry - 1 then
            scrollEntry = scrollEntry - (2/3)
        end
    end

    scrollEntry = math.floor(scrollEntry)

    if selection > scrollEntry then
        for i = scrollEntry + 1, selection do
            desiredOffset = desiredOffset + 60

            if entries[i].separator ~= nil then
                desiredOffset = desiredOffset + 30
            end
        end
    end

    if not selectionLockedToMouse then
        scrollOffset = desiredOffset
    end

    update_cursor_pos()
    background()
    settings_text()

    local height = 90
    local x = (djui_hud_get_screen_width() / 2) - (bgWidth / 2)
    local y = (djui_hud_get_screen_height() - bgHeight) / 2

    for i in pairs(entries) do
        if entries[i].separator ~= nil then
            if not is_entry_visible(i) then
                height = height + 90
                goto continue
            end
            height = height + 45

            djui_hud_set_color(theme.text.r, theme.text.g, theme.text.b, 255)
            djui_hud_print_colored_text(entries[i].separator, x + 30, y + height + 4 - scrollOffset, 1)

            height = height + 45
        else
            height = height + 60
        end

        if not is_entry_visible(i) then goto continue end

        if entries[i].text ~= nil then

            -- if there's a name, print it first
            if entries[i].name ~= nil then
                if selection == i then
                    djui_hud_set_color(theme.selectedText.r, theme.selectedText.g, theme.selectedText.b, 255)
                else
                    djui_hud_set_color(theme.text.r, theme.text.g, theme.text.b, 255)
                end

                djui_hud_print_text(entries[i].name, x + 20, y + height - scrollOffset, 1)

                height = height + 30
            end

            local textAmount = 80
            local wrappedTextLines = wrap_text(entries[i].text, textAmount)

            for j, line in ipairs(wrappedTextLines) do
                if selection == i then
                    djui_hud_set_color(theme.selectedText.r, theme.selectedText.g, theme.selectedText.b, 255)
                else
                    djui_hud_set_color(theme.text.r, theme.text.g, theme.text.b, 255)
                end

                local lineWidth = djui_hud_measure_text(line)
                local centeredX = x + (bgWidth / 2) - (lineWidth / 2)

                djui_hud_print_text(line, centeredX, y + height - scrollOffset + (j - 1) * 28, 1)
            end

            for _ in pairs(wrappedTextLines) do
                height = height + 25
            end

            goto continue
        end

        local outlineColor = nil

        if selection == i then
            djui_hud_set_color(theme.hoverRect.r, theme.hoverRect.g, theme.hoverRect.b, 230)
            outlineColor = theme.hoverRectOutline
        else
            djui_hud_set_color(theme.rect.r, theme.rect.g, theme.rect.b, 200)
            outlineColor = theme.rectOutline
        end

        djui_hud_render_rect_outlined(selection == i and x + 30 or x + 20, y + height - scrollOffset, bgWidth - 40, 40, outlineColor.r, outlineColor.g, outlineColor.b, 3)

        if not has_permission(entries[i].permission)
        or entries[i].disabled then
            djui_hud_set_color(theme.disabledText.r, theme.disabledText.g, theme.disabledText.b, 255)
        else
            djui_hud_set_color(theme.text.r, theme.text.g, theme.text.b, 255)
        end

        if entries[i].name ~= nil then
            djui_hud_print_colored_text(tostring(entries[i].name), selection == i and x + 50 or x + 30, y + height + 4 - scrollOffset, 1)
        end

        if entries[i].valueText ~= nil then
            djui_hud_set_color(theme.text.r, theme.text.g, theme.text.b, 255)
            djui_hud_print_colored_text(tostring(entries[i].valueText), x + (bgWidth - 30) - djui_hud_measure_text(tostring(entries[i].valueText)), y + height + 4 - scrollOffset, 1)
        end

        local entryX = x + 20
        local entryY = y + height - scrollOffset
        local entryW = bgWidth - 40
        local entryH = 40

        draw_cursor()

        if mouse_x >= entryX and mouse_x <= entryX + entryW and
        mouse_y >= entryY and mouse_y <= entryY + entryH and
        selectionLockedToMouse then
            selection = i
        end

        ::continue::
    end
end

---@param m MarioState
local function mario_update(m)
    if m.playerIndex ~= 0 then return end
    if not showSettings then return end

    local timer = get_time()
    m.freeze = 1
    m.controller.buttonPressed = m.controller.buttonPressed & ~(D_CBUTTONS | U_CBUTTONS | L_CBUTTONS | R_CBUTTONS | R_TRIG)

    if m.controller.stickX == 0
    and m.controller.stickY == 0
    and m.controller.buttonDown & U_JPAD == 0
    and m.controller.buttonDown & D_JPAD == 0 then joystickCooldown = 0 end

    if (m.controller.buttonDown & U_JPAD ~= 0
    or m.controller.stickY > 0.5) and joystickCooldown <= 0 then
        selection = selection - 1
        if selection < 1 then selection = clamp(#entries, 1,  #entries + 1) end
        play_sound(SOUND_MENU_MESSAGE_DISAPPEAR, gGlobalSoundSource)
        joystickCooldown = 0.2 * 30
        moved_cursor = false
        selectionLockedToMouse = false
        offset = timer + 1
    elseif (m.controller.buttonDown & D_JPAD ~= 0
    or m.controller.stickY < -0.5) and joystickCooldown <= 0 then
        selection = selection + 1
        if selection > #entries then selection = 1 end
        play_sound(SOUND_MENU_MESSAGE_DISAPPEAR, gGlobalSoundSource)
        joystickCooldown = 0.2 * 30
        moved_cursor = false
        selectionLockedToMouse = false
        offset = timer + 1
    end

    if (m.controller.buttonPressed & R_JPAD ~= 0 or (m.controller.stickX > 0.5
    and joystickCooldown <= 0))
    and entries[selection].input == INPUT_JOYSTICK then
        if has_permission(entries[selection].permission)
        and not entries[selection].disabled then
            if entries[selection].func ~= nil then
                entries[selection].func()
                play_sound(SOUND_MENU_MESSAGE_DISAPPEAR, gGlobalSoundSource)
            end
        else
            play_sound(SOUND_MENU_CAMERA_BUZZ, gGlobalSoundSource)
        end

        joystickCooldown = 0.2 * 30
    elseif (m.controller.buttonPressed & L_JPAD ~= 0 or (m.controller.stickX < -0.5
    and joystickCooldown <= 0))
    and entries[selection].input == INPUT_JOYSTICK then
        if has_permission(entries[selection].permission)
        and not entries[selection].disabled then
            if entries[selection].func ~= nil then
                entries[selection].func()
                play_sound(SOUND_MENU_MESSAGE_DISAPPEAR, gGlobalSoundSource)
            end
        else
            play_sound(SOUND_MENU_CAMERA_BUZZ, gGlobalSoundSource)
        end

        joystickCooldown = 0.2 * 30
    end

    if joystickCooldown > 0 then joystickCooldown = joystickCooldown - 1 end

    if  m.controller.buttonPressed & A_BUTTON ~= 0
    and entries[selection].input == INPUT_A then
        if has_permission(entries[selection].permission)
        and not entries[selection].disabled then
            if entries[selection].func ~= nil then
                table.insert(prevEntries, entries)
                entries[selection].func()
                play_sound(SOUND_MENU_CLICK_FILE_SELECT, gGlobalSoundSource)
                scrollOffset = 0
            end
        else
            play_sound(SOUND_MENU_CAMERA_BUZZ, gGlobalSoundSource)
        end
    end

    if m.controller.buttonPressed & B_BUTTON ~= 0 then
        if #prevEntries > 0 then
            entries = prevEntries[#prevEntries]
            table.remove(prevEntries, #prevEntries)
            scrollOffset = 0
            selection = math.min(selection, #entries)
            scrollEntry = math.min(scrollEntry, #entries)
            play_sound(SOUND_MENU_CLICK_FILE_SELECT, gGlobalSoundSource)
        else
            showSettings = false
            fade_volume_scale(0, 127, 1)
            play_sound(SOUND_MENU_CLICK_FILE_SELECT, gGlobalSoundSource)
        end
    end

    reset_main_entries()
    reset_start_entries()
    reset_gamemode_entries()
    reset_modifier_entries()
    reset_setting_selections()
    reset_game_selections()
    reset_general_selections()
    reset_hud_selections()
    reset_enemy_selections()
    reset_theme_selections()
    reset_theme_manager_entries()
    reset_theme_builder_entries()
    reset_rgb_slider_entries()
    reset_credit_entries()
end

hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_ON_HUD_RENDER, hud_render)