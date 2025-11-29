Config = {}

---------------------------------
-- shop settings
---------------------------------
Config = {
    FishmongerShopItems = {
        { name = 'weapon_fishingrod', amount = 50, price = 10 },
        { name = 'p_baitbread01x',    amount = 50, price = 0.25 },
        { name = 'p_baitcorn01x',     amount = 50, price = 0.25 },
        { name = 'p_baitcheese01x',   amount = 50, price = 0.25 },
        { name = 'p_baitworm01x',     amount = 50, price = 0.50 },
        { name = 'p_baitcricket01x',  amount = 50, price = 0.50 },
        { name = 'p_crawdad01x',      amount = 50, price = 0.50 },
        { name = 'fishtrap',          amount = 50, price = 5.00 },
        { name = 'trapbait',          amount = 50, price = 0.25 },  
    },
    PersistStock = true, --should stock save in database and load it after restart, to 'remember' stock value before restart
}

---------------------------------
-- settings
---------------------------------
Config.Debug          = false
Config.KeyBind        = 'J'
Config.SellTime       = 10000
Config.EnableTarget   = true
Config.RequireNearNPC = true

---------------------------------
-- npc settings
---------------------------------
Config.DistanceSpawn = 20.0
Config.FadeIn        = true

---------------------------------
-- webhook settings
---------------------------------
Config.WebhookName = 'rex-fishmonger'
Config.WebhookTitle = 'Rex Fishmonger'
Config.WebhookColour = 'default'
Config.Lang1 = ' Sold items to the Fishmonger for a total of $'

---------------------------------
-- SELLABLE FISH (price per fish)
---------------------------------
Config.SellableFish = {

    -- Small Fish
    a_c_fishbluegil_01_sm        = 0.10,
    a_c_fishbullheadcat_01_sm    = 0.10,
    a_c_fishchainpickerel_01_sm  = 0.10,
    a_c_fishperch_01_sm          = 0.10,
    a_c_fishredfinpickerel_01_sm = 0.10,
    a_c_fishrockbass_01_sm       = 0.10,

    -- Medium Fish
    a_c_fishbluegil_01_ms        = 0.35,
    a_c_fishbullheadcat_01_ms    = 0.35,
    a_c_fishchainpickerel_01_ms  = 0.35,
    a_c_fishlargemouthbass_01_ms = 0.35,
    a_c_fishperch_01_ms          = 0.35,
    a_c_fishrainbowtrout_01_ms   = 0.35,
    a_c_fishredfinpickerel_01_ms = 0.35,
    a_c_fishrockbass_01_ms       = 0.35,
    a_c_fishsalmonsockeye_01_ml  = 0.35,
    a_c_fishsalmonsockeye_01_ms  = 0.35,
    a_c_fishsmallmouthbass_01_ms = 0.35,

    -- Large Fish
    a_c_fishchannelcatfish_01_lg = 0.50,
    a_c_fishchannelcatfish_01_xl = 0.50,
    a_c_fishlakesturgeon_01_lg   = 0.50,
    a_c_fishlargemouthbass_01_lg = 0.50,
    a_c_fishlongnosegar_01_lg    = 0.50,
    a_c_fishmuskie_01_lg         = 0.50,
    a_c_fishnorthernpike_01_lg   = 0.50,
    a_c_fishrainbowtrout_01_lg   = 0.50,
    a_c_fishsalmonsockeye_01_lg  = 0.50,
    a_c_fishsmallmouthbass_01_lg = 0.50,

    -- pot fishing
    crayfish  = 0.10,
    crab      = 0.20,
    bluecrab  = 0.30,
    lobster   = 0.50,

}

