# Loot Tracker
A Firefall addon that tracks in-world loot drops and provides tools to make them more prominent to the user.

You are welcome and encouraged to [leave feedback / ask for help / report issues in the addon thread](//forums.firefall.com/community/threads/4880421) on the official Firefall forums.

## Features
* Tracks Equipment, Modules, Components, Salvage and Consumable item drops.
* Highly customizable, features can be enabled or disabled separately.
* Attaches Waypoints to tracked items, helping you quickly locate drops over larger distances.
* Display a list of items currently on the ground in the HUDTracker, allowing you to keep an eye on things at a glance.
* Play Sounds and send Messages when items are dropped or looted.
* Most of the features can have different kinds of behavior depending on what kind of loot it is acting on (Filtering).

## Interface Options
** TODO: ** Finish this section. There's a lot of Options. Nearly all of them have tooltip description that you can view in-game, and many of them are similar to the descriptions here. 

### Loot Tracker
This is the top-level page of the options, available by clicking Loot Tracker in the list.
It contains several "master-switches" for various features.

| Option  | Description |
|------------- | ------------- |
| Enabled | Enable/Disable the addon. Mainly suitable if you wish to tempoarily disable the addon, without modifying any other options. Please note that this doesn't truly stop the addon from functioning - it merely suppresses actions that would otherwise signify that the addon is active. |
| Version Message | Enable/Disable the version system message sent when the addon is loaded, announcing it is active. |
| Slash Handles | Comma separated list of slash handles that the addon will register for. Requires that you reload the UI to update. |

##### Features
This is a little section containing master switches for subsystems of the addon.
For example, if you're not interested in Panels at all, you can just uncheck them here and they'll never appear, regardless of any other settings.
Likewise, if you want Sounds, you have to make sure it is enabled here.

| Option  | Description |
|------------- | ------------- |
| Enable Messages | Enable/Disable Messages subsystem of the addon. |
| Enable Panels | Enable/Disable Panels subsystem of the addon. |
| Enable Waypoints | Enable/Disable Waypoints subsystem of the addon. |
| Enable HUDTracker | Enable/Disable HUDTracker subsystem of the addon. |
| Enable Sounds | Enable/Disable Sounds subsystem of the addon. |

##### Debug
This is a little group with a couple of developer options.
Checking the Debug checkboxs so that the other options are visible means you have enabled Debug mode, which will log messages into the console that are helpful to the addon creator in order to track down problems.
I decided not to detail any of the other options in this section as they are "in-flux" and most are quite dated. Feel free to play with them if you wish.

#### Tracker
This section contains options relating to the core, tracking system of the addon.
Making changes here have consequences on how the addon handles the actual tracking of loot, the information which in turn the other systems rely on.
For most purposes, you do not need to modify these settings.

| Option  | Description |
|------------- | ------------- |
| Track Delay | Upon detecting a new item, how long to wait before starting the procedure to begin tracking it. A delay is recommended because the game sometimes gives out incorrect information, and by waiting a little before taking action those can be weeded out. However, the delay is quite noticeable when playing, so a lower value feels better. |
| Update Delay | Delay before updating an item, serves little purpose. Keep it low. |
| Remove Delay | How long to wait before removing an item after it has been looted or has despawned. A short delay is neccessary for other parts of the addon to work properly. A long delay serves no real purpose at this point. |
| Limit | The maximum number of loot drops to be tracking at once. As long as the number of loot drops on the ground exceeds this Limit, the Tracker will ignore new loot drops. The purpose of this setting is to serve as a safeguard in the event that something ridiculous happens. The ideal limit is therefore a value for which during normal gameplay is either just high enough not to bother you, or low enough to stop you from lagging. |
| Unified Update Interval | How often to verify the continued availability of all tracked loot drops. If everything is working properly, a short delay serves little purpose and a longer delay should be used. However, with a shorter delay, potential missdetections will be cleared more swiftly. |
| Individual Update Interval | How often to verify the continued availability of each tracked loot drop. If everything is working properly, a short delay serves little purpose and a longer delay could be used. However, with a shorter delay, potential missdetections will be cleared more swiftly. |
| Loot Event History Cleanup Interval | How often to check the history of lootevents and cleanup those that have expired. A longer interval might be more performance efficient, but it could cause issues with the tracking of items. |
| Loot Event History Lifetime | How long a lootevent should be valid for. A shorter lifetime should result in better accuracy when multiple items of the same kind are picked up in a short timespan, but too short may cause the addon to think items have despawned when they were looted. Longer timespans prevent the aforementioned issue, but may result in reduced accuracy in the aforementioned scenario. |
| Ignore Currency Crystite | When enabled, the Tracker ignores Crytite. Otherwise, it is tracked under the currency category. That category was added to track stuff like Crystite Resonators. |
| Ignore Metals in Tornado | When enabled, the Tracker ignores any Metals when you are inside a (known) Melding Tornado Pocket. |

#### Waypoints
This section contains options related to the Waypoints subsystem.
These settings affect all Waypoints created by the addon.

| Option  | Description |
|------------- | ------------- |
| Show On Hud | Show Waypoints on the HUD |
| Show On WorldMap | Show Waypoints on the World Map |
| Show On Radar | Show Waypoints on the Radar |
| Radar Edge Mode | Behavior for Waypoint icons on the radar when outside range and the icon attaches to the radar edge. None : Hidden, Arrow: Nonspecific arrow icon, Icon : Keep showing the same icon |

##### Filtering: Waypoints Specific
This section cover only options in the Filtering system specific to the Waypoints.
For an overview of how the Filtering section of each subsystem works, see General Filtering Options.

| Option  | Description |
|------------- | ------------- |
| Waypoint Title Format | Customize the title of the waypoints. In-game, you will be able to view a list of message replacements in the tooltip that is displayed when you hover over this field. |

#### Panels
This section contains options related to the Panels subsystem.

| Option  | Description |
|------------- | ------------- |
| Header Color | Set the color of the background of the panel header. Allows you to pick between the color of all item Rarities, or Custom. |
| Custom Header Color | Set the color of the background of the panel header for the Custom option. |
| Item Name Color | Set the color of the item name text on the panel header. Allows you to pick between the color of all item Rarities, or Custom. |
| Custom Item Name Color | Set the color of the item name text on the panel header for the Custom option. |
| Timer Mode | Set the timer mode. Normal - The timer starts at 0 and counts to infinity. Countdown - The time starts at the specified timestamp and counts down to 0. (Useful as an indication of the risk of despawn.) |
| Countdown Time | The time to begin counting down from when Timer Mode is set to Countdown. |

#### HUDTracker
This section contains options related to the HUDTracker subsystem.

| Option  | Description |
|------------- | ------------- |
| Frame Width | Sets the frame width. Please note that the UI isn't guaranteed to work with any size. |
| Frame Height | Sets the frame height. Please note that the UI isn't guaranteed to work with any size. |
| Visibility | When to display the HUDTracker. HUD - Standard HUD behavior (hidden in cinematics, loadscreens etc.). Mouse Mode - Like HUD, but also requires. Mouse Mode Sin View - Like HUD, but also requires Sin View. Always - Remains visible as long as there is loot to display. |
| Enable Tooltips | When hovering over an entry in the HUDTracker list, a tooltip representation of the item will be displayed on the cursor. |
| Plate Style | Changes the look of the plate of entries in the Tracker. |
| Icon Style | Changes the look of the item icon of entries in the Tracker. |
| Entry Size | Sets the height of the entries in the HUDTracker. |
| Entry Font Type | Sets the font of the text in the HUDTracker. |
| Entry Font Size | Sets the font size of the text in the HUDTracker. |

##### Filtering: HUDTracker Specific
This section cover only options in the Filtering system specific to the HUDTracker.
For an overview of how the Filtering section of each subsystem works, see General Filtering Options.

| Option  | Description |
|------------- | ------------- |
| HUDTracker Title Format | Customize the title of each entry in the hudtracker. In-game, you will be able to view a list of message replacements in the tooltip that is displayed when you hover over this field. |

#### Sounds
The sound section itself doesn't have any options at this time.
Select which sounds to play when in the Filtering section.

##### Filtering: Sounds Specific
This section cover only options in the Filtering system specific to the Sounds.
For an overview of how the Filtering section of each subsystem works, see General Filtering Options.

| Option  | Description |
|------------- | ------------- |
| Sound Notification | Select a notification sound to be played when this kind of item is detected. |


#### Messages
This section has one top level page with master switches and several subtabs for each of the different events that a message can be sent for.
New means "New item found", Looted means "Known item was looted", Lost means "Known item disappeared without being looted" (despawn or out of range).
You configure the format of the message under an events filtering options.

| Option  | Description |
|------------- | ------------- |
| Generic Prefix | Set the prefix for all public facing messages. Does not include System messages sent by the addon that are not associated with the Messages subsystem. |
| Send on Squad Channel | Master switch for Squad messages. The addon will not send event squad messages if this is unchecked, regardless of other settings. |
| Send on Platoon Channel | Master switch for Squad messages. The addon will not send event platoon messages if this is unchecked, regardless of other settings. |
| Send on System Channel | Master switch for System messages. The addon will not send event system messages if this is unchecked, regardless of other settings. |
| Send on Notifications Channel | Master switch for Notification messages. The addon will not send event notification messages if this is unchecked, regardless of other settings. |
| Send on Squad only when Leader | When checked, messages will not be sent on the Squad channel unless you are the Squad leader. |
| Send on Platoon only when Leader | When checked, messages will not be sent on the Platoon channel, unless you are the Platoon leader. |

##### Filtering: Messages Specific
This section cover only options in the Filtering system specific to the Messages.
For an overview of how the Filtering section of each subsystem works, see General Filtering Options.

| Option  | Description |
|------------- | ------------- |
| Send Squad Message | Send message to Squad on this event |
| Squad Message Format | Specify the format of the Squad message. In-game, you will be able to view a list of message replacements in the tooltip that is displayed when you hover over this field. |
| Send Platoon Message | Send message to Platoon on this event |
| Platoon Message Format | Specify the format of the Platoon message. In-game, you will be able to view a list of message replacements in the tooltip that is displayed when you hover over this field. |
| Send System Message | Send message to System on this event |
| System Message Format | Specify the format of the System message. In-game, you will be able to view a list of message replacements in the tooltip that is displayed when you hover over this field. |


### General Filtering Options
Several subsystems makes use of Filtering options.

#### Filtering
The top level section of Filtering.
Here, you can select which Category of loot that should be allowed by this subsystem.

| Category  | Description |
|------------- | ------------- |
| Components | Crafting components. |
| Currency | Currencies such as Crystite. |
| Consumable | Items such as Ammo Packs, that you can activate later. Please note that this does not cover "Powerups" which are activated as soon as you step over them. Those are not items! |
| Metals | A type of crafting resources. |
| Equipment | Items that can be equipped by your Battleframe, such as Weapons, Abilities, Chassis... |
| Modules | Modules that are slotted into items. |
| Salvage | Items that exist only to be salvaged. |

##### Where to set Filtering Parameters
For each category, there is subtab to Filtering.
Here, you decide whether you wish to use Simple or Advanced filtering.
In Simple Mode, only the Filtering Parameters on this page are used.
In Advanced Mode, you must proceed to the Advanced tab to configure Filtering Parameters for each Rarity of loot.

##### Filtering Parameters
| Category  | Description |
|------------- | ------------- |
| Rarity Threshold | (Simple Mode Only) Set the minimum rarity that the item must be in order to be able to pass filtering. |
| Item Level Threshold | Set the minimum item level an item must have in order to pass filtering. |
| Required Level Threshold | Set the minimum required level an item must have in order to pass filtering. |

#### How to filter
##### Waypoints only for Equipment
To achieve this, you would only need to use Category level filtering.
You would navigate to the Filtering tab of Waypoints (Loot Tracker \> Waypoints \> Filtering).
Here, you would uncheck everything except "Equipment Enabled".
With default settings, that's all that's required. However, to verify, you should inspect the Equipment subtab (Loot Tracker \> Waypoints \> Filtering \> Equipment).
On this subtab, it is expected that Configuration Mode is set to Simple, Rarity Threshold is set to Salvage, Item Level and Required Level Threshold are both set to 0.

##### Send Messages only for Epic and Legendary items
To achieve this, we must use Advanced filtering.
You would navigate to the Filtering tab of the New message (Loot Tracker \> Messages \> New \> Filtering).
Here, you would want everything checked.
Then, for every category that you checked, you would have to go into the corresponding subtab.
In each subtab, you would set the Configuration Mode to Advanced.
Then you would go into the subtab of this subtab, Advanced.
You would then uncheck every group, except for "Legendary Enabled" and "Epic Enabled".

Unforatunately, you have to go through quite a few subtabs to achieve this effect.

### Moveable Frame
You can adjust the position of the HUDTRacker through the interface options menu, by moving the frame labeled "Loot Tracker" to the desired location. You can also scale the HUDTracker with the scrollwheel through this frame.

## Slash Commands
**Slash handles**: xlt,lt,xloottracker,loottracker

| Command  | Description |
|------------- | ------------- |
|/xlt \[help\|?\] | The addon will send a series of system messages briefly describing available commands. If you turn on Debug mode in the options, this list may include a few more slash commands. Those commands are not intended for normal usage and can change/break a lot between versions. Therefore they are not listed here. |
|/xlt clear | The addon will attempt to remove everything it is tracking. |
|/xlt refresh | The addon will immediately update the state of all tracked loot. |

### Blacklist Slash Commands

The blacklist slash command is an addition to the Filtering options.
The command and subcommands allow you to explicitly ban certain items from being handled by certain components of the addon.
This override other Filtering options set in the Interface Options.

| Command  | Description |
|------------- | ------------- |
|/xlt blacklist \<action\> \<scope\> \[itemName\|itemTypeId\] |  This is the syntax of the blacklist command. Please see list of actions and scopes below. |

| Action  | Description |
|------------- | ------------- |
|add | Adds a new item to the banlist. You must provide scope and either the exact, unique item name, or the corresponding itemTypeId/sdbId. |
|remove | Like "add", but for removing an existing item from the banlist.
|view | List all entries on the banlist of a particular scope. Alternative: "list". |
|clear | Remove ALL entries on the banlist of a particular scope. |

| Scope  | Description |
|------------- | ------------- |
|all | Ban the item from being handled by any system in the addon entirely. Alternatives: "tracker", "core". |
|panels | Ban the item from being handled by the Loot Panel sub-system. Alternatives: "panel", "pan". |
|sounds | Ban the item from being handled by the Sound notifications sub-system. Alternatives: "sound", "snd". |
|hudtracker | Ban the item from being handled by the HUDTracker sub-system. Alternatives: "hud", "ht". |
|messages | Ban the item from being handled by the Message notifications sub-system. Alternatives: "message", "msg". |
|waypoints | Ban the item from being handled by the Waypoints sub-system. Alternatives: "waypoint", "way", "wp". |

#### Examples
    > /lt blacklist add pan Recovered Chosen Tech
    This will add Recovered Chosen Tech to the Panels blacklist.
    No Panels will be displayed for this item.

    > /lt blacklist add all Crystite Resonator
    This will add Crystite Resonator to the Trackers blacklist.
    The Tracking system will ignore this item, preventing it from entering the system entirely.

    > /lt blacklist view all
    This lists all entries that fall into the all scope, that is the Trackers blacklist.
    So whilst you might think this would include our Recovered Chosen Tech ban, it does not.
    By the way, you can use list instead of view, I decided not to use that as the standard because it seemed silly to type list twice. ;3

    > /lt blacklist clear all
    With the knowledge we gained from testing the previous command, we now know that this does not actually clear all entries, it only clears those on the Trackers blacklist.

    > /lt blacklist remove pan 52206
    Finally, here's the single remove feature, but this time I used the itemTypeId instead.
    This one corresponds to Recovered Chosen Tech which we banned by its id earlier.
    Now Recovered Chosen Tech is no longer blacklisted.

### Debug Mode Slash Commands
These slash commands are only available if you have enabled Debug mode in the options. (First page, check the Debug group).
| Command  | Description |
|------------- | ------------- |
|/xlt test | Will create a range of "fake" items into the world for the addon to detect. |

## History
Loot Tracker succeeds Xsear's Squad Loot Manager. Originally, the addon was written to give organized groups a system to distribute loot with. It was built in anticipation for a different kind of endgame than what Firefall eventually developed into. Additionally, an official need/greed system was implemented, eliminating the need for the systems that the addon was providing. Therefore, those systems were scrapped and the focus shifted towards improving the tracking system and providing more convenience features than before. The change of direction and feature set warranted a change of addon name, and thus, Loot Tracker was born.

## Acknowledgements
### Arkii
For her work on Lokii, a localization tool which is used by xLootTracker.
Her work on Airii, which inspired me to implement Panels.
Her work on Apii, even though she doesn't update it anymore.
Her work on Scrapii, which is the only reason I can still play this game.
And of course, her work on Meldii.

### BurstBiscuit
For his help with everything.

### DeadWalking
For his help with building loot weighting systems for xSquadLootManager.

### DarkByke
For his help with testing the addon, as well as feedback and ideas.

### Granite
For his work on lib_GTimer, which is used by xLootTracker for the panel timers.

### Mortelentus
For his work on Simple Loot, which inspired parts of the early detection system.

### JeffGray
For his help with testing the addon, as well as feedback and ideas.

### Lemon King
For his work on lib_LKObjects, which xLootTracker utilizes in order to create in-world UI objects.

### Skotka
For [the slogan of xSquadLootManager](//i.imgur.com/RKiLPGb.png').

### thiconZ
For his work on the early API reference, which I made use of numerous times during the development of xSquadLootManager.

### Tomohisa
For his work on Chinese localization.

### Tomonor
For his help with testing the addon, as well as feedback and ideas.

### TwoShoes
For his help with testing the addon, as well as feedback, ideas and encouragement.
Also for the slogan of xLootTracker.

*And the many other friends who gave me feedback on the way.* :)











