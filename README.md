# Rex Fishmonger - Documentation

## Overview

**Rex Fishmonger** is a complete fishing economy system for RedM servers using the RSG-Core framework. The script provides fishmonger NPCs across the map where players can sell caught fish, process raw fish into meat, and purchase fishing supplies.

**Version:** 2.0.7  
**Framework:** RSG-Core  
**Dependencies:** rsg-core, ox_lib, rsg-inventory

---

## Features

- **Multiple Fishmonger Locations:** 8 fishmonger NPCs across the Red Dead world
- **Sell Fish:** Players can sell caught fish for cash
- **Process Fish:** Convert caught fish into raw_fish and trapbait
- **Fish Shop:** Purchase fishing equipment and bait
- **Persistent Stock:** Optional database-backed shop inventory
- **NPC Management:** Dynamic NPC spawning and despawning based on distance
- **Target Integration:** Optional ox_target support for interaction
- **Webhook Logging:** Automatic Discord logging of fish sales
- **Localization:** Full support for multiple languages (en.json)

---

## Installation

1. **Add dependency to your resources folder:**
   - Place `rex-fishmonger` folder in your resources directory
   - Ensure `rsg-core`, `ox_lib`, and `rsg-inventory` are installed

2. **Add to server.cfg:**
   ```
   ensure rsg-core
   ensure ox_lib
   ensure rsg-inventory
   ensure rex-fishmonger
   ```

3. **Database setup (Optional):**
   - If `PersistStock` is enabled, the shop inventory will persist across restarts
   - No manual database setup required—RSG-Inventory handles this automatically

---

## File Structure

```
rex-fishmonger/
├── fxmanifest.lua              # Resource manifest and dependencies
├── config.lua                  # Configuration and settings
├── client/
│   ├── client.lua             # Client-side menu and UI
│   └── npcs.lua               # NPC spawning and management
├── server/
│   ├── server.lua             # Server-side events and shops
│   └── versionchecker.lua     # Update notifications
├── locales/
│   └── en.json                # English language strings
└── installation/
    └── shared_items.lua       # Item definitions reference
```

---

## Configuration

### Main Settings (`config.lua`)

#### Shop Items
```lua
Config.FishmongerShopItems = {
    { name = 'weapon_fishingrod', amount = 50, price = 10 },
    { name = 'p_baitbread01x',    amount = 50, price = 0.25 },
    { name = 'p_baitcorn01x',     amount = 50, price = 0.25 },
    { name = 'p_baitcheese01x',   amount = 50, price = 0.25 },
    { name = 'p_baitworm01x',     amount = 50, price = 0.50 },
    { name = 'p_baitcricket01x',  amount = 50, price = 0.50 },
    { name = 'p_crawdad01x',      amount = 50, price = 0.50 },
    { name = 'fishtrap',          amount = 50, price = 5.00 },
    { name = 'trapbait',          amount = 50, price = 0.25 },  
}

Config.PersistStock = true  -- Save/load shop inventory across restarts
```

#### General Settings
```lua
Config.Debug = false                -- Enable debug mode
Config.KeyBind = 'J'               -- Keybind for opening menu (without Target)
Config.SellTime = 10000            -- Duration of sell/process animation (ms)
Config.EnableTarget = true         -- Use ox_target for interactions
```

#### NPC Settings
```lua
Config.DistanceSpawn = 20.0        -- Distance to spawn NPCs (units)
Config.FadeIn = true               -- Fade in/out NPCs when spawning
```

#### Webhook Settings (Discord)
```lua
Config.WebhookName = 'rex-fishmonger'
Config.WebhookTitle = 'Rex Fishmonger'
Config.WebhookColour = 'default'
Config.Lang1 = ' Sold items to the Fishmonger for a total of $'
```

