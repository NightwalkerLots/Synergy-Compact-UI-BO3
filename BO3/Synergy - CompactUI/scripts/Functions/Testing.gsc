//Hi there!

StartDevConfig( ) {
    if( is_true(self.syn_has_spawned) ) return;
    host = util::gethostplayer();
    SetMatchFlag("disableIngameMenu", true); level.AntiQuit = true; //anti quit
    self thread unlimitedammo(int(0));
    SetDvar("playerEnergy_enabled", 0);
    level globallogic_utils::pauseTimer();
    self toggleUAV();
    host S("Dev Config ^2Loaded");
}

InitBotCleanClient(  ) { 
    bot = AddTestClient();
    wait 1;
    foreach( bot in level.players ) {
        if(!bot IsTestClient())
            continue;
        if(bot.ice_isbot == 1)
            continue;
        bot [[ level.spawnplayer ]]();
        bot.ice_isbot = 1;
    }
}