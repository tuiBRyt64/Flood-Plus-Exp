-- Custom Pause Menu mod made by Blocky.cmd
        --------------------
        -- Romhacks Logos --
		--------------------

	
----------------------------------------
-----------------------
-- SAVE DATA
-----------------------

gGlobalSyncTable.playtime = gGlobalSyncTable.playtime or 0

-----------------------
-- CONFIG
-----------------------

-- Cargar el sonido
local Timer = 0
local iconRotation = iconRotation or 0
local OPTION_SOUND = audio_stream_load("a.ogg")
local A = get_texture_info("a")
local A_SOUND = audio_stream_load("a1.ogg")
local PLAYTIME_SCALE = 0.5
local zero = {x=0,y=0,z=0}
local m = gMarioStates[0]
local np = gNetworkPlayers[0]
local restartLevelArea = 1
local isPaused = false
local optionOffsetX = {}
local optionTargetX = {}
local slideSpeed = 0.15

--* thanks coolio for the hook & function overwriting

local function is_game_paused_modded()
    return isPaused
end

_G.is_game_paused = is_game_paused_modded

local pause_exit_funcs = {}

local real_hook_event = hook_event
local function hook_event_modded(hook, func)
    if hook == HOOK_ON_PAUSE_EXIT then
        table.insert(pause_exit_funcs, func)
    else
        return real_hook_event(hook, func)
    end
end
_G.hook_event = hook_event_modded

local function call_pause_exit_hooks(exitToCastle)
    local allowExit = true
    for _, func in ipairs(pause_exit_funcs) do
        if func(exitToCastle) == false then
            allowExit = false
            break
        end
    end
    return allowExit
end

local play_sound,save_file_get_star_flags,level_trigger_warp,warp_to_warpnode,djui_hud_set_resolution,djui_hud_set_font,
      djui_hud_get_screen_height,djui_hud_get_screen_width,djui_hud_set_color,djui_hud_render_rect,course_is_main_course,get_level_name,
      get_star_name,save_file_get_course_star_count,get_current_save_file_num,save_file_get_course_coin_score,djui_hud_measure_text,
      djui_hud_print_text,obj_count_objects_with_behavior_id,djui_open_pause_menu =
      play_sound,save_file_get_star_flags,level_trigger_warp,warp_to_warpnode,djui_hud_set_resolution,djui_hud_set_font,
      djui_hud_get_screen_height,djui_hud_get_screen_width,djui_hud_set_color,djui_hud_render_rect,course_is_main_course,get_level_name,
      get_star_name,save_file_get_course_star_count,get_current_save_file_num,save_file_get_course_coin_score,djui_hud_measure_text,
      djui_hud_print_text,obj_count_objects_with_behavior_id,djui_open_pause_menu

local selectedOption = 1

local function close_menu()
    if isPaused then
        isPaused = false
        play_sound(SOUND_MENU_PAUSE_HIGHPRIO, zero)
        m.controller.buttonPressed = 0
    end
end

local cooldown = 5
local cooldownCounter = 0

local previousStickY = 0

function loop_var(var, min, max)
    if var > max then
        var = min
    elseif var < min then
        var = max
    end
    return var
end