#### Fish Prices (Sell Value)
```lua
Config.FishPrice = {
    Small     = 0.10,   -- Small fish
    Medium    = 0.35,   -- Medium fish
    Large     = 0.50,   -- Large fish
    Crayfish  = 0.35,
    Lobster   = 0.50,
    Crab      = 0.35,
    BlueCrab  = 0.50,
}
```

#### Fish Processing Yields
```lua
Config.FishAmount = {
    Small  = 1,   -- Small fish → 1 raw_fish + 1 trapbait
    Medium = 2,   -- Medium fish → 2 raw_fish + 2 trapbait
    Large  = 3,   -- Large fish → 3 raw_fish + 3 trapbait
}
```

#### Blip Settings (Map Marker)
```lua
Config.Blip = {
    blipName = 'Fish Monger',
    blipSprite = 'blip_mg_fishing',
    blipScale = 0.2
}
```

#### Fishmonger Locations
```lua
Config.FishMongerLocations = {
    {
        name = 'St Denis Fish Monger',
        prompt = 'stdenis-fishmonger',
        coords = vector3(2662.2517, -1505.653, 45.968982),
        npcmodel = `cs_fishcollector`,
        npccoords = vector4(2661.7463, -1506.055, 45.968948, 321.56686),
        showblip = true
    },
    -- Additional 7 locations: Valentine, Rhodes, Annesburg, Van Horn, Blackwater, Tumbleweed, River
}
```

---

## Supported Fish

### Small Fish (0.10 each)
- `a_c_fishbluegil_01_sm`
- `a_c_fishbullheadcat_01_sm`
- `a_c_fishchainpickerel_01_sm`
- `a_c_fishperch_01_sm`
- `a_c_fishredfinpickerel_01_sm`
- `a_c_fishrockbass_01_sm`

### Medium Fish (0.35 each)
- `a_c_fishbluegil_01_ms`
- `a_c_fishbullheadcat_01_ms`
- `a_c_fishchainpickerel_01_ms`
- `a_c_fishlargemouthbass_01_ms`
- `a_c_fishperch_01_ms`
- `a_c_fishrainbowtrout_01_ms`
- `a_c_fishredfinpickerel_01_ms`
- `a_c_fishrockbass_01_ms`
- `a_c_fishsalmonsockeye_01_ml`
- `a_c_fishsalmonsockeye_01_ms`
- `a_c_fishsmallmouthbass_01_ms`

### Large Fish (0.50 each)
- `a_c_fishchannelcatfish_01_lg`
- `a_c_fishchannelcatfish_01_xl`
- `a_c_fishlakesturgeon_01_lg`
- `a_c_fishlargemouthbass_01_lg`
- `a_c_fishlongnosegar_01_lg`
- `a_c_fishmuskie_01_lg`
- `a_c_fishnorthernpike_01_lg`
- `a_c_fishrainbowtrout_01_lg`
- `a_c_fishsalmonsockeye_01_lg`
- `a_c_fishsmallmouthbass_01_lg`

### Shellfish
- `crayfish` (0.35)
- `lobster` (0.50)
- `crab` (0.35)
- `bluecrab` (0.50)

---

## Events

### Client Events

#### `rex-fishmonger:client:mainmenu`
Opens the main fishmonger menu with three options:
- Sell Fish
- Process Fish
- Open Shop

**Triggered by:** NPC interaction or prompt

**Example:**
```lua
TriggerEvent('rex-fishmonger:client:mainmenu')
```

#### `rex-fishmonger:client:selltofishmonger`
Initiates the sell animation/progress bar and triggers fish selling.

**Triggered by:** "Sell Fish" menu option

#### `rex-fishmonger:client:processfish`
Initiates the process animation and triggers fish processing.

**Triggered by:** "Process Fish" menu option

#### `rex-fishmonger:client:playerprocessfish`
Server command version to trigger fish processing.

**Triggered by:** `/processfish` command

---

### Server Events

#### `rex-fishmonger:server:sellfish`
Processes fish sale transaction.
- Checks player's inventory for fish
- Calculates total sale price based on fish types and quantities
- Removes fish from inventory
- Adds cash to player account
- Logs transaction to Discord webhook

