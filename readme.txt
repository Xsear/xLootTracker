This thing isn't exactly fully fleshed out yet but I'll keep working on it.


Slash Commands:
    
    First of, the slash handle is configurable in the Options, I'll use /lt since it's one of the defaults but I personally still use /slm :)

    These are commands that I added with the intention of keeping.
    Also, some commands and arguments have alternative shorthands that I added because I couldn't remember what it was supposed to be.

    /lt [help|?]

        Just calling the slash handler with help, ? or nothing as the only argument, will trigger a listing of commands.
        It will include the ones listed in this file, but does not go in depth on them.
        If you turn on Debug mode in the options, this list may include a few more slash commands. Those commands are not intended for normal usage and can change/break a lot between versions. Therefore they are not listed here.

    /lt clear

        This command immediately causes the tracker to remove its entries.
        It does so through relatively normal procedures though, so it can be affected by settings (which typically bites you in the ass).

    /lt blacklist <action> <scope> [itemName|itemTypeId]

        This command allows you to blacklist (filter away) specific items.
        Note that this is meant to be used as a last resort, the Filtering options found in the Interface Options are meant to be the primary way to filter stuff.

        The first argument is where you decide what you want to do with the blacklist.
        The following actions are possible: add, remove, view, clear

        The second argument is where you specify which feature to affect.
        I'll just drop it all in. One of the inputs on the right corresponds to the feature on the left.
            Tracker    >      'tracker', 'core', 'all',
            Panels     >      'panels', 'panel', 'pan',
            Sounds     >      'sounds', 'sound', 'snd',
            HUDTracker >      'hudtracker', 'hud', 'ht',
            Messages   >      'messages', 'message', 'msg',
            Waypoints  >      'waypoints', 'waypoint', 'way', 'wp',


        The third argument is required for the Add and Remove actions, but not for the others.


        So I don't think I have to explain what the actions do, I'll just give some examples:

        > /lt blacklist add pan Recovered Chosen Tech
        This will add Recovered Chosen Tech to the Panels blacklist.
        No Panels will be displayed for this item.

        > /lt blacklist add all Crystite Resonator
        This will add Crystite Resonator to the Trackers blacklist.
        The Tracking system will ignore this item, preventing it from entering the system entirely. (Though if I wasn't careful something might leak in through the loot events...)

        > /lt blacklist view all
        This lists all entries that fall into the all scope, that is the Trackers blacklist.
        So whilst you might think this would include our Recovered Chosen Tech ban, it does not.
        By the way, you can use list instead of view, I decided not to use that as the standard because it seemed silly to type list twice. ;3

        > /lt blacklist clear all
        With the knowledge we gained from testing the previous command, we now know that this does not actually clear all entries, it only clears those on the Trackers blacklist.

        > /lt blacklist remove pan 52206
        Finally, here's the single remove feature, but this time I used the itemTypeId instead.
        This one corresponds to Recovered Chosen Tech. Ain't I fancy~.
        Now Recovered Chosen Tech is no longer blacklisted.


    /lt refresh

        This command just causes the Tracker to immediately update the state of all tracked loot.
        If something breaks, it might come in handy. Or you could just clear. You'll probably have to clear.



