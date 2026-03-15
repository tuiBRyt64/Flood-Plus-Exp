gLobbys = {}

local function flood_api_define_lobby(level, area, customStartPos)
    table.insert(gLobbys, {
        level = level,
        area = area,
        customStartPos = customStartPos
    })
end

-- Hacerla accesible globalmente
_G.flood_define_lobby = flood_api_define_lobby

local function flood_load_lobbys()
    game = GAME_VANILLA

    flood_api_define_lobby(LEVEL_CASINO, 1, { x = -8325, y = 5550, z = -1500, a = 0 })
end