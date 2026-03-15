unsupported = false

-- Paintings

TEX_B1_PAINTING = get_texture_info("b1_painting") -- Bowser 1 Painting
TEX_B2_PAINTING = get_texture_info("bitfs_painting") -- Bowser 2 Painting
TEX_B3_PAINTING = get_texture_info("b3_painting") -- Bowser 3 Painting
TEX_BBH_PAINTING = get_texture_info("bbh_painting") -- BBH Painting
TEX_BOB_PAINTING = get_texture_info("bob_painting") -- BOB Painting
TEX_HMC_PAINTING = get_texture_info("br_painting") -- HMC Painting
TEX_DDD_PAINTING = get_texture_info("bs_painting") -- DDD Painting
TEX_CCM_PAINTING = get_texture_info("ccm_painting") -- CCM Painting
TEX_CG_PAINTING = get_texture_info("cg_painting") -- CG Painting
TEX_W8RC_PAINTING = get_texture_info("ithi_painting") -- W8RC Painting
TEX_PYRAMID_PAINTING = get_texture_info("itp_painting") -- Pyramid Painting
TEX_JRB_PAINTING = get_texture_info("jrb_painting") -- JRB Painting
TEX_LLL_PAINTING = get_texture_info("lll_painting") -- LLL Painting
TEX_WMOTR_PAINTING = get_texture_info("painting_gs_cq")  -- WMOTR Painting
TEX_RR_PAINTING = get_texture_info("rr_painting") -- RR Painting
TEX_SL_PAINTING = get_texture_info("sl_painting") -- SL Painting
TEX_SSL_PAINTING = get_texture_info("ssl_painting") -- SSL Painting
TEX_THI_PAINTING = get_texture_info("thi_painting") -- THI [BIG AND SMALL] Painting
TEX_TTC_PAINTING = get_texture_info("ttc_painting") -- TTC Painting
TEX_TTM_PAINTING = get_texture_info("ttm_painting") -- TTM Painting
TEX_WDW_PAINTING = get_texture_info("wdw_painting") -- WDW Painting
TEX_VCUTM_PAINTING = get_texture_info("vcutm_painting") -- VCUTM Painting
TEX_WF_PAINTING = get_texture_info("wf_painting") -- WF Painting

-- Custom Paintings

TEX_AP_PAINTING = get_texture_info("ap_painting") -- AP Painting
TEX_CCM_SLIDE_PAINTING = get_texture_info("ccm_slide_painting") -- CCM Slide Painting
TEX_CONSTRUCT_PAINTING = get_texture_info("construct_painting") -- Construct Painting
TEX_COTMC_PAINTING = get_texture_info("cotmc_painting") -- COTMC Painting
TEX_FCS_PAINTING = get_texture_info("fcs_painting") -- FCS Painting
TEX_TPSS_PAINTING = get_texture_info("pss_painting") -- TPSS Painting
TEX_MC_PAINTING = get_texture_info("mc_painting") -- MC Painting
TEX_UP_PAINTING = get_texture_info("up_painting") -- UP Painting
TEX_CTT_PAINTING = get_texture_info("ctt_painting") -- CTT Painting
TEX_SMW_PAINTING = get_texture_info("smw_painting") -- SMW Painting
TEX_CS_PAINTING = get_texture_info("casino_painting") -- UP Painting

FLOOD_WATER     = 0
FLOOD_LAVA      = 1
FLOOD_SAND      = 2
FLOOD_MUD       = 3
FLOOD_SNOW      = 4
FLOOD_WASTE     = 5
FLOOD_DESERT    = 6
FLOOD_ACID      = 7
FLOOD_POISON    = 8
FLOOD_SUNSET    = 9
FLOOD_FROSTBITE = 10
FLOOD_CLOUDS    = 11
FLOOD_RAINBOW   = 12
FLOOD_DARKNESS  = 13
FLOOD_MAGMA     = 14
FLOOD_SULFUR    = 15
FLOOD_COTTON    = 16
FLOOD_MOLTEN    = 17
FLOOD_OIL       = 18
FLOOD_MATRIX    = 19
FLOOD_BUP       = 20
FLOOD_TIDE      = 21
FLOOD_DARKTIDE  = 22
FLOOD_VOLCANO   = 23
FLOOD_REDTIDE   = 24
FLOOD_OPTIC     = 25

