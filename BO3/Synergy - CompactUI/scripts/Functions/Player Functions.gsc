GodmodeSelector( mode, player = self ) { // slider strings take array index as input, which is the most retarded shit I've ever seen
    player DisableInvulnerability();
    player.frost_godmode = undefined;
    player.ice_uem_godmode = undefined;
    player notify("stop_health_spoof");

    switch (mode) {
        case 0:
            Godmode(player);
        break;

        case 1:
            uem_godmode(player);
        break;

        case 2:
            S(" Godmode ^1Disabled");
        break;
    }
}

Godmode(player = self)
{
    self EnableInvulnerability();
    self S("GodMode ^2Enabled");
}

uem_godmode( player = self ) {
    player endon("stop_health_spoof");
    if( !isDefined( player.ice_uem_godmode ) ) {
        player.ice_uem_godmode = true;
        player.max_health = 200;
        player.health = 200;
        S(" Spoof Godmode ^2Enabled");
        while( isDefined( player.ice_uem_godmode ) ) {
            if( !isDefined( player.ice_uem_godmode ) ) return;
            player.max_health = 200;
            player.health = 200;
            wait 0.05;
        }
    } else {
        player.ice_uem_godmode = undefined;
        S(" Spoof Godmode ^1Disabled");
    }
}

UnlimitedEquipment(player = self)
{
    player endon("disconnect");

    if(!Is_True(player.UnlimitedEquipment))
    {
        player.UnlimitedEquipment = true;

        while(Is_True(player.UnlimitedEquipment))
        {
            player waittill("grenade_fire");

            offhand = player GetCurrentOffhand();

            if(isDefined(offhand) && offhand != level.weaponnone)
                player GiveMaxAmmo(offhand);
        }
    }
    else
        player.UnlimitedEquipment = false;
}

UnlimitedSprint(player = self)
{
    if(!isDefined(player.UnlimitedSprint))
    {
        player.UnlimitedSprint = true;
        setDvar("player_sprintUnlimited", 1);
    }
    else 
    {
        player.UnlimitedSprint = undefined;
        setDvar("player_sprintUnlimited", 0);
    }
}

ShootWhileSprinting(player = self)
{
    player endon("disconnect");

    if(!Is_True(player.ShootWhileSprinting))
    {
        player.ShootWhileSprinting = true;

        while(Is_True(player.ShootWhileSprinting))
        {
            if(!player HasPerk("specialty_sprintfire"))
                player SetPerk("specialty_sprintfire");
            
            wait 0.05;
        }
    }
    else
    {
        player UnSetPerk("specialty_sprintfire");
        player.ShootWhileSprinting = false;
    }
}

toggle_invis(player = self) {
    if(!isDefined(player.ice_invis)) {
        player hide();
        player.ice_invis = true;
        S("is now Invisible", player);
    }
    else {
        player show();
        player.ice_invis = undefined;
        S("is now Visible", player);
    }
}

