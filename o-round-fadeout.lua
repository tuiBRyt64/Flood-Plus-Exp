if unsupported then return end

local function on_hud_render()
    if not gGlobalSyncTable.roundFadeout then gGlobalSyncTable.alpha = 0 return end

    if  gGlobalSyncTable.timer < 50
    and gGlobalSyncTable.roundState == ROUND_STATE_ACTIVE
    and gGlobalSyncTable.roundFadeout then
        if network_is_server() and gGlobalSyncTable.alpha <= 255 then
            gGlobalSyncTable.alpha = gGlobalSyncTable.alpha + 5.11
        end
        djui_hud_set_adjusted_color(0, 0, 0, gGlobalSyncTable.alpha)
        djui_hud_render_rect(0, 0, 8192, 8192)
        fade_volume_scale(0, 0, 17)
    end
end

hook_event(HOOK_ON_HUD_RENDER, on_hud_render)