menuMonitor()
{
    self endon("disconnect");
    self endon("end_menu");
    while(self.access != 0)
    {
        if(!self.menu["isLocked"])
        {
            if(!self.menu["isOpen"])
            {
                if(self meleeButtonPressed() && self adsButtonPressed())
                {
                    self menuOpen();
                    wait .2;
                }
            }
            else
            {
                if((self attackButtonPressed() || self adsButtonPressed()))
                {
                    CurrentCurs = self getCurrentMenu() + "_cursor";

                    self.menu[CurrentCurs]+= self attackButtonPressed();
                    self.menu[CurrentCurs]-= self adsButtonPressed();
                
                    self thread scrollingSystem();
                    self PlayLocalSound("mouse_over");
                    wait .12;
                }
            
                if(self ActionSlotThreeButtonPressed() || self ActionSlotFourButtonPressed())
                {
                    Menu = self.eMenu[self getCursor()];
                    if(self ActionSlotFourButtonPressed())
                    {
                        if(IsDefined(Menu.optSlide))
                        {
                            self updateOptSlider("L2");
                            Func = self.Optsliders;
                        }
                        else if(IsDefined(Menu.val))
                        {
                            self updateSlider("L2");
                            Func = self.sliders;
                        }
                    }
                    if(self ActionSlotThreeButtonPressed())
                    {
                        if(IsDefined(Menu.optSlide))
                        {
                            self updateOptSlider("R2");
                            Func = self.Optsliders;
                        }
                        else if(IsDefined(Menu.val))
                        {
                            self updateSlider("R2");
                            Func = self.sliders;
                        }
                    }
                
                    if(IsDefined(Menu.autofunc))
                        self thread doOption(Menu.func, Func[self getCurrentMenu() + "_" + self getCursor()], Menu.p1, Menu.p2, Menu.p3);
                    
                    if(IsDefined(Menu.toggle))
                        self UpdateCurrentMenu();
                  
                    wait .12;
                }
            
                if(self useButtonPressed())
                {
                    Menu = self.eMenu[self getCursor()];
                    self PlayLocalSound("mouse_over");
                
                    if(IsDefined(self.sliders[self getCurrentMenu() + "_" + self getCursor()])){
                        slider = self.sliders[ self getCurrentMenu() + "_" + self getCursor() ];
                        slider = (IsDefined( menu.List1 ) ? menu.List1[slider] : slider);
                        self thread doOption(Menu.func, slider, Menu.p1, Menu.p2, Menu.p3,menu.p4,menu.p5);
                    }
                    else if(IsDefined(self.Optsliders[self getCurrentMenu() + "_" + self getCursor()]))
                        self thread doOption(Menu.func, self.Optsliders[self getCurrentMenu() + "_" + self getCursor()], Menu.p1, Menu.p2, Menu.p3);
                    
                    else
                        self thread doOption(Menu.func, Menu.p1, Menu.p2, Menu.p3, Menu.p4, Menu.p5, Menu.p6);
                    
                    if(IsDefined(Menu.toggle))
                        self UpdateCurrentMenu();
                    
                    while(self useButtonPressed())
                      wait .2;
                }
            
                if(self meleeButtonPressed())
                {
                    if(self getCurrentMenu() == "main")
                        self menuClose();
                    else
                        self newMenu();
                    
                    wait .2;
                }
            }
        }
        wait .05;
    }
}

doOption(func, p1, p2, p3, p4, p5, p6)
{
    if(!isdefined(func))
        return;
    if(isdefined(p6))
        self thread [[func]](p1,p2,p3,p4,p5,p6);
    else if(isdefined(p5))
        self thread [[func]](p1,p2,p3,p4,p5);
    else if(isdefined(p4))
        self thread [[func]](p1,p2,p3,p4);
    else if(isdefined(p3))
        self thread [[func]](p1,p2,p3);
    else if(isdefined(p2))
        self thread [[func]](p1,p2);
    else if(isdefined(p1))
        self thread [[func]](p1);
    else
        self thread [[func]]();
}

scrollingSystem()
{
    menu = self getCurrentMenu() + "_cursor";
    curs = self getCursor();
    if(curs >= self.eMenu.size || curs <0 || curs == 7 || curs >= 8)
    {
        if(curs <= 0)
            self.menu[menu] = self.eMenu.size -1;
            
        if(curs >= self.eMenu.size)
            self.menu[menu] = 0;
            
        self setMenuText();
    }
    self updateScrollbar();
    self refreshOPTSize();
}

