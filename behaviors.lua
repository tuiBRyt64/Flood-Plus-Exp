
if unsupported then return end

-- models
E_MODEL_FLOOD = smlua_model_util_get_id("flood_geo")
E_MODEL_LAUNCHPAD = smlua_model_util_get_id("launchpad_geo")

-- collisions
local COL_LAUNCHPAD = smlua_collision_util_get("launchpad_collision")

-- custom object fields (used for pipes)
define_custom_obj_fields({
    oIndex = 'u32'
})

blockScales = {}

local m = gMarioStates[0]

-- localize functions to improve performance
local get_environment_region,set_environment_region,set_override_far,cur_obj_scale,cur_obj_init_animation,bhv_pole_base_loop,nearest_mario_state_to_object,play_mario_jump_sound,set_mario_action,spawn_non_sync_object,mario_set_forward_vel,vec3f_set,load_object_collision_model = get_environment_region,set_environment_region,set_override_far,cur_obj_scale,cur_obj_init_animation,bhv_pole_base_loop,nearest_mario_state_to_object,play_mario_jump_sound,set_mario_action,spawn_non_sync_object,mario_set_forward_vel,vec3f_set,load_object_collision_model

--- @param o Object
local function bhv_flood_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oAnimState = gLevels[gGlobalSyncTable.level].type

    o.header.gfx.skipInViewCheck = true

    o.oFaceAnglePitch = 0
    o.oFaceAngleRoll = 0

    if gLevels[gGlobalSyncTable.level].floodScale ~= nil then
        obj_scale(o, gLevels[gGlobalSyncTable.level].floodScale)
    end
end

--- @param o Object
local function bhv_flood_loop(o)
    o.oPosY = gGlobalSyncTable.floodLevel
    if eFloodVariables.scrollingFloodTexture then
        o.oFaceAngleYaw = o.oTimer * 5 * (gLevels[gGlobalSyncTable.level].speed or 1)
    end

    for i = 0, 10 do
        if get_environment_region(i) < gGlobalSyncTable.floodLevel then
            set_environment_region(i, -20000)
        end
    end
end

--- @param o Object
local function bhv_custom_static_object_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    set_override_far(50000)
end

id_bhvCustomStaticObject = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_custom_static_object_init, nil)

--- @param o Object
local function bhv_flood_flag_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oInteractType = INTERACT_POLE
    o.hitboxRadius = 80
    o.hitboxHeight = 700
    o.oIntangibleTimer = 0
    o.oAnimations = gObjectAnimations.koopa_flag_seg6_anims_06001028

    cur_obj_init_animation(0)
end

--- @param o Object
local function bhv_flood_flag_loop(o)
    bhv_pole_base_loop()
end

id_bhvFloodFlag = hook_behavior(nil, OBJ_LIST_POLELIKE, true, bhv_flood_flag_init, bhv_flood_flag_loop)

local function bhv_flood_pipe_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = gGlobalObjectCollisionData.warp_pipe_seg3_collision_03009AC8
    obj_set_model_extended(o, E_MODEL_BITS_WARP_PIPE)
end

local function bhv_flood_pipe_loop(o)
    local m = nearest_mario_state_to_object(o)

    load_object_collision_model()

    if m.playerIndex ~= 0 then return end

    if dist_between_objects(o, m.marioObj) <= 50 then
        local pipePair = gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE and gLevels[gGlobalSyncTable.level].pipes[o.oIndex] or gLobbies[gGlobalSyncTable.lobby].pipes[o.oIndex]
        if pipePair == nil then return end
        local oppositePipe = obj_get_first_with_behavior_id(id_bhvFloodPipe)
        while oppositePipe == o or oppositePipe.oIndex ~= o.oIndex do
            oppositePipe = obj_get_next_with_same_behavior_id(oppositePipe)

            if oppositePipe == nil then return end
        end

        m.pos.x = oppositePipe.oPosX
        m.pos.y = oppositePipe.oPosY + 200
        m.pos.z = oppositePipe.oPosZ
        if m.pos.y > m.waterLevel then
            set_mario_action(m, ACT_EMERGE_FROM_PIPE, 0)
        else
            set_mario_action(m, ACT_BREASTSTROKE, 0)
        end
        m.faceAngle.y = oppositePipe.oBehParams2ndByte
        m.actionTimer = 15

        reset_camera(m.area.camera)             -- reset camera
        play_sound(SOUND_MENU_EXIT_PIPE, m.pos) -- play pipe sounds
    end
