-- named this way so that it loads after main.lua

if unsupported then return end

HOLIDAY_EVENT_NONE =          0
HOLIDAY_EVENT_HALLOWEEN =     1
HOLIDAY_EVENT_CHRISTMAS =     2
HOLIDAY_EVENT_NEW_YEARS_EVE = 3
HOLIDAY_EVENT_ST_PATRICKS =   4
HOLIDAY_EVENT_APRIL_FOOLS =   5
HOLIDAY_EVENT_EASTER =        6
HOLIDAY_EVENT_ANNIVERSARY =   7

holidayEvent = HOLIDAY_EVENT_NONE

local function update()
    if eFloodVariables.holidayEvents then
        if get_date_and_time().month == 9 then
            holidayEvent = HOLIDAY_EVENT_HALLOWEEN
            set_override_skybox(BACKGROUND_HAUNTED)
            set_lighting_dir(2, 100)
            set_lighting_color(1, 600)
            set_lighting_color(0, 900)
            set_vertex_color(1, 600)
            set_vertex_color(0, 900)
        elseif get_date_and_time().month == 11 and get_date_and_time().day ~= 31 then
            holidayEvent = HOLIDAY_EVENT_CHRISTMAS
            set_override_skybox(BACKGROUND_SNOW_MOUNTAINS)
            set_override_envfx(ENVFX_SNOW_BLIZZARD)
            set_lighting_dir(2, 300)
            set_lighting_color(1, 500)
            set_lighting_color(0, 200)
        elseif get_date_and_time().month == 11 and get_date_and_time().day == 31 then
            holidayEvent = HOLIDAY_EVENT_NEW_YEARS_EVE
        elseif get_date_and_time().month == 2 and get_date_and_time().day == 17 then
            holidayEvent = HOLIDAY_EVENT_ST_PATRICKS
            set_lighting_color(2, 100)
            set_lighting_color(1, 400)
            set_lighting_color(0, 340)
        elseif get_date_and_time().month == 3 and get_date_and_time().day == 1 then
            holidayEvent = HOLIDAY_EVENT_APRIL_FOOLS
        elseif get_date_and_time().month == 3 and get_date_and_time().day == 20 then
            holidayEvent = HOLIDAY_EVENT_EASTER
            set_override_skybox(BACKGROUND_BELOW_CLOUDS)
            set_lighting_color(1, 920)
            set_lighting_color(0, 500)
            set_vertex_color(1, 920)
            set_vertex_color(0, 500)
        elseif get_date_and_time().month == 11 and get_date_and_time().day == 18 then
            set_override_skybox(BACKGROUND_UNDERWATER_CITY)
            holidayEvent = HOLIDAY_EVENT_ANNIVERSARY
            set_lighting_color(1, 450)
            set_lighting_color(0, 300)
            set_vertex_color(1, 450)
            set_vertex_color(0, 300)
        end
    else
        holidayEvent = HOLIDAY_EVENT_NONE
        set_override_skybox(-1)
        set_override_envfx(-1)
        set_vertex_color(0, -1)
        set_vertex_color(1, -1)
        set_vertex_color(2, -1)
    end
end

hook_event(HOOK_UPDATE, update)