-- This is the behaviors for levels Flood Casino and SMW Underground
local abs = math.abs
local sin = math.sin
local tan = math.tan
local insert = table.insert
PURPLE_SWITCH_IDLE = 0
PURPLE_SWITCH_PRESSED = 1
PURPLE_SWITCH_TICKING = 2
PURPLE_SWITCH_UNPRESSED = 3
PURPLE_SWITCH_WAIT_FOR_MARIO_TO_GET_OFF = 4

define_custom_obj_fields({
    oFallTimer = "s32",
    oPreviousPlayers = "s32",
})

----------------------------------------------------
-- SMW LOG
----------------------------------------------------

local function bhv_smw_log_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 7000
    o.collisionData = COL_SMW_LOG
    o.header.gfx.skipInViewCheck = true

    o.oHomeX = o.oPosX
    o.oHomeY = o.oPosY
    o.oHomeZ = o.oPosZ
    o.oPreviousPlayers = 0

    obj_scale(o, 1)

    network_init_object(o, false, {
        "oPosX",
        "oPosY",
        "oPosZ",
        "oAction"
    })
end

local function bhv_smw_log_loop(o)
    load_object_collision_model()

    if o.oAction == 0 then
        if network_is_server() then
            local players = {}

            for i = 0, MAX_PLAYERS - 1 do
                if gMarioStates[i].marioObj.platform == o then
                    insert(players, i)
                end
            end

            o.oPreviousPlayers = #players
            o.oPosY = approach_f32_asymptotic(o.oPosY, o.oHomeY - #players * 32, 0.25)

            network_send_object(o, false)
        end
    end

    cur_obj_move_using_vel()
end

----------------------------------------------------
-- POKER CHIP
----------------------------------------------------

local function bhv_poker_chip_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 7000
    o.collisionData = COL_POKER_CHIP
    o.oAngleVelYaw = 256
    o.header.gfx.skipInViewCheck = true

    o.oHomeX = o.oPosX
    o.oHomeY = o.oPosY
    o.oHomeZ = o.oPosZ

    obj_scale(o, 1.25)
end

local function bhv_poker_chip_loop(o)
    load_object_collision_model()
    o.oPosY = o.oHomeY + tan(sin((o.oTimer - o.oBehParams2ndByte * 15) / 30) * 1.4) * 16
    cur_obj_rotate_face_angle_using_vel()
end

----------------------------------------------------
-- WINGCAP GIVER
----------------------------------------------------

local function bhv_wingcap_giver_init(o)
    obj_set_hitbox_radius_and_height(o, 512, 64)
end

local function bhv_wingcap_giver_loop(o)
    local m = gMarioStates[0]

    if o.oAction == 0 and obj_check_hitbox_overlap(o, m.marioObj) then
        m.flags = m.flags | MARIO_WING_CAP
        m.pos.y = m.pos.y + 512
        m.capTimer = 256
        m.vel.y = 1024
        set_mario_action(m, ACT_FLYING_TRIPLE_JUMP, 0)
        mario_set_forward_vel(m, 96)
        o.oAction = 1

    elseif o.oAction == 1 and o.oTimer > 30 then
        o.oAction = 0
    end
end

----------------------------------------------------
-- SMW LAUNCHER
----------------------------------------------------

local function bhv_launcher_init(o)
    obj_set_hitbox_radius_and_height(o, 512, 64)
end

local function bhv_launcher_loop(o)
    local m = gMarioStates[0]

    if o.oAction == 0 and obj_check_hitbox_overlap(o, m.marioObj) then
        m.pos.y = m.pos.y + 512
        m.vel.y = 8192
        m.faceAngle.y = o.oMoveAngleYaw
        set_mario_action(m, ACT_TRIPLE_JUMP, 0)
        mario_set_forward_vel(m, 48)

        o.oAction = 1

    elseif o.oAction == 1 and o.oTimer > 30 then
        o.oAction = 0
    end
end

----------------------------------------------------
-- P-SWITCH (MOP STYLE SIMPLE)
----------------------------------------------------

local PSWITCH_TIME = 300 -- 10 segundos (30fps)

function bhv_pswitch_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 1000
    o.oAction = PURPLE_SWITCH_IDLE
    o.oTimer = 0

    obj_set_hitbox_radius_and_height(o, 128, 64)

    network_init_object(o, false, {
        "oAction",
        "oTimer"
    })
end

function bhv_pswitch_loop(o)
    local m = gMarioStates[0]

    load_object_collision_model()

    -- IDLE
    if o.oAction == PURPLE_SWITCH_IDLE then
        if obj_check_hitbox_overlap(o, m.marioObj) then
            if network_is_server() then
                o.oAction = PURPLE_SWITCH_TICKING
                o.oTimer = 0
                cur_obj_play_sound_2(SOUND_GENERAL_ACTIVATE_CAP_SWITCH)
                network_send_object(o, false)
            end
        end
    end

    -- TICKING
    if o.oAction == PURPLE_SWITCH_TICKING then
        if network_is_server() then
            o.oTimer = o.oTimer + 1

            if o.oTimer >= PSWITCH_TIME then
                o.oAction = PURPLE_SWITCH_UNPRESSED
                o.oTimer = 0
                network_send_object(o, false)
            end
        end
    end

    -- RESET
    if o.oAction == PURPLE_SWITCH_UNPRESSED then
        if network_is_server() then
            o.oAction = PURPLE_SWITCH_IDLE
            network_send_object(o, false)
        end
    end
end

----------------------------------------------------
-- HOOKS
----------------------------------------------------

id_bhvSmwLog = hook_behavior(nil, OBJ_LIST_SURFACE, true,
    bhv_smw_log_init,
    bhv_smw_log_loop,
    "bhvSmwLog"
)

id_bhvPokerChip = hook_behavior(nil, OBJ_LIST_SURFACE, true,
    bhv_poker_chip_init,
    bhv_poker_chip_loop,
    "bhvPokerChip"
)

id_bhvSmwWingcapGiver = hook_behavior(nil, OBJ_LIST_SURFACE, true,
    bhv_wingcap_giver_init,
    bhv_wingcap_giver_loop,
    "bhvSmwWingcapGiver"
)

id_bhvSmwLauncher = hook_behavior(nil, OBJ_LIST_SURFACE, true,
    bhv_launcher_init,
    bhv_launcher_loop,
    "bhvSmwLauncher"
)

bhvPSwitch_MOP = hook_behavior(nil, OBJ_LIST_SURFACE, false,
    bhv_pswitch_init,
    bhv_pswitch_loop
)