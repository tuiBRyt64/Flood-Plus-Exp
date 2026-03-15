local deTimer = 0

local function update()
    if deTimer < 60 then
        deTimer = deTimer + 1
    end
    if deTimer == 30 then
        djui_chat_message_create("Welcome to \\#3e5f9c\\Flood \\#00ff00\\+ \\#39c5ff\\Exp")
    end
end

hook_event(HOOK_UPDATE, update)