-- =========================
-- FLOOD MODEL TOGGLE SYSTEM
-- =========================

local E_MODEL_FLOOD_EXPANDED = smlua_model_util_get_id("flood_expanded_geo")
local E_MODEL_FLOOD_OG       = smlua_model_util_get_id("flood_og_geo")
local E_MODEL_FLOOD_PLUS     = smlua_model_util_get_id("flood_plus_geo")

local function set_flood_model(model)
    gPlayerSyncTable[0].modelId = model
end

-- IMPORTANT: commands need to be idk xd

hook_chat_command("expflood", "Active flood expanded flood model", function()
    set_flood_model(E_MODEL_FLOOD_EXPANDED)
    djui_chat_message_create("Flood model changed to expanded")
end)

hook_chat_command("floodog", "Active OG flood model", function()
    set_flood_model(E_MODEL_FLOOD_OG)
    djui_chat_message_create("Flood model changed to OG")
end)

hook_chat_command("fplusflood", "Active Flood plus flood model", function()
    set_flood_model(E_MODEL_FLOOD_PLUS)
    djui_chat_message_create("Flood model changed to Plus")
end)