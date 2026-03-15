-- Modelo de skybox
E_MODEL_SKYBOX_MC = smlua_model_util_get_id("MCNightSkybox_geo")

local l = gLakituState

-- Inicialización del skybox
function bhv_skybox_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    obj_scale(o, 10.0)
end

-- Loop del skybox
function bhv_skybox_loop(o)
    o.oPosX = l.pos.x
    o.oPosY = l.pos.y
    o.oPosZ = l.pos.z
end

id_bhv3DSkybox = hook_behavior(bhv3DSkybox, OBJ_LIST_LEVEL, false, bhv_skybox_init, bhv_skybox_loop)

-- Función para spawnear skybox solo en LEVEL_NS y LEVEL_BOB_DEMON
function SpawnSkybox()
    local skyboxcheck = obj_get_nearest_object_with_behavior_id(o, id_bhv3DSkybox)
    local lvl = gNetworkPlayers[0].currLevelNum
    if skyboxcheck == nil and (lvl == LEVEL_NS or lvl == LEVEL_TEST) then
        spawn_non_sync_object(id_bhv3DSkybox, E_MODEL_SKYBOX_MC, l.pos.x, l.pos.y, l.pos.z, nil)
    end
end

-- Iluminación específica para LEVEL_NS
if gNetworkPlayers[0].currLevelNum == LEVEL_NS then
    set_lighting_dir(1, 40)
end

--- @param m MarioState
local function mario_update(m)
    if gNetworkPlayers[0].currLevelNum == LEVEL_NS then
        m.marioBodyState.shadeR = 52
        m.marioBodyState.shadeG = 55
        m.marioBodyState.shadeB = 95
        m.marioBodyState.lightR = 250
        m.marioBodyState.lightG = 178
        m.marioBodyState.lightB = 176
    end
end

hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_ON_LEVEL_INIT, SpawnSkybox)