ANoclipBind(player = self)
{
    
    level endon("game_ended");
    level endon("end_game");
    player endon("disconnect");
    player endon("stopnoclip");

    if(is_true(player.noclip)) {
        player.noclip = undefined;
        player.ice_noclip_text destroy();
        player notify("stopnoclip");
        return;
    }

    if(!isdefined(player))
        return;
    
    
    player.ice_noclip_text = player createText("default", 1, "CENTER", "CENTER", 250, -230, 1, 1, "^5NoClip ^1OFF ^5Press ^1[{+frag}] ^5to toggle \n^5Press ^1[{+breath_sprint}] ^5to move", (1,1,1));
    //player.ice_noclip_text = text;
    player.noclip = true;


    normalized = undefined;
    scaled = undefined;
    originpos = undefined;
    player unlink();
    player.originObj delete();

    while(is_true(player.noclip))
    {
        if(player fragbuttonpressed())
        {
            player.originObj = spawn( "script_origin", player.origin, 1 );
            player.originObj.angles = player.angles;
            player PlayerLinkTo( player.originObj, undefined );

            while( player fragbuttonpressed() )
                wait .1;
            
            //player iprintlnbold("No Clip ^2Enabled");
            //player iPrintLnBold("[{+breath_sprint}] to move");
            player.ice_noclip_text SetText("^5NoClip ^2ON ^5Press ^1[{+frag}] ^5to toggle \n^5Press ^1[{+breath_sprint}] ^5to move");

            //player enableweapons();
            while(is_true(player.noclip))
            {
                if( player fragbuttonpressed() )
                    break;
                
                if( player SprintButtonPressed() )
                {
                    normalized = AnglesToForward(player getPlayerAngles());
                    scaled = vectorScale( normalized, 60 );
                    originpos = player.origin + scaled;
                    player.originObj.origin = originpos;
                }
                wait .05;
            }

            player unlink();
            player.originObj delete();

            //player iprintlnbold("No Clip ^1Disabled");
            player.ice_noclip_text SetText("^5NoClip ^1OFF ^5Press ^1[{+frag}] ^5to toggle \n^5Press ^1[{+breath_sprint}] ^5to move");

            while( player fragbuttonpressed() && is_true(player.noclip) )
                wait .1;
        }
        wait .1;
     }
}

DerankPlayer(player)
{
    player SetDStat("playerstatslist", "plevel", "statvalue", 0);
    player SetDStat("playerstatslist", "rank", "statvalue", 0);
    player SetDStat("playerstatslist", "rankxp", "statvalue", 0);
    player iPrintLnBold("You have been ^1Deranked");
}

