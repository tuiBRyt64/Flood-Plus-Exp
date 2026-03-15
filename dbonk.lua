-- Remove double bonks by Sunk

if unsupported then return end

---@param m MarioState
---@param landAction integer
---@param hardFallAction integer
---@param animation CharacterAnimID | integer
---@param speed number
---@return integer
local function common_air_knockback_step(m, landAction, hardFallAction, animation, speed)
    if not m then return 0 end
    local stepResult = 0

    if gServerSettings.playerInteractions ~= PLAYER_INTERACTIONS_NONE then
        if m.knockbackTimer == 0 then
            if not m.interactObj or m.interactObj.oInteractType & INTERACT_PLAYER == 0 then
                mario_set_forward_vel(m, speed)
            end
        else
            m.knockbackTimer = 10
        end
    else
        mario_set_forward_vel(m, speed)
    end

    stepResult = perform_air_step(m, 0)
    if stepResult == AIR_STEP_NONE then
        set_character_animation(m, animation)
    elseif stepResult == AIR_STEP_LANDED then
        if m.action == ACT_SOFT_BONK then
            queue_rumble_data_mario(m, 5, 40)
        end
        if check_fall_damage_or_get_stuck(m, hardFallAction) == 0 then
            if m.action == ACT_THROWN_FORWARD or m.action == ACT_THROWN_BACKWARD then
                set_mario_action(m, landAction, m.hurtCounter)
            else
                set_mario_action(m, landAction, m.actionArg)
            end
        end
    elseif stepResult == AIR_STEP_HIT_WALL then
        set_character_animation(m, CHAR_ANIM_BACKWARD_AIR_KB)
        mario_bonk_reflection(m, 0)

        if m.vel.y > 0.0 then
            m.vel.y = 0.0
        end

        mario_set_forward_vel(m, -speed)
    elseif stepResult == AIR_STEP_HIT_LAVA_WALL then
        lava_boost_on_wall(m)
    end
    return stepResult
end

---@param m MarioState
local function act_backward_air_kb(m)
    if check_wall_kick(m) ~= 0 then
        return true
    end

    play_knockback_sound(m)
    common_air_knockback_step(m, ACT_BACKWARD_GROUND_KB, ACT_HARD_BACKWARD_GROUND_KB, 0x0002, -16.0)
    return false
end

hook_mario_action(ACT_BACKWARD_AIR_KB, act_backward_air_kb)

-------------------------------------------------------------------------