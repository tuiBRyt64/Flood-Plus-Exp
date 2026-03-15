if unsupported then return end

-- Only one left is Caec
tagsInfo = {
    ["974541020446478336"] = { tag = "[Flood + Author]", color = "\\#00FF00\\" }, -- Jzzay
    ["1221630587077398598"] = { tag = "[Lead Developer]", color = "\\#FF8EB2\\" }, -- Bear64DX
    ["490613035237507091"] = { tag = "[Original Flood Author, Tester]", color = "\\#DCDCDC\\" }, -- Agent X
    ["718693245894525002"] = { tag = "[FE Author, Developer]", color = "\\#7089B8\\" }, -- birdekek
    ["617853747854573590"] = { tag = "[Developer]", color = "\\#A5AE8F\\" }, -- EmeraldLockdown (As far as I know, he doesn't use Discord anymore, so this is kind of pointless)
    ["584329002689363968"] = { tag = "[Developer]", color = "\\#617BFF\\" }, -- Blocky
    ["1179638217914450031"] = { tag = "[Developer]", color = "\\#FC0\\" }, -- TOÑO!
    ["318399355809955843"] = { tag = "[Developer]", color = "\\#009C36\\" }, -- SuperRodrigo0
    ["1007354654671253626"] = { tag = "[Developer]", color = "\\#00FF00\\" }, -- Erikku
    ["729383909464342538"] = { tag = "[Flood Porter]", color = "\\#EC7731\\" }, -- MarcoGamerOJ
    ["1310127383143125124"] = { tag = "[Flood Porter]", color = "\\#EC7731\\" }, -- TikalSM64
    ["739231613296050267"] = { tag = "[Flood Porter, Contributor, Tester]", color = "\\#00FF00\\" }, -- SausRelics
    ["115655542617145352"] = { tag = "[Flood Porter]", color = "\\#29CCA6\\" }, -- Stew
    ["187704800366952449"] = { tag = "[Composer, Tester]", color = "\\#FF4545\\" }, -- LocaMash
    ["610479862846849024"] = { tag = "[Tester]", color = "\\#3030FF\\" }, -- bloop
    ["681692342650011709"] = { tag = "[Tester]", color = "\\#FF8800\\" }, -- benjamin11544
    ["184511170160492545"] = { tag = "[Tester]", color = "\\#FF18FF\\" }, -- AngelStar291
    ["1053818295796646051"] = { tag = "[Tester, Special Thanks]", color = "\\#316BE8\\" }, -- TheMan
    ["1000693375906893925"] = { tag = "[Tester, Special Thanks]", color = "\\#FFAA00\\" }, -- Viande
    ["708287786813358120"] = { tag = "[Tester]", color = "\\#8A8A8A\\" }, -- N64
    ["659115423769559043"] = { tag = "[Tester]", color = "\\#00FF00\\" }, -- Max_MARIO
    ["197761559601086464"] = { tag = "[Tester]", color = "\\#8C0000\\" }, -- Phenomenal Sire
    ["409438020870078486"] = { tag = "[Contributor]", color = "\\#F7B2F3\\" }, -- EmilyEmmi
    ["376426041788465173"] = { tag = "[Contributor]", color = "\\#54708C\\" }, -- Sunk
    ["767513529036832799"] = { tag = "[Contributor]", color = "\\#9C0072\\" }, -- CosmicNyan
    ["338005893377556480"] = { tag = "[Contributor]", color = "\\#480207\\" }, -- Gaming32
    ["771146325453963285"] = { tag = "[Contributor, Special Thanks]", color = "\\#FFCDAB\\" }, -- Fearl
    ["723015866308100116"] = { tag = "[Contributor, Special Thanks]", color = "\\#6D9FC9\\" }, -- Coolio
    ["806611115059445830"] = { tag = "[Contributor]", color = "\\#FF3030\\" }, -- [DT] Ryan
    ["165861686937518080"] = { tag = "[Contributor]", color = "\\#823A9E\\" }, -- kermeow
    ["1177802630152601600"] = { tag = "[Special Thanks]", color = "\\#C51DD1\\" } -- Error
}

local hasSetTag = false

local function update()
    if hasSetTag then return end
    local s = gPlayerSyncTable[0]
    local discordId = network_discord_id_from_local_index(0)

    if discordId ~= nil then
        if tagsInfo[discordId] then
            s.tag = tagsInfo[discordId].tag
            s.tagColor = tagsInfo[discordId].color
        else
            s.tag = ""
            s.tagColor = ""
        end
        hasSetTag = true
    end
end

local function tagged_name(np)
    local s = gPlayerSyncTable[np.localIndex]
    local playerColor = network_get_player_text_color_string(np.localIndex)

    if s.tag and s.tag ~= "" then
        return string.format("%s%s%s %s\\#DCDCDC\\", playerColor, np.name, s.tagColor, s.tag)
    else
        return string.format("%s%s\\#DCDCDC\\", playerColor, np.name)
    end
end

local function on_chat_message(m, msg)
    local np = gNetworkPlayers[m.playerIndex]
    local s = gPlayerSyncTable[np.localIndex]

    if s.tag and s.tag ~= "" then
        djui_chat_message_create(tagged_name(np) .. ": " .. msg)
        play_sound(SOUND_MENU_MESSAGE_DISAPPEAR, gGlobalSoundSource)
        return false
    end
    
    return true
end

hook_event(HOOK_UPDATE, update)
hook_event(HOOK_ON_CHAT_MESSAGE, on_chat_message)