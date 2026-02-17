#ifdef MP
PopulateKillstreakOptions( ) {
    streaks = ["uav", "autoturret", "counteruav", "rcbomb", "remote_missile", "planemortar", "microwave_turret", "satellite", "helicopter_comlink", "emp", "raps", "dart", "sentinel", "combat_robot", "ai_tank_drop", "drone_strike"];
    streakName = ["UAV", "Hardened Sentry", "Counter UAV", "HC-DX", "HellStorm Missle", "Lightning Strke", "Guardian", "H.A.T.R", "Wraith", "Power Core", "RAPS", "Dart", "Talon", "G.I Unit", "Cerberus", "Rolling Thunder"];
    
    switch (self getCurrentMenu()) { 
        case "Killstreaks":
            self addMenu("Killstreaks", "Killstreaks");
            for(i = 0; i < streaks.size; i++) {
             self addOpt(streakName[i], ::GiveKillStreak, streaks[i]); 
            }

        break;
    }
}

GiveKillStreak(streak, player = self)
{
	result = player killstreaks::give_internal(streak);
	if(!result)
	{
		self S("^1ERROR: ^7Could Not Give Kilstreak");
	}
}

#endif