updateScrollbar()
{
    curs = ((self getCursor() >= 8) ? 7 : self getCursor());
    
    if(self.menu["Theme"]["Default"] == true){
    self.menu["UI"]["SCROLL"].y = (self.menu["OPT"][0].y + (curs*15));}
    else if(self.menu["Theme"]["Flex"] == true){
    self.menu["UI"]["SCROLL"].y = (self.menu["OPT"][0].y + (curs*12));}
        
    if(IsDefined(self.eMenu[self getCursor()].val))
        self updateSlider();
        
    if(IsDefined(self.eMenu[self getCursor()].optSlide))
        self updateOptSlider();
    if(self getCurrentMenu() == "Clients")
        self.SavePInfo = level.players[self getCursor()];
}

newMenu(menu, Access)
{
    if(IsDefined(Access) && self.access < Access)
        return;
        
    if(!isDefined(menu))
    {
        menu = self.previousMenu[self.previousMenu.size-1];
        self.previousMenu[self.previousMenu.size-1] = undefined;
    }
    else {
        self.previousMenu[self.previousMenu.size] = self getCurrentMenu();
    }
        
    self setCurrentMenu(menu);    
    self menuOptions();
    self setMenuText();
    self refreshTitle();
    self resizeMenu();
        
    self refreshOPTSize();
    self updateScrollbar();
}

isMenuOpen()
{
    if( !isDefined(self.menu["isOpen"]) || !self.menu["isOpen"] )
        return false;
    return true;
}

lockMenu(which)
{
    if(toLower(which) == "lock")
    {
        if(self isMenuOpen())
            self menuClose();
        self.menu["isLocked"] = true;
    }
    else if (toLower(which) == "unlock")
    {
        if(!self isMenuOpen())
            self menuOpen();
        self.menu["isLocked"] = false;
    }
}

addMenu(menu, title)
{
    self.storeMenu = menu;
    if(self getCurrentMenu() != menu)
        return;
    self.eMenu     = [];
    self.menuTitle = title;
    if(!isDefined(self.menu[menu + "_cursor"]))
        self.menu[menu + "_cursor"] = 0;
}

addOpt(opt, func, p1, p2, p3, p4, p5, p6)
{
    if(self.storeMenu != self getCurrentMenu())
        return;
    option      = spawnStruct();
    option.opt  = opt;
    option.func = func;
    option.p1   = p1;
    option.p2   = p2;
    option.p3   = p3;
    option.p4   = p4;
    option.p5   = p5;
    option.p6   = p6;
    self.eMenu[self.eMenu.size] = option;
}

addToggleOpt(opt, func, toggle, p1, p2, p3, p4, p5, p6)
{
    if(self.storeMenu != self getCurrentMenu())
        return;
    if(!IsDefined(toggle))
        toggle = false;
    toggleOpt        = spawnStruct();
    toggleOpt.opt    = opt;
    toggleOpt.func   = func;
    toggleOpt.toggle = (IsDefined(toggle) && toggle);
    toggleOpt.p1     = p1;
    toggleOpt.p2     = p2;
    toggleOpt.p3     = p3;
    toggleOpt.p4     = p4;
    toggleOpt.p5     = p5;
    toggleOpt.p6     = p6;
    self.eMenu[self.eMenu.size] = toggleOpt;
}

addSlider(opt, val, min, max, inc, func, toggle, autofunc, p1, p2, p3)
{
    if(self.storeMenu != self getCurrentMenu())
        return;
    if(!IsDefined(toggle))
        toggle = false;
    slider          = SpawnStruct();
    slider.opt      = opt;
    slider.val      = val;
    slider.min      = min;
    slider.max      = max;
    slider.inc      = inc;
    slider.func     = func;
    slider.toggle   = (IsDefined(toggle) && toggle);
    slider.autofunc = autofunc;
    slider.p1       = p1;
    slider.p2       = p2;
    slider.p3       = p3;
    self.eMenu[self.eMenu.size] = slider;
}

