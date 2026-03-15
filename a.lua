local SEQ_DEMON = 0x7D
local SEQ_HELL = 106

smlua_audio_utils_replace_sequence(SEQ_DEMON, 37, 30, "demon")
smlua_audio_utils_replace_sequence(SEQ_HELL,19,   175, "og-ctt")

local level_music = {
    [LEVEL_TEST] = SEQ_DEMON,
    [LEVEL_HELL] = SEQ_HELL,
}

local function on_level_music()
    local level = gNetworkPlayers[0].currLevelNum
    if level_music[level] then
        set_background_music(0, level_music[level], 60)
    end
end

hook_event(HOOK_ON_LEVEL_INIT, on_level_music)
hook_event(HOOK_ON_WARP, on_level_music)