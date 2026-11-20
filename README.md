<div align="center">

<a href="https://eltruism.com/">
  <img src="https://github.com/eltreum0/eltreum0.github.io/raw/main/logohq.webp" alt="Eltruism Logo" width="500">
</a>

### Premium ElvUI Plugin & Complete Interface Suite for World of Warcraft

<p align="center">
  <a href="https://discord.gg/cXfA56gmYW"><img src="https://img.shields.io/badge/Discord-Join%20Community-5865F2?style=flat-square&logo=discord&logoColor=white" alt="Discord"></a>
  <a href="https://github.com/eltreum0/eltruism/releases"><img src="https://img.shields.io/github/downloads/eltreum0/eltruism/total?color=steelblue&style=flat-square&logo=github&label=Downloads" alt="GitHub Downloads"></a>
  <a href="https://www.curseforge.com/wow/addons/elvui-eltruism"><img src="https://img.shields.io/curseforge/dt/459494?color=f16436&style=flat-square&logo=curseforge&logoColor=white&label=CurseForge" alt="CurseForge"></a>
  <a href="https://addons.wago.io/addons/elvui-eltruism"><img src="https://img.shields.io/badge/Wago.io-Eltruism-c1272d?style=flat-square" alt="Wago"></a>
  <a href="https://eltruism.com/"><img src="https://img.shields.io/badge/Website-eltruism.com-38bdf8?style=flat-square" alt="Website"></a>
  <a href="https://www.patreon.com/eltreum"><img src="https://img.shields.io/badge/Patreon-Support-f96854?style=flat-square&logo=patreon&logoColor=white" alt="Patreon"></a>
</p>

<p align="center">
  <a href="#about"><b>About</b></a> &bull;
  <a href="#features"><b>Features</b></a> &bull;
  <a href="#screenshots"><b>Screenshots</b></a> &bull;
  <a href="#addon-profiles"><b>Addon Profiles</b></a> &bull;
  <a href="#installation"><b>Installation</b></a> &bull;
  <a href="#chat-commands"><b>Chat Commands</b></a> &bull;
  <a href="https://github.com/eltreum0/eltruism/blob/main/Changelog.md"><b>Changelog</b></a> &bull;
  <a href="#credits"><b>Credits</b></a>
</p>

</div>

<p align="center">
  <img src="https://github.com/eltreum0/eltreum0.github.io/raw/main/bar.webp" width="100%" height="4px" alt="---">
</p>

## About

**Eltruism** is a feature-rich ElvUI plugin that extends ElvUI with extensive customizations, signature gradients, combat voice alerts, and tailored interface profiles for World of Warcraft.

The **DPS/Tank**, **Healer**, **Thin Mode**, and **Alternative Group Frame** layouts are handcrafted for 16:9 displays and thoroughly tested across 1080p, 1440p, 4K, and Ultrawide resolutions.

Every single feature in Eltruism is **100% modular** and can be toggled on or off to match your personal preference, with an organized in-game **Help** tab featuring quick-action fixes.

