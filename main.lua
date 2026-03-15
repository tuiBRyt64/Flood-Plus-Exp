-- name: \\#3e5f9c\\Flood \\#00ff00\\+ \\#39c5ff\\Exp\\#dcdcdc\\ [WIP]
-- incompatible: gamemode
-- description: \\#3e5f9c\\Flood \\#00ff00\\+ \\#39c5ff\\Expanded \\#dcdcdc\\ is a modification of Flood Expanded 1.5.0 for be more good with more levels --note-- Pasue Menu Has been Remaked on the actual version -- Version 1.0 -- Why You Reading This? Come on Play The mod!!

if unsupported then return end

-- localize functions to improve performance
local network_player_connected_count,init_single_mario,warp_to_level,play_sound,network_get_player_text_color_string,djui_chat_message_create,disable_time_stop,network_player_set_description,set_mario_action,obj_get_first_with_behavior_id,obj_check_hitbox_overlap,spawn_mist_particles,vec3f_dist,play_race_fanfare,play_music,djui_hud_set_resolution,djui_hud_get_screen_height,djui_hud_get_screen_width,djui_hud_render_rect,djui_hud_set_font,djui_hud_world_pos_to_screen_pos,clampf,math_floor,djui_hud_measure_text,djui_hud_print_text,hud_render_power_meter,hud_get_value,save_file_erase_current_backup_save,save_file_set_flags,save_file_set_using_backup_slot,find_floor_height,spawn_non_sync_object,vec3f_set,vec3f_copy,math_random,set_ttc_speed_setting,get_level_name,hud_hide,smlua_text_utils_secret_star_replace,smlua_audio_utils_replace_sequence =
      network_player_connected_count,init_single_mario,warp_to_level,play_sound,network_get_player_text_color_string,djui_chat_message_create,disable_time_stop,network_player_set_description,set_mario_action,obj_get_first_with_behavior_id,obj_check_hitbox_overlap,spawn_mist_particles,vec3f_dist,play_race_fanfare,play_music,djui_hud_set_resolution,djui_hud_get_screen_height,djui_hud_get_screen_width,djui_hud_render_rect,djui_hud_set_font,djui_hud_world_pos_to_screen_pos,clampf,math.floor,djui_hud_measure_text,djui_hud_print_text,hud_render_power_meter,hud_get_value,save_file_erase_current_backup_save,save_file_set_flags,save_file_set_using_backup_slot,find_floor_height,spawn_non_sync_object,vec3f_set,vec3f_copy,math.random,set_ttc_speed_setting,get_level_name,hud_hide,smlua_text_utils_secret_star_replace,smlua_audio_utils_replace_sequence

-- constants
ROUND_STATE_INACTIVE   = 0
ROUND_STATE_ACTIVE     = 1
ROUND_STATE_END        = 2
ROUND_COOLDOWN         = 16 * 30 -- 16 seconds, the 16 should only be shown on 1 frame

SPEEDRUN_MODE_OFF      = 0
SPEEDRUN_MODE_PROGRESS = 1
SPEEDRUN_MODE_RESTART  = 2
SPEEDRUN_MODE_MARATHON  = 3

SPECTATOR_MODE_NORMAL  = 0
SPECTATOR_MODE_FOLLOW  = 1

TEX_NSMB_HIT = get_texture_info("hitbox")

-- local scope variables
local dddisspawned = false
local omm = false
local TEX_ROUNDED_CORNER1 = get_texture_info("cornertl")
local TEX_ROUNDED_CORNER2 = get_texture_info("cornertr")
local TEX_ROUNDED_CORNER3 = get_texture_info("cornerbl")
local TEX_ROUNDED_CORNER4 = get_texture_info("cornerbr")
local flagRotation = 0
local Timer = 0

version = "v1.0"

targetPlayer = 0
musicPack = false

-- global variables
gGlobalSyncTable.roundState = ROUND_STATE_INACTIVE
gGlobalSyncTable.timer = ROUND_COOLDOWN
gGlobalSyncTable.level = 1
gGlobalSyncTable.waterLevel = -20000
gGlobalSyncTable.speedMultiplier = 1
gGlobalSyncTable.coinCount = 4
gGlobalSyncTable.difficulty = 1
gGlobalSyncTable.mapMode = 1
gGlobalSyncTable.popups = true
gGlobalSyncTable.isPermitted = true
-- wish you could use tables with gGlobalSyncTable
gGlobalSyncTable.modif_nsmb = false
gGlobalSyncTable.modif_instakill = false
gGlobalSyncTable.modif_reds = false
gGlobalSyncTable.modif_trollface = false
gGlobalSyncTable.redCoinCounter = 0

-- gLevelValues, to prevent cap stuff as well as pss's star and extend MC time
gLevelValues.metalCapDuration = 1200
gLevelValues.metalCapDurationCotmc  = 1
gLevelValues.vanishCapDurationVcutm = 85
gLevelValues.pssSlideStarTime = 30

if omm == true then
    gGlobalSyncTable.modif_trollface = true
end

-- eFloodVariables
eFloodVariables = {
    isRedFlagSpawned = 0,
    showNotEnoughRedCoinsPopup = false,
    hudHide = false,
    spectatorMode = SPECTATOR_MODE_NORMAL
}

eTrollProperties = {
    skin = E_MODEL_TROLLFACE
}


-- current modifiers
modifiersfe = {}

for i = 0, MAX_PLAYERS - 1 do
    gPlayerSyncTable[i].finished = false
    gPlayerSyncTable[i].time = 0
end

local flagIconPrevPos = { x = 0, y = 0 }

local speedrunner = 0
local customCoinCounter = 0

for mod in pairs(gActiveMods) do
    if gActiveMods[mod].name:find("FECM") then
        musicPack = true
    end
end

function round_start()
    if gGlobalSyncTable.isPermitted == true then
        if omm == true then
            gGlobalSyncTable.speedMultiplier = 3
        end
        if table.contains(modifiersfe, "reds") == true then
            gGlobalSyncTable.speedMultiplier = 0
            gGlobalSyncTable.redCoinCounter = 0
        end
        dddisspawned = false
        eFloodVariables.isRedFlagSpawned = 0
        rcustomcoincounter = 0
        customCoinCounter = 0
        randomnumb = math_random(2)

        if musicPack == false then
            if randomnumb == 1 then
                smlua_audio_utils_replace_sequence(0x51, 17, 85, "bigworld")
            elseif randomnumb == 2 then
                smlua_audio_utils_replace_sequence(0x51, 17, 85, "seaside")
            end
        end

        gGlobalSyncTable.roundState = ROUND_STATE_ACTIVE
        gGlobalSyncTable.timer = if_then_else(gLevels[gGlobalSyncTable.level].level == LEVEL_CTT or (gLevels[gGlobalSyncTable.level].level == LEVEL_RR and game == GAME_STAR_ROAD), 730, 100)
    end
end

local function checker()
    if gGlobalSyncTable.modif_nsmb == true then
        if table.contains(modifiersfe, "nsmb") == false then
            table.insert(modifiersfe, "nsmb")
        end
    end

    if gGlobalSyncTable.modif_nsmb == false then
        if table.contains(modifiersfe, "nsmb") == true then
            local pos = table.poselement(modifiersfe, "nsmb")
            table.remove(modifiersfe, pos)
        end
    end

    if gGlobalSyncTable.modif_instakill == true then
        if table.contains(modifiersfe, "instakill") == false then
            table.insert(modifiersfe, "instakill")
        end
    end

    if gGlobalSyncTable.modif_instakill == false then
        if table.contains(modifiersfe, "instakill") == true then
            local pos = table.poselement(modifiersfe, "instakill")
            table.remove(modifiersfe, pos)
        end
    end

    if gGlobalSyncTable.modif_reds == true then
        if table.contains(modifiersfe, "reds") == false then
            table.insert(modifiersfe, "reds")
        end
    end

    if gGlobalSyncTable.modif_reds == false then
        if table.contains(modifiersfe, "reds") == true then
            local pos = table.poselement(modifiersfe, "reds")
            table.remove(modifiersfe, pos)
        end
    end

    if gGlobalSyncTable.modif_trollface == true then
        if table.contains(modifiersfe, "trollface") == false then
            table.insert(modifiersfe, "trollface")
        end
    end

    if gGlobalSyncTable.modif_trollface == false then
        if table.contains(modifiersfe, "trollface") == true then
            local pos = table.poselement(modifiersfe, "trollface")
            table.remove(modifiersfe, pos)
        end
    end

    if gGlobalSyncTable.modif_pvp == true then
        if table.contains(modifiersfe, "pvp") == false then
            table.insert(modifiersfe, "pvp")
        end
    end

    if gGlobalSyncTable.modif_pvp == false then
        if table.contains(modifiersfe, "pvp") == true then
            local pos = table.poselement(modifiersfe, "pvp")
            table.remove(modifiersfe, pos)
        end
    end
end

local function round_end()
    gGlobalSyncTable.roundState = ROUND_STATE_END
    gGlobalSyncTable.timer = 5 * 30
    gGlobalSyncTable.waterLevel = -20000
    eFloodVariables.birdVariable = 0
end

