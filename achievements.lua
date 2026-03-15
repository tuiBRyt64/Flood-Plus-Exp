-----------------------------
-- SAVE SYSTEM
----------------------------

gGlobalSyncTable.achievements = {}


----------------------------
-- MENU STATE
----------------------------

local menuOpen = false


----------------------------
-- PAUSE MENU FUNCTION
----------------------------

local function achievements()
    if call_pause_exit_hooks(false) then
        close_menu()
        play_sound(SOUND_MENU_CAMERA_BUZZ, zero)
        menuOpen = not menuOpen
        return true
    end
end


----------------------------
-- CONFIG
----------------------------

local popupSliding = false
local popupOffsetX = 0
local slideSpeed = 25
local popupTimer = 0
local popupText = ""

local TEX_ACH_POPUP = get_texture_info("achievement_popup")

ACHIEVEMENTS = {

    coins100 = {
        name = "Rich!",
        desc = "Collect 100 coins",
        condition = function(m)
            return m.numCoins >= 100
        end
    },

    jump500 = {
        name = "Jump Man",
        desc = "Jump 500 times",
        counter = 0,
        goal = 500,
        event = "jump"
    },

    fall1000 = {
        name = "Sky Diver",
        desc = "Fall 1000 units",
        counter = 0,
        goal = 1000,
        event = "fall"
    }

}

for id,_ in pairs(ACHIEVEMENTS) do
    if mod_storage_load("ach_" .. id) == "1" then
        gGlobalSyncTable.achievements[id] = true
    end
end


----------------------------
-- UNLOCK FUNCTION
----------------------------

local function unlock(id)
    if gGlobalSyncTable.achievements[id] then return end

    gGlobalSyncTable.achievements[id] = true
    mod_storage_save("ach_" .. id, "1")

    popupTimer = 150
    popupText = "Achievement Unlocked: "..ACHIEVEMENTS[id].name

    popupSliding = false
    popupOffsetX = 0
end


----------------------------
-- EVENT TRACKING
----------------------------

hook_event(HOOK_MARIO_UPDATE, function(m)

    for id,a in pairs(ACHIEVEMENTS) do

        if not gGlobalSyncTable.achievements[id] then

            -- condition
            if a.condition and a.condition(m) then
                unlock(id)
            end

            -- jump counter
            if a.event == "jump" then
                if m.action == ACT_JUMP and m.actionTimer == 0 then
                    a.counter = a.counter + 1
                    if a.counter >= a.goal then
                        unlock(id)
                    end
                end
            end

            -- fall counter
            if a.event == "fall" then
                if m.vel.y < -20 then
                    a.counter = a.counter + 1
                    if a.counter >= a.goal then
                        unlock(id)
                    end
                end
            end

        end
    end

end)


----------------------------
-- POPUP RENDER
----------------------------

hook_event(HOOK_ON_HUD_RENDER, function()

    if popupTimer > 0 or popupSliding then

        djui_hud_set_resolution(RESOLUTION_N64)

        local scale = 0.7
        local boxW = TEX_ACH_POPUP.width * scale
        local boxH = TEX_ACH_POPUP.height * scale

        local screenW = djui_hud_get_screen_width()
        local screenH = djui_hud_get_screen_height()

        if popupTimer > 0 then
            popupTimer = popupTimer - 1
        else
            popupSliding = true
            popupOffsetX = popupOffsetX + slideSpeed
            if popupOffsetX > screenW then
                popupSliding = false
            end
        end

        local x = ((screenW - boxW) * 0.5) + popupOffsetX
        local y = screenH - boxH - 40

        djui_hud_set_color(255,255,255,255)
        djui_hud_render_texture(TEX_ACH_POPUP, x, y, scale, scale)

        djui_hud_set_font(FONT_NORMAL)
        djui_hud_set_color(255,255,255,255)

        local textScale = 0.5
        local textWidth = djui_hud_measure_text(popupText) * textScale
        local textX = x + (boxW - textWidth) * 0.5
        local textY = y + boxH * 0.4

        djui_hud_print_text(popupText, textX, textY, textScale)
    end

end)


----------------------------
-- ACHIEVEMENT MENU RENDER
----------------------------

hook_event(HOOK_ON_HUD_RENDER, function()

    if not menuOpen then return end

    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_NORMAL)

    local screenW = djui_hud_get_screen_width()
    local screenH = djui_hud_get_screen_height()

    local boxW = 260
    local boxH = 180

    local x = (screenW - boxW) * 0.5
    local y = (screenH - boxH) * 0.5

    -- Background
    djui_hud_set_color(0,0,0,220)
    djui_hud_render_rect(x, y, boxW, boxH)

    djui_hud_set_color(255,255,255,255)
    djui_hud_print_text("Achievements", x + 70, y + 10, 0.6)

    local offsetY = 35

    for id,a in pairs(ACHIEVEMENTS) do

        local completed = gGlobalSyncTable.achievements[id]

        if completed then
            djui_hud_set_color(0,255,0,255)
        else
            djui_hud_set_color(255,0,0,255)
        end

        djui_hud_print_text(a.name, x + 15, y + offsetY, 0.5)

        djui_hud_set_color(200,200,200,255)
        djui_hud_print_text(a.desc, x + 25, y + offsetY + 12, 0.4)

        offsetY = offsetY + 30
    end

end)