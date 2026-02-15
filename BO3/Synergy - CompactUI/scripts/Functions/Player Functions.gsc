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