local function server_update()
    if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
        if gNetworkPlayers[0].currLevelNum == gLevels[gGlobalSyncTable.level].level then
            gGlobalSyncTable.waterLevel = gGlobalSyncTable.waterLevel + gLevels[gGlobalSyncTable.level].speed * gGlobalSyncTable.speedMultiplier

            local active = 0
            for i = 0, (MAX_PLAYERS - 1) do
                local m = gMarioStates[i]
                if active_player(m) ~= 0 and m.health > 0xff and not gPlayerSyncTable[i].finished then
                    active = active + 1
                end
            end

            if active == 0 then
                local dead = 0
                for i = 0, (MAX_PLAYERS) - 1 do
                    if active_player(gMarioStates[i]) ~= 0 and gMarioStates[i].health <= 0xff then
                        dead = dead + 1
                    end
                end

                if dead == network_player_connected_count() or (speedrun_mode() and gNetworkPlayers[0].currLevelNum ~= LEVEL_CTT) then
                    gGlobalSyncTable.timer = 0
                elseif dead == network_player_connected_count() or (speedrun_mode(SPEEDRUN_MODE_MARATHON)) then
                    gGlobalSyncTable.timer = 0
                end

                if gGlobalSyncTable.timer > 0 then
                    gGlobalSyncTable.timer = gGlobalSyncTable.timer - 1
                else
                    round_end()

                    if not speedrun_mode() or speedrun_mode(SPEEDRUN_MODE_PROGRESS) then
                        randomnumb = math_random(2)

                        if musicPack == false then
                            if randomnumb == 1 then
                                smlua_audio_utils_replace_sequence(0x51, 17, 85, "bigworld")
                            else
                                smlua_audio_utils_replace_sequence(0x51, 17, 85, "seaside")
                            end
                        end

                        local finished = 0
                        for i = 0, (MAX_PLAYERS - 1) do
                            if active_player(gMarioStates[i]) ~= 0 and gPlayerSyncTable[i].finished then
                                finished = finished + 1
                            end
                        end

                        if finished ~= 0 then
                            -- calculate position

                            if gGlobalSyncTable.isPermitted == true then
                                gGlobalSyncTable.level = gGlobalSyncTable.level + 1
                                if gGlobalSyncTable.level > FLOOD_LEVEL_COUNT - FLOOD_BONUS_LEVELS then
                                    gGlobalSyncTable.level = 1
                                end
                            end
                        end
                    elseif speedrun_mode(SPEEDRUN_MODE_MARATHON) then
                        randomnumb = math_random(2)

                        if musicPack == false then
                            if randomnumb == 1 then
                                smlua_audio_utils_replace_sequence(0x51, 17, 85, "bigworld")
                            else
                                smlua_audio_utils_replace_sequence(0x51, 17, 85, "seaside")
                            end
                        end

                        local finished = 0
                        for i = 0, (MAX_PLAYERS - 1) do
                            if active_player(gMarioStates[i]) ~= 0 and gPlayerSyncTable[i].finished then
                                finished = finished + 1
                            end
                        end

                        if finished ~= 0 then
                            -- calculate position

                            if gGlobalSyncTable.isPermitted == true then
                                gGlobalSyncTable.level = gGlobalSyncTable.level + 1
                                if gGlobalSyncTable.level > FLOOD_LEVEL_COUNT then
                                    gGlobalSyncTable.level = 1
                                end
                            end
                        end
                    end
                end
            end
        end
    elseif gGlobalSyncTable.roundState == ROUND_STATE_INACTIVE then
        if network_player_connected_count() > 1 then
            if gGlobalSyncTable.timer > 0 then
                gGlobalSyncTable.timer = gGlobalSyncTable.timer - 1

                if gGlobalSyncTable.timer == 30 or gGlobalSyncTable.timer == 60 or gGlobalSyncTable.timer == 90 then
                    play_sound(SOUND_MENU_CHANGE_SELECT, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                elseif gGlobalSyncTable.timer == 11 then
                    play_sound(SOUND_GENERAL_RACE_GUN_SHOT, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                end
            end
            
            if gGlobalSyncTable.timer == 1 then
                if gGlobalSyncTable.mapMode == 0 then
                    round_start()
                elseif gGlobalSyncTable.mapMode == 1 then
                    gGlobalSyncTable.level = math_random(#gLevels)

                    round_start()
                elseif gGlobalSyncTable.mapMode == 2 then
                    host_init_voting_timer()
                end
            end
        end
    elseif gGlobalSyncTable.roundState == ROUND_STATE_END then
        if gGlobalSyncTable.timer > 0 then
            gGlobalSyncTable.timer = gGlobalSyncTable.timer - 1
        else
            gGlobalSyncTable.timer = ROUND_COOLDOWN
            gGlobalSyncTable.roundState = ROUND_STATE_INACTIVE
        end
    end
end

function speedrun_mode(mode)
    if mode == nil then
        return speedrunner > 0 and network_player_connected_count() == 1
    else
        return speedrunner == mode and network_player_connected_count() == 1
    end
end

-- runs serverside

local function on_rando_command()
    gGlobalSyncTable.level = math_random(#gLevels)
    round_start()
    return true
end

local function get_dest_act()
    if game ~= GAME_STAR_ROAD then
        return if_then_else(gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE_GROUNDS, 99, 6)
    else
        if gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE_GROUNDS then
            return 99
        end
        return if_then_else(gNetworkPlayers[0].currLevelNum == LEVEL_BBH or LEVEL_CCM, 1, 6)
    end
end

local function get_modifiers_string()
    if not cheats and not moveset then return "" end

    local modifiers = " ("
    if moveset then
        modifiers = modifiers .. "Moveset"
    else
        modifiers = modifiers .. "No moveset"
    end
    if cheats then
        modifiers = modifiers .. ", cheats"
    end
    modifiers = modifiers .. ")"
    return modifiers
end

function level_restart()
    if gGlobalSyncTable.isPermitted == true then
        round_start()
        init_single_mario(gMarioStates[0])
        mario_set_full_health(gMarioStates[0])
        gPlayerSyncTable[0].time = 0
        warp_to_level(gLevels[gGlobalSyncTable.level].level, gLevels[gGlobalSyncTable.level].area, get_dest_act())
        eFloodVariables.isRedFlagSpawned = 0
        if table.contains(modifiersfe, "reds") == true then
            gGlobalSyncTable.speedMultiplier = 0
            gGlobalSyncTable.redCoinCounter = 0
        end
        customCoinCounter = 0
    end
end

local function update()
    --gLevels[gGlobalSyncTable.level].level == LEVEL_CCM and gLevels[gGlobalSyncTable.level].area == 2
    --if gLevels[gGlobalSyncTable.level].level == LEVEL_PSS or or
    --gLevels[gGlobalSyncTable.level].level == LEVEL_CS and

    if gGlobalSyncTable.roundState == ROUND_STATE_INACTIVE and not network_is_server() then
        --djui_chat_message_create("1")
        if gGlobalSyncTable.timer == 1 and not gGlobalSyncTable.map_deciding then
            --djui_chat_message_create("2")
            if gGlobalSyncTable.mapMode == 2 then
                --djui_chat_message_create("3")
                init_voting_menu()
            end
        end
    end

    if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
        if gLevels[gGlobalSyncTable.level].level == LEVEL_DDD and gNetworkPlayers[0].currAreaIndex == 2 and dddisspawned == false then
            local pos = gLevels[gGlobalSyncTable.level].goalPos
            spawn_non_sync_object(
                id_bhvFloodFlag,
                E_MODEL_KOOPA_FLAG,
                pos.x, pos.y + 100, pos.z,
                --- @param o Object
                function(o)
                    o.oFaceAnglePitch = 0
                    o.oFaceAngleYaw = pos.a
                    o.oFaceAngleRoll = 0
                end
            )
            spawn_non_sync_object(
                id_bhvBasePlatform,
                E_MODEL_BASE,
                pos.x, pos.y, pos.z,
                --- @param o Object
                function(o)
                    o.oFaceAnglePitch = 0
                    o.oFaceAngleYaw = 0
                    o.oFaceAngleRoll = 0
                end
            )
            spawn_non_sync_object(
                id_bhvWater,
                E_MODEL_FLOOD,
                0, gGlobalSyncTable.waterLevel, 0,
                nil
            )
            dddisspawned = true
        end

        if gGlobalSyncTable.modif_reds == true then
            if gGlobalSyncTable.redCoinCounter * 4 >= 8 then
                obj_mark_for_deletion(redflag)
                    if eFloodVariables.isRedFlagSpawned == 0 then
                        local pos = gLevels[gGlobalSyncTable.level].goalPos
                        spawn_non_sync_object(
                            id_bhvFloodFlag,
                            E_MODEL_KOOPA_FLAG,
                            pos.x, pos.y, pos.z,
                            --- @param o Object
                            function(o)
                                o.oFaceAnglePitch = 0
                                o.oFaceAngleYaw = pos.a
                                o.oFaceAngleRoll = 0
                            end
                        )
                    end
                eFloodVariables.isRedFlagSpawned = 1
            end
        end
    end

    if network_is_server() then server_update() end

    if gGlobalSyncTable.roundState == ROUND_STATE_INACTIVE
    or gGlobalSyncTable.roundState == ROUND_STATE_END then
        obj_mark_for_deletion(trollface)
        if gNetworkPlayers[0].currLevelNum ~= LEVEL_LOBBY or gNetworkPlayers[0].currActNum ~= 0 then
            if speedrun_mode() then
                level_restart()
            end

            warp_to_level(LEVEL_LOBBY, 1, 0)
            gGlobalSyncTable.redCoinCounter = 0
            if table.contains(modifiersfe, "reds") == true then
                gGlobalSyncTable.speedMultiplier = 0
            end

            gServerSettings.playerInteractions = PLAYER_INTERACTIONS_PVP
        end
    elseif gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
        local act = get_dest_act()

        if gNetworkPlayers[0].currLevelNum ~= gLevels[gGlobalSyncTable.level].level or gNetworkPlayers[0].currActNum ~= act then
            mario_set_full_health(gMarioStates[0])
            gPlayerSyncTable[0].time = 0
            gPlayerSyncTable[0].finished = false
            warp_to_level(gLevels[gGlobalSyncTable.level].level, gLevels[gGlobalSyncTable.level].area, act)
        end
        return checker()
    end

    -- stops the star spawn cutscenes from happening
    local m = gMarioStates[0]
    if m.area ~= nil and m.area.camera ~= nil and (m.area.camera.cutscene == CUTSCENE_STAR_SPAWN or m.area.camera.cutscene == CUTSCENE_RED_COIN_STAR_SPAWN) then
        m.area.camera.cutscene = 0
        m.freeze = 0
        disable_time_stop_including_mario()
    end
end

--- @param m MarioState
local function before_mario_update(m)
    if m.playerIndex ~= 0 then return end
    
    if network_player_connected_count() == 1 
    and (gGlobalSyncTable.roundState == ROUND_STATE_INACTIVE 
    or gGlobalSyncTable.roundState == ROUND_STATE_END) then
        if m.controller.buttonDown & START_BUTTON ~= 0
        and m.controller.buttonDown & A_BUTTON ~= 0 then
            if gGlobalSyncTable.mapMode == 0 then
                round_start()
            elseif gGlobalSyncTable.mapMode == 1 then
                gGlobalSyncTable.level = math_random(#gLevels)

                round_start()
            elseif gGlobalSyncTable.mapMode == 2 then
                djui_chat_message_create("This mapmode is incompatible with quick-start. Try changing your mapmode.")
            end
            m.controller.buttonPressed = 0
        end
    end
end

--- @param m MarioState
local function mario_update(m)
    if m.health > 0xff then
        network_player_set_description(gNetworkPlayers[m.playerIndex], "Alive", 75, 255, 75, 255)
    else
        network_player_set_description(gNetworkPlayers[m.playerIndex], "Dead", 255, 75, 75, 255)
    end

    if m.playerIndex ~= 0 then return end

    -- action specific modifications
    if m.action == ACT_STEEP_JUMP then
        m.action = ACT_JUMP
    elseif m.action == ACT_JUMBO_STAR_CUTSCENE then
        m.flags = m.flags | MARIO_WING_CAP
    end

    -- disable instant warps
    if m.floor ~= nil and gLevels[gGlobalSyncTable.level].level ~= LEVEL_DDD and (m.floor.type == SURFACE_WARP or (m.floor.type >= SURFACE_PAINTING_WARP_D3 and m.floor.type <= SURFACE_PAINTING_WARP_FC) or (m.floor.type >= SURFACE_INSTANT_WARP_1B and m.floor.type <= SURFACE_INSTANT_WARP_1E)) then
        m.floor.type = SURFACE_DEFAULT
    end

    -- disable insta kills
    if m.floor ~= nil and (m.floor.type == SURFACE_INSTANT_QUICKSAND or m.floor.type == SURFACE_INSTANT_MOVING_QUICKSAND) then
        m.floor.type = SURFACE_BURNING
    end

    -- disable damage in lobby
    if gGlobalSyncTable.roundState == ROUND_STATE_INACTIVE
    or gGlobalSyncTable.roundState == ROUND_STATE_END then
        mario_set_full_health(m)
        m.peakHeight = m.pos.y
        return
    end

    -- dialog boxes
    if (m.action == ACT_SPAWN_NO_SPIN_AIRBORNE or m.action == ACT_SPAWN_NO_SPIN_LANDING or m.action == ACT_SPAWN_SPIN_AIRBORNE or m.action == ACT_SPAWN_SPIN_LANDING) and m.pos.y < m.floorHeight + 10 then
        set_mario_action(m, ACT_FREEFALL, 0)
    end

    -- manage CTT
    if gNetworkPlayers[0].currLevelNum == LEVEL_CTT then
        m.peakHeight = m.pos.y

        local star = obj_get_first_with_behavior_id(id_bhvFinalStar)
        if star ~= nil and obj_check_hitbox_overlap(m.marioObj, star)
        and m.action ~= ACT_JUMBO_STAR_CUTSCENE
        and m.health > 0xFF then
            spawn_mist_particles()
            set_mario_action(m, ACT_JUMBO_STAR_CUTSCENE, 0)
        end

        if m.action == ACT_JUMBO_STAR_CUTSCENE and m.actionTimer >= 499 then
            set_mario_spectator(m)
        end
    end

    -- Removes item boxes and warp pipes if the level is not a level that is construct or birdslair
    local block = obj_get_first_with_behavior_id(id_bhvExclamationBox)
    local warppipe = obj_get_first_with_behavior_id(id_bhvWarpPipe)
    if gNetworkPlayers[0].currLevelNum ~= 52 then
        while block do
            obj_mark_for_deletion(block)
            block = obj_get_next_with_same_behavior_id(block)
        end
    end

    if gNetworkPlayers[0].currLevelNum ~= 53 then
        while warppipe do
            obj_mark_for_deletion(warppipe)
            warppipe = obj_get_next_with_same_behavior_id(warppipe)
        end
    end

    -- check if the player has reached the end of the level
    if gNetworkPlayers[0].currLevelNum == gLevels[gGlobalSyncTable.level].level and not gPlayerSyncTable[0].finished and ((gNetworkPlayers[0].currLevelNum ~= LEVEL_CTT and m.pos.y == m.floorHeight)
    or ((gNetworkPlayers[0].currLevelNum == LEVEL_CTT and m.action == ACT_JUMBO_STAR_CUTSCENE) or (gNetworkPlayers[0].currLevelNum == LEVEL_CTT and speedrun_mode(SPEEDRUN_MODE_MARATHON) == true)) or (m.action & ACT_FLAG_ON_POLE) ~= 0)
    and vec3f_dist(m.pos, gLevels[gGlobalSyncTable.level].goalPos) < 755
    and m.health > 0xFF then
        if table.contains(modifiersfe, "reds") == false then
            if m.playerIndex ~= 0 then return end

            gPlayerSyncTable[0].finished = true
        
            if gGlobalSyncTable.popups == true then
                djui_popup_create_global(network_get_player_text_color_string(0) .. gNetworkPlayers[0].name .. "\\#ffffff\\ finished, Time: " .. string.format("%.3f", gPlayerSyncTable[0].time / 30), 1)
            end
        
            local string = ""
            if gNetworkPlayers[0].currLevelNum ~= LEVEL_CTT and not (game == GAME_STAR_ROAD and gNetworkPlayers[0].currLevelNum == LEVEL_RR) then
                string = string .. "\\#00ff00\\You escaped the flood!\n"
                play_race_fanfare()
            else
                if speedrun_mode(SPEEDRUN_MODE_MARATHON) then
                    string = string .. "\\#00ff00\\You escaped the \\#ffff00\\final\\#00ff00\\ flood.. If only it wasn't Marathon Mode!\n"
                else
                    string = string .. "\\#00ff00\\You escaped the \\#ffff00\\final\\#00ff00\\ flood! Congratulations!\n"
                    play_music(0, SEQUENCE_ARGS(8, SEQ_EVENT_CUTSCENE_VICTORY), 0)
                end
            end
            string = string .. "\\#ffffff\\Time: " .. string.format("%.3f", gPlayerSyncTable[0].time / 30) .. get_modifiers_string()
        else
            if m.playerIndex ~= 0 then return end

            if gGlobalSyncTable.redCoinCounter * 4 == 8 then
                gPlayerSyncTable[0].finished = true
            
                if gGlobalSyncTable.popups == true then
                    djui_popup_create_global(network_get_player_text_color_string(0) .. gNetworkPlayers[0].name .. "\\#ffffff\\ finished, Time: " .. string.format("%.3f", gPlayerSyncTable[0].time / 30), 1)
                end

                local string = ""
                if gNetworkPlayers[0].currLevelNum ~= LEVEL_CTT and not (game == GAME_STAR_ROAD and gNetworkPlayers[0].currLevelNum == LEVEL_RR) then
                    string = string .. "\\#00ff00\\You escaped the flood!\n"
                    play_race_fanfare()
                else
                    if speedrun_mode(SPEEDRUN_MODE_MARATHON) then
                        string = string .. "\\#00ff00\\You escaped the \\#ffff00\\final\\#00ff00\\ flood.. If only it wasn't Marathon Mode!\n"
                    else
                        string = string .. "\\#00ff00\\You escaped the \\#ffff00\\final\\#00ff00\\ flood! Congratulations!\n"
                        play_music(0, SEQUENCE_ARGS(8, SEQ_EVENT_CUTSCENE_VICTORY), 0)
                    end
                end
                string = string .. "\\#ffffff\\Time: " .. string.format("%.3f", gPlayerSyncTable[0].time / 30) .. get_modifiers_string()
            else
                if eFloodVariables.showNotEnoughRedCoinsPopup then
                    djui_chat_message_create("You dont have the required amount of red coins to pass, The current amount of red coins is " .. gGlobalSyncTable.redCoinCounter * 4)
                    eFloodVariables.showNotEnoughRedCoinsPopup = false
                end
            end
        end
    end

    if vec3f_dist(m.pos, gLevels[gGlobalSyncTable.level].goalPos) > 760 then
        if not eFloodVariables.showNotEnoughRedCoinsPopup then
            eFloodVariables.showNotEnoughRedCoinsPopup = true
        end
    end

    -- update spectator if finished, manage other things if not
    if gPlayerSyncTable[0].finished then
        mario_set_full_health(m)
        if network_player_connected_count() > 1
        and m.action ~= ACT_JUMBO_STAR_CUTSCENE
        and gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
            set_mario_spectator(m)
        end
    else
        if m.pos.y + 40 < gGlobalSyncTable.waterLevel then
            if table.contains(modifiersfe, "instakill") == true then
                if (m.flags & MARIO_METAL_CAP) ~= 0 then

                elseif (m.flags & MARIO_VANISH_CAP ) ~= 0 then
                    m.health = m.health - 512
                else
                    m.health = m.health - 512
                end
            else
                if (m.flags & MARIO_METAL_CAP) ~= 0 then

                elseif (m.flags & MARIO_VANISH_CAP ) ~= 0 then
                    m.health = m.health - 8 * gGlobalSyncTable.difficulty
                else
                    m.health = m.health - 32 * gGlobalSyncTable.difficulty
                end
            end
        end

        if m.action == ACT_QUICKSAND_DEATH then
            m.health = 0xff
        end

        if m.health <= 0xff then
            if  network_player_connected_count() > 1
            and gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
                m.area.camera.cutscene = 0
                set_mario_spectator(m)
            end
        else
            gPlayerSyncTable[0].time = gPlayerSyncTable[0].time + 1
        end
    end
end

-- Detección de Meta
if gNetworkPlayers[0].currLevelNum == gLevels[gGlobalSyncTable.level].level and not gPlayerSyncTable[0].finished then
    if vec3f_dist(m.pos, gLevels[gGlobalSyncTable.level].goalPos) < 498 and m.health > 0xFF then
        gPlayerSyncTable[0].finished = true
        if gGlobalSyncTable.popups then
            djui_popup_create_global(
                "\\#00ff00\\You Won! Time: " ..
                string.format("%.3f", gPlayerSyncTable[0].time / 30), 2)
            play_race_fanfare()
        end
    end
end

local function on_hud_render()
    local water = obj_get_first_with_behavior_id(id_bhvWater)
    if gNetworkPlayers[0].currLevelNum == gLevels[gGlobalSyncTable.level].level and water ~= nil then -- LEVEL 52 + 36 VOTING ERROR
        djui_hud_set_resolution(RESOLUTION_DJUI)
        if gLakituState.pos.y < gGlobalSyncTable.waterLevel + 2 then
            switch(water.oAnimState, {
                [FLOOD_WATER] = function()
                    djui_hud_set_adjusted_color(0, 20, 200, 175)
                end,
                [FLOOD_LAVA] = function()
                    djui_hud_set_adjusted_color(200, 0, 0, 175)
                end,
                [FLOOD_SAND] = function()
                    djui_hud_set_adjusted_color(254, 193, 121, 230)
                end,
                [FLOOD_MUD] = function()
                    djui_hud_set_adjusted_color(128, 71, 34, 240)
                end,
                [FLOOD_SNOW] = function()
                    djui_hud_set_adjusted_color(255, 255, 255, 220)
                end,
                [FLOOD_WASTE] = function()
                    djui_hud_set_adjusted_color(74, 123, 0, 220)
                end,
                [FLOOD_DESERT] = function()
                    djui_hud_set_adjusted_color(254, 193, 121, 230)
                end,
                [FLOOD_ACID] = function()
                    djui_hud_set_adjusted_color(0, 142, 36, 190)
                end,
                [FLOOD_POISON] = function()
                    djui_hud_set_adjusted_color(174, 0, 255, 190)
                end,
                [FLOOD_SUNSET] = function()
                    djui_hud_set_adjusted_color(235, 164, 0, 200)
                end,
                [FLOOD_FROSTBITE] = function()
                    djui_hud_set_adjusted_color(126, 197, 249, 200)
                end,
                [FLOOD_CLOUDS] = function()
                    djui_hud_set_adjusted_color(255, 255, 255, 200)
                end,
                [FLOOD_RAINBOW] = function()
                    djui_hud_set_adjusted_color(244, 140, 253, 230)
                end,
                [FLOOD_DARKNESS] = function()
                    djui_hud_set_adjusted_color(0, 0, 0, 200)
                end,
                [FLOOD_MAGMA] = function()
                    djui_hud_set_adjusted_color(237, 0, 0, 220)
                end,
                [FLOOD_SULFUR] = function()
                    djui_hud_set_adjusted_color(0, 20, 167, 220)
                end,
                [FLOOD_COTTON] = function()
                    djui_hud_set_adjusted_color(255, 181, 225, 220)
                end,
                [FLOOD_MOLTEN] = function()
                    djui_hud_set_adjusted_color(225, 106, 19, 220)
                end,
                [FLOOD_OIL] = function()
                    djui_hud_set_adjusted_color(0, 0, 0, 200)
                end,
                [FLOOD_MATRIX] = function()
                    djui_hud_set_adjusted_color(16, 71, 0, 200)
                end,
                [FLOOD_BUP] = function()
                    djui_hud_set_adjusted_color(254, 193, 121, 200)
                end,
                [FLOOD_TIDE] = function()
                    djui_hud_set_adjusted_color(15, 122, 211, 200)
                end,
                [FLOOD_DARKTIDE] = function()
                    djui_hud_set_adjusted_color(15, 75, 124, 200)
                end,
                [FLOOD_VOLCANO] = function()
                    djui_hud_set_adjusted_color(252, 30, 30, 200)
                end,
                [FLOOD_REDTIDE] = function()
                    djui_hud_set_adjusted_color(211, 12, 35, 200)
                end,
                [FLOOD_OPTIC] = function()
                    djui_hud_set_adjusted_color(146, 0, 132, 200)
                end
            })
            djui_hud_render_rect(0, 0, djui_hud_get_screen_width(), djui_hud_get_screen_height())
            set_lighting_dir(1,128)
        else
            set_lighting_dir(1,0)
        end
    end

    if eFloodVariables.hudHide == false then
        if gGlobalSyncTable.roundState == ROUND_STATE_INACTIVE
        or gGlobalSyncTable.roundState == ROUND_STATE_END then
            set_lighting_dir(1,0)
        end
        djui_hud_set_resolution(RESOLUTION_N64)
djui_hud_set_font(FONT_TINY)

Timer = Timer + 1
local level = gLevels[gGlobalSyncTable.level]

if level ~= nil and level.name ~= "ctt"
or level ~= nil and speedrun_mode(SPEEDRUN_MODE_MARATHON) == true then

    local out = { x = 0, y = 0, z = 0 }
    djui_hud_world_pos_to_screen_pos(level.goalPos, out)

    local dX = clampf(out.x, 0, djui_hud_get_screen_width())
    local dY = clampf(out.y, 0, djui_hud_get_screen_height())

    -- rgb
    local r = 200 + math.sin(Timer * 0.1) * 55
    local g = 200 + math.sin(Timer * 0.13) * 55
    local b = 200 + math.sin(Timer * 0.16) * 55

    djui_hud_set_adjusted_color(r, g, b, 200)

    -- rotate
    flagRotation = (flagRotation + 0x300) % 0x10000
    djui_hud_set_rotation(flagRotation, 0.5, 0.5)

    djui_hud_render_texture_interpolated(
        TEX_NSMB_HIT,
        flagIconPrevPos.x - 8, flagIconPrevPos.y - 8, 0.5, 0.5,
        dX - 8, dY - 8, 0.5, 0.5
    )

    -- reset state
    djui_hud_set_rotation(0, 0, 0)
    djui_hud_set_adjusted_color(255, 255, 255, 255)

    flagIconPrevPos.x = dX
    flagIconPrevPos.y = dY
end

        local text = if_then_else(gGlobalSyncTable.roundState == ROUND_STATE_INACTIVE, 'Type "/flood start" or press [Start] + [A] to start a round', "0.000 seconds" .. get_modifiers_string())
        if gNetworkPlayers[0].currAreaSyncValid then
            if gGlobalSyncTable.roundState == ROUND_STATE_INACTIVE then
                if gGlobalSyncTable.mapMode == 2 then
                    if network_player_connected_count() > 1 then
                        text = if_then_else(network_player_connected_count() > 1, "Voting starts in " .. tostring(math_floor(gGlobalSyncTable.timer / 30)), 'Type "/flood start" or press [Start] + [A] to start a round')
                    end
                else
                    text = if_then_else(network_player_connected_count() > 1, "Round starts in " .. tostring(math_floor(gGlobalSyncTable.timer / 30)), 'Type "/flood start" or press [Start] + [A] to start a round')
                end
            elseif gGlobalSyncTable.roundState == ROUND_STATE_END then
                text = "Intermision"
                text = if_then_else(network_player_connected_count() > 1, "Intermision", 'Round is ending.')
            elseif gNetworkPlayers[0].currLevelNum == gLevels[gGlobalSyncTable.level].level then
                text = tostring(string.format("%.3f", gPlayerSyncTable[0].time / 30)) .. " seconds" .. get_modifiers_string()
            end
        end

        local padding = 6
        local txtscale = 1
        local textWidth = djui_hud_measure_text(text) * txtscale
        local boxW = textWidth + padding * 2
        local boxH = 24
        local boxX = (djui_hud_get_screen_width() - boxW) * 0.5
        local boxY = 0
        local cornerSize = 12
        local scale = cornerSize / TEX_ROUNDED_CORNER1.width

-- Fondo central
djui_hud_set_adjusted_color(0, 0, 0, 200)
djui_hud_render_rect(boxX + cornerSize, boxY + cornerSize, boxW - cornerSize*2, boxH - cornerSize*2)

-- Bordes laterales
djui_hud_render_rect(boxX, boxY + cornerSize, cornerSize, boxH - cornerSize*2)
djui_hud_render_rect(boxX + boxW - cornerSize, boxY + cornerSize, cornerSize, boxH - cornerSize*2)

-- Bordes superior e inferior
djui_hud_render_rect(boxX + cornerSize, boxY, boxW - cornerSize*2, cornerSize)
djui_hud_render_rect(boxX + cornerSize, boxY + boxH - cornerSize, boxW - cornerSize*2, cornerSize)

-- Esquinas redondeadas
djui_hud_set_adjusted_color(0, 0, 0, 200)
djui_hud_render_texture(TEX_ROUNDED_CORNER1, boxX, boxY, scale, scale) -- superior izquierda
djui_hud_render_texture(TEX_ROUNDED_CORNER2, boxX + boxW - cornerSize, boxY, scale, scale) -- superior derecha
djui_hud_render_texture(TEX_ROUNDED_CORNER3, boxX, boxY + boxH - cornerSize, scale, scale) -- inferior izquierda
djui_hud_render_texture(TEX_ROUNDED_CORNER4, boxX + boxW - cornerSize, boxY + boxH - cornerSize, scale, scale) -- inferior derecha

-- Texto
djui_hud_set_adjusted_color(255,255,255,255)
djui_hud_print_text(text, boxX + padding, boxY + 4, txtscale)

hud_render_power_meter(gMarioStates[0].health, djui_hud_get_screen_width() - 64, 0, 64, 64)

-- =======================
-- Speed Multiplier Box
-- =======================
if gGlobalSyncTable.speedMultiplier ~= 1 then
    local speedtex = string.format("%.2fx", gGlobalSyncTable.speedMultiplier)
    local scaleSpeed = 0.5
    local paddingS = 4

    local textWidthS = djui_hud_measure_text(speedtex) * scaleSpeed
    local boxSW = textWidthS + paddingS * 2
    local boxSH = 18

    local boxSX = (djui_hud_get_screen_width() - boxSW) * 0.5
    local boxSY = 20

    -- Corner propio del speed (no usa el de arriba)
    local cornerSizeS = 9
    local scaleS = cornerSizeS / TEX_ROUNDED_CORNER1.width

    djui_hud_set_adjusted_color(32, 16, 75, 128)

    -- Centro
    djui_hud_render_rect(
        boxSX + cornerSizeS,
        boxSY + cornerSizeS,
        boxSW - cornerSizeS*2,
        boxSH - cornerSizeS*2
    )

    -- Lados
    djui_hud_render_rect(boxSX, boxSY + cornerSizeS, cornerSizeS, boxSH - cornerSizeS*2)
    djui_hud_render_rect(boxSX + boxSW - cornerSizeS, boxSY + cornerSizeS, cornerSizeS, boxSH - cornerSizeS*2)

    -- Arriba y abajo
    djui_hud_render_rect(boxSX + cornerSizeS, boxSY, boxSW - cornerSizeS*2, cornerSizeS)
    djui_hud_render_rect(boxSX + cornerSizeS, boxSY + boxSH - cornerSizeS, boxSW - cornerSizeS*2, cornerSizeS)

    -- Esquinas
    djui_hud_render_texture(TEX_ROUNDED_CORNER1, boxSX, boxSY, scaleS, scaleS)
    djui_hud_render_texture(TEX_ROUNDED_CORNER2, boxSX + boxSW - cornerSizeS, boxSY, scaleS, scaleS)
    djui_hud_render_texture(TEX_ROUNDED_CORNER3, boxSX, boxSY + boxSH - cornerSizeS, scaleS, scaleS)
    djui_hud_render_texture(TEX_ROUNDED_CORNER4, boxSX + boxSW - cornerSizeS, boxSY + boxSH - cornerSizeS, scaleS, scaleS)

    -- Texto
    djui_hud_set_adjusted_color(255, 255, 255, 255)
    djui_hud_print_text(speedtex, boxSX + paddingS, boxSY + 4, scaleSpeed)
end

        if gGlobalSyncTable.roundState ~= ROUND_STATE_INACTIVE then -- also EmeraldLoc, please fix this area below, this is very VERY crappy
            if gLevels[gGlobalSyncTable.level].area == 1 then
                if gNetworkPlayers[0].currLevelNum ~= LEVEL_CTT and gNetworkPlayers[0].currLevelNum ~= LEVEL_SL and gNetworkPlayers[0].currLevelNum ~= LEVEL_WMOTR then
                    textlv1 = get_level_name(gNetworkPlayers[0].currCourseNum, gNetworkPlayers[0].currLevelNum, gNetworkPlayers[0].currAreaIndex)
                elseif gNetworkPlayers[0].currLevelNum == LEVEL_CTT then
                    textlv1 = "Climb The Tower"
                elseif gNetworkPlayers[0].currLevelNum == LEVEL_SL then
                    textlv1 = "Underground Platforms"
                elseif gNetworkPlayers[0].currLevelNum == LEVEL_WMOTR then
                    textlv1 = "Freezing Cold Slopes"
                end
                textlv2 = levelinfo[gNetworkPlayers[0].currLevelNum].author
            else
                textlv1 = " "
                textlv2 = " "
            end

            if gLevels[gGlobalSyncTable.level].area == 2 then
                if gLevels[gGlobalSyncTable.level].level == LEVEL_CCM or gLevels[gGlobalSyncTable.level].level == LEVEL_TTM then
                    textlv1 = get_level_name(gNetworkPlayers[0].currCourseNum, gNetworkPlayers[0].currLevelNum, gNetworkPlayers[0].currAreaIndex) .. " (Slide)"
                    textlv2 = levelinfo[gNetworkPlayers[0].currLevelNum].author
                elseif gLevels[gGlobalSyncTable.level].level == LEVEL_LLL then
                    textlv1 = get_level_name(gNetworkPlayers[0].currCourseNum, gNetworkPlayers[0].currLevelNum, gNetworkPlayers[0].currAreaIndex) .. " (Volcano)"
                    textlv2 = levelinfo[gNetworkPlayers[0].currLevelNum].author
                elseif gLevels[gGlobalSyncTable.level].level == LEVEL_SSL then
                    textlv1 = get_level_name(gNetworkPlayers[0].currCourseNum, gNetworkPlayers[0].currLevelNum, gNetworkPlayers[0].currAreaIndex) .. " (Pyramid)"
                    textlv2 = levelinfo[gNetworkPlayers[0].currLevelNum].author
                elseif  gLevels[gGlobalSyncTable.level].level == LEVEL_THI then
                    textlv1 = get_level_name(gNetworkPlayers[0].currCourseNum, gNetworkPlayers[0].currLevelNum, gNetworkPlayers[0].currAreaIndex) .. " (Small)"
                    textlv2 = levelinfo[gNetworkPlayers[0].currLevelNum].author
                elseif  gLevels[gGlobalSyncTable.level].level == LEVEL_JRB then
                    textlv1 = get_level_name(gNetworkPlayers[0].currCourseNum, gNetworkPlayers[0].currLevelNum, gNetworkPlayers[0].currAreaIndex) .. " (Ship)"
                    textlv2 = levelinfo[gNetworkPlayers[0].currLevelNum].author
                else
                    textlv1 = get_level_name(gNetworkPlayers[0].currCourseNum, gNetworkPlayers[0].currLevelNum, gNetworkPlayers[0].currAreaIndex)
                    textlv2 = levelinfo[gNetworkPlayers[0].currLevelNum].author
                end
            end

            if gLevels[gGlobalSyncTable.level].area == 3 then
                if gLevels[gGlobalSyncTable.level].level == LEVEL_THI then
                    textlv1 = get_level_name(gNetworkPlayers[0].currCourseNum, gNetworkPlayers[0].currLevelNum, gNetworkPlayers[0].currAreaIndex) .. " (Cave)"
                    textlv2 = levelinfo[gNetworkPlayers[0].currLevelNum].author
                else
                    textlv1 = get_level_name(gNetworkPlayers[0].currCourseNum, gNetworkPlayers[0].currLevelNum, gNetworkPlayers[0].currAreaIndex)
                    textlv2 = levelinfo[gNetworkPlayers[0].currLevelNum].author
                end
            end
        else
            textlv1 = " "
            textlv2 = " "
        end

        djui_hud_set_resolution(RESOLUTION_N64);
        djui_hud_set_font(FONT_MENU)
        if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
            djui_hud_print_text(textlv1, 16, 8, 0.20)
            djui_hud_print_text("by ", 16, 18, 0.15)
            local r, g, b = 0, 0, 0
            if textlv2 == "Birdekek" then
                r, g, b = 62, 110, 255
            elseif textlv2 == "Agent X" then
                r, g, b = 222, 130, 44
            elseif textlv2 == "Nintendo" then
                r, g, b = 196, 47, 47
            elseif textlv2 == "Error" then
                r, g, b = 196, 47, 47
            elseif textlv2 == "Blocky.cmd" then
                r, g, b = 0, 0, 150
            elseif textlv2 == "zMarioRayo" then
                r, g, b = 0, 0, 150
            elseif textlv2 == "Skelux" then
                r, g, b = 156, 255, 145
            end
            djui_hud_set_adjusted_color(r, g, b, 255)
            djui_hud_print_text("    " .. textlv2, 16, 18, 0.15)
            djui_hud_set_adjusted_color(255, 255, 255, 255)
        end

        hud_hide()

        m = gMarioStates[0]
        if m.action == ACT_FOLLOW_SPECTATOR then
            djui_hud_set_font(FONT_MENU)
            scale = 0.2
            text = "< " .. string_without_hex(gNetworkPlayers[targetPlayer].name) .. " >"
            local measureText = djui_hud_measure_text(text)
            x = (djui_hud_get_screen_width() - measureText * scale) / 2
            y = djui_hud_get_screen_height() - 100 * scale
            djui_hud_set_adjusted_color(220, 220, 220, 255)
            djui_hud_print_text(text, x, y, scale)
        end
    end
end

local function on_speed_command(msg)
    local speed = tonumber(msg)

    if omm == false then
        if speed ~= nil then
            speed = clampf(speed, -8, 8)
            djui_chat_message_create("Water speed set to " .. speed)
            gGlobalSyncTable.speedMultiplier = speed

            if gGlobalSyncTable.popups == true then
                djui_popup_create_global("Flood Speed changed to " .. speed .. "x", 1)
            end

            return true
        end
    else
        djui_chat_message_create("Flood speed cannot be changed right now, Try disabiling OMM first.")
        if gGlobalSyncTable.popups == true then
            djui_popup_create_global("Flood Speed was tried to be changed to " .. speed .. "x", 1)
        end
    end

    djui_chat_message_create("/flood \\#00ffff\\speed\\#ffff00\\ [number]\\#ffffff\\\nSets the speed multiplier of the flood")
    return true
end

local function on_info_command(msg)
    djui_chat_message_create("\\#7687cf\\Flood (Expanded) Info")
    djui_chat_message_create("      \\#3e5f9c\\[mapmode]")
    if gGlobalSyncTable.mapMode == 1 then
        djui_chat_message_create("            \\#354d7a\\mapmode: random")
    else
        djui_chat_message_create("            \\#354d7a\\mapmode: default")
    end
    djui_chat_message_create("      \\#3e5f9c\\[modifiers]")
    if table.contains(modifiersfe, "nsmb") == true then
        djui_chat_message_create("            \\#354d7a\\modifier: nsmb")
    end
    if table.contains(modifiersfe, "instakill") == true then
        djui_chat_message_create("            \\#354d7a\\modifier: instakill")
    end
    if table.contains(modifiersfe, "reds") == true then
        djui_chat_message_create("            \\#354d7a\\modifier: reds")
    end
    if table.contains(modifiersfe, "trollface") == true then
        djui_chat_message_create("            \\#354d7a\\modifier: trollface")
    end
    if table.contains(modifiersfe, "pvp") == true then
        djui_chat_message_create("            \\#354d7a\\modifier: pvp")
    end
    if table.contains(modifiersfe, "nsmb") == true then
        djui_chat_message_create("            \\#354d7a\\coincount: " .. tostring(gGlobalSyncTable.coinCount))
    end
    djui_chat_message_create("      \\#3e5f9c\\[level]")
    djui_chat_message_create("            \\#354d7a\\level number: " .. tostring(gNetworkPlayers[0].currLevelNum))
    djui_chat_message_create("             \\#354d7a\\level name (display): " .. textlv1)
    djui_chat_message_create("            \\#354d7a\\author (display): " .. textlv2)
    --djui_chat_message_create("            \\#354d7a\\debug: " .. table.concat(times, ", "))
    if gGlobalSyncTable.roundState ~= 0 then
        djui_chat_message_create("            \\#354d7a\\roundstate: active")
    else
        djui_chat_message_create("            \\#354d7a\\roundstate: false")
    end
    djui_chat_message_create("      \\#3e5f9c\\flood speed Mulitplier: " .. tostring(gGlobalSyncTable.speedMultiplier))
    djui_chat_message_create("      \\#3e5f9c\\difficulty: " .. tonumber(gGlobalSyncTable.difficulty))
    djui_chat_message_create("      \\#3e5f9c\\version: v2.3.5")
    djui_chat_message_create("      \\#3e5f9c\\modifiers: " .. table.concat(modifiersfe, ", "))
    djui_chat_message_create("FYI: This info may not be accurate, as this hasn't been updated for some time")
    return true
end

local function on_level_init()
    save_file_erase_current_backup_save()
    if gNetworkPlayers[0].currLevelNum ~= LEVEL_CASTLE_GROUNDS then
        save_file_set_flags(SAVE_FLAG_HAVE_METAL_CAP)
        save_file_set_flags(SAVE_FLAG_HAVE_VANISH_CAP)
        save_file_set_flags(SAVE_FLAG_HAVE_WING_CAP)
    end

    save_file_set_using_backup_slot(true)

    if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
        if network_is_server() then
            local start = gLevels[gGlobalSyncTable.level].customStartPos
            if start ~= nil then
                gGlobalSyncTable.waterLevel = find_floor_height(start.x, start.y, start.z) - 1200
            else
                -- only sub areas have a weird issue where this function appears to always return the floor lower limit on level init
                gGlobalSyncTable.waterLevel = if_then_else(gLevels[gGlobalSyncTable.level].area == 1, find_floor_height(gMarioStates[0].pos.x, gMarioStates[0].pos.y, gMarioStates[0].pos.z), gMarioStates[0].pos.y) - 1200
            end
        end

        --trollfacespawn
        local m = gMarioStates[0]

        if table.contains(modifiersfe, "trollface") == true then
            if eTrollProperties.skin ~= nil then
                trollface = spawn_non_sync_object(id_bhvTrollface, eTrollProperties.skin, m.pos.x, m.pos.y + 800, m.pos.z, nil)
            else
                trollface = spawn_non_sync_object(id_bhvTrollface, E_MODEL_TROLLFACE, m.pos.x, m.pos.y + 800, m.pos.z, nil)
            end
        end

        if game == GAME_VANILLA then
            if gNetworkPlayers[0].currLevelNum == LEVEL_BITS then
                spawn_non_sync_object(
                    id_bhvCustomStaticObject,
                    E_MODEL_CTT,
                    10000, -2000, -40000,
                    function(o) obj_scale(o, 0.5) end
                )
            elseif gNetworkPlayers[0].currLevelNum == LEVEL_UP then
                tempabci = math_random(200)
                if tempabci == 100 then
                    spawn_non_sync_object(
                        id_bhvCustomStaticObject,
                        E_MODEL_EGGRT,
                        -4682, 6248, -7110,
                        function(o) obj_scale(o, 1) end
                    )
                end
            elseif gNetworkPlayers[0].currLevelNum == LEVEL_WDW then
                set_water_level(1, -20000, false)
            elseif gNetworkPlayers[0].currLevelNum == LEVEL_VCUTM then
                gGlobalSyncTable.waterLevel = -12000
            end
        end

        spawn_non_sync_object(
            id_bhvWater,
            E_MODEL_FLOOD,
            0, gGlobalSyncTable.waterLevel, 0,
            nil
        )
    end

    local pos = gLevels[gGlobalSyncTable.level].goalPos
    if pos == nil then return end

    if gNetworkPlayers[0].currLevelNum == LEVEL_CTT then
        if speedrun_mode(SPEEDRUN_MODE_MARATHON) then
            spawn_non_sync_object(
            id_bhvFloodFlag,
                E_MODEL_KOOPA_FLAG,
                0, 392, -1250,
                --- @param o Object
                function(o)
                    o.oFaceAnglePitch = 0
                    o.oFaceAngleYaw = 0
                    o.oFaceAngleRoll = 0
            end
            )
            spawn_non_sync_object(
                id_bhvBasePlatform,
                E_MODEL_BASE,
                0, 307, -1250,
                --- @param o Object
                function(o)
                    o.oFaceAnglePitch = 0
                    o.oFaceAngleYaw = 0
                    o.oFaceAngleRoll = 0
                end
            )
        else
            spawn_non_sync_object(
                id_bhvFinalStar,
                E_MODEL_STAR,
                pos.x, pos.y, pos.z,
                nil
            )
        end
    elseif gNetworkPlayers[0].currLevelNum ~= LEVEL_CASTLE_GROUNDS and gGlobalSyncTable.modif_reds == false then
        if levelinfo[gNetworkPlayers[0].currLevelNum].containsbase == true then
            spawn_non_sync_object(
            id_bhvFloodFlag,
                E_MODEL_KOOPA_FLAG,
                pos.x, pos.y + 85, pos.z,
                --- @param o Object
                function(o)
                    o.oFaceAnglePitch = 0
                    o.oFaceAngleYaw = pos.a
                    o.oFaceAngleRoll = 0
            end
            )
            spawn_non_sync_object(
                id_bhvBasePlatform,
                E_MODEL_BASE,
                pos.x, pos.y, pos.z,
                --- @param o Object
                function(o)
                    o.oFaceAnglePitch = 0
                    o.oFaceAngleYaw = 0
                    o.oFaceAngleRoll = 0
                end
            )
            return true
        else
            spawn_non_sync_object(
                id_bhvFloodFlag,
                E_MODEL_KOOPA_FLAG,
                pos.x, pos.y, pos.z,
                --- @param o Object
                function(o)
                    o.oFaceAnglePitch = 0
                    o.oFaceAngleYaw = pos.a
                    o.oFaceAngleRoll = 0
                end
            )
            return true
        end
    elseif gGlobalSyncTable.modif_reds == true then
        local pos = gLevels[gGlobalSyncTable.level].goalPos
        redflag = spawn_non_sync_object(
            id_bhvFloodFlag,
            E_MODEL_HIDDENFLAG,
            pos.x, pos.y, pos.z,
            --- @param o Object
            function(o)
                o.oFaceAnglePitch = 0
                o.oFaceAngleYaw = pos.a
                o.oFaceAngleRoll = 0
            end
        )
    end
end

-- dynos warps mario back to castle grounds facing the wrong way, likely something from the title screen
local function on_warp()
    --- @type MarioState
    local m = gMarioStates[0]

    if table.contains(modifiersfe, "pvp") == true then
        gServerSettings.playerInteractions = PLAYER_INTERACTIONS_PVP

        --djui_chat_message_create("goarmdpo")

        if gGlobalSyncTable.roundState ~= ROUND_STATE_END then
            m.flags = m.flags | MARIO_VANISH_CAP
            m.capTimer = 120 -- 4 seconds in-game
        end
    else gServerSettings.playerInteractions = PLAYER_INTERACTIONS_NONE
    end

    if gNetworkPlayers[0].currLevelNum == LEVEL_CASTLE_GROUNDS then
        if game == GAME_VANILLA then
            m.faceAngle.y = m.faceAngle.y + 0x8000
        elseif game == GAME_STAR_ROAD then
            if gGlobalSyncTable.roundState == ROUND_STATE_INACTIVE then
                vec3f_set(m.pos, -6797, 1830, 2710)
                m.faceAngle.y = 0x6000
            else
                vec3f_set(m.pos, -1644, -614, -1524)
                m.faceAngle.y = -0x4000
            end
        end

        if omm == true and musicPack == false then
            if #survivors == 0 then
                play_music(0, SEQUENCE_ARGS(8, 0x41), 0)
            end
        end

        if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE and musicPack == false and omm == false then
            play_music(0, SEQUENCE_ARGS(4, SEQ_LEVEL_BOSS_KOOPA_FINAL), 0)
        end

    elseif gLevels[gGlobalSyncTable.level].customStartPos ~= nil then
        local start = gLevels[gGlobalSyncTable.level].customStartPos
        vec3f_copy(m.pos, start)
        set_mario_action(m, ACT_SPAWN_SPIN_AIRBORNE, 0)
        m.faceAngle.y = start.a
    end

    if game == GAME_VANILLA and musicPack == false and omm == false then
        local currMusic = get_current_background_music()
        if gNetworkPlayers[0].currLevelNum == LEVEL_TTM or gNetworkPlayers[0].currLevelNum == LEVEL_CONSTRUCT then
            if currMusic == SEQ_LEVEL_GRASS or currMusic == SEQ_LEVEL_UNDERGROUND then
                play_music(0, SEQUENCE_ARGS(4, 0x50), 0)
            end
        elseif gNetworkPlayers[0].currLevelNum == LEVEL_CS or gNetworkPlayers[0].currLevelNum == LEVEL_MC then
            if currMusic == SEQ_LEVEL_SLIDE then
                play_music(0, SEQUENCE_ARGS(4, 0x51), 0)
            end
        end
    end

    if omm == true and gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
        play_music(0, SEQUENCE_ARGS(4, 0x40), 0)
    end
end

---@param m MarioState
local function on_player_connected(m)
    if network_is_server()
    and gGlobalSyncTable.roundState == ROUND_STATE_INACTIVE
    and m.playerIndex == 0 then
        gGlobalSyncTable.timer = ROUND_COOLDOWN
    end
end

local function on_start_command(msg)
    if msg == "?" then
        djui_chat_message_create("/flood \\#00ffff\\start\\#ffff00\\ [random|1-" .. FLOOD_LEVEL_COUNT .. "]\\#ffffff\\\nSets the level to a random one or a specific one, you can also leave it empty for normal progression.")
        return true
    end

    if msg == "random" then
        gGlobalSyncTable.level = math_random(#gLevels)
        round_start()
    else
        local override = tonumber(msg)
        if override ~= nil then
            override = clamp(math_floor(override), 1, FLOOD_LEVEL_COUNT)
            gGlobalSyncTable.level = override
        else
            for k, v in pairs(gLevels) do
                if msg ~= nil and msg:lower() == v.name then
                    gGlobalSyncTable.level = k
                end
            end
        end
    end
    if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
        network_send(true, { restart = true })
        level_restart()
    else
        round_start()
    end
    return true
end

local function on_ttc_speed_command(msg)
    if gGlobalSyncTable.roundState ~= ROUND_STATE_INACTIVE then
        djui_chat_message_create("\\#ff0000\\You can only change the TTC speed before the round starts!")
        return true
    end

    msg = msg:lower()
    if msg == "fast" then
        set_ttc_speed_setting(TTC_SPEED_FAST)
        djui_chat_message_create("TTC speed set to fast")
        return true
    elseif msg == "slow" then
        set_ttc_speed_setting(TTC_SPEED_SLOW)
        djui_chat_message_create("TTC speed set to slow")
        return true
    elseif msg == "random" then
        set_ttc_speed_setting(TTC_SPEED_RANDOM)
        djui_chat_message_create("TTC speed set to random")
        return true
    elseif msg == "stopped" then
        set_ttc_speed_setting(TTC_SPEED_STOPPED)
        djui_chat_message_create("TTC speed stopped")
        return true
    end

    djui_chat_message_create("/flood \\#00ffff\\ttc-speed\\#ffff00\\ [fast|slow|random|stopped]\\#ffffff\\\nChanges the speed of TTC")
    return true
end

local function on_speedrun_command(msg)
    msg = msg:lower()
    if msg == "off" then
        djui_chat_message_create("Speedrun mode status: \\#ff0000\\OFF")
        speedrunner = SPEEDRUN_MODE_OFF
        return true
    elseif msg == "progress" then
        djui_chat_message_create("Speedrun mode status: \\#00ff00\\Progress Level")
        speedrunner = SPEEDRUN_MODE_PROGRESS
        return true
    elseif msg == "marathon" then
        djui_chat_message_create("Speedrun mode status: \\#00ff00\\Marathon (All 35 Levels)")
        speedrunner = SPEEDRUN_MODE_MARATHON
        return true
    elseif msg == "restart" then
        djui_chat_message_create("Speedrun mode status: \\#00ff00\\Restart Level")
        speedrunner = SPEEDRUN_MODE_RESTART
        return true
    end

    djui_chat_message_create("/flood \\#00ffff\\speedrun\\#ffff00\\ [off|progress|marathon|restart]\\#ffffff\\\nTo make adjustments to singleplayer Flood helpful for speedrunners")
    return true
end

local function on_scoreboard_command()
    djui_chat_message_create("Times:")
    local modifiers = get_modifiers_string()
    local total = 0
    for level = 1, FLOOD_LEVEL_COUNT do
        -- local level = gMapRotation[i]
        djui_chat_message_create(get_level_name(level_to_course(gLevels[level].level), gLevels[level].level, 1) .. " - " .. timestamp(gPlayerSyncTable[0].time) .. modifiers)
        total = total + gPlayerSyncTable[0].time
    end

    djui_chat_message_create("Total Time: " .. timestamp(total))

    return true
end

local function powerup_roulette()
    local m = gMarioStates[0]
    local randomfc = math_random(5)
    if randomfc == 1 then
        spawn_sync_object(id_bhvMetalCap, E_MODEL_MARIOS_METAL_CAP, m.pos.x, m.pos.y + 445, m.pos.z, nil)
    end
    if randomfc == 2 then
        spawn_sync_object(id_bhvWingCap, E_MODEL_MARIOS_WING_CAP, m.pos.x, m.pos.y + 445, m.pos.z, nil)
    end
    if randomfc == 3 then
        spawn_sync_object(id_bhvVanishCap, E_MODEL_MARIOS_CAP, m.pos.x, m.pos.y + 445, m.pos.z, nil)
    end
    if randomfc == 4 then
        spawn_sync_object(id_bhv1upRunningAway, E_MODEL_1UP, m.pos.x, m.pos.y + 445, m.pos.z, nil)
    end
    if randomfc == 5 then
        spawn_sync_object(id_bhvKoopaShell, E_MODEL_KOOPA_SHELL, m.pos.x, m.pos.y + 445, m.pos.z, nil)
    end
end

local function on_modifiers_switch(msg)
    msg = msg:lower()
    if msg == "nsmb" then
        if table.contains(modifiersfe, "nsmb") == false then
            djui_chat_message_create("NSMB Modifier has been applied.")
            table.insert(modifiersfe, "nsmb")

            if gGlobalSyncTable.popups == true then
                djui_popup_create_global("NSMB Modifier applied.", 1)
            end
            gGlobalSyncTable.modif_nsmb = true
        else
            djui_chat_message_create("NSMB Modifier removed.")
            local pos = table.poselement(modifiersfe, "nsmb")
            table.remove(modifiersfe, pos)
            if gGlobalSyncTable.popups == true then
                djui_popup_create_global("NSMB Modifier removed.", 1)
            end
            gGlobalSyncTable.modif_nsmb = false
        end
    elseif msg == "instakill" then
        if table.contains(modifiersfe, "instakill") == false then
            djui_chat_message_create("Insta-Kill Modifier has been applied.")
            table.insert(modifiersfe, "instakill")

            if gGlobalSyncTable.popups == true then
                djui_popup_create_global("Insta-Kill Modifier applied.", 1)
            end
            gGlobalSyncTable.modif_instakill = true
        else
            djui_chat_message_create("Insta-Kill Modifier removed.")
            local pos = table.poselement(modifiersfe, "instakill")
            table.remove(modifiersfe, pos)
            if gGlobalSyncTable.popups == true then
                djui_popup_create_global("Insta-Kill Modifier removed.", 1)
            end
            gGlobalSyncTable.modif_instakill = false
        end
    elseif msg == "reds" then
        if table.contains(modifiersfe, "reds") == false then
            djui_chat_message_create("Red Coin Modifier has been applied.")
            table.insert(modifiersfe, "reds")

            if gGlobalSyncTable.popups == true then
                djui_popup_create_global("Red Coin Modifier applied.", 1)
            end
            gGlobalSyncTable.modif_reds = true
        else
            djui_chat_message_create("Red Coin Modifier removed.")
            local pos = table.poselement(modifiersfe, "reds")
            table.remove(modifiersfe, pos)
            if gGlobalSyncTable.popups == true then
                djui_popup_create_global("Red Coin Modifier removed.", 1)
            end
            gGlobalSyncTable.modif_reds = false
        end
    elseif msg == "trollface" then
        if table.contains(modifiersfe, "trollface") == false then
            djui_chat_message_create("Trollface Modifier has been applied.")
            table.insert(modifiersfe, "trollface")

            if gGlobalSyncTable.popups == true then
                djui_popup_create_global("Trollface Modifier applied.", 1)
            end
            gGlobalSyncTable.modif_trollface = true
        else
            if omm == false then
                djui_chat_message_create("Trollface Modifier removed.")
                local pos = table.poselement(modifiersfe, "trollface")
                table.remove(modifiersfe, pos)
                if gGlobalSyncTable.popups == true then
                    djui_popup_create_global("Trollface Modifier removed.", 1)
                end
                gGlobalSyncTable.modif_trollface = false
            elseif omm == true then
                if gGlobalSyncTable.popups == true then
                    djui_popup_create_global("Trollface Modifier wasn't able to be removed.", 1)
                end
                djui_chat_message_create("\\#ff0000\\You can't disable trollface right now, Try disabiling OMM first.")
            end
        end
    elseif msg == "pvp" then
        if table.contains(modifiersfe, "pvp") == false then
            djui_chat_message_create("PvP Modifier has been applied.")
            table.insert(modifiersfe, "pvp")

            if gGlobalSyncTable.popups == true then
                djui_popup_create_global("PvP Modifier applied.", 1)
            end
            gGlobalSyncTable.modif_pvp = true
        else
            djui_chat_message_create("PvP Modifier removed.")
            local pos = table.poselement(modifiersfe, "pvp")
            table.remove(modifiersfe, pos)
            if gGlobalSyncTable.popups == true then
                djui_popup_create_global("PvP Modifier removed.", 1)
            end
            gGlobalSyncTable.modif_pvp = false
        end
    else
        djui_chat_message_create("\\#ff0000\\Incorrect usage, List of modifiers [NSMB, InstaKill, Reds, Trollface, PvP]")
    end
    return true
end

local function on_mode_switch(msg)
    msg = msg:lower()
    if msg == "default" then
        if gGlobalSyncTable.mapMode ~= 0 then
            djui_chat_message_create("Mode will be applied once the next round starts.")
            if gGlobalSyncTable.popups == true then
                djui_popup_create_global("Mapmode set to Default.", 1)
            end
        else
            djui_chat_message_create("Mode already set to default.")
        end
        gGlobalSyncTable.mapMode = 0
    elseif msg == "random" then
        if gGlobalSyncTable.mapMode ~= 1 then
            djui_chat_message_create("Mode will be applied once the next round starts.")
            if gGlobalSyncTable.popups == true then
                djui_popup_create_global("Mapmode set to Random.", 1)
            end
        else
            djui_chat_message_create("Mode already set to random.")
        end
        gGlobalSyncTable.mapMode = 1
    elseif msg == "voting" then
        if gGlobalSyncTable.mapMode ~= 2 then
            djui_chat_message_create("Mode will be applied once the next round starts.")
            if gGlobalSyncTable.popups == true then
                djui_popup_create_global("Mapmode set to Voting.", 1)
            end
        else
            djui_chat_message_create("Mode already set to voting.")
        end
        gGlobalSyncTable.mapMode = 2
    else
        djui_chat_message_create("\\#ff0000\\Incorrect usage, you can either use Default, Random, or Voting.")
    end
    return true
end

local function on_coinc_command(msg)
    if tonumber(msg) == nil then
        djui_chat_message_create("\\#ff0000\\You need to put a number of any kind for this command to work. Right now the Coin Count is set to " .. gGlobalSyncTable.coinCount)
        return true
    end
    if tonumber(msg) < 1 then
        djui_chat_message_create("\\#ff0000\\You can't disable powerups in this modifier, you can remove this modifier if you want to disable powerups.")
        return true
    end
    if tonumber(msg) == gGlobalSyncTable.coinCount then
        djui_chat_message_create("\\#ff0000\\It's already set it to " .. gGlobalSyncTable.coinCount .. " try a different number.")
        return true
    end
    if tonumber(msg) ~= nil then
        gGlobalSyncTable.coinCount = tonumber(msg)
        djui_chat_message_create("Coin Count changed to " .. gGlobalSyncTable.coinCount)
        if gGlobalSyncTable.popups == true then
            djui_popup_create_global("Coin Count changed to " .. msg, 1)
        end
        return true
    else
        djui_chat_message_create('\\#ff0000\\The character you provided needs to have a number to change how many coins to collect.')
    end
end

local function hide_djui_hudelements()
    eFloodVariables.hudHide = not eFloodVariables.hudHide
end

local function on_difc_command(msg)
	if tonumber(msg) == nil then
	djui_chat_message_create("\\#ff0000\\You need to put a number between [0 - 10] for this command to work. Right now the Difficulty is set to " .. gGlobalSyncTable.difficulty)
	return true
	end
	if tonumber(msg) == gGlobalSyncTable.difficulty then
	djui_chat_message_create("\\#ff0000\\It's already set it to " .. gGlobalSyncTable.difficulty .. " try a different number.")
	return true
	end
    if gGlobalSyncTable.difficulty ~= nil then
        msg = clampf(tonumber(msg), 0, 10)
        gGlobalSyncTable.difficulty = msg
		djui_chat_message_create("Difficulty changed to " .. msg .. "x")
        if gGlobalSyncTable.popups == true then
            djui_popup_create_global("Difficulty changed to " .. msg .. "x", 1)
        end
        return true
	end
    return true
end

---@param msg string
local function spectator_command(msg)
    if msg == nil or type(msg) ~= "string" then goto help end
    msg = msg:lower()
    if msg == "normal" then
        eFloodVariables.spectatorMode = SPECTATOR_MODE_NORMAL
        djui_chat_message_create("Spectator Mode set to Normal")
        return true
    elseif msg == "follow" then
        eFloodVariables.spectatorMode = SPECTATOR_MODE_FOLLOW
        djui_chat_message_create("Spectator Mode set to Following")
        return true
    end
    ::help::
    djui_chat_message_create("/flood spectator [normal|follow]")
    return true
end

local function flood_config(msg1, msg2)
    msg1 = msg1:lower()

    if msg1 == "round-cooldown" then
        if tonumber(msg2) == nil then
            djui_chat_message_create("\\#ff0000\\Command has failed, Non-number input for second argument.")
            return true
        end
        ROUND_COOLDOWN = clampf(tonumber(msg2), 0, 32) * 30
        djui_chat_message_create("Round cooldown changed to " .. tostring(clampf(tonumber(msg2), 0, 32)))
        return true
    elseif msg1 == "difficulty" then
        if omm == false then
            if tonumber(msg2) == nil then
                djui_chat_message_create("\\#ff0000\\Command has failed, Non-number input for second argument.")
                return true
            end
            on_difc_command(clampf(tonumber(msg2), 0, 8))
            djui_chat_message_create("Difficulty changed to " .. tostring(clampf(tonumber(msg2), 0, 8)))
        elseif omm == true then
            djui_chat_message_create("\\#ff0000\\Maybe turn off.. OMM.")
        end
        return true
    elseif msg1 == "popups" then
        msg2 = msg2:lower()

        if msg2 == "true" then
            if gGlobalSyncTable.popups == false then
                djui_chat_message_create("Popups Enabled.")
                djui_popup_create_global("Popups Enabled.", 1)
            else
                djui_chat_message_create("Popups already enabled.")
            end
            gGlobalSyncTable.popups = true
            return true
        elseif msg2 == "false" then
            if gGlobalSyncTable.popups == true then
                djui_chat_message_create("Popups Disabled.")
                djui_popup_create_global("Popups Disabled.", 1)
            else
                djui_chat_message_create("Popups already disabled.")
            end
            gGlobalSyncTable.popups = false
            return true
        else
            djui_chat_message_create("\\#ff0000\\Command has failed, Non-boolean input for second argument.")
            return true
        end
    
        return true
    end
end

local function on_flood_command(msg)
    if gGlobalSyncTable.isPermitted == true then
        local args = split(msg)
        if args[1] == "start" then
            return on_start_command(args[2])
        elseif args[1] == "speed" then
            return on_speed_command(args[2])
        elseif args[1] == "ttc-speed" then
            return on_ttc_speed_command(args[2])
        elseif args[1] == "speedrun" then
            return on_speedrun_command(args[2])
        elseif args[1] == "mapmode" then
            return on_mode_switch(args[2])
        elseif args[1] == "scoreboard" then
            return on_scoreboard_command()
        elseif args[1] == "random" then
            return on_rando_command()
        elseif args[1] == "modifiers" then
            return on_modifiers_switch(args[2])
        elseif args[1] == "coincount" and table.contains(modifiersfe, "nsmb") == true then
            return on_coinc_command(args[2])
        elseif args[1] == "info" then
            return on_info_command()
        elseif args[1] == "spectator" then
            return spectator_command(args[2])
        elseif args[1] == "hidehud" then
            return hide_djui_hudelements()
        elseif args[1] == "config" then
            return flood_config(args[2], args[3])
        end

        if table.contains(modifiersfe, "nsmb") == true then
            djui_chat_message_create("/flood \\#00ffff\\[start|speed|ttc-speed|speedrun|scoreboard|random|mapmode|modifiers|coincount|config|info]")
        else
            djui_chat_message_create("/flood \\#00ffff\\[start|speed|ttc-speed|speedrun|scoreboard|random|mapmode|modifiers|config|info]")
        end

        return true
    else
        djui_chat_message_create("Commands are disabled!")
    end
end

local function on_flood_baby_command(msg)
    if gGlobalSyncTable.isPermitted == true then
        local args = split(msg)
        if args[1] == "info" then
            return on_info_command()
        elseif args[1] == "spectator" then
            return spectator_command(args[2])
        elseif args[1] == "hidehud" then
            return hide_djui_hudelements()
        end

        djui_chat_message_create("/flood \\#00ffff\\[info|spectator]")
        return true
    else
        djui_chat_message_create("Commands are disabled!")
    end
end


local function coin_update(m, o, interactType)
    if table.contains(modifiersfe, "nsmb") == true then
        if m.playerIndex ~= 0 then return end
        if interactType == INTERACT_COIN then
            customCoinCounter = customCoinCounter + 1
        end
        if ( customCoinCounter == gGlobalSyncTable.coinCount) then
            customCoinCounter = customCoinCounter - gGlobalSyncTable.coinCount
            network_play(sNsmbUse, m.pos, 1.2, m.playerIndex)

            return powerup_roulette()
        end
    end
    if table.contains(modifiersfe, "reds") == true then
        if m.playerIndex ~= 0 then return end
        if obj_has_behavior_id(o, id_bhvRedCoin) ~= 0 then
            gGlobalSyncTable.redCoinCounter = gGlobalSyncTable.redCoinCounter + 0.25
        end
    end
    if table.contains(modifiersfe, "reds") == true then
        gGlobalSyncTable.speedMultiplier = gGlobalSyncTable.redCoinCounter
    end
end



gServerSettings.skipIntro = 1
gServerSettings.stayInLevelAfterStar = 2

gLevelValues.entryLevel = LEVEL_LOBBY
gLevelValues.floorLowerLimit = -20000
gLevelValues.floorLowerLimitMisc = -20000 + 1000
gLevelValues.floorLowerLimitShadow = -20000 + 1000.0
gLevelValues.fixCollisionBugs = 1
gLevelValues.fixCollisionBugsRoundedCorners = 0

hud_hide()

-- music thingy, makes it better :mindblow:
if musicPack == false then
    if game == GAME_VANILLA then
        set_ttc_speed_setting(TTC_SPEED_SLOW)

        smlua_text_utils_secret_star_replace(COURSE_SA, "   Climb The Tower Flood")

        smlua_audio_utils_replace_sequence(SEQ_EVENT_MERRY_GO_ROUND, 42, 76, "toads_turnpike")

        smlua_audio_utils_replace_sequence(SEQ_LEVEL_BOSS_KOOPA_FINAL, 42, 60, "00_pinball_custom")

        smlua_audio_utils_replace_sequence(SEQ_EVENT_BOSS, 24, 60, "nsmb_battle_course")

        smlua_audio_utils_replace_sequence(0x51, 17, 60, "seaside")

        smlua_audio_utils_replace_sequence(SEQ_LEVEL_UNDERGROUND, 42, 60, "floodescape")

        smlua_audio_utils_replace_sequence(0x50, 17, 95, "mission_mode")
        
        smlua_audio_utils_replace_sequence(0x52, 42, 62, "frappesnowland")
        
        smlua_audio_utils_replace_sequence(0x40, 37, 62, "civilization")

        smlua_audio_utils_replace_sequence(0x41, 17, 62, "gameover")
    else
        smlua_text_utils_secret_star_replace(COURSE_SA, "   Climb The Tower Flood")

        smlua_audio_utils_replace_sequence(SEQ_EVENT_MERRY_GO_ROUND, 42, 46, "toads_turnpike")

        smlua_audio_utils_replace_sequence(0x51, 17, 60, "seaside")

        smlua_audio_utils_replace_sequence(0x50, 17, 95, "mission_mode")

        smlua_audio_utils_replace_sequence(0x40, 37, 62, "civilization")       

        smlua_audio_utils_replace_sequence(0x41, 17, 62, "gameover")
    end
end

hook_event(HOOK_ON_INTERACT, coin_update)
hook_event(HOOK_UPDATE, update)
hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
hook_event(HOOK_ON_HUD_RENDER, on_hud_render)
hook_event(HOOK_ON_LEVEL_INIT, on_level_init)
hook_event(HOOK_ON_WARP, on_warp)
hook_event(HOOK_ON_PLAYER_CONNECTED, on_player_connected)
hook_event(HOOK_ON_DIALOG, function () return false end)

if not network_is_server() and not network_is_moderator() then
    hook_chat_command("flood", "\\#00ffff\\[info|spectator]", on_flood_baby_command)
end

if network_is_server() or network_is_moderator() then
    hook_chat_command("flood", "\\#00ffff\\[start|speed|ttc-speed|speedrun|scoreboard|random|mapmode|modifiers|info|spectator|config]", on_flood_command)
end