---------------------------------
-- PROCESSABLE FISH → raw_fish amount per fish
---------------------------------
Config.ProcessableFish = {
    -- Small → 1 raw_fish
    a_c_fishbluegil_01_sm        = 1,
    a_c_fishbullheadcat_01_sm    = 1,
    a_c_fishchainpickerel_01_sm  = 1,
    a_c_fishperch_01_sm          = 1,
    a_c_fishredfinpickerel_01_sm = 1,
    a_c_fishrockbass_01_sm       = 1,

    -- Medium → 2 raw_fish
    a_c_fishbluegil_01_ms        = 2,
    a_c_fishbullheadcat_01_ms    = 2,
    a_c_fishchainpickerel_01_ms  = 2,
    a_c_fishlargemouthbass_ms    = 2,
    a_c_fishperch_01_ms          = 2,
    a_c_fishrainbowtrout_01_ms   = 2,
    a_c_fishredfinpickerel_01_ms = 2,
    a_c_fishrockbass_01_ms       = 2,
    a_c_fishsalmonsockeye_01_ml  = 2,
    a_c_fishsalmonsockeye_01_ms  = 2,
    a_c_fishsmallmouthbass_01_ms = 2,

    -- Large → 3 raw_fish
    a_c_fishchannelcatfish_01_lg = 2,
    a_c_fishchannelcatfish_01_xl = 2,
    a_c_fishlakesturgeon_01_lg   = 2,
    a_c_fishlargemouthbass_01_lg = 2,
    a_c_fishlongnosegar_01_lg    = 2,
    a_c_fishmuskie_01_lg         = 2,
    a_c_fishnorthernpike_01_lg   = 2,
    a_c_fishrainbowtrout_01_lg   = 2,
    a_c_fishsalmonsockeye_01_lg  = 2,
    a_c_fishsmallmouthbass_01_lg = 2,
}

---------------------------------
-- blip settings
---------------------------------
Config.Blip = {
    blipName = 'Fish Monger', -- Config.Blip.blipName
    blipSprite = 'blip_mg_fishing', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

---------------------------------
-- prompt locations
---------------------------------
Config.FishMongerLocations = {
    {   --st denis
        name = 'St Denis Fish Monger',
        prompt = 'stdenis-fishmonger',
        coords = vector3(2662.2517, -1505.653, 45.968982),
        npcmodel = `cs_fishcollector`,
        npccoords = vector4(2661.7463, -1506.055, 45.968948, 321.56686),
        showblip = true
    }, 
    {   --valentine
        name = 'Valentine Fish Monger',
        prompt = 'valentine-fishmonger',
        coords = vector3(-335.5372, 761.984, 116.58402),
        npcmodel = `cs_fishcollector`,
        npccoords = vector4(-335.4444, 762.00537, 116.5845, 45.516292),
        showblip = true
    }, 
    {   -- rhodes
        name = 'Rhodes Fish Monger',
        prompt = 'rhodes-fishmonger',
        coords = vector3(1292.9488, -1274.879, 75.814758),
        npcmodel = `cs_fishcollector`,
        npccoords = vector4(1292.9885, -1273.963, 75.870391, 181.20063),
        showblip = true
    }, 
    {   -- annesburg
        name = 'Annesburg Fish Monger',
        prompt = 'annesburg-fishmonger',
        coords = vector3(3017.9001, 1352.2457, 42.735687),
        npcmodel = `cs_fishcollector`,
        npccoords = vector4(3018.2368, 1352.096, 42.713443, 23.409223),
        showblip = true
    },
    {   -- vanhorn
        name = 'Van Horn Fish Monger',
        prompt = 'vanhorn-fishmonger',
        coords = vector3(2991.6115, 558.83947, 44.355224),
        npcmodel = `cs_fishcollector`,
        npccoords = vector4(2991.539, 558.93402, 44.357906, 4.9385623),
        showblip = true
    },
    {   -- blackwater
        name = 'Blackwater Fish Monger',
        prompt = 'blackwater-fishmonger',
        coords = vector3(-724.5062, -1253.603, 44.734111),
        npcmodel = `cs_fishcollector`,
        npccoords = vector4(-723.9387, -1254.361, 44.734092, 49.674472),
        showblip = true
    },
    {   -- tumbleweed
        name = 'Tumbleweed Fish Monger',
        prompt = 'tumbleweed-fishmonger',
        coords = vector3(-5513.275, -2943.476, -2.025686),
        npcmodel = `cs_fishcollector`,
        npccoords = vector4(-5513.404, -2944.167, -2.001027, 29.520355),
        showblip = true
    }, 
    {   -- river
        name = 'River Fish Monger',
        prompt = 'river-fishmonger',
        coords = vector3(-1451.595, -2685.068, 41.228832),
        npcmodel = `cs_fishcollector`,
        npccoords = vector4(-1452.24, -2684.517, 41.256187, 221.86631),
        showblip = false
    },
}
