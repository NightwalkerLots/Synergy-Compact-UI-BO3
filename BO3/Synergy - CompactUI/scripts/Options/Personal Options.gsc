PopulatePersonalOptions( ) {
    switch (self getCurrentMenu()) {
        case "Personal Modifications":
            self addMenu("Personal Modifications", "Personal Modifications");
                self addToggleOpt("(T) God Mode", ::Godmode, self.godmode);
                self addToggleOpt("(T) Infinite Ammo", ::ToggleAmmo, self.UnlimAmmo);
                self addToggleOpt("(T) Third Person", ::ThirdPersonToggle, self.ThirdPersonToggle);
                self addToggleOpt("(T) All Perks", ::AllPerkToggle, self.HasAllPerks);
                #ifdef ZM
                self addToggleOpt("(T) No Target", ::noTarget, self.ignoreme);
                self addOpt("Score Menu", ::newMenu, "Score Menu");
                #endif
                #ifdef MP
                self addToggleOpt("(T) Advanced UAV", ::toggleUAV, self.AdvancedUAV);
                #endif
        break;
    }
}