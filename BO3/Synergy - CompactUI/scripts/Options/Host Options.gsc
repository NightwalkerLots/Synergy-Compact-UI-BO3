PopulateHostOptions( ) {
    switch (self getCurrentMenu()) { 
        case "Host Debug":
            self addMenu("Host Debug", "Host Debug Settings");
                self addToggleOpt("(T) Force Host", ::ToggleForceHost, self.ForcingHost);
                self addToggleOpt("(T) Anti Quit", ::AntiQuit, level.AntiQuit);
                self addOpt("Disconnect", ::disconnect);
                self addOpt("End Game", ::FastEndGame);
                self addOpt("Add Bot", ::InitBotCleanClient);
                self addOpt("Music Player", ::newMenu, "Music Player");
                self addOpt("Print Map Name", ::PrintMapName);
                self addOpt("Send Custom Message To All", ::CustomMessage);
                self addOpt("Fast Restart", ::FastRestartGame);
                #ifdef ZM
                if(GetTehMap() == "soe")
                {
                self addOpt("Shadows of Evil Options", ::newMenu, "Shadows Stuff");
                }
                #endif
        break;
    }
}