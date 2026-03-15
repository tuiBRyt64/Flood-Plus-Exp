-- This file contains the entire API for Flood + that external mods can utilize.
-- Here you can learn how your mod can interact with Flood + using various functions.

if unsupported then return end

_G.floodPlus = {
    -- Adds a level to the gLevels table.
    -- See a-levels.lua for more info on how
    -- you can add a level.
    add_level = function (levelData)
        table.insert(gLevels, { name = levelData.name, level = levelData.level, area = levelData.area, flagPos = levelData.flagPos, speed = levelData.speed, type = levelData.type, startPos = levelData.startPos, floodScale = levelData.floodScale, unwantedBhvs = levelData.unwantedBhvs, overrideName = levelData.overrideName, overrideWater = levelData.overrideWater, floodHeight = levelData.floodHeight, pipes = levelData.pipes, launchpads = levelData.launchpads, capTimer = levelData.capTimer, act = levelData.act, overrideSlide = levelData.overrideSlide, powerUp = levelData.powerUp, music = levelData.music, skybox = levelData.skybox, separator = levelData.separator, blocks = levelData.blocks, blockScale = levelData.blockScale })

        FLOOD_LEVEL_COUNT = FLOOD_LEVEL_COUNT + 1
    end,

    -- Adds a lobby to the gLobbies table.
    -- You can control the level, area, and spawn for your lobby.
    add_lobby = function (lobbyData)
        table.insert(gLobbies, { level = lobbyData.level, area = lobbyData.area, spawn = lobbyData.spawn, unwantedBhvs = lobbyData.unwantedBhvs, overrideWater = lobbyData.overrideWater, pipes = lobbyData.pipes, launchpads = lobbyData.launchpads, music = lobbyData.music, skybox = lobbyData.skybox })
    end,

    -- Gets the current game/romhack.
    -- See a-levels.lua for all of the game IDs (integers)
    get_game = function ()
        return game
    end,

    -- Creates a custom Flood + popup.
    create_popup = create_popup,

    -- Adds a lobby song.
    add_lobby_song = function (id, name)
        table.insert(gLobbySongs, { id = id, name = name })
    end,

    -- Gets the current flood type.
    -- See a-levels.lua for all of the flood type IDs (integers)
    get_type = function ()
        return gLevels[gGlobalSyncTable.level].type
    end,

    -- Gets the current level.
    -- This allows you to check many things about a specific level.
    get_current_level = function ()
        return gLevels[gGlobalSyncTable.level]
    end,

    -- Gets the current round state.
    -- See main.lua for all of the round state IDs (integers)
    get_round_state = function ()
        return gGlobalSyncTable.roundState
    end
}