FLOOD_BONUS_LEVELS = 0
FLOOD_LEVEL_COUNT = 0

LEVEL_LOBBY = LEVEL_LB
LEVEL_CTT = LEVEL_SA
LEVEL_MC = level_register('level_mc_entry', COURSE_NONE, 'Mountain Chog', 'Mountain Chog', 28000, 0x28, 0x28, 0x28)
LEVEL_CONSTRUCT = level_register('level_co_entry', COURSE_NONE, 'gm_construct', 'gm_construct', 28000, 0x28, 0x28, 0x28)
LEVEL_AVALANCHE = level_register('level_ap_entry', COURSE_NONE, 'Avalanche Peaks', 'Avalanche Peaks', 28000, 0x28, 0x28, 0x28)
LEVEL_CS = level_register('level_cs_entry', COURSE_NONE, 'Crystal Slide', 'Crystal Slide', 28000, 0x28, 0x28, 0x28)
LEVEL_SMW_RETRO = level_register('level_smwretro_entry', COURSE_NONE, 'SMW Underground', 'SMW Underground', 28000, 0x28, 0x28, 0x28)
LEVEL_CASINO = level_register('level_casino_entry', COURSE_NONE, 'Flood Casino', 'Flood Casino', 28000, 0x28, 0x28, 0x28)
LEVEL_UP = level_register('level_up_entry', COURSE_NONE, 'up', 'up', 28000, 0x28, 0x28, 0x28)
LEVEL_BIRDSLAIR = level_register('level_birdslair_entry', COURSE_NONE, "Bird's lair", "Bird's lair", 28000, 0x28, 0x28, 0x28)
LEVEL_LOBBY = level_register('level_lobby_entry', COURSE_NONE, "ZERO LIFE", "ZERO LIFE", 28000, 0x28, 0x28, 0x28)
LEVEL_ISLES = level_register("level_isles_entry", COURSE_NONE, "Sunshine Isles", "isles", 28000, 0x28, 0x28, 0x28)
LEVEL_NS = level_register('level_ns_entry', COURSE_NONE, 'Starry Night Sky', 'ns', 28000, 0x28, 0x28, 0x28) -- Special thanks to Blocky.cmd for the "Starry Night Sky" level
LEVEL_TEST = level_register("level_test_entry", COURSE_NONE, "Chief Chilly's Frosty Lair", "chilly", 28000, 0x28, 0x28, 0x28)
------------Brutal Mario 64--------
LEVEL_LB = level_register('level_lb_entry', COURSE_NONE, 'MCDONALDS', 'MCDONALDS', 28000, 0x28, 0x28, 0x28)
LEVEL_HELL = level_register('level_hell_entry', COURSE_NONE, 'Hell!', 'Hell!', 28000, 0x28, 0x28, 0x28)

GAME_VANILLA = 0
GAME_STAR_ROAD = 1

game = GAME_VANILLA

--- @class FloodLevel
--- @field public level          integer
--- @field public name           string
--- @field public goalPos        Vec3f
--- @field public speed          number
--- @field public area           integer
--- @field public type           integer
--- @field public customStartPos Vec3f
--- @field public painting       TextureInfo

--- @type FloodLevel[]
gLevels = {}
-- localize functions to improve performance
local table_insert,djui_popup_create = table.insert,djui_popup_create

---@param bonus boolean
---@param level LevelNum
---@param name string
---@param goalPos Vec3f
---@param speed number
---@param area integer
---@param type integer
---@param customStartPos Vec3f?
---@param painting TextureInfo?
local function flood_define_level(bonus, level, name, goalPos, speed, area, type, customStartPos, painting)
    table_insert(gLevels,
    {
        level = level,
        name = name,
        goalPos = goalPos,
        speed = speed,
        area = area,
        type = type,
        customStartPos = customStartPos,
        painting = painting
    })

    if bonus then FLOOD_BONUS_LEVELS = FLOOD_BONUS_LEVELS + 1 end
    FLOOD_LEVEL_COUNT = FLOOD_LEVEL_COUNT + 1