addOptSlider(opt, strTok, func, toggle, autofunc, p1, p2, p3)
{
    if(self.storeMenu != self getCurrentMenu())
        return;
    if(!IsDefined(toggle))
        toggle = false;
    Optslider          = SpawnStruct();
    Optslider.opt      = opt;
    Optslider.optSlide = strTok(strTok, "|");
    Optslider.func     = func;
    Optslider.toggle   = (IsDefined(toggle) && toggle);
    Optslider.autofunc = autofunc;
    Optslider.p1       = p1;
    Optslider.p2       = p2;
    Optslider.p3       = p3;
    self.eMenu[self.eMenu.size] = Optslider;
}

addSliderWithString(opt, List1, List2, func, p1, p2, p3, p4, p5)
{
    if(self.storeMenu != self getCurrentMenu())
        return;
    optionlist = spawnstruct();
    if(!isDefined(List2))
        List2 = List1;
    optionlist.List1 = (IsArray(List1)) ? List1 : strTok(List1, ";");
    optionlist.List2 = (IsArray(List2)) ? List2 : strTok(List2, ";");
    optionlist.opt = MakeLocalizedString(opt);
    optionlist.func = func;
    optionlist.p1   = p1;
    optionlist.p2   = p2;
    optionlist.p3   = p3;
    optionlist.p4   = p4;
    optionlist.p5   = p5;
    self.eMenu[self.eMenu.size] = optionlist;
}

updateSlider(pressed) 
{
    Menu = self.eMenu[self getCursor()];
    maxOpts = self.menuSetting["MaxOpsDisplayed"];
    if(!IsDefined(self.sliders[self getCurrentMenu() + "_" + self getCursor()]))
        self.sliders[self getCurrentMenu() + "_" + self getCursor()] = self.eMenu[self getCursor()].val;
        
    curs = self.sliders[self getCurrentMenu() + "_" + self getCursor()];
    if(pressed == "R2")
        curs += Menu.inc;
    if(pressed == "L2")
        curs -= Menu.inc;
    if(curs > Menu.max)
        curs = Menu.min;
    if(curs < Menu.min)
        curs = Menu.max;
    
    
    cur = ((self getCursor() >= maxOpts) ? 7 : self getCursor());
    if(curs != Menu.val)
        self.menu["OPT"]["OPTScroll"][cur] SetText("" + curs);
    self.sliders[self getCurrentMenu() + "_" + self getCursor()] = curs;
}

updateOptSlider(pressed)
{
    Menu = self.eMenu[self getCursor()];
    maxOpts = self.menuSetting["MaxOpsDisplayed"];
    
    if(!IsDefined(self.Optsliders[self getCurrentMenu() + "_" + self getCursor()]))
        self.Optsliders[self getCurrentMenu() + "_" + self getCursor()] = 0;
        
    curs = self.Optsliders[self getCurrentMenu() + "_" + self getCursor()];
    
    if(pressed == "R2")
        curs ++;
    if(pressed == "L2")
        curs --;               
    if(curs > Menu.optSlide.size-1)
        curs = 0;
    if(curs < 0)
        curs = Menu.optSlide.size-1;

    cur = ((self getCursor() >= maxOpts) ? 7 : self getCursor());
    self.menu["OPT"]["OPTScroll"][cur] SetText(Menu.optSlide[curs] + " [" + (curs+1) + "/" + Menu.optSlide.size + "]");
    self.Optsliders[self getCurrentMenu() + "_" + self getCursor()] = curs;
}

setCurrentMenu(menu)
{
    self.menu["current"] = menu;
}

getCurrentMenu()
{
    return self.menu["current"];
}

getCursor()
{
    return self.menu[self getCurrentMenu()+ "_cursor"];
}

hasMenu()
{
    return (isDefined(self.access) && self.access != 0 ? true : false);
}

UpdateCurrentMenu()
{
    self setCurrentMenu(self getCurrentMenu());
    self menuOptions();
    self setMenuText();
    self updateScrollbar();
    self resizeMenu();
    self refreshOPTSize();
}

menuOpen()
{
    maxOpts = self.menuSetting["MaxOpsDisplayed"];
    ary = (self getCursor() >= maxOpts ? self getCursor()-7 : 0);
    self.menu["isOpen"] = true;
    if(bool(self.menuSetting["MenuFreeze"]))
        self FreezeControls(true);
    self menuOptions();
    self drawText();
    self drawMenu();
    self updateScrollbar();
    for(e=0;e<maxOpts;e++)
    {
        if(IsDefined(self.eMenu[ary + e].val) || IsDefined(self.eMenu[ary + e].optSlide))
        {
            self.menu["OPT"]["OPTScroll"][e].alpha = 0;
            self.menu["OPT"]["OPTScroll"][e] affectElement("alpha", .4, 1);
        }
    }
}

