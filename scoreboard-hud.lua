local TEX_ROUNDED_CORNER1 = get_texture_info("cornertl")
local TEX_ROUNDED_CORNER2 = get_texture_info("cornertr")
local TEX_ROUNDED_CORNER3 = get_texture_info("cornerbl")
local TEX_ROUNDED_CORNER4 = get_texture_info("cornerbr")

local function render_colored_text(text, x, y, scale)
    local i = 1
    local currentX = x
    local r, g, b = 255, 255, 255

    while i <= #text do
        local c = text:sub(i, i)

        -- detectar inicio de color \#RRGGBB\
        if c == "\\" and text:sub(i + 1, i + 1) == "#" then
            local hex = text:sub(i + 2, i + 7)

            if #hex == 6 then
                r = tonumber(hex:sub(1, 2), 16) or 255
                g = tonumber(hex:sub(3, 4), 16) or 255
                b = tonumber(hex:sub(5, 6), 16) or 255
            end

            -- saltar \#RRGGBB\
            i = i + 9
        else
            -- imprimir carácter normal
            djui_hud_set_color(r, g, b, 255)

            local char = c
            djui_hud_print_text(char, currentX, y, scale)

            currentX = currentX + djui_hud_measure_text(char) * scale
            i = i + 1
        end
    end
end

local function hud_render()
    -- ensure round state is set to round active or end
    if  gGlobalSyncTable.roundState ~= ROUND_STATE_ACTIVE
    and gGlobalSyncTable.roundState ~= ROUND_STATE_END then return end

    -- set font and res
    djui_hud_set_font(FONT_NORMAL)
    djui_hud_set_resolution(RESOLUTION_DJUI)

    -- get screen height
    local screenHeight = djui_hud_get_screen_height()

    -- get width of rect
    local width = 287

    -- get initial height for rect
    -- this includes survivor text
    local height = 85

    survivors = {}

    -- loop thru all survivors
    for i = 0, MAX_PLAYERS - 1 do
        local np = gNetworkPlayers[i]
        local s = gPlayerSyncTable[i]
        local m = gMarioStates[i]

        if np.connected and m.health > 0xFF and (s.finished
        or gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE) then
            -- add survivor to table
            table.insert(survivors, i)
        end
    end

    if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
        -- sort survivers via time if the player's finished
        -- otherwise use the distance to the flag
        table.sort(survivors, function (a, b)
            if gPlayerSyncTable[a].finished
            or gPlayerSyncTable[b].finished then
                return gPlayerSyncTable[a].time < gPlayerSyncTable[b].time
            else
                local aO = gMarioStates[a].marioObj
                local bO = gMarioStates[b].marioObj

                local pos = gLevels[gGlobalSyncTable.level].goalPos

                return dist_between_object_and_point(aO, pos.x, pos.y, pos.z) < dist_between_object_and_point(bO, pos.x, pos.y, pos.z)
            end
        end)
    else
        -- sort survivers via time
        table.sort(survivors, function (a, b)
            return gPlayerSyncTable[a].time < gPlayerSyncTable[b].time
        end)
    end

    if #survivors < 1 then
        -- if there are no survivors, increase height by 25
        height = height + 25
    else
        -- give each survivor 35 pixels of play room plus 25 for padding at bottom
        height = height + (#survivors - 1) * 35 + 25
    end

    -- get x and y for rect and scale cornersize for rect bords
    local x = 0
    local y = screenHeight / 2 - height / 2 - 80
    local cornerSize = 16
    local scale = cornerSize / TEX_ROUNDED_CORNER1.width

-- Fondo central
djui_hud_set_color(0, 0, 0, 140)
djui_hud_render_rect(x + cornerSize, y, width - cornerSize*2, height) -- rectángulo central

-- Bordes izquierdo y derecho
djui_hud_render_rect(x, y + cornerSize, cornerSize, height - cornerSize*2) -- borde izquierdo
djui_hud_render_rect(x + width - cornerSize, y + cornerSize, cornerSize, height - cornerSize*2) -- borde derecho

-- (Opcional) Bordes superior e inferior
djui_hud_render_rect(x + cornerSize, y - 2, width - cornerSize*2, 2) -- borde superior
djui_hud_render_rect(x + cornerSize, y + height, width - cornerSize*2, 2) -- borde inferior

djui_hud_render_texture(TEX_ROUNDED_CORNER1, x, y, scale, scale) -- superior izquierda
djui_hud_render_texture(TEX_ROUNDED_CORNER2, x + width - cornerSize, y, scale, scale) -- superior derecha
djui_hud_render_texture(TEX_ROUNDED_CORNER3, x, y + height - cornerSize, scale, scale) -- inferior izquierda
djui_hud_render_texture(TEX_ROUNDED_CORNER4, x + width - cornerSize, y + height - cornerSize, scale, scale) -- inferior derecha

    -- set x and y to have more padding
    x = 5
    y = y + 5

    -- render survivors text
    djui_hud_set_color(220, 220, 220, 255)
    djui_hud_print_text("Survivors", x, y, 1)

    local position = 1

    if #survivors > 0 then
        -- render players text
        for s = 1, #survivors do -- survivors is a table that starts at 1

            local i = survivors[s]
            -- offset y
            y = y + 35
            -- reset x
            x = 5
            -- render player position
            local positionText = "#" .. position
            local positionColor = { r = 0, g = 0, b = 0 }
            if position == 1 then
                positionColor.r = 255
                positionColor.g = 215
                positionColor.b = 0
            elseif position == 2 then
                positionColor.r = 170
                positionColor.g = 170
                positionColor.b = 170
            elseif position == 3 then
                positionColor.r = 205
                positionColor.g = 127
                positionColor.b = 50
            else
                positionColor.r = 220
                positionColor.g = 220
                positionColor.b = 220
            end
            djui_hud_set_color(positionColor.r, positionColor.g, positionColor.b, 255)
            djui_hud_print_text(positionText, x, y, 1)
            -- get player color
            -- get player hex color string (RRGGBB)
local hex = network_get_player_text_color_string(i)

-- get player name CON colores originales
local name = gNetworkPlayers[i].name

-- posicionar después del #1, #2, etc
x = djui_hud_measure_text(positionText) + 10

-- renderizar nombre con tu función personalizada
render_colored_text(name, x, y, 1)

-- ===============================
-- DISTANCIA / FINISHED
-- ===============================
if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
    local pos = gLevels[gGlobalSyncTable.level].goalPos

    local dist = math.floor(
        dist_between_object_and_point(
            gMarioStates[i].marioObj,
            pos.x, pos.y, pos.z
        ) / 100
    )

    local distText = tostring(dist)

    if gPlayerSyncTable[i].finished then
        distText = "finished."
    end

    -- ⚠ IMPORTANTE: medir nombre SIN códigos de color
    local cleanName = string_without_hex(name)

    x = djui_hud_measure_text(positionText)
        + djui_hud_measure_text(cleanName)
        + 25

    djui_hud_set_color(positionColor.r, positionColor.g, positionColor.b, 255)
    djui_hud_print_text(distText, x, y, 1)
end

            -- increase position
            position = position + 1
        end
    end

    -- if we didn't render a player...
    if position == 1 then
        -- ...offset y...
        y = y + 35
        -- ...and render text
        djui_hud_set_color(255, 0, 0, 255)
        djui_hud_print_text("None", x, y, 1)
    end
end

hook_event(HOOK_ON_HUD_RENDER, hud_render)