SuperJump()
{
    if(!Is_True(level.SuperJump))
    {
        level.SuperJump = true;
        SetJumpHeight(300);
    }
    else
    {
        level.SuperJump = false;
        SetJumpHeight(39);
    }
}

LowGravity()
{
    if( !isDefined(level.BgGravity) ) level.BgGravity = GetDvarInt("bg_gravity");
    if(GetDvarInt("bg_gravity") == level.BgGravity)
        value = 200;
    else
        value = level.BgGravity;
    
    SetDvar("bg_gravity", value);
}

SuperSpeed()
{
    if( !isDefined(level.GSpeed) ) level.GSpeed = GetDvarString("g_speed");
    if(GetDvarString("g_speed") == level.GSpeed)
        value = "500";
    else
        value = level.GSpeed;
    
    SetDvar("g_speed", value);
}

PlayerBlink( player = self ) {
    if( !isDefined( player.ice_blinking ) ) {
        player.ice_blinking = true;
        S("is blinking");
        while( isDefined( player.ice_blinking ) ) {
            if( !isDefined( player.ice_blinking ) ) return;
            player hide();
            wait 0.2;
            player show();
            wait 0.2;
        }
    } else {
        player.ice_blinking = undefined;
        S("is no longer blinking");
    }
}

togglejumpboost( player = self ) {
    if( GetDvarInt("playerEnergy_enabled", 0) == 1 ) {
        SetDvar("playerEnergy_enabled", 0);
        level S("Unlimited Jump Boost ^2Enabled");
    } else {
        SetDvar("playerEnergy_enabled", 1);
        level S("Unlimited Jump Boost ^1Disabled");
    }
}

ServerSetTimeScale(timescale)
{
    if(GetDvarInt("timescale") == timescale)
        return;
    
    SetDvar("timescale", timescale);
}