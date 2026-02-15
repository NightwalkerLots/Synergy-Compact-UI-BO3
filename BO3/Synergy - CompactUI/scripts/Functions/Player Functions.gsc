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

Noclip1(player)
{
    player endon("disconnect");

    if(!Is_True(player.Noclip) && player isPlayerLinked())
        return self iPrintlnBold("^1ERROR: ^7Player Is Linked To An Entity");
    
    if(!Is_True(player.Noclip))
    {
        player.Noclip = true;

        if(player hasMenu() && player isInMenu(true))
            player menuclose();

        player DisableWeapons();
        player DisableOffHandWeapons();

        player.nocliplinker = SpawnScriptModel(player.origin, "tag_origin");
        player PlayerLinkTo(player.nocliplinker, "tag_origin");
        player.DisableMenuControls = true;

        player.noclip_instructions = player createText("default", 1, "CENTER", "CENTER", 0, 0, 1, 1, "[{+attack}] - Move Forward\n[{+speed_throw}] - Move Backwards\n[{+melee}] - Exit", (1,1,1));
        
        while(Is_True(player.Noclip) && Is_Alive(player) && !player isPlayerLinked(player.nocliplinker))
        {
            if(player AttackButtonPressed())
                player.nocliplinker.origin = player.nocliplinker.origin + AnglesToForward(player GetPlayerAngles()) * 60;
            else if(player AdsButtonPressed())
                player.nocliplinker.origin = player.nocliplinker.origin - AnglesToForward(player GetPlayerAngles()) * 60;

            if(player MeleeButtonPressed())
                break;

            wait 0.01;
        }

        if(Is_True(player.Noclip))
            player Noclip1(player);
    }
    else
    {
        player Unlink();
        player.nocliplinker delete();

        player EnableWeapons();
        player EnableOffHandWeapons();

        player.DisableMenuControls = false;
        player.Noclip = false;

        player.noclip_instructions Destroy();
    }
}