menuClose()
{
    self.menu["isOpen"] = false;
    if(bool(self.menuSetting["MenuFreeze"]))
        self FreezeControls(false);
    self destroyAll(self.menu["UI"]);
    self destroyAll(self.menu["OPT"]);
    self destroyAll(self.menu["OPT"]["OPTScroll"]);
}

onPlayerDisconnect(player)
{
    host = util::gethostplayer();
    self notify("StopPMonitor");
    self endon("StopPMonitor");
    self endon("end_menu");
    self endon("disconnect");
    player waittill("disconnect");
    while(self getCurrentMenu() != "Clients")
        self newMenu();
    self setcursor(0);
    self UpdateCurrentMenu();

    #ifdef MP 
    if(!self IsTestClient())
        host S("Has ^1Disconnected", self);
    #endif
}

setcursor(value, menu = self getCurrentMenu())
{
    self.menu[menu + "_cursor"] = value;
}

is_true(boolvar)
{
	if(!isdefined(boolvar) || !boolvar)
	{
		return 0;
	}
	return 1;
}

AntiQuit()
{
    if(!Is_True(level.AntiQuit))
        level.AntiQuit = true;
    else
        level.AntiQuit = false;

    SetMatchFlag("disableIngameMenu", level.AntiQuit);
}

SpawnScriptModel(origin, model, angles, time)
{
    if(isDefined(time))
        wait time;

    ent = Spawn("script_model", origin);
    ent SetModel(model);

    if(isDefined(angles))
        ent.angles = angles;

    return ent;
}

isPlayerLinked(exclude)
{
    ents = GetEntArray("script_model", "classname");

    for(a = 0; a < ents.size; a++)
    {
        if(isDefined(exclude))
        {
            if(ents[a] != exclude && self isLinkedTo(ents[a]))
                return true;
        }
        else
        {
            if(self isLinkedTo(ents[a]))
                return true;
        }
    }

    return false;
}

Is_Alive(player)
{
    return (IsAlive(player) && player.sessionstate != "spectator");
}

color(value)
{
    /*
        Size constraints comment:
        
        Why is this better than rgb = (r,g,b) => return (r/255, g/255, b/255)?
        
        This will emit PSC, GetInt, align(4), value, SFT, align(1 + pos, 4), 4
        rgb... emits PSC, {GetInt, align(4), value}[3], SFT, align(1 + pos, 4), 4
        Vector emits Vec, align(4), r as float, b as float, g as float 
        
        color:  Min: 14, Max: 17
        rgb:    Min: 30, Max: 33
        vector: Min: 13, Max: 16
    */
    
    return
    (
    (value & 0xFF0000) / 0xFF0000,
    (value & 0x00FF00) / 0x00FF00,
    (value & 0x0000FF) / 0x0000FF
    );
}

CleanString(string)
{
    if(string[0] == ToUpper(string[0]))
        if(IsSubStr(string, " ") && !IsSubStr(string, "_"))
            return string;
    
    string = StrTok(ToLower(string), "_");
    str = "";
    
    for(a = 0; a < string.size; a++)
    {
        //List of strings what will be removed from the final string output
        strings = ["specialty", "zombie", "zm", "mp", "zmu", "t7", "t6", "p7", "zmb", "zod", "ai", "g", "bg", "perk", "player", "weapon", "wpn", "aat", "bgb", "visionset", "equip", "craft", "der", "viewmodel", "mod", "fxanim", "moo", "moon", "zmhd", "fb", "bc", "asc", "vending", "part", "menu", "ui", "uie", "mtl", "_"];
        
        //This will replace any '_' found in the string
        replacement = " ";

        if(!isInArray(strings, string[a]))
        {
            for(b = 0; b < string[a].size; b++)
                if(b != 0)
                    str += string[a][b];
                else
                    str += ToUpper(string[a][b]);
            
            if(a != (string.size - 1))
                str += replacement;
        }
    }
    
    return str;
}

serverchangemap(map)
{
	if(!mapexists(map))
	{
		return self IPrintLnBold("Map Doesn't Exist");
	}
	if(level.script == map)
	{
		return;
	}
	map(map);
}

CanTrollPlayer( player ) {
    if(player IsHost()){ S("Can't Troll the host"); return false; }

    return true;
}