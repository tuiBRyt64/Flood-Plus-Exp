-- Full credit goes to EmeraldLockdown for the enemy system

if unsupported then return end

enemies = {
    { name = "Amp", bhvs = { id_bhvCirclingAmp, id_bhvHomingAmp }, active = true, default = true },
    { name = "Boo", bhvs = { id_bhvBoo, id_bhvBooInCastle, id_bhvBalconyBigBoo, id_bhvGhostHuntBigBoo, id_bhvMerryGoRoundBigBoo }, active = true, default = true },
    { name = "Bob-omb", bhvs = { id_bhvBobomb }, active = true, default = true },
    { name = "Bookend", bhvs = { id_bhvFlyingBookend, id_bhvBookendSpawn }, active = true, default = true },
    { name = "Bullet Bill", bhvs = { id_bhvBulletBill, id_bhvBulletBillCannon }, active = true, default = true },
    { name = "Bully", bhvs = { id_bhvBigBully, id_bhvBigBullyWithMinions, id_bhvSmallBully, id_bhvBigChillBully, id_bhvSmallChillBully }, active = true, default = true },
    { name = "Bubba", bhvs = { id_bhvBubba }, active = true, default = true },
    { name = "Chuckya", bhvs = { id_bhvChuckya }, active = true, default = true },
    { name = "Clam", bhvs = { id_bhvClamShell }, active = true, default = true },
    { name = "Fly Guy", bhvs = { id_bhvFlyGuy }, active = true, default = true },
    { name = "Goomba", bhvs = { id_bhvGoomba, id_bhvGoombaTripletSpawner }, active = true, default = true },
    { name = "Heave-Ho", bhvs = { id_bhvHeaveHo, id_bhvHeaveHoThrowMario }, active = true, default = true },
    { name = "Klepto", bhvs = { id_bhvKlepto }, active = true, default = true },
    { name = "Koopa Troopa", bhvs = { id_bhvKoopa }, active = true, default = true },
    { name = "Lakitu", bhvs = { id_bhvEnemyLakitu }, active = true, default = true },
    { name = "Mad Piano", bhvs = { id_bhvMadPiano }, active = true, default = true },
    { name = "Manta Ray", bhvs = { id_bhvMantaRay }, active = true, default = true },
    { name = "Moneybags", bhvs = { id_bhvMoneybag, id_bhvMoneybagHidden }, active = true, default = true },
    { name = "Mr. Blizzard", bhvs = { id_bhvMrBlizzard, id_bhvMrBlizzardSnowball }, active = true, default = true },
    { name = "Mr. I", bhvs = { id_bhvMrI, id_bhvMrIBody, id_bhvMrIBlueCoin }, active = true, default = true },
    { name = "Piranha Plant", bhvs = { id_bhvPiranhaPlant, id_bhvFirePiranhaPlant }, active = true, default = true },
    { name = "Pokey", bhvs = { id_bhvPokey, id_bhvPokeyBodyPart }, active = true, default = true },
    { name = "Scuttlebug", bhvs = { id_bhvScuttlebug, id_bhvScuttlebugSpawn }, active = true, default = true },
    { name = "Skeeter", bhvs = { id_bhvSkeeter, id_bhvSkeeterWave }, active = true, default = true },
    { name = "Snufit", bhvs = { id_bhvSnufit, id_bhvScuttlebugSpawn }, active = true, default = true },
    { name = "Spindel", bhvs = { id_bhvSpindel }, active = true, default = true },
    { name = "Spindrift", bhvs = { id_bhvSpindrift }, active = true, default = true },
    { name = "Spiny", bhvs = { id_bhvSpiny }, active = true, default = true },
    { name = "Sushi", bhvs = { id_bhvSushiShark }, active = true, default = true }, -- tasty
    { name = "Swoop", bhvs = { id_bhvSwoop }, active = true, default = true },
    { name = "Thwomp", bhvs = { id_bhvThwomp, id_bhvThwomp2, id_bhvGrindel, id_bhvHorizontalGrindel }, active = true, default = true },
    { name = "Tox Box", bhvs = { id_bhvToxBox }, active = true, default = true },
    { name = "Whomp", bhvs = { id_bhvSmallWhomp }, active = true, default = true },
}

local function mario_update()
    -- loop through all enemies and delete if they're not active
    for _, enemy in pairs(enemies) do
        if not enemy.active then
            for _, bhvId in pairs(enemy.bhvs) do
                obj_mark_for_deletion(obj_get_first_with_behavior_id(bhvId))
            end
        end
    end
end

hook_event(HOOK_MARIO_UPDATE, mario_update)