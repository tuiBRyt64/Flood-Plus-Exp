local SEQ_SNS = 0x7C

smlua_audio_utils_replace_sequence(SEQ_SNS, 0x2A, 60, "sns") -- MKDS Rainbow Road

local level_music = {
    [LEVEL_NS] = SEQ_SNS,
}

local function on_level_music()
    local level = gNetworkPlayers[0].currLevelNum
    if level_music[level] then
        set_background_music(0, level_music[level], 60)
    end
end

hook_event(HOOK_ON_LEVEL_INIT, on_level_music)
hook_event(HOOK_ON_WARP, on_level_music)