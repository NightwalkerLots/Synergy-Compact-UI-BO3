//Hi there!

StartDevConfig( ) {
    AntiQuit();
    unlimitedammo(int(0));
    ToggleLobbyTimer();
    wait 10;
    SetDvar("playerEnergy_enabled", 0);
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