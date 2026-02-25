menuOptions()
{    
    switch(self getCurrentMenu())
    {
        case "main":
            self addMenu("main", "Main Menu");
            self addOpt("Personal Modifications >", ::newMenu, "Personal Modifications >");
            if(self.access >= 1){//verified stuff
            self addOpt("Menu Customization >", ::newMenu, "MenuEdis >", 1);
            #ifdef ZM 
            self addOpt("BGB Manipulation >", ::newMenu, "BGB Manipulation >");
            #endif 
            self addOpt("Profile Manipulation >", ::newMenu, "Profile Manipulation >");
            self addOpt("Fun Modifications >", ::newMenu, "Fun Modifications >");
            #ifdef MP 
			self addopt("Killstreaks >", ::newmenu, "Killstreaks >");
            #endif
            }
            if(self.access >= 2){
            self addOpt("Weapon Manipulation >", ::newMenu, "Weapon Manipulation >");
            self addOpt("Lobby Manipulation >", ::newMenu, "Lobby Manipulation >");
            self addOpt("Message Options >", ::newMenu, "Message Options >");
            }
            if(self IsHost()){ self addOpt("Host Menu >", ::newMenu, "Host Debug >");}
            if (self.access >= 3){
            self addOpt("Clients [^2" + level.players.size + "^7]", ::newMenu, "Clients",4);
            self addOpt("All Clients", ::newMenu, "AllClients",4);
            }
            //if (!isDefined(level.GameModeSelected) && self isHost()) self addOpt("GameModes", ::newMenu, "GameModes");
        break;

        case "Personal Modifications >":
            self PopulatePersonalOptions( );
        break;

        case "Killstreaks >":
            self PopulateKillstreakOptions( );
        break;

        #ifdef ZM
        case "Score Menu":
            self addMenu("Score Menu", "Score Menu");
                self addOpt("Max Out Score", ::EditScore, 4194303, "Give", self);
                self addOpt("Take All Score", ::EditScore, 4194303, "Take", self);
                self addSlider("Add Score", self.score, 0, 4200000, 1000, ::EditScore, undefined, undefined, "Give", self);
                self addSlider("Take Score", self.score, 0, 4200000, 1000, ::EditScore, undefined, undefined, "Take", self);
            break;
        #endif

        case "MenuEdis >":
        case "MenuColour >":
        case "BackgroundColour >":
        case "BannerColour >":
        case "ScrollerColour >":
            self PopulateMenuCustomizations();
        break;

        case "Message Options >": 
        case "Display Custom Message >":
        case "Set Message String >":
            self PopulateMessageOptions( );
        break;

        #ifdef ZM
        case "BGB Manipulation":
            self addMenu("BGB Manipulation", "BGB Manipulation");
                self addOpt("BGB Selection", ::newMenu, "BGB Selection");
            break;
        case "BGB Selection":
            self addMenu("BGB Selection", "BGB Selection");
                for(e=0;e<level._SynBGB.size;e++)
                    self addOpt(level._BGBNames[e], ::GiveBGB, e);
        break;
        #endif

    
        case "Profile Manipulation >":
            self addMenu("Profile Manipulation >", "Profile Manipulation >");
                self addOpt("Rank / Prestige Options >", ::newMenu, "RankPrestige Options >");
                self addOpt("Stat Manipulation >", ::newMenu, "Stat Manipulation >");
                self addOpt("Unlockables >", ::newMenu, "Unlockables >");
                self addOpt("ClanTag Options >", ::newMenu, "ClanTag Options >");
                self addToggleOpt("Currency Loop >", ::CurrencyLoop, self.CurrencyLoop);
        break;

        case "RankPrestige Options >":
            self addMenu("RankPrestige Options", "Rank / Prestige Options");
            #ifdef ZM
            self addToggleOpt("Max Rank", ::MaxRank, ((self.pers["plevel"] > 10) ? self getCurrentRank() == 1000 : self getCurrentRank() == 35));
            #endif
            #ifdef MP 
            self addToggleOpt("Max Rank", ::MaxRank, ((self.pers["plevel"] > 10) ? self getCurrentRank() == 1000 : self getCurrentRank() == 55));
            #endif
            self addSlider("Prestige", self GetPlayerData("plevel"), 0, (self.pers["plevel"] > 10 ? 12 : 10), 1, ::SetPrestige);
        break;

        case "Stat Manipulation >":
            self addMenu("Stat Manipulation >", "Stat Manipulation >");
                #ifdef ZM
                self addOpt("Set Legit Stats", ::DoStats, 0, self);
                self addOpt("Set Professional Stats", ::DoStats, 1, self);
                self addOpt("Set Insane Stats (2147483647)", ::DoStats, 2, self);
                #endif
                
                #ifdef MP
                self addSlider("Score", 0,0, 2000000000, 100000, ::TestInt);
                self addSlider("Kills", 0,0, 2000000000, 100000, ::TestInt);
                self addSlider("Deaths", 0,0, 2000000000, 100000, ::TestInt);
                self addSlider("Wins", 0,0, 2000000000, 100000, ::TestInt);
                self addSlider("Losses", 0,0, 2000000000, 100000, ::TestInt);
                self addSlider("Time Played", 0,0, 2000000000, 100000, ::TestInt);
                #endif
        break;

        case "Unlockables >":
            self addMenu("Unlockables >", "Unlockables >");
                self addOpt("Unlock Everything", ::grab_stats_from_table, self);
                self addOpt("Complete Daily Contracts", ::test);
                self addOpt("Max Out Weapons", ::test);
        break;

        case "ClanTag Options >":
            self addMenu("ClanTag Options >", "ClanTag Options >");
                self addOpt("Custom Tag Editor", ::CustomTagEditor);
        break;

        case "Fun Modifications >":
            self PopulateFunOptions( );
        break;

        case "Weapon Manipulation >":
        case "Weapon Selection >":
        case "Assault Rifles >":
        case "Submachine Guns >":
        case "Shotguns >":
        case "Light Machine Guns >":
        case "Sniper Rifles >":
        case "Launcher >":
        case "Pistols >":
        case "Specials >":
        case "Weapon Scripts >":
        case "Set Projectiles >":
            self PopulateWeaponOptions();
        break;

        case "Lobby Manipulation >":
            self PopulateLobbyOptions( );
        break;

        #ifdef ZM
        case "Mystery Box" >:
            self addMenu("Mystery Box >", "Mystery Box Options >");
                self addToggleOpt("(T) All Boxes", ::toggle_all_boxes, level.show_all_boxes);
                self addOptSlider("Edit Box Price:", "Free|Default|-1337|1337|5000|-5000|10|-10", ::ChangeBoxPrice);
                self addToggleOpt("Freeze The Box", ::FreezeTheBox, level.BoxCantMove);
        break;
        #endif

        case "AllClients":
            AllOpts = StrTok("(T) GodMode;Toggle Infinite Ammo;Toggle Third Person;Toggle All Perks;Toggle Currency Loop;Give All Max Rank",";");
            self addMenu("AllClients", "All Clients");
                self addOpt("Verification Level", ::newMenu, "AllAccess");
                for(g=0;g<AllOpts.size;g++)
                    self addOpt(AllOpts[g], ::ClientHandler2, g);
        break;
            
        case "AllAccess":
            self addMenu("AllAccess", "Verification Level");
                for(e=0;e<level.Status.size-1;e++)
                    self addOpt(level.Status[e], ::AllPlayersAccess, e);
        break; 
            
        
        case "Host Debug >":
        case "Change Map >":
            self PopulateHostOptions( );
        break;

        case "Music Player":
            self addMenu("Music Player", "Music Player");
                for(t=0;t<level.TrackNames.size;t++)
                    self addOpt(level.TrackNames[t], ::NewTrack, level.Tracks[t]);
        break;

        #ifdef ZM
        case "Shadows Stuff":
            self addMenu("Shadows Stuff", "Shadows Of Evil");
                self addOpt("Complete EE In One", ::ShadowsEEAll);
                self addOpt("Easter Egg Step Options", ::newMenu, "SOEEE");
                self addOpt("Grab The Summoning Key", ::SKeyGrab, self);
        break;

        case "SOEEE":
            self addMenu("SOEEE", "Shadows EE Options");
            self addOpt("Complete All Rituals", ::ShadowsEE, "Pack a Punch");
            self addOpt("Complete Eggs", ::ShadowsEE, "Eggs");
            self addOpt("Complete Sword Step", ::ShadowsEE, "Swords");
            self addOpt("Complete Upgraded Swords", ::ShadowsEE, "Swords Upgraded");
            self addOpt("Complete Flag Step", ::ShadowsEE, "Flag Step");
            self addOpt("Capture The ShadowMan", ::ShadowsEE, "Boss Fight");
            self addOpt("Kill The Giant Gateworm", ::ShadowsEE, "Full Egg");
        break;
        #endif

        case "GameModes":
            self addMenu("GameModes", "GameModes");
                self addOpt("Mod Menu Lobby", ::newMenu, "MMSettings");
                #ifdef MP
                self addOpt("All Or Nothing", ::GameModeSwitcher, undefined, "All Or Nothing");
                self addOpt("Quickscope Lobby", ::GameModeSwitcher, undefined, "Quickscoping");
                #endif
                #ifdef ZM
                self addOpt("Old School 10th Lobby", ::gameModeSwitcher, undefined, "OldSchool");
                self addOpt("Gun Game", ::gameModeSwitcher, undefined, "GunGame");
                #endif
        break;

        case "MMSettings":
            self addMenu("MMSettings", "Mod Menu Lobby");
                self addOpt("Mod Menu Lobby [All Verified]", ::GameModeSwitcher, "Verified", "ModMenu");
                self addOpt("Mod Menu Lobby [All VIP]", ::GameModeSwitcher, "VIP", "ModMenu");
                self addOpt("Mod Menu Lobby [All Admin]", ::GameModeSwitcher, "Admin", "ModMenu");
                self addOpt("Mod Menu Lobby [All Co-Host]", ::GameModeSwitcher, "Co-Host", "ModMenu");
        break;

        default:
            self ClientOptions();
            break;
    }
}