end

--- @param o Object
local function bhv_start_pos_pipe_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = gGlobalObjectCollisionData.warp_pipe_seg3_collision_03009AC8
    obj_set_model_extended(o, E_MODEL_BITS_WARP_PIPE)
end

--- @param o Object
local function bhv_start_pos_pipe_loop(o)
    load_object_collision_model()

    if gPlayerSyncTable[0].time >= 30 then
        if o.oAction ~= 3 then
            o.oAction = 3
            o.oTimer = 0
            o.oHomeY = o.oPosY 
        end
        if o.oTimer < 30 then
            o.oPosY = o.oPosY - 7.0
        end
        if o.oTimer >= 40 then
            obj_mark_for_deletion(o)
        end
    end
end

local function bhv_launchpad_loop(o)
    local m = nearest_mario_state_to_object(o)
    if m.marioObj.platform == o then
        play_mario_jump_sound(m)
        if o.oBehParams2ndByte ~= 255 then
            set_mario_action(m, ACT_TWIRLING, 0)
            m.vel.y = o.oBehParams2ndByte
        else
            spawn_non_sync_object(
                id_bhvWingCap,
                E_MODEL_NONE,
                m.pos.x + m.vel.x, m.pos.y + m.vel.y, m.pos.z + m.vel.z,
                nil
            )
            set_mario_action(m, ACT_FLYING_TRIPLE_JUMP, 0)
            mario_set_forward_vel(m, 100)
            vec3f_set(m.angleVel, 0, 0, 0)
            vec3f_set(m.faceAngle, 0, 0x4500, 0)
            m.vel.y = 55
        end
    end
    load_object_collision_model()
end

local function bhv_customizable_launchpad_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 500
    o.collisionData = COL_LAUNCHPAD
    o.oFaceAnglePitch = 0
    o.oFaceAngleRoll = 0
    obj_scale(o, 0.85)
end

local function bhv_customizable_launchpad_loop(o)
    local m = nearest_mario_state_to_object(o)

    if m.marioObj.platform == o then
        play_mario_jump_sound(m)
        if o.oForwardVel == 0 then
            set_mario_action(m, ACT_TWIRLING, 0)
            m.vel.y = o.oBehParams2ndByte
        else
            m.flags = m.flags | MARIO_WING_CAP
            m.capTimer = o.oBehParams
            set_mario_action(m, ACT_FLYING_TRIPLE_JUMP, 0)
            mario_set_forward_vel(m, o.oForwardVel)
            vec3f_set(m.angleVel, 0, 0, 0)
            vec3f_set(m.faceAngle, 0, o.oFaceAngleYaw, 0)
            m.vel.y = o.oBehParams2ndByte
        end
    end
    load_object_collision_model()
end

--- @param o Object
local function bhv_block_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = gGlobalObjectCollisionData.metal_box_seg8_collision_08024C28
    obj_set_model_extended(o, smlua_model_util_get_id("block_geo"))

    local scale = blockScales[o]
    if scale ~= nil then
        obj_scale(o, scale)
    end
end

local function bhv_block_loop()
    load_object_collision_model()
end

id_bhvFlood = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_flood_init, bhv_flood_loop)
id_bhvFloodPipe = hook_behavior(nil, OBJ_LIST_SURFACE, false, bhv_flood_pipe_init, bhv_flood_pipe_loop)
id_bhvStartPosPipe = hook_behavior(nil, OBJ_LIST_SURFACE, false, bhv_start_pos_pipe_init, bhv_start_pos_pipe_loop)
id_bhvLaunchpad = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_launchpad_init, bhv_launchpad_loop)
id_bhvCustomizableLaunchpad = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_customizable_launchpad_init, bhv_customizable_launchpad_loop)
id_bhvBlock = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_block_init, bhv_block_loop)
