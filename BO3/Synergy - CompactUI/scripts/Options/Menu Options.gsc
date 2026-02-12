PopulateMenuCustomizations() {
    switch (self getCurrentMenu()) {
        case "MenuEdis":
            self addMenu("MenuEdis", "Menu Customization");
                self addOpt("Menu Colours", ::newMenu, "MenuColour");
                //self addSlider("Set Max Options", self.menuSetting["MaxOpsDisplayed"], 5, 11, 1, ::SetMenuMaxOptions);
                self addOpt("Change Theme To Physics N Flex", ::ChangeTheme, 1);
                self addOpt("Change Theme To Synergy V3", ::ChangeTheme, 0);
        break;

        case "MenuColour":
            self addMenu("MenuColour", "Menu Colours");
                self addOpt("Background", ::newMenu, "BackgroundColour");
                self addOpt("Banner", ::newMenu, "BannerColour");
                self addOpt("Scroller", ::newMenu, "ScrollerColour");
        break;

        case "BackgroundColour":
            self addMenu("BackgroundColour", "Menu Background");
                for(e=0;e<3;e++)
                    self addSlider(level.RGB[e] + " Slider", 0, 0, 255, 10, ::MenuPreSetCol, undefined, true, "Background", true);
                self addOptSlider("Colour Presets", GetColoursSlider(), ::MenuPreSetCol, undefined, true, "Background");
                self addToggleOpt("Rainbow Fade", ::MenuToggleRainbow, IsString(self.menuSetting["BackgroundGradRainbow"]), "Background");
        break;

        case "BannerColour":
            self addMenu("BannerColour", "Menu Banner");
                for(e=0;e<3;e++)
                    self addSlider(level.RGB[e] + " Slider", 0, 0, 255, 10, ::MenuPreSetCol, undefined, true, "Banner", true);
                self addOptSlider("Colour Presets", GetColoursSlider(),::MenuPreSetCol, undefined, true, "Banner");
                self addToggleOpt("Rainbow Fade", ::MenuToggleRainbow, bool(self.menuSetting["HUDEdit"]) ? IsString(self.menuSetting["BannerNoneRainbow"]) : IsString(self.menuSetting["BannerGradRainbow"]), "Banner");
        break;

        case "ScrollerColour":
            self addMenu("ScrollerColour", "Menu Scroller");
                for(e=0;e<3;e++)
                    self addSlider(level.RGB[e] + " Slider", 0, 0, 255, 10, ::MenuPreSetCol, undefined, true, "Scroller", true);
                self addOptSlider("Colour Presets", GetColoursSlider(), ::MenuPreSetCol, undefined, true, "Scroller");
                self addToggleOpt("Rainbow Fade", ::MenuToggleRainbow, IsString(self.menuSetting["ScrollerGradRainbow"]), "Scroller");
        break;
    }
}