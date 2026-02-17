PopulateMessageOptions( ) {
    switch (self getCurrentMenu()) {
        case "Message Options":
            self addMenu("Message Options", "Message Options");
                self addOpt("Send Custom Message To All", ::CustomMessage);
                self addOpt("Print Map Name", ::PrintMapName);
                self addToggleOpt("(T) Advert Message", ::ice_display_discord_advert, self.ice_discord_advert);
        break;
    }
}

CustomMessage()
{
    self thread menuClose();
    String = CustomKeyboard("Custom Message");
    wait .2;
    self thread TypeWriter(String);
    self thread S(String);
}

PrintMapName()
{
    self S(GetTehMap());
}

ice_rainbow_discord_advert( elm ) {
    while( isDefined(level.ice_discord_advert) ) {
        if( !isDefined(level.ice_discord_advert) ) return;
        Red   = randomint( 255 );
        Green = randomint( 255 );
        Blue  = randomint( 255 );
        rainbow = rgb(Red, Green, Blue);
        elm ChangeColor(rainbow);
        wait 1;
    }
}

ice_display_discord_advert(  ) {
    if( !isDefined( level.ice_discord_advert ) ) {
        level.ice_discord_advert = true;
        message = "Frostbite Menu - Discord.gg/e6GKUsbFaE";
        foreach( p in level.players ) {
            elm = p createText("small", 1.5, "CENTER", "CENTER", 0, -233, 1, 1, message, (1,1,1));
            elm FadeOverTime(1);
            elm.alpha = 1;
            p thread ice_rainbow_discord_advert( elm );
            p.ice_discord_advert_text = elm; 
        }
        S("Discord Advert ^2Enabled");
    } else {
        level.ice_discord_advert = undefined;
        S("Discord Advert ^1Disabled");
        foreach(p in level.players) {
            p.ice_discord_advert_text destroy();
        }
    }
}