local function menu_controls(options)
    local stickY = gMarioStates[0].controller.stickY

    if stickY * previousStickY <= 0 then
        cooldownCounter = cooldownCounter // 2
    end

    if cooldownCounter > 0 then
        cooldownCounter = cooldownCounter - 1
    else
        local delta = options and 1 or -1
        if stickY > 0.5 then
            selectedOption = (selectedOption - delta)
            if options then
                selectedOption = loop_var(selectedOption, 1, #options)
            else
                selectedOption = loop_var(selectedOption, 0, COURSE_MAX)
            end
            audio_stream_play(A_SOUND, true, 1)
            cooldownCounter = cooldown
        elseif stickY < -0.5 then
            selectedOption = (selectedOption + delta)
            if options then
                selectedOption = loop_var(selectedOption, 1, #options)
            else
                selectedOption = loop_var(selectedOption, 0, COURSE_MAX)
            end
            audio_stream_play(A_SOUND, true, 1)
            cooldownCounter = cooldown
        end
    end

    if gMarioStates[0].controller.buttonPressed & A_BUTTON ~= 0 and options then
    audio_stream_play(OPTION_SOUND, true, 1)
    local option = options[selectedOption]
    if option and option.func then
        option.func()
    end
end

    previousStickY = stickY
end


local function is_star_collected(fileIndex, courseIndex, starId)
    if fileIndex < 0 or courseIndex < -1 or starId < 0 then
        return false
    end

    local currentLevelStarFlags = save_file_get_star_flags(fileIndex, courseIndex)

    return (currentLevelStarFlags & (1 << starId)) ~= 0
end

local function round_reset()
    if call_pause_exit_hooks(false) and gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE and network_is_server() or network_is_moderator() then
        network_send(true, { restart = true })
        level_restart()
	
    if gGlobalSyncTable.popups == true then	
       djui_popup_create_global("Reseting the round...", 1)	
	end   		
        close_menu()
    else
        play_sound(SOUND_MENU_CAMERA_BUZZ, zero)
    if network_is_server() or network_is_moderator() then				
        djui_chat_message_create("\\#ff3030\\The round need to be started to be reseted")
		end
    end
end

local function round_start()
    if call_pause_exit_hooks(true)
    and (network_is_server() or network_is_moderator()) then

        -- Si la ronda NO está activa → iniciar
        if gGlobalSyncTable.roundState ~= ROUND_STATE_ACTIVE then
            gGlobalSyncTable.roundState = ROUND_STATE_ACTIVE
            close_menu()

        -- Si YA está activa → resetear
        else
            round_reset()
        end

        return true
    else
        play_sound(SOUND_MENU_CAMERA_BUZZ, zero)
    end
end

local function round_skip()
    if call_pause_exit_hooks(true) and network_is_server() or network_is_moderator() then
       gGlobalSyncTable.roundState = ROUND_STATE_ACTIVE	
       gGlobalSyncTable.level = gGlobalSyncTable.level + 1
    if gGlobalSyncTable.popups == true then	
       djui_popup_create_global("Skipping this round...", 1)	
	end   
       close_menu()
    else
        play_sound(SOUND_MENU_CAMERA_BUZZ, zero)
    end
end

-- Flood Settings
local function flood_settings()
    if call_pause_exit_hooks(false) then
        close_menu()
        play_sound(SOUND_MENU_CAMERA_BUZZ, zero)
        showSettings = not showSettings
        if true then return true end
    end
end

local function other_settings()
    if call_pause_exit_hooks(false) then
	djui_chat_message_create("\\#ff3030\\Coming Soon!")
    end
end

local function achievements()
    if call_pause_exit_hooks(false) then
        close_menu()
        play_sound(SOUND_MENU_CAMERA_BUZZ, zero)
        menuOpen = not menuOpen
        return true
    end
end

local pauseMenuLevelOptions = {
    {name = "Start / Restart Level",   func = round_start},	
    {name = "Skip Level",  func = round_skip},
    {name = "Settings",  func = other_settings},
    {name = "Achievements",  func = achievements},
    {name = "Flood Menu",  func = flood_settings},					
}

local function open_cs()
    _G.charSelect.set_menu_open(true)			
    close_menu()
end

local function render_options(options, screenHeight, screenWidth, optionPosY)

    local centerX = 90
    local spacing = 20


    for i, option in ipairs(options) do

        local y = optionPosY + (i - 1) * spacing

        if optionOffsetX[i] == nil then
            optionOffsetX[i] = -80
            optionTargetX[i] = -40
        end

        if i == selectedOption then
            optionTargetX[i] = 0
        else
            optionTargetX[i] = -40
        end

        optionOffsetX[i] =
            optionOffsetX[i] +
            (optionTargetX[i] - optionOffsetX[i]) * slideSpeed

        local finalX = centerX + optionOffsetX[i]

        -- sombra
        djui_hud_set_color(0,0,0,150)
        djui_hud_print_text(option.name, finalX + 1, y + 1, 1)

        -- color principal
        if i == selectedOption then
            djui_hud_set_color(255,255,255,255)
        else
            djui_hud_set_color(150,150,150,120)
        end

        djui_hud_print_text(option.name, finalX, y, 1)

        -- icono rotando solo en seleccionado
        if i == selectedOption then
    local scale = 1 + math.sin(Timer * 0.25) * 0.08
    local float = math.sin(Timer * 0.2) * 2

    iconRotation = (iconRotation + 0x400) % 0x10000

    djui_hud_set_rotation(iconRotation, 0.5, 0.5)

    djui_hud_render_texture(A, finalX - 35, y + float, scale, scale)

    djui_hud_set_rotation(0, 0, 0) -- resetear rotación
     end
   end
 end

local function render_text(text)
    for _, data in ipairs(text) do
        djui_hud_set_font(data.font)
        djui_hud_set_color(0, 0, 0, 128)
        djui_hud_print_text(data.text, data.posX + 1, data.posY + 1, 1)
        if data.color then
            djui_hud_set_color(data.color.r, data.color.g, data.color.b, data.color.a)
        else
            djui_hud_set_color(255, 255, 255, 255)
        end
        djui_hud_print_text(data.text, data.posX, data.posY, 1)
    end
end

if _G.charSelectExists then
    if gGlobalSyncTable.popups == true then				
    djui_popup_create("You can enter to the CS Menu in the Pause Menu", 2)	
	end
end	

local function format_time(frames)
    local totalSeconds = math.floor(frames / 30)
    local hours = math.floor(totalSeconds / 3600)
    local minutes = math.floor((totalSeconds % 3600) / 60)
    local seconds = totalSeconds % 60

    return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end		

local function hud_render()
    if not isPaused then return end

    -- Character Select Support
    if _G.charSelectExists then
        local csOptionExists = false
        for _, option in ipairs(pauseMenuLevelOptions) do		
            if option.name == "CS MENU" then
                csOptionExists = true
                break
            end
        end
        if not csOptionExists then			
            table.insert(pauseMenuLevelOptions, {name = "CS MENU", func = open_cs})
        end

        if isPaused and _G.charSelect.is_menu_open() then
            close_menu()
        end
    end

    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_TINY)
    local screenHeight = djui_hud_get_screen_height()
    local screenWidth = djui_hud_get_screen_width()
    local totalOptions = #pauseMenuLevelOptions
    local optionSpacing = 20
    local blockHeight = totalOptions * optionSpacing
    local optionPosY = (screenHeight * 0.5) - (blockHeight * 0.5) + 30

-- :p
djui_hud_set_color(0, 0, 0, 120)  -- edit for the pause menu color
djui_hud_render_rect(0, 0, screenWidth + 20, screenHeight)

m.freeze = 1

-- CUADRO DEL PAUSE MENU
local logoTex = get_texture_info("sm64_logo_generic")
local logoScale = 0.1
local logoWidth = logoTex.width * logoScale
local logoHeight = logoTex.height * logoScale

local screenHeight = djui_hud_get_screen_height()
local screenWidth = djui_hud_get_screen_width()
local totalOptions = #pauseMenuLevelOptions
local optionSpacing = 25

local maxOptionWidth = logoWidth
    for _, option in ipairs(pauseMenuLevelOptions) do
        local w = djui_hud_measure_text(option.name)
        if w > maxOptionWidth then maxOptionWidth = w end
    end
    local width = maxOptionWidth + 60  -- margen horizontal

    -- Altura del cuadro: logo + versión + opciones + margen
    local versionHeight = 10
    local height = logoHeight + versionHeight + (totalOptions * optionSpacing) + 20

    -- Posición del cuadro (mismo que logo)
    local x = 14
    local y = 27

    local cornerSize = 16
    local scale = cornerSize / TEX_ROUNDED_CORNER1.width

    -- Fondo central
    djui_hud_set_color(0, 0, 0, 140)
    djui_hud_render_rect(x + cornerSize, y, width - cornerSize * 2, height)

    -- Bordes izquierdo y derecho
    djui_hud_render_rect(x, y + cornerSize, cornerSize, height - cornerSize * 2)
    djui_hud_render_rect(x + width - cornerSize, y + cornerSize, cornerSize, height - cornerSize * 2)

    -- Bordes superior e inferior
    djui_hud_render_rect(x + cornerSize, y - 2, width - cornerSize * 2, 2)
    djui_hud_render_rect(x + cornerSize, y + height, width - cornerSize * 2, 2)

    -- Esquinas
    djui_hud_render_texture(TEX_ROUNDED_CORNER1, x, y, scale, scale)
    djui_hud_render_texture(TEX_ROUNDED_CORNER2, x + width - cornerSize, y, scale, scale)
    djui_hud_render_texture(TEX_ROUNDED_CORNER3, x, y + height - cornerSize, scale, scale)
    djui_hud_render_texture(TEX_ROUNDED_CORNER4, x + width - cornerSize, y + height - cornerSize, scale, scale)

    -- Logo
    djui_hud_set_color(255, 255, 255, 255)
    djui_hud_render_texture(logoTex, x, y, logoScale, logoScale)

    -- Texto versión
    local versionText = "v1.0"
    local versionScale = 0.4
    local versionX = x
    local versionY = y + logoHeight + 5

    djui_hud_set_font(FONT_NORMAL)
    djui_hud_set_color(255, 255, 255, 255)
    djui_hud_print_text(versionText, versionX, versionY, versionScale)

-----------------------
    -- PLAYTIME DISPLAY
    -----------------------

    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_NORMAL)

    local text = "Total Play Time: " .. format_time(gGlobalSyncTable.playtime)
    local textWidth = djui_hud_measure_text(text) * PLAYTIME_SCALE

    local x = djui_hud_get_screen_width() - textWidth - 20
    local y = 20

    -- sombra
    djui_hud_set_color(0, 0, 0, 150)
    djui_hud_print_text(text, x + 1, y + 1, PLAYTIME_SCALE)

    -- texto
    djui_hud_set_color(255, 255, 255, 255)
    djui_hud_print_text(text, x, y, PLAYTIME_SCALE)
    
	if gNetworkPlayers[0].currLevelNum == LEVEL_BOB then
        courseName = "- Course 1 -"
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_WF then
        courseName = "- Course 2 -"
    elseif gNetworkPlayers[0].currLevelNum == LEVEL_JRB then
        courseName = "- Course 3 -"
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_CCM then
        courseName = "- Course 4 -"
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_BBH then
        courseName = "- Course 5 -"
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_HMC then
        courseName = "- Course 6 -"
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_LLL then
        courseName = "- Course 7 -"
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_SSL then
        courseName = "- Course 8 -"		
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_DDD then
        courseName = "- Course 9 -"
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_SL then
        courseName = "- Course 10 -"
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_WDW then
        courseName = "- Course 11 -"
    elseif gNetworkPlayers[0].currLevelNum == LEVEL_TTM then
        courseName = "- Course 12 -"
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_THI then
        courseName = "- Course 13 -"
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_TTC then
        courseName = "- Course 14 -"
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_RR then
        courseName = "- Course 15 -"
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE 
	or gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE_GROUNDS 
	or gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE_COURTYARD then
        courseName = "- HUB Course -"		
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_WMOTR 
	or gNetworkPlayers[0].currLevelNum == LEVEL_SA
	or gNetworkPlayers[0].currLevelNum == LEVEL_PSS
    or gNetworkPlayers[0].currLevelNum == LEVEL_ENDING
    or gNetworkPlayers[0].currLevelNum == LEVEL_ZERO_LIFE 
    or gNetworkPlayers[0].currLevelNum == LEVEL_BORDER then
        courseName = "- Side Course -"	
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_BITDW
	or gNetworkPlayers[0].currLevelNum == LEVEL_BITFS 
    or gNetworkPlayers[0].currLevelNum == LEVEL_BITS
    or gNetworkPlayers[0].currLevelNum == LEVEL_BOWSER_1
    or gNetworkPlayers[0].currLevelNum == LEVEL_BOWSER_2
    or gNetworkPlayers[0].currLevelNum == LEVEL_BOWSER_3 then
        courseName = "- Bowser Course -"	
	elseif gNetworkPlayers[0].currLevelNum == LEVEL_COTMC
    or gNetworkPlayers[0].currLevelNum == LEVEL_VCUTM
    or gNetworkPlayers[0].currLevelNum == LEVEL_TOTWC then
        courseName = "- Cap Course -"	
	end	
		local textlv1 = get_level_name(gNetworkPlayers[0].currCourseNum, gNetworkPlayers[0].currLevelNum, gNetworkPlayers[0].currAreaIndex)

        djui_hud_set_font(FONT_TINY)
        if (gLevelValues.pauseExitAnywhere or (gMarioStates[0].action & ACT_FLAG_PAUSE_EXIT) ~= 0) then
            menu_controls(pauseMenuLevelOptions)
            render_options(pauseMenuLevelOptions, screenHeight, screenWidth, optionPosY)
			
        djui_hud_set_resolution(RESOLUTION_N64);
		djui_hud_set_font (FONT_NORMAL)	
		if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
		djui_hud_print_text("Level Number: " .. gGlobalSyncTable.level .. " /" .. FLOOD_LEVEL_COUNT, 3.5, 230, 0.15)
		else
		djui_hud_print_text("Next Level: " .. gGlobalSyncTable.level .. " /" .. FLOOD_LEVEL_COUNT, 3.5, 230, 0.15)		
        end		
    end