**Triggered by:** Client after sell progress bar completes

#### `rex-fishmonger:server:processfish`
Converts caught fish into raw_fish and trapbait.
- Removes caught fish from inventory
- Adds raw_fish (based on size multiplier)
- Adds trapbait (1:1 ratio with raw_fish)

**Triggered by:** Client after process progress bar completes

#### `rex-fishmonger:server:openShop`
Opens the fishmonger shop inventory for the player.

**Triggered by:** "Open Shop" menu option

**Example:**
```lua
TriggerEvent('rex-fishmonger:server:openShop')
```

---

## Commands

### `/processfish`
- **Description:** Process fish in your inventory into raw_fish
- **Permission:** user
- **Usage:** Type `/processfish` in chat
- **Requirements:** Must have caught fish in inventory; knife required if using `/processfish`

---

## Server Functions

### Sell Fish Event Handler
**Event:** `rex-fishmonger:server:sellfish`

Processes the sale of all fish in a player's inventory:
1. Validates player exists
2. Iterates through inventory items
3. For each matching fish item:
   - Retrieves price from `Config.FishPrice`
   - Multiplies by quantity
   - Removes item from inventory
4. Adds total cash to player
5. Logs to Discord webhook

**Example Sale Calculation:**
```
2x Small Fish @ 0.10 = 0.20
3x Medium Fish @ 0.35 = 1.05
1x Large Fish @ 0.50 = 0.50
Total: 1.75 cash
```

### Process Fish Event Handler
**Event:** `rex-fishmonger:server:processfish`

Converts caught fish to raw materials:
1. Validates player exists
2. Iterates through inventory items
3. For each matching fish item:
   - Retrieves amount from `Config.FishAmount` (based on size)
   - Multiplies by quantity
   - Removes original fish from inventory
4. Adds raw_fish to inventory
5. Adds trapbait to inventory (1:1 with raw_fish)

**Example Processing:**
```
3x Medium Fish (yield 2 each) = 6 raw_fish + 6 trapbait
2x Large Fish (yield 3 each) = 6 raw_fish + 6 trapbait
Total: 12 raw_fish, 12 trapbait
```

---

## Client Functions

### NPC Spawning (`client/npcs.lua`)

#### `NearPed(npcmodel, npccoords)`
Spawns and configures a fishmonger NPC.

**Parameters:**
- `npcmodel` (hash): NPC model hash
- `npccoords` (vector4): Position and heading

**Behavior:**
- Loads model asynchronously
- Creates ped at specified location (z-1.0)
- Sets random outfit variation
- Makes invincible and prevents targeting
- Fade in effect if enabled
- Registers with ox_target if enabled
- Returns ped entity handle

**Example:**
```lua
local ped = NearPed(`cs_fishcollector`, vector4(2661.7463, -1506.055, 45.968948, 321.56686))
```

### NPC Management Loop
Runs every 500ms:
- Checks distance to each fishmonger location
- Spawns NPCs when player gets close (`Config.DistanceSpawn`)
- Despawns NPCs when player moves away
- Handles fade in/out animations

---

## Localization

The script uses ox_lib's locale system. Language strings are stored in `/locales/en.json`:

```json
{
    "cl_lang_1": "Open",                          -- NPC interaction label
    "cl_lang_2": "Fish Monger Menu",             -- Menu title
    "cl_lang_3": "Sell Fish",                    -- Menu option
    "cl_lang_4": "Sell your fish to the monger",
    "cl_lang_5": "Open Fish Monger Shop",
    "cl_lang_6": "buy fishing items from the shop",
    "cl_lang_12": "Fishmonger Checking...",      -- Sell progress bar
    "cl_lang_13": "Process Fish",                -- Menu option
    "cl_lang_14": "process fish into raw fish meat",
    "cl_lang_15": "Processing Fish",             -- Process progress bar
    "cl_lang_16": "Knife Needed!",               -- Error title
    "cl_lang_17": "you need a knife to process fish", -- Error desc
    "sv_lang_1": "No Fish!",                     -- Server error
    "sv_lang_2": "you don't have any fish to sell",
    "sv_lang_3": "you don't have any fish to process",
    "sv_lang_4": "Player Process Fish"           -- Command description
}
```

