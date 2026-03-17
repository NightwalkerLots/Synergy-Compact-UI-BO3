syn_override_player_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if( self.syn_reflect_damage ) {
        if(isDefined(einflictor.syn_reflect_damage)) return false;
        einflictor Kill(self.origin, self, self, weapon);
        idamage = int(0);
    }

    return int(idamage);
}

// check if self has var, but also apply var to victem inside statement, if var doesn't exist on victem then run the code