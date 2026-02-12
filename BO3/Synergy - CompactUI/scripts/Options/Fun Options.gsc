PopulateFunOptions( ) {
    switch (self getCurrentMenu()) {
        case "Fun Modifications":
            self addMenu("Fun Modifications", "Fun Modifications");
                self addToggleOpt("(T) Blinking Player Model", ::PlayerBlink, self.ice_blinking);

                #ifdef MP 
                #endif
        break;
    }
}