end

local function pressed_pause()
    if get_dialog_id() >= 0 or (_G.charSelectExists and _G.charSelect.is_menu_open()) then
        return false
    end

    return gMarioStates[0].controller.buttonPressed & START_BUTTON ~= 0
end

function before_mario_update()
    local rTrigPressed = m.controller.buttonPressed & R_TRIG ~= 0

    if pressed_pause() then
        if not isPaused then
            isPaused = true
            selectedOption = 1
            for i = 1, #pauseMenuLevelOptions do
    optionOffsetX[i] = -80
    optionTargetX[i] = -40
end
            m.controller.buttonPressed = 0
            play_sound(SOUND_MENU_PAUSE_HIGHPRIO, zero)
        else
            close_menu()
        end
    elseif rTrigPressed and isPaused then
        djui_open_pause_menu()
        m.controller.buttonPressed = 0
        play_sound(SOUND_MENU_EXIT_A_SIGN, zero)
    end
end

real_hook_event(HOOK_ON_HUD_RENDER, hud_render)
real_hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
real_hook_event(HOOK_ON_WARP, close_menu)
real_hook_event(HOOK_ON_LEVEL_INIT, function () restartLevelArea = gNetworkPlayers[0].currAreaIndex close_menu() end)
-- PLAYTIME UPDATE
real_hook_event(HOOK_UPDATE, function()
    Timer = Timer + 1
    if not isPaused then
        gGlobalSyncTable.playtime = gGlobalSyncTable.playtime + 1
    end
end)
-- if you see this thanks for all
-- si ves esto gracias por todo
-- GD ES CLAVE >w< xdddd no se poruqe pongo esto Writed by a Flood + Expanded Developer
