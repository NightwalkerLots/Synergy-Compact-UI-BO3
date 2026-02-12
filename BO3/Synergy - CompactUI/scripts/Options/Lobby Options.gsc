PopulateLobbyOptions( ) {
    switch (self getCurrentMenu()) {
        case "Lobby Manipulation":
            self addMenu("Lobby Manipulation", "Lobby Manipulation");
                #ifdef MP 
                self addToggleOpt("(T) Lobby Timer", ::ToggleLobbyTimer, level.timerStopped);
                self addOpt("No Score Limit", ::ToggleLobbyScoreLimit, 0);
                self addOpt("Custom Score Limit", ::CustomLobbyScoreLimit);
                self addToggleOpt("(T) Unlimited Jump Boost", ::togglejumpboost, !is_true(GetDvarInt("playerEnergy_enabled", 0)));
                #endif

                #ifdef ZM
                self addSlider("Edit Round: ", level.round_number, 0, 255, 1, ::ChangeTehRound);
                self addOpt("Mystery Box Options", ::newMenu, "Mystery Box");
                self addOpt("Open All Doors / Debris", ::OpenAllDoors);
                #endif
                
                self addToggleOpt("(T) SuperJump", ::SuperJump, level.SuperJump);
                self addSlider("Timescale", GetDvarInt("timescale"), 0.5, 5, 0.5, ::ServerSetTimeScale);
                self addToggleOpt("(T) Low Gravity", ::LowGravity, (GetDvarInt("bg_gravity") == 200));
                self addToggleOpt("(T) Super Speed", ::SuperSpeed, (GetDvarString("g_speed") == "500"));
        break;
    }
}