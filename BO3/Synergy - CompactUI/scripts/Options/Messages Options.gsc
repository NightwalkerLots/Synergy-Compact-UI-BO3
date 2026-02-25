PopulateMessageOptions( ) {
    switch (self getCurrentMenu()) {
        case "Message Options >":
            self addMenu("Message Options >", "Message Options >");
                self addOpt("Display Custom Message >", ::newMenu, "Display Custom Message >");
                self addOpt("Set Message String >", ::newMenu, "Set Message String >");
                self addOpt("Print Map Name", ::PrintMapName);
        break;

        case "Display Custom Message >":
            self addMenu("Display Custom Message >", "Display Custom Message >");
                self addOpt("Debug - Print Cached String", ::PrintCachedCustomMessage);
                self addToggleOpt("(T) Advert Message", ::ice_display_discord_advert, self.ice_discord_advert);
                self addToggleOpt("(T) iPrintLn Loop", ::PrintlnLoop, level.customprintlnloop);
        break;

        case "Set Message String >":
            self addMenu("Set Message String >", "Set Message String >");
                self addOpt("Type Custom String", ::CustomMessage);
                self addOpt("Frostbite Link", ::SetCachedString, "Frostbite Menu - Discord.gg/e6GKUsbFaE");
                self addOpt("Youtube Link", ::SetCachedString, "Youtube.com/c/NightwalkerLots");
                self addOpt("Sponsered by Israel", ::SetCachedString, "this server is sponsored by Israel!!");
                self addOpt("cids runs skidops", ::SetCachedString, "cidshook runs skidops and T7 patch");
                self addOpt("cleanops.dev is c&p", ::SetCachedString, "cleanops.dev is c&p");
                self addOpt("nightWolf & Krashgamer are pedophiles", ::SetCachedString, "nightWolf & Krashgamer are pedophiles");
                self addOpt("cids is fat", ::SetCachedString, "cids is fat");
                self addOpt("lerggy sniffs pennies", ::SetCachedString, "lerggy sniffs pennies");
                self addOpt("cidshook rails your mom", ::SetCachedString, "cidshook rails your mom");
        break;
    }
}

CustomMessage()
{
    self thread menuClose();
    String = CustomKeyboard("Custom Message");
    wait .2;
    SetDvar("syn_custom_message_string", String);
    self S("Custom String Set");
}

GetCachedCustomMessage() {
    c_string = GetDvarString("syn_custom_message_string", "Frostbite Menu - Discord.gg/e6GKUsbFaE");
    return c_string;
}

PrintCachedCustomMessage() {
    c_string = MakeLocalizedString( GetCachedCustomMessage() );
    self iPrintLnBold(c_string);
}

SetCachedString( c_string ) {
    SetDvar("syn_custom_message_string", c_string);
    self S("String Set");
}

PrintlnLoop( ) {
    level.customprintlnloop = isDefined(level.customprintlnloop) ? undefined : true;
    message = GetCachedCustomMessage();

    while(is_true(level.customprintlnloop)) {
        if(!isDefined(level.customprintlnloop)) return;
        iPrintLn(message);
        wait 0.5;
    }
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
        message = GetCachedCustomMessage();
        foreach( p in level.players ) {
            elm = p createText("small", 1.5, "CENTER", "CENTER", 0, -233, 1, 1, message, (1,1,1));
            elm FadeOverTime(1);
            elm.alpha = 1;
            //p thread ice_rainbow_discord_advert( elm );
            p.ice_discord_advert_text = elm; 
        }
        S("String Advert ^2Enabled");
    } else {
        level.ice_discord_advert = undefined;
        S("String Advert ^1Disabled");
        foreach(p in level.players) {
            p.ice_discord_advert_text destroy();
        }
    }
}

NewPlayer_DisplayAdvert( ) {
    message = GetCachedCustomMessage();
    elm = self createText("small", 1.5, "CENTER", "CENTER", 0, -233, 1, 1, message, (1,1,1));
    elm FadeOverTime(1);
    elm.alpha = 1;
    //self thread ice_rainbow_discord_advert( elm );
    self.ice_discord_advert_text = elm;
}