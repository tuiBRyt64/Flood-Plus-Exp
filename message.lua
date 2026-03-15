-- big thanks to birdekek for coding this hud message
local hud_timer = 0
local hud_state = 0
local strings = {
    [1] = "Welcome to \\#3e5f9c\\Flood \\#00ff00\\+ \\#39c5ff\\Exp",
    [2] = "\\#dcdcdc\\This is a Mod of Flood Expanded 1.5.0",
    [3] = "No link for the moment sorry",
    [4] = "Play With Your Friends",
    [5] = "Press \\#344feb\\A \\#ffffff\\to remove this popup.",
}

TEX_ROUNDED_CORNER1 = get_texture_info("cornertl")
TEX_ROUNDED_CORNER2 = get_texture_info("cornertr")
TEX_ROUNDED_CORNER3 = get_texture_info("cornerbl")
TEX_ROUNDED_CORNER4 = get_texture_info("cornerbr")

TEX_STAR = get_texture_info("star")

local function render_colored_text_centered(text, x, y, scale, spacing_factor) -- Most helpful function of 2024 [ChatGPT wrote this, im sorry, if I wrote this it would be MUCH worse (assuming i even could)]
    local default_color = {255, 255, 255, 255}

    djui_hud_set_font(FONT_MENU)

    local current_color = default_color
    local segments = {}
    local total_text_width = 0

    local pattern = "(.-)\\#(%x%x%x%x%x%x)\\(.*)"

    local function add_segment(text_segment, color)
        local segment_width = djui_hud_measure_text(text_segment) * scale * spacing_factor
        table.insert(segments, {text = text_segment, color = color, width = segment_width})
        total_text_width = total_text_width + segment_width
    end


    while #text > 0 do
        local text_segment, color_code, remaining_text = string.match(text, pattern)

        if color_code then

            if text_segment and #text_segment > 0 then
                add_segment(text_segment, current_color)
            end

            current_color = {
                tonumber(color_code:sub(1, 2), 16),
                tonumber(color_code:sub(3, 4), 16),
                tonumber(color_code:sub(5, 6), 16),
                255
            }
            text = remaining_text
        else
            add_segment(text, current_color)
            break
        end
    end

    local start_x = x - (total_text_width / 2)

    for _, segment in ipairs(segments) do
        djui_hud_set_color(segment.color[1], segment.color[2], segment.color[3], segment.color[4])
        djui_hud_print_text(segment.text, start_x, y, scale)
        start_x = start_x + segment.width
    end
end

local function on_hud_render()
    hud_timer = hud_timer + 1

    if hud_timer >= 60 and hud_state ~= 2 then
        if hud_timer == 60 and hud_state == 0 then
            play_sound_cbutton_up()
        end

        local global_y_modifier = 0
        local screen_width = 0

        if hud_state == 0 then
            global_y_modifier = (128 / -clampf((hud_timer - 60) / 60, 0, 1)) + 128
            screen_width = djui_hud_get_screen_width()
        elseif hud_state == 1 then
            global_y_modifier = (-128 / (1 - clampf((hud_timer - 60) / 60, 0, 1))) + 128
            screen_width = djui_hud_get_screen_width()
        end

        local r = math.sin(0.25 * hud_timer + 0) * 127 + 128
        local g = math.sin(0.25 * hud_timer + 2) * 127 + 128
        local b = math.sin(0.25 * hud_timer + 4) * 127 + 128

        djui_hud_set_color(0, 0, 80, 155)
        djui_hud_render_rect((screen_width / 2) - 512, ((djui_hud_get_screen_height() / 2) - 384) - global_y_modifier, 1024, 768)

        djui_hud_render_rect((screen_width / 2) - 576, ((djui_hud_get_screen_height() / 2) - 320) - global_y_modifier, 64, 640)
        djui_hud_render_rect((screen_width / 2) + 512, ((djui_hud_get_screen_height() / 2) - 320) - global_y_modifier, 64, 640)

        djui_hud_render_texture(TEX_ROUNDED_CORNER1, (screen_width / 2) - 576, ((djui_hud_get_screen_height() / 2) - 384) - global_y_modifier, 4, 4)
        djui_hud_render_texture(TEX_ROUNDED_CORNER2, (screen_width / 2) + 512, ((djui_hud_get_screen_height() / 2) - 384) - global_y_modifier, 4, 4)
        djui_hud_render_texture(TEX_ROUNDED_CORNER3, (screen_width / 2) - 576, ((djui_hud_get_screen_height() / 2) + 320) - global_y_modifier, 4, 4)
        djui_hud_render_texture(TEX_ROUNDED_CORNER4, (screen_width / 2) + 512, ((djui_hud_get_screen_height() / 2) + 320) - global_y_modifier, 4, 4)

        djui_hud_set_color(r, g, b, 255)

        djui_hud_render_texture(TEX_STAR, (screen_width / 2) - (djui_hud_measure_text(string_without_hex(strings[1])) + (gTextures.star.width * 10)), (djui_hud_get_screen_height() / 2) - (global_y_modifier + 256), 4, 4)

        djui_hud_set_color(b, g, r, 255)

        djui_hud_render_texture(TEX_STAR, (screen_width / 2) + (djui_hud_measure_text(string_without_hex(strings[1])) + (gTextures.star.width * 6)), (djui_hud_get_screen_height() / 2) - (global_y_modifier + 256), 4, 4)

        render_colored_text_centered(strings[1], screen_width / 2, (djui_hud_get_screen_height() / 2) - (global_y_modifier + 256), 1, 1)
        render_colored_text_centered(strings[2], screen_width / 2, (djui_hud_get_screen_height() / 2) - (global_y_modifier + 192), 0.5, 1)
        render_colored_text_centered(strings[3], screen_width / 2, (djui_hud_get_screen_height() / 2) - (global_y_modifier + 64), 1, 1)
        render_colored_text_centered(strings[4], screen_width / 2, (djui_hud_get_screen_height() / 2) - (global_y_modifier - 64), 1, 1)

        if hud_state == 0 then
            if (hud_timer - 60) <= 30 then
                render_colored_text_centered("3", screen_width / 2, (djui_hud_get_screen_height() / 2) - (global_y_modifier - 256), 1, 1)
            elseif (hud_timer - 60) <= 60 and (hud_timer - 60) > 30 then
                render_colored_text_centered("2", screen_width / 2, (djui_hud_get_screen_height() / 2) - (global_y_modifier - 256), 1, 1)
            elseif (hud_timer - 60) <= 90 and (hud_timer - 60) > 60 then
                render_colored_text_centered("1", screen_width / 2, (djui_hud_get_screen_height() / 2) - (global_y_modifier - 256), 1, 1)
            elseif (hud_timer - 60) > 90 then
                render_colored_text_centered(strings[5], screen_width / 2, (djui_hud_get_screen_height() / 2) - (global_y_modifier - 256), 1, 1)
            end
        end

        if hud_state == 1 and hud_timer > 125 then
            hud_state = 2
        end
    end
end

local function on_mario_update(m)
    if (hud_timer - 60) > 90 and hud_state ~= 2 then
        if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
            hud_state = 1
            hud_timer = 90

            play_sound_cbutton_down()
        end
    end
end

hook_event(HOOK_ON_HUD_RENDER, on_hud_render)
hook_event(HOOK_MARIO_UPDATE, on_mario_update)