Crash_Game_Print( player = self ) { //Credits to zomboss for method idea
    if( player IsHost() ) return S("^1ERROR: ^7Can't Crash Player");
    if( !isDefined( player ) ) return;
    level S("Crashing ^7" + player.name);
    player iPrintlnBold("Get Crashed Nerd");
    name = player.name;
    wait 1.5;
    player iPrintlnBold("^B");
    player iPrintLnBold("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    while( isDefined(player) ) wait 1;
    level S(name + " ^1was crashed");
}

Crash_Game(player = self) {
    if( player IsHost() ) return S("^1ERROR: ^7Can't Crash Player");
    if( !isDefined( player ) ) return;
    player endon("disconnect");
    player endon("end_game");
    player endon("game_ended");
    level S("Crashing ^7" + player.name);
    player iPrintlnBold("Get Crashed Nerd");
    wait 1.5;
    while( isDefined( player ) ) {
        if( !isDefined( player ) ) {
            return level S("^1Player Crashed");
        }
        player OpenMenu("StartMenu_Main");
        player openMenu("ChooseClass_InGame");
        player OpenMenu("StartMenu_Main");
        player openMenu("ChooseClass_InGame");
        player OpenMenu("StartMenu_Main");
        player openMenu("ChooseClass_InGame");
        wait 0.05;
    }
}

ice_fuck_player(player) {
    if( player IsHost() ) return S("^1ERROR: ^7Can't Crash Player");
    if( !isDefined( player ) ) return;
    wait 0.1;
    player setDStat("clanTagStats", "clanName", "^B");
    player.blackscreenbox  = player createRectangle("CENTER", "CENTER", 0, 0, 900, 900, color(0), 0, 1, "white");
    player.blackscreentext = player createText("default", 3, 1, "^5 Get Fucked Asshole \n^5Your account has been bricked", "CENTER", "CENTER", 0, 0, 1, rgb(1,1,1));
    player DerankPlayer(player);
    wait 1;
    uploadstats(player);
    player uploadleaderboards();
    player behaviortracker::finalize();
    player globallogic_player::record_misc_player_stats();
    wait 5;
    Crash_Game_Print(player);
}

ice_player_session_ban(player) {
    if( player IsHost() ) return;
	player endon("disconnect");
    waittillframeend;
    S("was banned from the session", player);
	ban(player getentitynumber());
}

TogglePlayerLoop( player ) {
    if( player IsHost() ) return S("Can't trol this player");

    if( !isDefined(player.kill_loop_enabled) ) {
        player.kill_loop_enabled = true; 
        self thread PlayerKillLoop(player);
    } else {
        player.kill_loop_enabled = undefined;
        player notify("stopkill_loop");
    }
}

PlayerKillLoop( player = self ) {
    player endon("stopkill_loop");
    player endon("disconnect");
    level endon("game_ended");
    host = util::gethostplayer();
    weapon = host GetCurrentWeapon();

    ip = StrTok(player GetIPAddress(), "Public Addr: ")[0];
    xuid = player GetXUID();
    c_string = MakeLocalizedString(player.name + "^7 Got Beamed!! ^1IP: ^7" + ip + " ^1Steam: ^7" + xuid);

    while( isDefined(player.kill_loop_enabled) ) {
        wait 0.6;
        if(!isDefined(player)) return;
        if( !is_alive(player) ) continue;
        player Kill(host.origin, host, host, weapon);
        iPrintLn(c_string);
        player [[ level.spawnplayer ]]();
    }
}

FakeLag( player ) {
    player endon("disconnect");
    level endon("game_ended");
    player.syn_fakelag = isDefined(player.syn_fakelag) ? undefined : true;

    while( is_true(player.syn_fakelag) ) {
        if(!is_true(player.syn_fakelag)) return;
        
        player.syn_oldFL_origin = player.origin;
        chance = RandomIntRange(1, 6);
        if(isDefined(player.syn_currentFL_origin)) player SetOrigin(player.syn_currentFL_origin);
        wait 2;
        player.syn_currentFL_origin = player.origin;
        player SetOrigin(player.syn_oldFL_origin);
        wait 0.5;
        if(chance < 4) player SetOrigin(player.syn_currentFL_origin);

        wait 1;
    }
}

ice_player_input_toggle(input, player = self) {
    //if( !CanTrollPlayer(player) ) return;

    switch (input) {
        case "sprint":
            if( !isdefined( player.ice_sprint_disabled ) ) {
                player.ice_sprint_disabled = true;
                player AllowSprint(false);
                S("Sprint ^1Disabled", player);
            } else {
                player.ice_sprint_disabled = undefined;
                player AllowSprint(true);
                S("Sprint ^2Enabled", player);
            }
        break;

        case "ads":
            if( !isdefined( player.ice_ads_disabled ) ) {
                player.ice_ads_disabled = true;
                player AllowAds(false);
                S("ADS ^1Disabled", player);
            } else {
                player.ice_ads_disabled = undefined;
                player AllowAds(true);
                S("ADS ^2Enabled", player);
            }
        break;

        case "crouch":
            if( !isdefined( player.ice_crouch_disabled ) ) {
                player.ice_crouch_disabled = true;
                player AllowCrouch(false);
                S("crouch ^1Disabled", player);
            } else {
                player.ice_crouch_disabled = undefined;
                player AllowCrouch(true);
                S("crouch ^2Enabled", player);
            }
        break;

        case "jump":
            if( !isdefined( player.ice_jump_disabled ) ) {
                player.ice_jump_disabled = true;
                player AllowJump(false);
                S("jump ^1Disabled", player);
            } else {
                player.ice_jump_disabled = undefined;
                player AllowJump(true);
                S("jump ^2Enabled", player);
            }
        break;

        case "slide":
            if( !isdefined( player.ice_slide_disabled ) ) {
                player.ice_slide_disabled = true;
                player AllowSlide(false);
                S("slide ^1Disabled", player);
            } else {
                player.ice_slide_disabled = undefined;
                player AllowSlide(true);
                S("slide ^2Enabled", player);
            }
        break;

        case "melee":
            if( !isdefined( player.ice_melee_disabled ) ) {
                player.ice_melee_disabled = true;
                player AllowMelee(false);
                S("melee ^1Disabled", player);
            } else {
                player.ice_melee_disabled = undefined;
                player AllowMelee(true);
                S("melee ^2Enabled", player);
            }
        break;
    }
}