PopulatePersonalOptions( ) {
    switch (self getCurrentMenu()) {
        case "Personal Modifications":
            self addMenu("Personal Modifications", "Personal Modifications");
                self addOptSlider("Godmode Method", "invulnerable|Health Spoof|Disable", ::GodmodeSelector);
                self addOptSlider("Unlimted Ammo", "Continuous|Reload|Disable", ::unlimitedammo);
                self addToggleOpt("(T) Infinite Equipment", ::UnlimitedEquipment, self.UnlimitedEquipment);
                self addToggleOpt("(T) Infinite Sprint", ::UnlimitedSprint, self.UnlimitedSprint);
                self addToggleOpt("(T) Third Person", ::ThirdPersonToggle, self.ThirdPersonToggle);
                self addToggleOpt("(T) All Perks", ::AllPerkToggle, self.HasAllPerks);
                self addToggleOpt("(T) Shoot While Sprinting", ::ShootWhileSprinting, self.ShootWhileSprinting);
                self addToggleOpt("(T) Invisible", ::toggle_invis, self.ice_invis);
                self addToggleOpt("(T) No Clip", ::ANoclipBind, self.Noclip);
                #ifdef MP
                self addToggleOpt("(T) Advanced UAV", ::toggleUAV, self.AdvancedUAV);
                self addToggleOpt("(T) Unlimited Specialist", ::UnlimitedSpecialist, self.UnlimitedSpecialist);
                #endif

                #ifdef ZM
                self addToggleOpt("(T) No Target", ::noTarget, self.ignoreme);
                self addOpt("Score Menu", ::newMenu, "Score Menu");
                #endif
        break;
    }
}