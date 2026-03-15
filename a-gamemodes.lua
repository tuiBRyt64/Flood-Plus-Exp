if unsupported then return end

GAMEMODE_NORMAL = 0
GAMEMODE_LIFELINK = 1
GAMEMODE_HARD_MODE = 2
GAMEMODE_RED_GREEN_LIGHT = 3
GAMEMODE_FLOOD_ROYALE = 4

LIGHT_STATE_GREEN = 0
LIGHT_STATE_RED = 1

gGlobalSyncTable.gamemode = GAMEMODE_NORMAL
gGlobalSyncTable.lightState = LIGHT_STATE_GREEN
gGlobalSyncTable.lightTimer = math.random(10, 20) * 30

gamemodes = {
    [GAMEMODE_NORMAL] = {
        name = "Normal",
        description = "Standard Flood Gameplay, good for those who don't want anything special",
    },
    [GAMEMODE_LIFELINK] = {
        name = "Lifelink",
        description = "In this Gamemode, every player shares a special life link, which means that if anybody dies, anybody who hasn't reached the flag in time will face the consequences.",
        hooks = { [HOOK_MARIO_UPDATE] = function (m)
                if m.health <= 0xFF and gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
                    round_end()
                end
            end
        },
        color = { r = 15, g = 100, b = 230 }
    },
    [GAMEMODE_HARD_MODE] = {
        name = "Hard Mode",
        description = "In this Gamemode, players only have can have 4 HP Max, slopejumps are off, quicksand is active, and more things, better be prepared for this challenge!.",
        hooks = { [HOOK_MARIO_UPDATE] = function (m)
                if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
                    if m.health > 0x400 then
                        m.health = 0x400
                    end
                    if gGlobalSyncTable.speedMultiplier < 1.09 then
                        gGlobalSyncTable.speedMultiplier = 1.1
                    end
                    gGlobalSyncTable.quicksand = true
                    gGlobalSyncTable.slopejumps = false
                    gGlobalSyncTable.respawn = false
                end
            end
        },
        color = { r = 220, g = 30, b = 30 }
    },
    [GAMEMODE_RED_GREEN_LIGHT] = {
        name = "Red / Green Light",
        description = "In this Gamemode, players must reach the flag without moving when the light is red or they will die, moving only when the light is green.",
        hooks = { [HOOK_MARIO_UPDATE] = function (m)
                if (m.health > 0xFF or not gPlayerSyncTable[0].finished) and gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
                    if (m.forwardVel > 0 or m.forwardVel < 0) and gGlobalSyncTable.lightState == LIGHT_STATE_RED then
                        m.health = 0xFF
                    end
                end
            end,
           [HOOK_UPDATE] = function ()
                lightText = ""
                if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
                    gGlobalSyncTable.lightTimer = gGlobalSyncTable.lightTimer - 1
                    if gGlobalSyncTable.lightTimer <= 0 then
                        if gGlobalSyncTable.lightState == LIGHT_STATE_GREEN then
                            gGlobalSyncTable.lightTimer = math.random(3,5) * 30
                            gGlobalSyncTable.lightState = LIGHT_STATE_RED
                        else
                            gGlobalSyncTable.lightTimer = math.random(10, 20) * 30
                            gGlobalSyncTable.lightState = LIGHT_STATE_GREEN
                        end
                    end
                else
                    if gGlobalSyncTable.roundState ~= ROUND_STATE_ACTIVE then
                        gGlobalSyncTable.lightTimer = math.random(10, 20) * 30
                        gGlobalSyncTable.lightState = LIGHT_STATE_GREEN
                    end
                end
                lightR, lightG = 0
                    if gGlobalSyncTable.lightState == LIGHT_STATE_GREEN then
                        lightText = "Green Light"
                        lightG = 220
                    else
                        lightText = "Red Light"
                        lightR, lightG = 220, 0
                    end
                if (gGlobalSyncTable.lightTimer == 1.5 * 30 or gGlobalSyncTable.lightTimer == 1 * 30 or gGlobalSyncTable.lightTimer == 0.5 * 30) and gGlobalSyncTable.lightState == LIGHT_STATE_GREEN then
                    play_sound(SOUND_MENU_CAMERA_BUZZ, gGlobalSoundSource)
                elseif (gGlobalSyncTable.lightTimer == 1.5 * 30 or gGlobalSyncTable.lightTimer == 1 * 30 or gGlobalSyncTable.lightTimer == 0.5 * 30) and gGlobalSyncTable.lightState == LIGHT_STATE_RED then
                    play_sound(SOUND_MENU_CLICK_FILE_SELECT, gGlobalSoundSource)
                end
                if gGlobalSyncTable.lightTimer <= 1.5 * 30 then
                    lightText = "Light Transition"
                    if (gGlobalSyncTable.lightTimer % 10) < 5 then
                        lightR, lightG = 255, 255
                    end
                end
            end,
            [HOOK_ON_HUD_RENDER] = function ()
                if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
                    djui_hud_set_resolution(RESOLUTION_N64)
                    local theme = floodThemes[selectedTheme]
                    local screenWidth = djui_hud_get_screen_width()
                    local width = djui_hud_measure_text(lightText) * 0.3
                    local x = (screenWidth - width) / 2.0
                    djui_hud_set_adjusted_color(lightR, lightG, 0, theme.rect.a)
                    djui_hud_render_rect_rounded_outlined(x - 6, 0, width + 12, 16, lightR, lightG, 0, 1);
                    djui_hud_set_color(255, 255, 255, 255);
                    djui_hud_print_text(lightText, x, 2, 0.3);
                end
            end
        },
        color = { r = 0, g = 255, b = 0 }
    },
    [GAMEMODE_FLOOD_ROYALE] = {
        name = "Flood Royale",
        description = "In this Gamemode, only the first player to reach the flag can survive, so you'd better activate Player Interactions for a better chance of winning!.",
        hooks = { [HOOK_MARIO_UPDATE] = function (m)
                if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
                    for i = 0, MAX_PLAYERS - 1 do
                        if gPlayerSyncTable[i] ~= nil and gPlayerSyncTable[i].finished then
                            if m.playerIndex ~= i then
                                m.health = 0xFF
                            end
                        end
                    end
                end
            end
        },
        color = { r = 30, g = 30, b = 220 }
    }
}

for gamemode in pairs(gamemodes) do
    if gamemodes[gamemode].hooks then
        for hook, func in pairs(gamemodes[gamemode].hooks) do
            hook_event(hook, function (param1, param2, param3, param4, param5)
                if gGlobalSyncTable.gamemode == gamemode then
                    func(param1, param2, param3, param4, param5)
                end
            end)
        end
    end
end