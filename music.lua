-- Reemplazo de secuencias
smlua_audio_utils_replace_sequence(0x05, 0x2A, 75, "jrb")   -- JRB / Water Levels

local SEQ_CASINO = 0x7E
local SEQ_ISLES  = 0x7F

smlua_audio_utils_replace_sequence(SEQ_CASINO, 42, 62, "casino")
smlua_audio_utils_replace_sequence(SEQ_ISLES, 0x2A, 60, "isles") -- Super Mario Sunshine Delfino Plaza

-- Diccionario de niveles y sus secuencias
local level_music = {
    [LEVEL_CASINO] = SEQ_CASINO,
    [LEVEL_ISLES]  = SEQ_ISLES,
}

-- Función para reproducir la música correspondiente al nivel
local function on_level_music()
    local level = gNetworkPlayers[0].currLevelNum
    if level_music[level] then
        set_background_music(0, level_music[level], 60)
    end
end

-- Hooks para ejecutar la función al iniciar nivel o hacer warp
hook_event(HOOK_ON_LEVEL_INIT, on_level_music)
hook_event(HOOK_ON_WARP, on_level_music)