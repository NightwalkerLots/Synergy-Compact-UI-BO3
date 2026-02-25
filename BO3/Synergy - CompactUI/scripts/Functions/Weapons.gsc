HideGunToggle()
{
    if(!isDefined(self.InvisGun)){self.InvisGun = true;SetDvar("cg_drawGun", "0");self S("Invisible Gun Enabled");}else{self.InvisGun=undefined;SetDvar("cg_drawGun", "1"); self S("Invisible Gun Disabled");}
}

WeaponOptions(i)
{
    weap = self GetCurrentWeapon();
    switch(i)
    {
        case 0: self TakeWeapon(weap); self S("You just had your Weapon ^1Taken"); break;
        case 1: self takeAllWeapons(); self S("You just lost All Your Weapons"); break;
        case 2: self dropItem(weap); self S("Did you just Drop your ^1"+weap); break;
    }
}

GiveWeaponToPlayer(WeaponName, player)
{
    player takeWeapon(player getCurrentWeapon());
    wait .1;
    player GiveWeapon(GetWeapon(WeaponName), player CalcWeaponOptions(randomInt(128), randomInt(5), 2), 0);
    wait .1;
    player switchToWeapon(GetWeapon(WeaponName));
    player S("You Just Got: ^2: "+WeaponName);
}

ice_do_rapidfire(player = self) {
    if(!isDefined(self.ice_rapidfire)) {
        player.ice_rapidfire = true;
        S("Rapid Fire ^2Enabled");

        player endon("ice_stop_rapid_fire");
        while(player.ice_rapidfire == true) {
            wait 0.025;
            while( !player AttackButtonPressed() ) wait 0.025;
            player thread fakeShoot(player);
        }
    } else {
        player notify("ice_stop_rapid_fire");
        player.ice_rapidfire = undefined;
        S("Rapid Fire ^1Disabled");
    }
}

aimbot_exclude(person, team)
{
    return person.team == team || !isAlive(person);
}

fakeShoot( player ) 
{
    name = player getCurrentWeapon();
    ammo = player getWeaponAmmoClip( name );  

    if(player getCurrentWeapon() == "none" || player isReloading() || player isOnLadder() || player isMantling() || player isSwitchingWeapons() || ammo <= 0 || player isMeleeing() )
        return;
        
    magicBullet(name, player GetWeaponMuzzlePoint(), (player GetWeaponMuzzlePoint() + anglestoforward( player getplayerangles() ) * 2000), player);
    
    player weaponplayejectbrass();
    player playSoundToPlayer(name.firesoundplayer, player);

    if( !is_true(player.unlimitedammo) )
        player setWeaponAmmoClip(name, ammo-1); 

    if(!isDefined(player.ice_rapidfire)) {
        wait name.fireTime / 2;  
    }
}

GetSelectedProjetileType(type) {
    if( self.bulletType == type ) return true;
    else return false;
}

SetCustomProjectile( proj, weapon, player = self ) {
    if(isDefined(player.CustomProjectiles)) {
        player.CustomProjectiles = undefined;
        player.bulletType = undefined;
        player notify("StopCustomProjectiles");
    }
    
    if(proj == "None") {
        return;
    } else {
        level endon("game_ended");
        player endon("StopCustomProjectiles");
        player.CustomProjectiles = true;
        bullet_type = GetWeapon(weapon);
        player.bulletType = weapon;

        while(is_true(player.CustomProjectiles)) {
            wait 0.025;
            player waittill("weapon_fired");
            trace = GetNormalTrace(999);
            magicBullet(bullet_type, player GetWeaponMuzzlePoint(), trace["position"], player);
        }
    }
}

GetTraceOrigin(distance = 1000000)
{
    return self GetNormalTrace(distance)["position"];
}

GetNormalTrace(distance = 1000000)
{
    return bullettrace(self GetEye(), self GetEye() + anglesToForward(self getplayerangles()) * distance, 0, self);
}