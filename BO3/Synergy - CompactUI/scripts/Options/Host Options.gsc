PopulateHostOptions( ) {
    map_ids = ["mp_veiled", "mp_stronghold", "mp_spire", "mp_sector", "mp_redwood", "mp_metro", "mp_infection", "mp_havoc", "mp_ethiopia", "mp_chinatown", "mp_biodome", "mp_apartments", "mp_nuketown_x", "mp_redwood", "mp_airship"];

    switch (self getCurrentMenu()) { 
        case "Host Debug >":
            self addMenu("Host Debug >", "Host Debug Settings >");
                self addOpt("Change Map >", ::newMenu, "Change Map >");
                self addToggleOpt("(T) Force Host", ::ToggleForceHost, self.ForcingHost);
                self addToggleOpt("(T) Anti Quit", ::AntiQuit, level.AntiQuit);
                self addOpt("Disconnect", ::disconnect);
                self addOpt("End Game", ::FastEndGame);
                self addOpt("Add Bot", ::InitBotCleanClient);
                self addOpt("Music Player", ::newMenu, "Music Player");
                self addOpt("Fast Restart", ::FastRestartGame);
                #ifdef ZM
                if(GetTehMap() == "soe")
                {
                self addOpt("Shadows of Evil Options >", ::newMenu, "Shadows Stuff >");
                }
                #endif
        break;

        case "Change Map >":
            self addMenu("Change Map >", "Change Map >");
                foreach(map in map_ids) {
                    self addOpt(Cleanstring(map), ::serverchangemap, map);
                }
        break;
    }
}