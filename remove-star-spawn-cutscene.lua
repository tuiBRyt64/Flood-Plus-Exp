-- removes the star spawn cutscene, created by Sunk

if unsupported then return end

function remove_timestop()
    ---@type MarioState
    local m = gMarioStates[0]
    ---@type Camera
    local c = gMarioStates[0].area.camera

    if m == nil or c == nil then
        return
    end

    if (c.cutscene == CUTSCENE_STAR_SPAWN) or (c.cutscene == CUTSCENE_RED_COIN_STAR_SPAWN) or (c.cutscene == CUTSCENE_ENTER_BOWSER_ARENA) then
        disable_time_stop_including_mario()
        m.freeze = 0
        c.cutscene = 0
    end
end

hook_event(HOOK_UPDATE, remove_timestop)