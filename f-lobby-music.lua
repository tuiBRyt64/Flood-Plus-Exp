-- ID base seguro
local SEQ_LB_BASE = 35

local lobbySequences = {}
local seqIndex = 0

-- Agregar LB.m64 primero
local lbSeq = SEQ_LB_BASE + seqIndex
smlua_audio_utils_replace_sequence(lbSeq, 0x25, 30, "LB")
table.insert(lobbySequences, lbSeq)
seqIndex = seqIndex + 1

-- Crear lobby_00 hasta lobby_63
for i = 0, 63 do
    local seqId = SEQ_LB_BASE + seqIndex
    local name = string.format("lobby_%02d", i)

    smlua_audio_utils_replace_sequence(seqId, 0x25, 30, name)

    table.insert(lobbySequences, seqId)
    seqIndex = seqIndex + 1
end

-- Agregar 02_creepy_cavern.m64
local creepySeq = SEQ_LB_BASE + seqIndex
smlua_audio_utils_replace_sequence(creepySeq, 0x25, 30, "02_creepy_cavern")
table.insert(lobbySequences, creepySeq)

-- Música random en el lobby
local level_music = {
    [LEVEL_LOBBY] = lobbySequences
}

local function on_level_music()
    local level = gNetworkPlayers[0].currLevelNum

    if level_music[level] then
        local musicList = level_music[level]
        local chosenSeq = musicList[math.random(#musicList)]

        set_background_music(0, chosenSeq, 60)
    end
end

hook_event(HOOK_ON_LEVEL_INIT, on_level_music)
hook_event(HOOK_ON_WARP, on_level_music)