To add a new language, create `/locales/[lang].json` with the same keys and translated values.

---

## Webhook Integration

The script logs fish sales to Discord via `rsg-log` framework:

**Logged Information:**
- Player name
- Amount of cash earned
- Timestamp (automatic)

**Format:**
```
Player: [PlayerName]
Sold items to the Fishmonger for a total of $[Amount]
```

**Requirements:**
- `rsg-log` resource must be installed
- Discord webhook configured in rsg-log

**Configuration:**
```lua
Config.WebhookName = 'rex-fishmonger'    -- Log channel identifier
Config.WebhookTitle = 'Rex Fishmonger'   -- Embed title
Config.WebhookColour = 'default'         -- Embed color
```

---

## Dependencies

### Required
- **rsg-core:** Core framework for player management and functions
- **ox_lib:** UI framework (progress bars, notifications, menus, localization)
- **rsg-inventory:** Shop and inventory management system

### Optional
- **ox_target:** For target-based NPC interaction (set `Config.EnableTarget = true`)
- **rsg-log:** For Discord webhook logging

---

## Troubleshooting

### NPCs not appearing
- Check `Config.DistanceSpawn` value (default: 20.0)
- Verify NPC models exist (use `cs_fishcollector`)
- Ensure client scripts are loading

### Fish not selling
- Verify fish item names match server inventory
- Check player has at least one supported fish
- Review server console for errors
- Confirm `rsg-inventory` is running

### Progress bar freezes
- Check `Config.SellTime` (should be 8000-15000ms)
- Ensure `Wait()` calls in loops (npcs.lua respects this)

### Shop not opening
- Verify `rsg-inventory` is running
- Check shop name in config matches server
- Ensure player has permission level to access

### Webhook not logging
- Verify `rsg-log` is installed and configured
- Check Discord webhook URL in rsg-log config
- Ensure `Config.WebhookName` matches a configured log channel

---

## Performance Tips

1. **NPC Spawning:** Adjust `Config.DistanceSpawn` to balance visibility vs. performance
2. **Persistent Stock:** Use `Config.PersistStock = false` on low-resource servers
3. **Keybind:** Prefer `Config.EnableTarget = true` over keybinds for reduced input overhead

---

## Adding Locations

To add a new fishmonger location, add an entry to `Config.FishMongerLocations`:

```lua
{
    name = 'Unique Location Name',
    prompt = 'unique-prompt-id',
    coords = vector3(x, y, z),              -- Player interaction location
    npcmodel = `cs_fishcollector`,
    npccoords = vector4(x, y, z, heading),  -- NPC spawn location
    showblip = true                         -- Show on map
}
```

Then run `/refresh` to reload the resource.

---

## Adding Custom Fish

To add support for additional fish types:

1. Add item price to `Config.FishPrice`:
   ```lua
   Config.FishPrice.CustomFish = 0.75
   ```

2. Add processing amount to `Config.FishAmount` if applicable

3. Add catch logic in both `rex-fishmonger:server:sellfish` and `rex-fishmonger:server:processfish` events:
   ```lua
   elseif Player.PlayerData.items[k].name == 'custom_fish_item' then
       price = price + (Config.FishPrice.CustomFish * Player.PlayerData.items[k].amount)
       Player.Functions.RemoveItem('custom_fish_item', Player.PlayerData.items[k].amount, k)
       hasfish = true
   ```

---

## License

See LICENSE.md for licensing information.

---

## Support

For issues or feature requests, contact the script author or your server administrator.

**Version:** 2.0.7  
**Last Updated:** 2024
