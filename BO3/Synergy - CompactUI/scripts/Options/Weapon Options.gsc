PopulateWeaponOptions( ) {
    switch (self getCurrentMenu()) {
        case "Weapon Manipulation":
            self addMenu("Weapon Manipulation", "Weapon Manipulation");
            #ifdef MP 
                self addOpt("Change Class", ::MPChangeClass);
            #endif


            #ifdef ZM
                self addOpt("Upgrade Current Weapon", ::UpgradeWeapon, self, self GetCurrentWeapon());
            #endif
                self addOpt("Weapon Selection", ::newMenu, "Weapon Selection");
        break;

        case "Weapon Selection":
            self addMenu("Weapon Selection", "Weapon Selection");
                for(e=0;e<level.WeaponCategories.size;e++)
                self addOpt(level.WeaponCategories[e], ::newMenu, level.WeaponCategories[e] );
        break;

        case "Assault Rifles":
            self addMenu(level.WeaponCategories[0], "Assault Rifles");
                foreach(weap in level.weapons[0])
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
        break; 

        case "Submachine Guns":
            self addMenu(level.WeaponCategories[1], "Submachine Guns");
                foreach(weap in level.weapons[1])
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
        break;

        case "Shotguns":
            self addMenu(level.WeaponCategories[2], "Shotguns");
                foreach(weap in level.weapons[2])
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
        break;

        case "Light Machine Guns":
            self addMenu(level.WeaponCategories[3], "Light Machine Guns");
                foreach(weap in level.weapons[3])
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
        break;

        case "Sniper Rifles":
            self addMenu(level.WeaponCategories[4], "Sniper Rifles");
                foreach(weap in level.weapons[4])
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
        break;

        case "Launcher":
            self addMenu(level.WeaponCategories[5], "Launcher");
                foreach(weap in level.weapons[5])
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
        break;

        case "Pistols":
            self addMenu(level.WeaponCategories[6], "Pistols");
                foreach(weap in level.weapons[6])
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
        break;

        case "Specials":
            self addMenu(level.WeaponCategories[7], "Specials");
                foreach(weap in level.weapons[7]){
                    if(weap.name == "Beast Weapon" && GetTehMap() != "soe" || weap.name == "The Undead-Zapper" && GetTehMap() != "zm_factory" || weap.name == "H.I.V.E" || weap.name == "Skull of Nan Sepwe" && GetTehMap() != "zns") continue;
                    self addOpt( weap.name, ::GiveWeaponToPlayer, weap.id, self ); 
                }
        break;
    }
}