PopulateBulletOptions( ) {
    switch (self getCurrentMenu()) {
        case "Bullet Menu":
            self addMenu("Bullet Menu", "Bullet Menu");
                self addOpt("Weapon Projectiles", ::newMenu, "Weapon Projectiles");
                self addOpt("Equipment", ::newMenu, "Equipment Bullets");
                self addOpt("Effects", ::newMenu, "Bullet Effects");
                self addOpt("Spawnables", ::newMenu, "Bullet Spawnables");
                self addOpt("Explosive Bullets", ::newMenu, "Explosive Bullets");
                //self addOpt("Reset", ::ResetBullet, self);
        break;
    }
}