end
_G.flood_define_level = flood_define_level

local function flood_load_vanilla_levels()
    game = GAME_VANILLA

 -- flood_define_level(bonus, level, name,
 --                    goal position,
 --                    speed, area, type, start pos, painting)

    flood_define_level(false, LEVEL_BOB, "bob",
                       { x = 3082, y = 4293, z = -4612, a = 0x0000 },
                       2.5, 1, FLOOD_WATER, nil, TEX_BOB_PAINTING)

    flood_define_level(false, LEVEL_WF, "wf",
                       { x = 414, y = 5325, z = -20, a = 0x0000 },
                       4.0, 1, FLOOD_WATER, nil, TEX_WF_PAINTING)

    flood_define_level(false, LEVEL_CCM, "ccm",
                       { x = -478, y = 3471, z = -964, a = 0x0000 },
                       5.0, 1, FLOOD_WATER, { x = 3336, y = -3800, z = 0, a = 0x0000 }, TEX_CCM_PAINTING)

    flood_define_level(false, LEVEL_BITDW, "bitdw",
                       { x = 6772, y = 2867, z = 0, a = -0x4000 },
                       4.0, 1, FLOOD_WATER, nil, TEX_B1_PAINTING)

    flood_define_level(false, LEVEL_BBH, "bbh",
                       { x = 655, y = 3277, z = 244, a = 0x8000 },
                       3.5, 1, FLOOD_WATER, nil, TEX_BBH_PAINTING)

    flood_define_level(false, LEVEL_HMC, "hmc",
                       { x = -4163, y = 2355, z = -2544, a = 0x0000 },
                       5.0, 1, FLOOD_WATER, { x = -3538, y = -3979, z = 3568, a = 0x8000 }, TEX_HMC_PAINTING)

    flood_define_level(false, LEVEL_LLL, "lll-volcano",
                       { x = 2523, y = 3591, z = -898, a = -0x8000 },
                       3.5, 2, FLOOD_LAVA,  nil, TEX_LLL_PAINTING)

    flood_define_level(false, LEVEL_SSL, "ssl-pyramid",
                       { x = 512, y = 4815, z = -551, a = 0x0000 },
                       3.0, 2, FLOOD_SAND,  nil, TEX_SSL_PAINTING)

    flood_define_level(false, LEVEL_WDW, "wdw",
                       { x = 1467, y = 4096, z = 93, a = -0x4000 },
                       4.0, 1, FLOOD_WATER, nil, TEX_WDW_PAINTING)

    flood_define_level(false, LEVEL_TTM, "ttm",
                       { x = 1053, y = 2309, z = 305, a = 0x0000 },
                       3.0, 1, FLOOD_WATER, nil, TEX_TTM_PAINTING)

    flood_define_level(false, LEVEL_THI, "thi",
                       { x = -12, y = 3891, z = -1556, a = 0x0000 },
                       4.0, 1, FLOOD_WATER, nil, TEX_THI_PAINTING)

    flood_define_level(false, LEVEL_TTC, "ttc",
                       { x = 2208, y = 7051, z = 2217, a = 0x0000 },
                       4.0, 1, FLOOD_WATER, nil, TEX_TTC_PAINTING)

    flood_define_level(false, LEVEL_BITS, "bits",
                       { x = 369, y = 6552, z = -6000, a = 0x0000 },
                       4.5, 1, FLOOD_LAVA,  nil, TEX_B3_PAINTING)

    flood_define_level(false, LEVEL_CTT, "ctt",
                       { x = 0, y = 700,   z = -1250, a = 0x0000 },
                       5.0, 1, FLOOD_LAVA,  nil, TEX_CTT_PAINTING)

    flood_define_level(true, LEVEL_RR, "rr",
                       { x = 0, y = 3468, z = -2335, a = 0x0000 },
                       3.0, 1, FLOOD_WATER, nil, TEX_RR_PAINTING)

    flood_define_level(true, LEVEL_CASTLE_GROUNDS, "castle-grounds",
                       { x = 0, y = 7583, z = -4015, a = 0x0000 },
                       5.0, 1, FLOOD_WATER, nil, TEX_CG_PAINTING)

    flood_define_level(true, LEVEL_PSS, "pss",
                       { x = 4400, y = 6144, z = -5650, a = 0x0000 },
                       6.0, 1, FLOOD_WATER, { x = -6387, y = -4000, z = 5723, a = 0x8000 }, TEX_TPSS_PAINTING)

    flood_define_level(true, LEVEL_CCM, "ccm-slide",
                       { x = -5836, y = 6656, z = -6143, a = 0x0000 },
                       6.0, 2, FLOOD_WATER, { x = -6072, y = -5836, z = -6933, a = -0x4000}, TEX_CCM_SLIDE_PAINTING)

    flood_define_level(true, LEVEL_JRB, "jrb",
                       { x = 4863, y = 1889, z = 703, a = 0x0000 },
                       1.0, 1, FLOOD_SAND,  nil, TEX_JRB_PAINTING)

    flood_define_level(true, LEVEL_LLL, "lll",
                       { x = -21, y = 768, z = -6709, a = -0x8000 },
                       1.75, 1, FLOOD_LAVA,  nil, TEX_LLL_PAINTING)

    flood_define_level(true, LEVEL_SSL, "ssl",
                       { x = -5890, y = 1024, z = -2555, a = 0x0000 },
                       2.25, 1, FLOOD_SAND,  nil, TEX_SSL_PAINTING)

    flood_define_level(true, LEVEL_DDD, "ddd",
                       { x = 3945, y = 571,   z = -1321, a = 0x0000 },
                       3.0, 1, FLOOD_SAND,  nil, TEX_DDD_PAINTING)

    flood_define_level(true, LEVEL_BITFS, "bitfs",
                       { x = 6723, y = 2899, z = 117, a = 0x0000 },
                       2.0, 1, FLOOD_LAVA,  nil, TEX_B2_PAINTING)

    flood_define_level(true, LEVEL_THI, "thi-w8rc",
                       { x = -1826, y = 1434, z = 1645, a = 0x0000 },
                       7.0, 3, FLOOD_WATER, nil, TEX_W8RC_PAINTING)

    flood_define_level(true, LEVEL_THI, "thi-small",
                       { x = -2, y = 1167, z = -467, a = 0x0000 },
                       5.5, 2, FLOOD_WATER, nil, TEX_THI_PAINTING)

    flood_define_level(true, LEVEL_COTMC, "metal",
                       { x = -13, y = 374,   z = -6136, a = 0x0000 },
                       4.0,  1, FLOOD_WATER, nil, TEX_COTMC_PAINTING)

    flood_define_level(true, LEVEL_VCUTM, "vcutm",
                       { x = -6170, y = 5734, z = -6163, a = 0x0000 },
                       17.0, 1, FLOOD_WATER, { x = 4272, y = -0, z = -4742, a = 0x8000 }, TEX_VCUTM_PAINTING)

    flood_define_level(true, LEVEL_WMOTR, "fcs",
                       { x = 3644, y = 5411, z = 2205, a = 0x0000 },
                       5.0,  1, FLOOD_WATER, { x = 5600, y = -1150, z = -377, a = 0x0000 }, TEX_FCS_PAINTING)

    flood_define_level(true, LEVEL_MC, "mc",
                       { x = -3384, y = 3700, z = -7421, a = 0x0000 },
                       4.5,  1, FLOOD_WATER, { x = 90, y = 10, z = 24, a = 0x8000 }, TEX_MC_PAINTING)

    flood_define_level(true, LEVEL_SL, "up",
                       { x = -1438, y = 10957, z = -77, a = 0x0000 },
                       4.35, 1, FLOOD_WATER, { x = 2322, y = -652, z = 8970, a = 0x8000 }, TEX_UP_PAINTING)

    flood_define_level(true, LEVEL_CONSTRUCT, "construct",
                       { x = -468, y = 5536, z = 7955, a = 0x0000 },
                       3.15, 1, FLOOD_WATER, { x = -5177, y = -635, z = -10277, a = 0x8000 }, TEX_CONSTRUCT_PAINTING)

    flood_define_level(true, LEVEL_AVALANCHE, "ap",
                       { x = 5697, y = 3950, z = -2380, a = 0x0000 },
                       2.5, 1, FLOOD_WATER, { x = -2273, y = 500, z = 400, a = 0x8000 }, TEX_AP_PAINTING)

    flood_define_level(true,  LEVEL_CS,             "cs",             { x =  4307,  y = -6703, z = -415,  a =  0x0000 }, -5.0, 1,   FLOOD_WATER, { x = 5600, y = 6400, z = -3445, a = 0x8000 })
                       
    flood_define_level(true,  LEVEL_BIRDSLAIR,      "birdslair",      { x = 671,   y = 1558,  z = 2108,  a =  0x0000 }, 4.5, 1,     FLOOD_WATER, { x = -149, y = -426, z = 42, a = 0x8000 })                
                       
    flood_define_level(true, LEVEL_SMW_RETRO, "smw",
                       { x = 2464, y = 7104, z = -5964, a = 0x0000 },
                       3, 1, FLOOD_LAVA, { x = -5164, y = 192, z = -16, a = 0x0000 }, TEX_SMW_PAINTING)

    flood_define_level(true, LEVEL_CASINO, "casino",
                       { x = -8325, y = 5550, z = -1500, a = 0x0000 },
                       4.2, 1, FLOOD_LAVA, { x = 5430, y = 0, z = -6730, a = 0x0000 }, TEX_CS_PAINTING)    
                       
    flood_define_level(true, LEVEL_ISLES,          "si",              { x = -988,    y = 735, z = -1708, a =  0x0000 }, 5.0,  1,   FLOOD_WATER,  { x = -3392, y = 61, z = 10269, a = 0x7000 })

     flood_define_level(true, LEVEL_NS,             "sns",             { x = 2994, y = 2985, z = -6086, a = -0x6000 }, 2.6, 1, FLOOD_RAINBOW, { x = -452, y = -302, z = 4387, a = 0x8000 })
  flood_define_level(true, LEVEL_NS,             "sns2",            { x = 4932, y = 2773, z = -1303, a = -0x4000 }, 2.6, 1, FLOOD_RAINBOW, { x = -1322, y = -488, z = -1640, a = 0x4000 })
