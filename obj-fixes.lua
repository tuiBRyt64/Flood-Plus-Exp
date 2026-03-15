-- Big thanks to Cooliokid956 for both the exclamation box function and for_each_object_with_behavior function/hook

if unsupported then return end

local function custom_exclamation_box(o)
    if o.oAction == 5 then
        obj_mark_for_deletion(o)
    end
end

-- Fixes Bowser from standing still and doing absolutely nothing
local function custom_bowser(o)
    if o.oAction == 5 then
        o.oAction = 14
    end
end

-- Fixes the DDD sub from despawning when the star counter is high enough (Thank you EmilyEmmi!)
---@param o Object
local function custom_ddd_sub_init(o)
    o.oFlags = o.oFlags | (OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.oCollisionDistance = 20000
    o.collisionData = smlua_collision_util_get('ddd_seg7_collision_submarine')
end

---@param o Object
local function custom_ddd_door_init(o)
    o.oFlags = o.oFlags | (OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.oCollisionDistance = 20000
    o.collisionData = smlua_collision_util_get('ddd_seg7_collision_bowser_sub_door')
end

---@param o Object
local function custom_ddd_loop(o)
    load_object_collision_model()
end

-- All Cannon stuff (Credits to EmeraldLockdown)

---@param o Object
local function cannon_lid_init(o)
    o.oFlags = OBJ_FLAG_PERSISTENT_RESPAWN | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = gGlobalObjectCollisionData.cannon_lid_seg8_collision_08004950
    cur_obj_set_home_once()
end

---@param o Object
local function cannon_lid_loop(o)
    obj_set_model_extended(o, E_MODEL_DL_CANNON_LID)
    load_object_collision_model()
end

---@param o Object
local function hidden_120_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = gGlobalObjectCollisionData.castle_grounds_seg7_collision_cannon_grill
    o.oCollisionDistance = 4000
end

---@param o Object
local function hidden_120_loop(o)
    obj_set_model_extended(o, E_MODEL_CASTLE_GROUNDS_CANNON_GRILL)
    load_object_collision_model()
end

local function allow_interact(m, o, intee)
    if intee == INTERACT_CANNON_BASE then
        return false
    end
end

local function fading_warp_set_model()
    for_each_object_with_behavior(id_bhvFadingWarp, function(fw)
        if obj_has_model_extended(fw, E_MODEL_NONE) ~= 0 and gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE then
            obj_set_model_extended(fw, E_MODEL_BUBBLE_PLAYER)
        end
    end)
end

function mario_inside_hitbox(m, o)
    local dx = m.pos.x - o.oPosX
    local dz = m.pos.z - o.oPosZ
    local dist = math.sqrt(dx * dx + dz * dz)

    local dy = m.pos.y - (o.oPosY - (o.hitboxDownOffset or 0))

    return (dist <= o.hitboxRadius) and (dy >= 0 and dy <= o.hitboxHeight)
end

function caps_loop(o)
    o.oPosY = o.oPosY + o.oVelY

    local floorY = find_floor_height(o.oPosX, o.oPosY, o.oPosZ)
    if o.oPosY <= floorY then
        o.oPosY = floorY
        o.oVelY = 0
    end

    if o.oTimer > 510 then
        if (o.oTimer % 10) < 5 then
            o.oOpacity = 255
        else
            o.oOpacity = 80
        end
    end

    if o.oTimer > 600 then
        obj_mark_for_deletion(o)
    end

    o.oFaceAngleYaw = o.oFaceAngleYaw + 0x400
end

function caps_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | COOP_OBJ_FLAG_NON_SYNC
    o.hitboxRadius = 100
    o.hitboxHeight = 100
    o.hitboxDownOffset = 100
    o.oPosY = o.oPosY + 120
    o.oVelY = -3
end

local function bhv_wing_cap_init(o)
    caps_init(o)
    o.oOpacity = 255
end

local function bhv_metal_cap_init(o)
    caps_init(o)
    o.oOpacity = 255
end

local function bhv_vanish_cap_init(o)
    caps_init(o)
    o.oOpacity = 125
end

local function bhv_wing_cap_loop(o)
    local m = gMarioStates[0]

    caps_loop(o)

    if mario_inside_hitbox(m, o) then
        m.flags = m.flags | MARIO_WING_CAP
        m.capTimer = gLevelValues.wingCapDuration
        o.activeFlags = ACTIVE_FLAG_DEACTIVATED
    end
end

local function bhv_metal_cap_loop(o)
    local m = gMarioStates[0]

    caps_loop(o)

    if mario_inside_hitbox(m, o) then
        m.flags = m.flags | MARIO_METAL_CAP
        m.capTimer = gLevelValues.metalCapDuration
        o.activeFlags = ACTIVE_FLAG_DEACTIVATED
    end
end

local function bhv_vanish_cap_loop(o)
    local m = gMarioStates[0]

    caps_loop(o)

    if mario_inside_hitbox(m, o) then
        m.flags = m.flags | MARIO_VANISH_CAP
        m.capTimer = gLevelValues.vanishCapDuration
        o.activeFlags = ACTIVE_FLAG_DEACTIVATED
    end
end

function for_each_object_with_behavior(behavior, func)
    local obj = obj_get_first_with_behavior_id(behavior)
    while obj do
        func(obj)
        obj = obj_get_next_with_same_behavior_id(obj)
    end
end

-- hooks used for objects
hook_event(HOOK_UPDATE, function () for_each_object_with_behavior(id_bhvExclamationBox, custom_exclamation_box) for_each_object_with_behavior(id_bhvBowser, custom_bowser) end)
hook_behavior(id_bhvBowsersSub, OBJ_LIST_SURFACE, true, custom_ddd_sub_init, custom_ddd_loop)
hook_behavior(id_bhvBowserSubDoor, OBJ_LIST_SURFACE, true, custom_ddd_door_init, custom_ddd_loop)
id_bhvCannonLid = hook_behavior(id_bhvCannonLid, OBJ_LIST_SURFACE, false, cannon_lid_init, cannon_lid_loop, "cannonLid")
id_bhvWingCap = hook_behavior(id_bhvWingCap, OBJ_LIST_LEVEL, true, bhv_wing_cap_init, bhv_wing_cap_loop, "bhvWingCap")
id_bhvMetalCap = hook_behavior(id_bhvMetalCap, OBJ_LIST_LEVEL, true, bhv_metal_cap_init, bhv_metal_cap_loop, "bhvMetalCap")
id_bhvVanishCap = hook_behavior(id_bhvVanishCap, OBJ_LIST_LEVEL, true, bhv_vanish_cap_init, bhv_vanish_cap_loop, "bhvVanishCap")
hook_behavior(id_bhvCannonClosed, OBJ_LIST_SURFACE, false, function (o)
    spawn_non_sync_object(id_bhvCannonLid, E_MODEL_DL_CANNON_LID, o.oPosX, o.oPosY - 5, o.oPosZ, function (obj)
        obj.oFaceAnglePitch = o.oFaceAnglePitch
        obj.oFaceAngleYaw = o.oFaceAngleYaw
        obj.oFaceAngleRoll = o.oFaceAngleRoll
    end)
    o.activeFlags = ACTIVE_FLAG_DEACTIVATED
end, nil, "cannonClosed")
hook_behavior(id_bhvHiddenAt120Stars, OBJ_LIST_SURFACE, true, hidden_120_init, hidden_120_loop)
hook_event(HOOK_ALLOW_INTERACT, allow_interact)
hook_event(HOOK_OBJECT_SET_MODEL, fading_warp_set_model)