> [!IMPORTANT]
> Eltruism is an ElvUI plugin and requires **[ElvUI](https://www.tukui.org/download.php/ui=elvui)** to function.

<p align="center">
  <img src="https://github.com/eltreum0/eltreum0.github.io/raw/main/bar.webp" width="100%" height="4px" alt="---">
</p>

## Features

- **Tailored Profiles & Thin Mode:** Handcrafted DPS/Tank, Healer, Thin Mode, and Alternative Group Frame layouts with debuff-focused raid anchors and 1-click fader toggling (`/eltruism fader`).
- **Signature Gradients:** Smooth color gradients across Unitframes, Raid Frames, Nameplates, Castbars, Aurabars, and Damage Meters powered by cached Lua color tables.
- **Custom Glow Engine:** Replaces Blizzard spell procs across Action Bars, Pet Bar, Unitframes, and Nameplates with six styles (Pixel, Autocast, Border Pulse, Bling, Proc, Blizzard), Dispel Glow with Pixel fallback, Shaman totem element colors, and 3-color animated gradients.
- **Rectangle Minimap & Button Bar:** `16:9`, `4:3`, or `2:1` rectangular minimap (or classic circle) with Questie pin masking, plus a movable skinned Minimap Button Bar with mouseover fade and combat hiding.
- **Hold to Cast Fix:** Fixes Blizzard's Press and Hold Casting on ElvUI ActionBars in Retail & Forever with optional spell macro conversion, auto-upgrading ranks, and `/eltruism holdtocast`.
- **Blizzard Damage Meter Skin:** Styles Blizzard's Damage Meter in Retail & Forever with gradient bars, shadows, mouseover menu, right-chat embed with out-of-combat hiding, and customizable Class or Specialization icon packs.
- **Dynamic Threat Nameplates:** Dynamic height scaling, threat-colored borders, integrated power bars, aura glows, and separate enemy castbar target display.
- **Cursor Casts, GCD & Cooldowns:** Rotating HUD rings anchored to your cursor displaying cast progress, GCD, combat status, and ability cooldown flashes across Retail, Forever, and Classic, with 15 ring textures and optional sound alerts.
- **Cooldown Pulse & TTS Alerts:** Pulsing on-screen cooldown ready icons paired with optional Text-To-Speech spell announcements, custom allow/ignore lists, and pet spell tracking across Retail, Forever, and Classic.
- **Smart Questing & Quest Item Bar:** Automatically track only quests in your current zone/map, keep objectives positioned reliably after leveling up, and use the rewritten movable Quest Item Bar with keybinds and ActionBar 1 sync.
- **Sleek Shadows, Themes & Skins:** Fine-tuned soft frame shadows, Dark & Light modes, transparent unitframe health (`/eltruism transparent`), unified interrupt castbars, Ace3-matched DBM skin, FollowTheArrow skin, and enhanced Character, Inspect, and Quest skins.
- **Engine-Wide Combat Performance:** Optimized hooks, texture lookups, and color caching across shadows, gradients, borders, tooltips, and nameplates, plus `/eltruism performance` and `/eltruism encountercheck`.
- **Secret Tracker, Alt Setup & Help:** Monitor modern addon restriction states live with the Secret State Tracker DataText (Retail & Forever), set up alts in one command via `/eltruism newchar`, and browse the categorized in-game **Help** tab with quick actions.
- **Instant Fast Loot & Wishlist:** Zero-lag instant auto-looting, a standalone movable LootText engine without Blizzard CombatText dependency, automated junk selling, and a personal loot wishlist that auto-removes obtained drops.
- **Chat Levels, `!keys` & Group Finder:** Difficulty-colored player levels, font-scaled race/gender icons, inline item icons, smooth chat fade, `!keys` / `/!keys` keystone sharing with automatic pedestal slotting, plus Mythic+ Group Finder spec icons, rating, and region tags.
- **Waypoints, Bags & Portrait Crests:** Enhanced `/way` waypoints with travel ETA and pin naming, 1-click bag buttons (Rogue poisons, Fishing, professions), HD Rare/Boss portrait crests with 3D models, and Forever ranged swing timer auto-hide.
- **Encounter, Boss & Duel Music:** Contextual combat playlists, custom boss encounter themes, 1v1 Duel music with in-game previews, relaxing AFK screens with 3D character models, and animated mail notifications with custom sounds or TTS.
- **Multi-Expansion & Modular:** Actively maintained for Midnight (Retail), World of Warcraft Forever, Mists of Pandaria Classic, Wrath Titan Reforged, Burning Crusade Anniversary, and Classic Era.

<p align="center">
  <img src="https://github.com/eltreum0/eltreum0.github.io/raw/main/bar.webp" width="100%" height="4px" alt="---">
</p>

## Screenshots

<p align="center">
  <em>Click any preview image to open the full-resolution 4K screenshot.</em>
</p>

<p align="center">
  <b>DPS &amp; Tank Profile</b><br>
  <sub>Streamlined combat layout with centered actionbars, dynamic resource trackers, Details! &amp; Damage Meter skinning, and non-intrusive raid anchors.</sub>
</p>
<p align="center">
  <a href="https://raw.githubusercontent.com/eltreum0/eltreum0.github.io/main/Preview1Full.webp">
    <img src="https://github.com/eltreum0/eltreum0.github.io/raw/main/Preview1.webp" alt="DPS & Tank Profile Preview" width="850">
  </a>
</p>

<p align="center">
  <b>Healer Profile</b><br>
  <sub>Optimized central layout with debuff-focused party &amp; raid frames, gradient health bars, out-of-range fading, and dedicated mana monitors.</sub>
</p>
<p align="center">
  <a href="https://raw.githubusercontent.com/eltreum0/eltreum0.github.io/main/Preview2Full.webp">
    <img src="https://github.com/eltreum0/eltreum0.github.io/raw/main/Preview2.webp" alt="Healer Profile Preview" width="850">
  </a>
</p>

<p align="center">
  <b>Themes &amp; Skins</b><br>
  <sub>Modern soft shadows, character panel enhancements, quest dialogue restyling, transparent unitframe health, and bespoke borders.</sub>
</p>
<p align="center">
  <a href="https://raw.githubusercontent.com/eltreum0/eltreum0.github.io/main/Preview3Full.webp">
    <img src="https://github.com/eltreum0/eltreum0.github.io/raw/main/Preview3.webp" alt="Dark & Light Skins Preview" width="850">
  </a>
</p>

<p align="center">
  <b>Dynamic Nameplates &amp; Castbars</b><br>
  <sub>Gradient nameplates with dynamic height, threat-colored borders, integrated power bars, aura glows, and unified interrupt castbars.</sub>
</p>
<p align="center">
  <a href="https://raw.githubusercontent.com/eltreum0/eltreum0.github.io/main/Preview4Full.webp">
    <img src="https://github.com/eltreum0/eltreum0.github.io/raw/main/Preview4.webp" alt="Nameplates & Castbars Preview" width="850">
  </a>
</p>

<p align="center">
  <img src="https://github.com/eltreum0/eltreum0.github.io/raw/main/bar.webp" width="100%" height="4px" alt="---">
</p>

## Addon Profiles

The Eltruism installer includes tailored profiles for the following companion addons:

- **[Details! Damage Meter](https://www.curseforge.com/wow/addons/details)**
- **[BigWigs](https://www.curseforge.com/wow/addons/big-wigs)**
- **[Capping](https://www.curseforge.com/wow/addons/capping-bg-timers)**
- **[Deadly Boss Mods (DBM)](https://www.curseforge.com/wow/addons/deadly-boss-mods)**
- **[DynamicCam](https://www.curseforge.com/wow/addons/dynamiccam)**
- **[Immersion](https://www.curseforge.com/wow/addons/immersion)**
- **[Questie](https://www.curseforge.com/wow/addons/questie)**
- **[Gladdy](https://www.curseforge.com/wow/addons/gladdy-classic)**
- **[Nameplate Scrolling Combat Text](https://www.curseforge.com/wow/addons/nameplate-scrolling-combat-text)**
- **[WarpDeplete](https://www.curseforge.com/wow/addons/warpdeplete)**
- **[ElvUI Floating Combat Text](https://github.com/kodewdle/ElvUI_FCT/)**

### Dedicated UI & Addon Skins

Eltruism also includes cohesive visual skins for Blizzard and companion addons:

- Blizzard Damage Meter (Retail & Forever)
- Ace3 & ElvUI Frames
- Cell
- Auctionator
- BugSack
- RareScanner
- FollowTheArrow
- SimpleAddonManager
- Clique
- SimulationCraft
- Hekili
- PallyPower
- OmniCD & WeakAuras Options (Classic)

<p align="center">
  <img src="https://github.com/eltreum0/eltreum0.github.io/raw/main/bar.webp" width="100%" height="4px" alt="---">
</p>

## Installation

1. **Install ElvUI:** Download and extract the latest version of **[ElvUI](https://www.tukui.org/download.php/ui=elvui)** into your World of Warcraft `_retail_/Interface/AddOns` (or classic equivalent) folder.
2. **Download Eltruism:** Install Eltruism via the **[CurseForge App](https://www.curseforge.com/wow/addons/elvui-eltruism)**, **[Wago App](https://addons.wago.io/addons/elvui-eltruism)**, or manually from **[GitHub Releases](https://github.com/eltreum0/eltruism/releases)**.
3. **Run In-Game Installer:** Launch World of Warcraft. The setup installer will greet you automatically, or open `/eltruism` anytime to customize modules, browse the **Help** tab, or run `/eltruism newchar` on alts.

<p align="center">
  <img src="https://github.com/eltreum0/eltreum0.github.io/raw/main/bar.webp" width="100%" height="4px" alt="---">
</p>

## Chat Commands

All primary configuration and utilities can be accessed via `/eltruism`:

### General & Setup

| Command | Action |
| :--- | :--- |
| `/eltruism` *(or `/eltruism config` / `/eltruism options`)* | Opens the Eltruism configuration options menu |
| `/eltruism setup` *(or `/eltruism install` / `/eltruism installer`)* | Opens the Eltruism setup installer |
| `/eltruism help` | Prints the full list of available Eltruism slash commands in chat |
| `/eltruism newchar` | Runs Chat Setup, CVars, and Edit Mode layout setup on the current character |
| `/eltruism update` | Resets/updates Eltruism settings to Eltreum's official defaults |
| `/eltruism autoupdate` | Toggles automatic updating of Eltruism settings when updating versions |
| `/eltruism fader` | Toggles ElvUI UnitFrame and ActionBar fading on/off |
| `/eltruism elvuiskin` | Toggles the Eltruism ElvUI skin template |
| `/eltruism weakauras` | Toggles ActionBars, UnitFrames, and Powers layout to be similar to WeakAuras |
| `/eltruism paging` `[1-10]` | Swaps ActionBar paging between Bar 1 and Bar 4, or switches to a specific bar |

### Visuals & Themes

| Command | Action |
| :--- | :--- |
| `/eltruism transparent` | Toggles unitframes transparent health mode on/off |
| `/eltruism color` | Toggles unitframes between light and dark modes |
| `/eltruism gradient` | Toggles unitframe and interface gradient mode |
| `/eltruism chat` | Toggles chat window between dark and transparent modes |
| `/eltruism background` | Toggles unitframe background between grey and black |
| `/eltruism autoadjust` | Toggles borders automatically adjusting the layout for DPS & Healer profiles |
| `/eltruism togglemodels` | Toggles 3D portrait and frame models on/off |
| `/eltruism universalborders` | Toggles test mode to enable borders across all ElvUI frames |
| `/eltruism universalshadows` | Toggles test mode to enable shadows across all ElvUI frames |

### Gameplay & Convenience

| Command | Action |
| :--- | :--- |
| `/eltruism holdtocast` | Toggles the Press and Hold Casting fix on ElvUI ActionBars in Retail & Forever *(also `/eltruism holdtocastdiag` and `/eltruism holdtocastrestore`)* |
| `/eltruism detailshide` | Toggles automatically hiding Details! damage meter out of combat |
| `/way <x> <y> [title]` *(or `/waypoint`)* | Sets a map waypoint coordinate with distance, ETA, and arrow navigation |
| `/eway <x> <y> [title]` *(or `/ewaypoint`)* | Sets a map waypoint (used when TomTom is detected to avoid command conflicts) |
| `!keys` *(or `!key` / `/!keys` / `/!key`)* | Links your active Mythic+ or Delve keystone to party, guild, or raid chat and auto-slots it at the pedestal |

### Performance & Utilities

| Command | Action |
| :--- | :--- |
| `/eltruism performance` | Optimizes performance by applying CVars and disabling heavy functions |
| `/eltruism performancecvars` | Applies CVars to optimize client performance and framerates |
| `/eltruism encountercheck` | Toggles disabling non-essential functions during boss encounters |
| `/eltruism loot` | Demonstrates the movable Eltruism LootText alert |
| `/eltruism modeldebug` | Prints your current target's 3D portrait model FileID |
| `/eltruismdebug on` / `off` | Toggles debug mode (disables third-party addons and enables Lua script errors) |
| `/eltruism screenshotcomparison` | Automatically captures sequential screenshots across Native, 720p, 1080p, 1440p, and 4K |

<p align="center">
  <img src="https://github.com/eltreum0/eltreum0.github.io/raw/main/bar.webp" width="100%" height="4px" alt="---">
</p>

## Credits

> Eltruism was originally based on **[LuckyoneUI](https://github.com/Luckyone961/LuckyoneUI)**. Credits and sincere gratitude to **Luckyone** for allowing its use and inspiration.
