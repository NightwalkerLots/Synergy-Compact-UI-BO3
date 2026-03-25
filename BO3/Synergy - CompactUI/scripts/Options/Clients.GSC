ClientOptions()
{
    player = self.SavePInfo;
    Name   = player getName();
    switch(self getCurrentMenu())
    {
         case "Clients":
            self addmenu("Clients","Clients [^2" + level.players.size + "^7]");
            foreach(Client in level.players)
                self addopt(Client getName(), ::newmenu, "PMain");
        break;
            
        case "PMain":
            self addmenu("PMain", Name);
            if(self IsHost()) self addOpt("Verification Level >", ::newMenu, "PAccess");
            self addOpt("Exploits >", ::newMenu, "Exploits");
            self addOpt("Personal Modifications >", ::newMenu, "Personal Modifications Client");
            self addOpt("Stat Manipulation >", ::newMenu, "Stat Manipulation Client");
            #ifdef MP
            self addOpt("Force Change Team", ::ChangePlayerTeam, player);
            self addOpt("Blame Options >", ::newMenu, "Blame Options");
            #endif
            self addOpt("Trolling Options >", ::newMenu, "Allowed Inputs");
            self addOpt("Allowed Inputs >", ::newMenu, "Allowed Inputs");
            self addOpt("Give Player Currency >", ::ClientHandler1, 4, player);
            if(self isHost()){
                self addOpt("Lock Client Menu >", ::ClientHandler1, 13, player);
                self addOpt("Unlock Client Menu >", ::ClientHandler1, 14, player);
            }
        break;

        case "Personal Modifications Client":
            self addMenu("Personal Modifications Client", "Personal Modifications "+Name);
                self addToggleOpt("(T) God Mode", ::ClientHandler1, player.godmode, 0, player);
                self addToggleOpt("(T) Infinite Ammo", ::ClientHandler1, player.UnlimAmmo, 1, player);
                self addToggleOpt("(T) Third Person", ::ClientHandler1, player.ThirdPersonToggle, 2, player);
                self addToggleOpt("(T) All Perks", ::ClientHandler1, player.HasAllPerks, 3, player);
                #ifdef ZM
                self addOpt("Upgrade Client Weapon", ::UpgradeWeapon, player, self GetCurrentWeapon());
                #endif
        break;

        case "Exploits":
            self addMenu("Exploits", "Exploits "+Name);
            self addOpt("Crash - Invalid Text", ::Crash_Game_Print, player);
            self addOpt("Crash - PauseMenu Spam", ::Crash_Game, player);
            self addOpt("Brick Account", ::ice_fuck_player, player);
        break;

        case "Blame Options":
            self addMenu("Blame Options", "Blame Options "+Name);
            self addOpt("Blame for killing player >", ::newMenu, "Blame for killing player >");
            self addOpt("Blame Kill all players", ::BlameKillAll, player);
        break;

        case "Blame for killing player >":
            self addMenu("Blame for killing player >", "Blame for killing player > "+Name);
            foreach( p in level.players ) {
                if( p IsHost()) continue;
                if(p == player) continue;
                if(p.team == player.team) continue;
                self addOpt("Blame for killing ^1" + p.name, ::BlameKillPlayer, player, p);
            }

        break;

        case "Stat Manipulation Client":
            self addMenu("Stat Manipulation Client", "Stat Manipulation "+Name);
                self addOpt("Max Rank", ::ClientHandler1, 5, player);
                #ifdef ZM
                self addOpt("Max Prestige", ::ClientHandler1, 25, player);
                self addOpt("Set Client Legit Stats", ::DoStats, 0, player);
                self addOpt("Set Client Professional Stats", ::DoStats, 1, player);
                self addOpt("Set Client Insane Stats", ::DoStats, 2, player);
                self addOpt("Liquid Divinium Options", ::newMenu, "Liquid Options");
                #endif
                self addOpt("Client Unlock All", ::ClientHandler1, 15, player);
        break;

        #ifdef ZM case "Liquid Options":
            self addMenu("Liquid Options", "Liquid Divinium Options");
                self addOpt("Give 50k Divinium", ::ClientHandler1, 16, player);
                self addOpt("Give 40k Divinium", ::ClientHandler1, 17, player);
                self addOpt("Give 30k Divinium", ::ClientHandler1, 18, player);
                self addOpt("Give 20k Divinium", ::ClientHandler1, 19, player);
                self addOpt("Give 10k Divinium", ::ClientHandler1, 20, player);
                self addOpt("Give 5k Divinium", ::ClientHandler1, 21, player);
                self addOpt("Give 1k Divinium", ::ClientHandler1, 22, player);
                self addOpt("Give 500 Divinium", ::ClientHandler1, 23, player);
                self addOpt("Give 200 Divinium", ::ClientHandler1, 24, player);
                self addSlider("Give Custom Divinium",0,0,100000,1000, ::CustomDiviniumSlider,undefined, undefined, player);
        break;

        #endif
        case "Trolling Options":
            self addMenu("Trolling Options", "Trolling Options");
                self addOpt("Take Client Weapon", ::ClientHandler1, 6, player);
                self addOpt("Take All Client Weapons", ::ClientHandler1, 7, player);
                self addOpt("Drop Current Client Weapon", ::ClientHandler1, 8, player);
                #ifdef ZM
                self addOpt("Down Client", ::ClientHandler1, 10, player);
                #endif
                self addToggleOpt("(T) Fake Lag", ::FakeLag, player.syn_fakelag, player);
                self addToggleOpt("(T) Kill Loop", ::TogglePlayerLoop, player.kill_loop_enabled, player);
                self addOpt("Kill The Client", ::ClientHandler1, 11, player);
                self addOpt("Kick The Client", ::ClientHandler1, 12, player);
                self addOpt("Ban The Client", ::ice_player_session_ban, player);
        break;

        case "Allowed Inputs":
            self addMenu("Allowed Inputs", "Allowed Inputs");
                self addToggleOpt("(T) Sprint", ::ice_player_input_toggle, player.ice_sprint_disabled, "sprint", player);
                self addToggleOpt("(T) ADS", ::ice_player_input_toggle, player.ice_sprint_disabled, "ads", player);
                self addToggleOpt("(T) Crouch", ::ice_player_input_toggle, player.ice_sprint_disabled, "crouch", player);
                self addToggleOpt("(T) Slide", ::ice_player_input_toggle, player.ice_sprint_disabled, "slide", player);
                self addToggleOpt("(T) Melee", ::ice_player_input_toggle, player.ice_sprint_disabled, "melee", player);
        break;

        case "PAccess":
            self addMenu("PAccess", Name+" Verification");
            for(e=0;e<level.Status.size-1;e++)
                self addToggleOpt(GetAccessName(e), ::initializeSetup, player.access == e, e, player);
        break;
    }
}