flood_define_level(true, LEVEL_TEST,         "ccfl",            { x = -2927,    y = 2783, z = 8320, a =  0x9000 }, 4.3,  1,   FLOOD_FROSTBITE,  { x = 3749, y = 1095, z = 2017, a = -0x4000 })
flood_define_level(true, LEVEL_HELL, "hell",
                       { x =  60,    y =  320, z = 13606, a =  0x0000 },
                       0.5,  1, FLOOD_MAGMA, { x =  69,  y = 348,  z =  -11646,  a = 0x4000 })
flood_define_level(true, LEVEL_LOBBY, "zl",       { x = 2795,  y = -3255,  z =  -657,  a = 0x4000 }, 4.5,  1,   FLOOD_DARKNESS, { x =  -4379,  y = -3500,  z =  202,  a = 0x4000 })                                
flood_define_level(true, LEVEL_LB,           "mcd",              { x = -988,    y = 735, z = -1708, a =  0x0000 }, 2.3,  1,   FLOOD_WATER, { x =  1660,  y = 200,  z =  2146,  a = 0x4000 })

end

local function flood_load_star_road_levels()
    game = GAME_STAR_ROAD

    flood_define_level(false, LEVEL_BOB,"bob",
                       { x = 5364,  y = 1875, z = 2251, a = 0x0000 },
                       3.0,  1,   FLOOD_WATER, nil) --

    flood_define_level(false, LEVEL_WF,"wf",
                       { x = 208,   y = 2448, z = -2080, a = 0x4000 },
                       5.0,  1,   FLOOD_WATER, nil) --

    flood_define_level(false, LEVEL_CCM,"ccm",
                       { x = 3789,  y = 5600, z = -3830, a = -0x4000 },
                       2.8,  1,   FLOOD_WATER, nil) --

    flood_define_level(false, LEVEL_BITDW,"bitdw",
                       { x = -2164,  y = 556,   z = -3578, a = -0x4000 },
                       2.45, 1,   FLOOD_MUD,   nil) --

    flood_define_level(false, LEVEL_BBH,"bbh",
                       { x = 4380,  y = 2632, z = -4494, a = 0x8000 },
                       3.0,  1,   FLOOD_WATER, nil) --

    flood_define_level(false, LEVEL_HMC,"hmc",
                       { x = 2468,  y = 4160, z = -5054, a = 0x0000 },
                       3.75, 1,   FLOOD_WATER, { x = 4292, y = 2974, z = 4697, a = 0x8000} ) -- 0.75x, 4405, 2632, -4537 no base

    flood_define_level(false, LEVEL_WDW,"wdw",
                       { x = 1467,  y = 4096, z = 93, a = -0x4000 },
                       4.0,  1,   FLOOD_WATER, nil) -- messed up -3465, 2603, 879

    flood_define_level(false, LEVEL_TTM,"ttm",
                       { x = 176,   y = 2719, z = -1194, a = 0x0000 },
                       2.5,  1,   FLOOD_WATER, nil) -- flag needs no base

    flood_define_level(false, LEVEL_THI,"thi",
                       { x = -4159,  y = 735,   z = -2844, a = 0x0000 },
                       4.0,  1,   FLOOD_LAVA,  { x = -3815, y = -1070, z = 6646, a = 0x8000} ) -- needs lava

    flood_define_level(false, LEVEL_TTC,"ttc",
                       { x = 1660,  y = 3425, z = 1992, a = 0x0000 },
                       4.0,  1,   FLOOD_WATER, nil) -- 1660, 3425, 1992

    flood_define_level(false, LEVEL_BITS,"bits",
                       { x = 1861,  y = 4192, z = 841, a = 0x0000 },
                       3.25, 1,   FLOOD_LAVA,  nil) -- 0.75x, 1861, 4192, 841

    flood_define_level(false, LEVEL_CTT,"sa",
                       { x = 3762,  y = 3532, z = 2252, a = 0x0000 },
                       5,    1,   FLOOD_SAND,  { x = 5656,     y = -6010,   z = -5627, a = 0x0000 }) --

    flood_define_level(false, LEVEL_RR,"rr",
                       { x = -2668,  y = 6684, z = 7122, a = 0x0000 },
                       4.35, 1,   FLOOD_WATER, nil) -- 1.5x

    flood_define_level(false, LEVEL_PSS,"pss",
                       { x = -3415,  y = 4573, z = 2678, a = 0x0000 },
                       2.8,  1,   FLOOD_WATER, nil)

    flood_define_level(false, LEVEL_JRB,"jrb",
                       { x = -4653,  y = 3560, z = -3616, a = 0x0000 },
                       3.3,  1,   FLOOD_WATER, nil) -- -4653, 3541, -3616

    flood_define_level(false, LEVEL_LLL,"lll",
                       { x = 4315,  y = 4638, z = 3963, a = -0x8000 },
                       7,    1,   FLOOD_SAND,  nil) -- 4.5x

    flood_define_level(false, LEVEL_SSL,"ssl",
                       { x = -3756,  y = -751, z = 1514, a = 0x0000 },
                       5,    1,   FLOOD_MUD,   { x = 4361, y = -870, z = -4430, a = 0x8000} ) -- 2.6x

    flood_define_level(false, LEVEL_DDD,"ddd",
                       { x = 598,   y = 2232, z = -3389, a = 0x0000 },
                       6.0,  1,   FLOOD_WATER, { x = -5717, y = -744, z = 1258, a = 0x8000} ) -- 2x

    flood_define_level(false, LEVEL_BITFS,"bitfs",
                       { x = 3010,  y = 584,   z = 4469, a = 0x0000 },
                       1.6,  1,   FLOOD_LAVA,  nil) -- 0.8x, 3010, 584, 4469

    flood_define_level(false, LEVEL_TOTWC,"wing",
                       { x = -4212,  y = 4229, z = -4488, a = 0x8000 },
                       5.0,  1,   FLOOD_WATER, nil) -- 2x (also messed up) -4212, 4229, -4488

    flood_define_level(false, LEVEL_COTMC,"metal",
                       { x = 2038,  y = 10150, z = 4960, a = 0x0000 },
                       2,    1,   FLOOD_WATER, { x = -4212,  y = 4229, z = -4488, a = 0x8000 }) --

    flood_define_level(true, LEVEL_WMOTR,"fcs",
                       { x = 3644,  y = 5411, z = 2205, a = 0x0000 },
                       5.0,  1,   FLOOD_WATER, { x = 5600, y = -1150, z = -377, a = 0x0000 })

    flood_define_level(true, LEVEL_MC,"mc",
                       { x = -3384,  y = 3700, z = -7421, a = 0x0000 },
                       4.5,  1,   FLOOD_WATER, { x = 90, y = 10, z = 24, a = 0x8000 })

    flood_define_level(true, LEVEL_SL,"up",
                       { x = -1438,  y = 10957, z = -77, a = 0x0000 },
                       4.35, 1,   FLOOD_WATER, { x = 2322, y = -652, z = 8970, a = 0x8000 })

    flood_define_level(true, LEVEL_CONSTRUCT,"construct",
                       { x = -468,   y = 5536, z = 7955, a = 0x0000 },
                       3.15, 1,   FLOOD_WATER, { x = -5177, y = -635, z = -10277, a = 0x8000 })

    flood_define_level(true, LEVEL_AVALANCHE,"ap",
                       { x = 5697,  y = 3950, z = -2380, a = 0x0000 },
                       2.5,  1,   FLOOD_WATER, { x = -2273, y = 500, z = 400, a = 0x8000 })
        
     flood_define_level(true,  LEVEL_CS,             "cs",             { x =  4307,  y = -6703, z = -415,  a =  0x0000 }, -5.0, 1,   FLOOD_WATER, { x = 5600, y = 6400, z = -3445, a = 0x8000 })
                       
     flood_define_level(true,  LEVEL_BIRDSLAIR,      "birdslair",      { x = 671,   y = 1558,  z = 2108,  a =  0x0000 }, 4.5, 1,     FLOOD_WATER, nil)                
               
     flood_define_level(true, LEVEL_SMW_RETRO, "smw",
                       { x = -672, y = 1728, z = -3981, a = 0x0000 },
                       2.0, 1, FLOOD_LAVA, { x = -4833, y = 290, z = -123, a = 0x8000 })

    flood_define_level(true, LEVEL_CASINO, "casino",
                       { x = -7623, y = 5643, z = 3552, a = 0x0000 },
                       1.5, 1, FLOOD_WATER, { x = -1857, y = 150, z = -1191, a = 0x8000 })  

flood_define_level(true, LEVEL_UP, "up",
                       { x = -1438, y = 10957, z = -77, a = 0x0000 },
                       4.35, 1, FLOOD_WATER, { x = 3222, y = -652, z = 8970, a = 32768 })                                                                                   

    end

-- load romhack levels
for mod in pairs(gActiveMods) do
    if gActiveMods[mod].incompatible ~= nil and gActiveMods[mod].incompatible:find("romhack") then
        if gActiveMods[mod].relativePath == "star-road" then
            flood_load_star_road_levels()
        else
            unsupported = true
            djui_popup_create("\\#ff0000\\This rom hack is not supported with Flood.", 2)
        end
        break
    end
end

if not unsupported and game == GAME_VANILLA then
    flood_load_vanilla_levels()
end