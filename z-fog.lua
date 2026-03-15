-- credits to Blocky.cmd for the Fog model and system

if unsupported then return end

local E_MODEL_FOG = smlua_model_util_get_id("fog_geo")

local STATE_NORMAL = 0
local STATE_SAND = 1
local STATE_BLACK = 2
local STATE_GREEN = 3
local STATE_PURPLE = 4
local STATE_HAUNTED = 5
local STATE_FIRE = 6

local skyboxInfo = {
    [BACKGROUND_OCEAN_SKY]       = {anim = STATE_NORMAL , color = {r = 000, g = 047, b = 100}},
    [BACKGROUND_SNOW_MOUNTAINS]  = {anim = STATE_NORMAL , color = {r = 000, g = 047, b = 100}},
    [BACKGROUND_ABOVE_CLOUDS]    = {anim = STATE_NORMAL , color = {r = 000, g = 047, b = 100}},
    [BACKGROUND_BELOW_CLOUDS]    = {anim = STATE_NORMAL , color = {r = 000, g = 047, b = 100}},
    [BACKGROUND_UNDERWATER_CITY] = {anim = STATE_NORMAL , color = {r = 000, g = 047, b = 100}},
    [BACKGROUND_FLAMING_SKY]     = {anim = STATE_FIRE   , color = {r = 235, g = 077, b = 066}},
    [BACKGROUND_GREEN_SKY]       = {anim = STATE_GREEN  , color = {r = 004, g = 044, b = 048}},
    [BACKGROUND_HAUNTED]         = {anim = STATE_HAUNTED, color = {r = 013, g = 003, b = 138}},
    [BACKGROUND_DESERT]          = {anim = STATE_SAND   , color = {r = 171, g = 171, b = 116}},
    [BACKGROUND_PURPLE_SKY]      = {anim = STATE_PURPLE , color = {r = 147, g = 004, b = 199}},
    [BACKGROUND_CUSTOM]          = {anim = STATE_NORMAL , color = {r = 000, g = 000, b = 000}},
}

---@param o Object
local function fog_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oFaceAnglePitch = 0
    o.oFaceAngleRoll = 0
    o.oOpacity = 75
    obj_scale(o, 3.5)
    set_override_far(1000000)
end

---@param o Object
local function fog_loop(o)
    local m = gMarioStates[0]

    local flood = gLevels[gGlobalSyncTable.level].type
    local skybox = get_skybox()

    if typeInfo[flood] and gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
        o.oAnimState = typeInfo[flood].anim
    else
        o.oAnimState = skybox >= 0 and skyboxInfo[skybox].anim or STATE_NORMAL
    end

    if not gGlobalSyncTable.modif_fog then
        obj_mark_for_deletion(o)
    end

    if m.action == ACT_SPECTATOR then
        o.oPosX, o.oPosY, o.oPosZ = sPlayerFirstPerson.pos.x, sPlayerFirstPerson.pos.y, sPlayerFirstPerson.pos.z
    else
        o.oPosX, o.oPosY, o.oPosZ = m.pos.x, m.pos.y, m.pos.z
    end
    o.oFaceAngleYaw = m.faceAngle.y
end

---@param m MarioState
local function mario_update(m)
    if m.playerIndex ~= 0 then return end

    if not obj_get_first_with_behavior_id(id_bhvFog) and gGlobalSyncTable.modif_fog then
        spawn_non_sync_object(id_bhvFog, E_MODEL_FOG, 0, 0, 0, nil)
    end
end

local function on_hud_render()
    if not obj_get_first_with_behavior_id(id_bhvFog) then return end

    local screenWidth  = djui_hud_get_screen_width()
    local screenHeight = djui_hud_get_screen_height()

    local flood = gLevels[gGlobalSyncTable.level].type
    local skybox = get_skybox()
    local r, g, b = 0, 47, 100

    if gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
        r, g, b = typeInfo[flood].color.r, typeInfo[flood].color.g, typeInfo[flood].color.b
    else
        if skybox >= 0 then
            r, g, b = skyboxInfo[skybox].color.r, skyboxInfo[skybox].color.g, skyboxInfo[skybox].color.b
        end
    end

    djui_hud_set_color(r, g, b, 100)
    djui_hud_render_rect(0, 0, screenWidth + 20, screenHeight + 20)
end

id_bhvFog = hook_behavior(nil, OBJ_LIST_DEFAULT, false, fog_init, fog_loop)
hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_ON_HUD_RENDER, on_hud_render)