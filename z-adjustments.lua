if unsupported then return end

djui_set_popup_disabled_override(true)

gServerSettings.skipIntro = 1

gServerSettings.stayInLevelAfterStar = 2

gServerSettings.bubbleDeath = 0

gLevelValues.cellHeightLimit = 32767
gLevelValues.floorLowerLimit = -32768
gLevelValues.floorLowerLimitMisc = -31768
gLevelValues.floorLowerLimitShadow = -31768

hud_hide()