#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

// base script by DRAG modified by Clippy/Clipzor aka me
// use //help ingame to check commands
// uncomment the line for player checking if u want to be the only one able to use commands

// Entry
init()
{
    replacefunc(maps\mp\_utility::isBuffUnlockedForWeapon, ::isBuffUnlockedForWeaponReplace);
    replacefunc(maps\mp\gametypes\_gamelogic::setWeaponStat, ::setWeaponStatReplace);
    replacefunc(maps\mp\gametypes\_weapons::mayDropWeapon, ::mayDropWeaponReplace);
    replacefunc(maps\mp\_utility::isKillstreakWeapon, ::isKillstreakWeaponReplace);
    //replaces some weapon stat shit if i remember right

	precacheitem("at4_mp");
    precacheitem("lightstick_mp");

    setDvarIfUninitialized("firsty", "none"); // this is for infected, i dont remember if it ever got to live server on coomers but can be used to select someone as first infected, needs another file thats not included though, as it replaces base infected script

    level.forcestancemodeon = false; // these are jsut some global things that get setup
    level.leftgun = false;
    level.tinygun = false;
    level.thirdperson = false;
    level.timescale = 1.0;
    level.timescalecur = 1.0;

    setdvar("camera_thirdpersonoffset", "-120 -10 30");
    setdvar("camera_thirdpersonoffsetads", "-40 -10 4"); // nicer camera position in 3rd person

    level thread Commands();
    level thread onplayerconnect();
}

onPlayerConnect() 
{
    for(;;) 
	{
        level waittill("connected", player); // waits for players to connect

        if(level.forcestancemodeon == true) // if mode is active, activates it for said player
        player thread ForceStanceModeAll();

        if(level.leftgun == true) // if mode is active, activates it for said player
        player setclientdvar ( "cg_gun_y", "12" );

        if(level.tinygun == true) // if mode is active, activates it for said player
        player setclientdvar ( "cg_gun_x", "100" );
    }
}

Jumploop(height) { // player based increased jump height
	self endon("endjumpingheight");
	while(1) {
		while(self isonground()) {
			self waittill("jumping");
			self setVelocity((0,0,height));
		}
		wait .05;
	}
}

// Listen for commands until disconnect or game end
Commands()
{
    for(;;) {
        // Wait until a chat is sent
        level waittill( "say", message, player );

        //  if (player.name != "Clipzor" && player.name != "addyournamehere") // these 2 lines is what u need to uncomment if u want to have commands limited by playername (admins)
        //    continue;
        
        target = undefined;
        source = undefined;
        dest = undefined;

        // Reset the arguments
        level.args = undefined;
        level.args = [];

        // Get rid of junk character IW5 produces
        str = strTok( message, "" );

        // Parse the string past the junk character
        i = 0;
        foreach ( s in str ) {
            //if ( i > 2 )
            //    break;
            level.args[i] = s;
            i++;
        }

        // Lets split with space as a delimiter
        str = strTok( level.args[0], " " );

        // Parse between spaces
        i = 0;
        foreach( s in str ) {
            //if ( i > 2 )
            //    break;
            level.args[i] = s;
            i++;
        }

        if(IsSubStr(level.args[0], "/"))
		{
        // Switch cases for the commands. Each is fairly self explanatory
        switch ( level.args[0] ) {

            case "/ang":
                if(isdefined(level.args[1]) && isdefined(level.args[2]) && isdefined(level.args[3]))
                player SetPlayerAngles((int(level.args[1]) , int(level.args[2]) , int(level.args[3])));
                else
                player iprintln("Not All Angles Defined");
            break;

            case "/drop":
                player dropitem(player getcurrentweapon());
            break;

            case "/fi": // this does not work without a file i wont share
            case "/firstinfected":
                if (!isdefined(level.args[1]))
                    continue;
                target = findPlayerByName( level.args[1] );

                if(isdefined(target))
                {
                    setdvar("firsty", target.guid);
                }
                else
                {
                    player iprintln("Player ^1Not Found");
                    continue;
                }

    
            break;

            case "/freeze":
                if (!isdefined(level.args[1]))
                    continue;
                target = findPlayerByName( level.args[1] );

                if(!isdefined(target))
                {
                    player iprintln("Player ^1Not Found");
                    continue;
                }

                if(!isdefined(target.chillydick))
                {
                target.chillydick = true;
                target freezeControls( true );
                }
                else
                {
                    target.chillydick = undefined;
                    target freezeControls( false );
                }
    
            break;

            case "/mp":
            case "/messageplayer":
                if(isdefined(level.args[1])) {
                	target = findPlayerByName( level.args[1] );

                    if(!isdefined(target))
                    {
                        player iprintln("Player ^1Not Found");
                        continue;
                    }

                	if(isdefined(level.args[2]))
                    {
                        msg = str(level.args[2]);
                        for(i=3;i<level.args.size;i++)
                        {
                            msg = msg + " " + str(level.args[i]);
                            //iprintln(msg);
                        }
                		target iprintlnbold(msg);
                    }
                	else
                		player iprintln("Message ^1Argument Missing");
                }
                else
                	player iprintln("Player ^1Argument Missing");
            break;

            case "/sa":
            case "/sayas":
                if(isdefined(level.args[1]))
                {
                	target = findPlayerByName( level.args[1] );

                    if(!isdefined(target))
                    {
                        player iprintln("Player ^1Not Found");
                        continue;
                    }


                	if(isdefined(level.args[2]))
                    {
                        msg = str(level.args[2]);
                        for(i=3;i<level.args.size;i++)
                        {
                            msg = msg + " " + str(level.args[i]);
                            //iprintln(msg);
                        }
                		target sayall(msg); 
                    }
                	else
                		player iprintln("Message ^1Argument Missing");
                }
                else
                	player iprintln("Player ^1Argument Missing");
            break;

            case "/movespeed":
            	if(isdefined(level.args[1]) && level.args[1] != "all")
                {
            		target = findPlayerByName( level.args[1] );
            		if(isdefined(target)) {
                		if(isdefined(level.args[2]))
                			target SetMoveSpeedScale(float(level.args[2]));
                		else
                			player iprintln("Speed Value ^1Missing");
                	}
                	else
                		player iprintln("Player ^1Not Found");
            	}
            	else if(level.args[1] == "all") {
            		setdvar("g_speed", level.args[2]);
            		foreach(user in level.players)
            			user iprintlnbold("^2Move Speed Changed to ^5" + level.args[1]);
            	}
            break;

            case "/jumpheightplayer":
                if(isdefined(level.args[1])) {
                	target = findPlayerByName( level.args[1] );
                	if(isdefined(level.args[2]) && isdefined(target))
                		if(!isdefined(target.jumpheight)) {
                			target.jumpheight = true;
                			target thread Jumploop(int(level.args[2]));
                			player iprintlnbold("^2Jump Height for ^5" + target.name + "^2 Changed to ^5" + level.args[2]);
                		}
                		else {
                			target.jumpheight = undefined;
                			target notify("endjumpingheight");
                			player iprintlnbold("^2Jump Height for ^5" + target.name + "^2 Set to ^5Default");
                		}
                	else
                		player iprintln("Message ^1Argument Missing");
                }
                else
                	player iprintln("Player ^1Argument Missing");
            break;

            case "/givekillstreak":
                if(isdefined(level.args[1]) && level.args[1] != "all") {
                	target = findPlayerByName( level.args[1] );
                	if(isdefined(level.args[2])) {
                		if(isdefined(target))
                			target maps\mp\killstreaks\_killstreaks::giveKillstreak(level.args[2]);
                		else
                			player iprintln("Player ^1Not Found");
                	}
                	else
                		player iprintln("Killstreak Name ^1Missing");
                }
                else if(level.args[1] == "all") {
                	if(isdefined(level.args[2])) {
                		foreach(user in level.players)
                			user maps\mp\killstreaks\_killstreaks::giveKillstreak(level.args[2]);
                	}
                	else
                		player iprintln("Killstreak Name ^1Missing");
             	}
            break;
            
            case "/giveammo":
                if(isdefined(level.args[1])) {
                	target = findPlayerByName( level.args[1] );
                	if(isdefined(target))
                		target GiveMaxAmmo(target getcurrentweapon());
                	else
                		player iprintln("Player ^1Not Found");
                }
                else
                	player iprintln("Player ^1Argument Missing");
            break;

            case "/kill":
                if (!isdefined(level.args[1]))
                    continue;
                target = findPlayerByName( level.args[1] );
                if (isdefined(target))
                    target suicide();
                else
                player iprintln("^2Player ^7Not Found!");
            break;

            case "/tpto":
                if (!isdefined(level.args[1]))
                    continue;
                target = findPlayerByName( level.args[1] );
                if (isdefined(target))
                    player setOrigin( target getOrigin() );
                else
                player iprintln("^2Player ^7Not Found!");
            break;

            case "/bring":
                if (!isdefined(level.args[1]))
                    continue;
                target = findPlayerByName( level.args[1] );
                if (isdefined(target))
                {
                target setOrigin( player getOrigin() );
                target SetPlayerAngles( player getplayerangles() );
                }
                else
                player iprintln("^2Player ^7Not Found!");
            break;

            case "/linkto":
                if (!isdefined(level.args[1]))
                    continue;
                target = findPlayerByName( level.args[1] );
                if (isdefined(target))
                {
                player playerLinkTo(target);
                player iprintlnbold( "You Got Linked To ^1" + target.name);
                }
                else
                player iprintln("^2Player ^7Not Found!");
            break;

            case "/linktolink":
                if (!isdefined(level.args[1]))
                    continue;

                source = findPlayerByName( level.args[1] );
                dest = findPlayerByName( level.args[2] );
                if ( isdefined(source) && isdefined(dest) )
				{
                    source playerLinkTo(dest);
					source iprintlnbold( "You Got Linked To ^1" + dest.name);
				}
                else if(!isdefined(dest))
                player iprintln("^2Player 2^7Not Found!");
                else if(!isdefined(source))
                player iprintln("^2Player 1 ^7Not Found!");
            break;

            case "/unlink":
                if (!isdefined(level.args[1]))
                {
                    player unlink();
                    player iprintlnbold("Unlinked");
                }
                else
                {
                    target = findPlayerByName( level.args[1] );
                    if (isdefined(target))
                    target unlink();
                    target iprintlnbold("Unlinked");
                }
            break;

            case "/stance":
                if (!isdefined(level.args[1]))
                    continue;
                target = findPlayerByName( level.args[1] );
                if (isdefined(target))
                {
                    if(level.args[2] == "stand" || level.args[2] == "crouch" || level.args[2] == "prone")
                    {
                    target SetStance( level.args[2] );
                    }
                    else
                    player iprintln("Wrong Arguement");
                }
                else
                player iprintln("^2Player ^7Not Found!");
            break;

            case "/leftgun":

                if(level.leftgun == false)
				{
                    level.leftgun = true;
					foreach ( p in level.players )
                    {
                        P setclientdvar ( "cg_gun_y", "12" );
                    }
                }
				else if(level.leftgun == true)
				{
                    level.leftgun = false;
					foreach ( p in level.players )
                    {
                        P setclientdvar ( "cg_gun_y", "0" );
                    }
                }
            break;

            case "/tinygun":

                if(level.tinygun == false)
				{
                    level.tinygun = true;
					foreach ( p in level.players )
                    {
                        P setclientdvar ( "cg_gun_x", "100" );
                    }
                }
				else if(level.tinygun == true)
				{
                    level.tinygun = false;
					foreach ( p in level.players )
                    {
                        P setclientdvar ( "cg_gun_x", "0" );
                    }
                }
            break;

            case "/thirdperson":
                if(level.thirdperson == false)
				{
                    level.thirdperson = true;
                    setdvar ( "camera_thirdperson", "1" );
                }
				else if(level.thirdperson == true)
				{
                    level.thirdperson = false;
                    setdvar ( "camera_thirdperson", "0" );
                }
            break;

            case "/forcestance":
                if (!isdefined(level.args[1]))
                    continue;
                target = findPlayerByName( level.args[1] );
                if (isdefined(target))
                {
                    if(level.args[2] == "")
                    {
                        target notify("endforcemode");
                        iprintln("stopping");
                        break;
                    }

                    if(level.args[2] == "stand" || level.args[2] == "crouch" || level.args[2] == "prone")
                    {
                        target.forcemode = level.args[2];
                    }
                    else
                    {
                        iprintln("Passing");
                        break;
                    }

                    target iprintlnbold( "ForceStanceMode Enabled");
                    target thread ForceStanceMode();
                }
                else
                player iprintln("^2Player ^7Not Found!");
            break;

            case "/forcestanceall":

                if(!isdefined(level.args[1]))
                {
                    level notify("endforcemodeall");
                    level.forcestancemodeon = false;
                    iprintln("stopping");
                    break;
                }

                if(level.args[1] == "stand" || level.args[1] == "crouch" || level.args[1] == "prone")
                {
                    level.forcemode = level.args[1];
                }
                else
                {
                    iprintln("Passing");
                    break;
                }

                if(level.forcestancemodeon == false)
                {
                level.forcestancemodeon = true;
                iprintlnbold( "ForceStanceMode Enabled");
                    foreach ( p in level.players )
                    {
                        P thread ForceStanceModeAll();
                    }
                }
            break;

            case "/push":
                if (!isdefined(level.args[1]))
                    continue;
                target = findPlayerByName( level.args[1] );
                if (isdefined(target))
                {
                    target setVelocity(target getVelocity()+((randomintrange(-100,100),randomintrange(-100,100),randomintrange(100,300))));
                }
                else
                player iprintln("^2Player ^7Not Found!");
            break;

            case "/pushnum":
                if (!isdefined(level.args[1]))
                    continue;
                target = findPlayerByName( level.args[1] );
                if (isdefined(target))
                {
                    val = int(level.args[2]);
                    valmin = int(level.args[2]) - int(level.args[2]) * 2;
                    target setVelocity(target getVelocity()+((randomintrange(valmin,val),randomintrange(valmin,val),int(level.args[2]))));
                }
                else
                player iprintln("^2Player ^7Not Found!");
            break;

            case "/give":
                if (!isdefined(level.args[1]))
                    continue;
                target = findPlayerByName( level.args[1] );
                if (isdefined(target)) {
					target iprintlnbold( "You Got Given The " + level.args[2] );
                    target giveWeapon(level.args[2]);
                    target switchToWeapon( level.args[2] );
                }
                else
                player iprintln("^2Player ^7Not Found!");
            break;

            case "/giveall":
                foreach( p in level.players )
				{
					p iprintlnbold( "You Got Given The " + level.args[1] );
                    p giveWeapon( level.args[1] );
                    p switchToWeapon( level.args[1] );
                }
            break;

            case "/give":
                if (!isdefined(level.args[1]))
                    continue;
                target = findPlayerByName( level.args[1] );
                if (isdefined(target)) {
					target iprintlnbold( "You Got Given The " + level.args[2] );
                    target giveWeapon(level.args[2]);
                    target switchToWeapon( level.args[2] );
                }
                else
                player iprintln("^2Player ^7Not Found!");
            break;

            case "/takeall":
                foreach( p in level.players )
				{
					p iprintlnbold( "All Your Weapons Got Taken");
                    p takeAllWeapons();
                }
            break;
            
            case "/takeweapons":
                if (!isdefined(level.args[1]))
                    continue;
                target = findPlayerByName( level.args[1] );
                if (isdefined(target)) {
					target iprintlnbold( "All Your Guns Have Been Taken, Bozo");
                    target takeallweapons();
                }
                else
                player iprintln("^2Player ^7Not Found!");
            break;

            case "/givesur":
                foreach ( p in level.players )
				{
                    if ( p.sessionteam == "allies" )
					{
						p iprintlnbold( "You Got Given The " + level.args[1] );
                        p giveWeapon( level.args[1] );
                        p switchToWeapon( level.args[1] );
                    }
                }
            break;

            case "/giveinf":
                foreach ( p in level.players )
				{
                    if ( p.sessionteam == "axis" )
					{
						p iprintlnbold( "You Got Given The " + level.args[1] );
                        p giveWeapon( level.args[1] );
                        p switchToWeapon( level.args[1] );
                    }
                }
            break;

            case "/takesur":
                foreach ( p in level.players ) {
                    if ( p.sessionteam == "allies" )
					{
						p iprintlnbold( "Your Weapon Got Taken");
                        p takeAllWeapons();
					}
                }
            break;

            case "/takeinf":
                foreach ( p in level.players ) {
                    if ( p.sessionteam == "axis" )
					{
						p iprintlnbold( "Your Weapon Got Taken");
                        p takeAllWeapons();
					}
                }
            break;

            case "/vision":
                if (!isdefined(level.args[1]))
                    continue;
                target = findPlayerByName( level.args[1] );

                thevision = level.args[2];

                if (isdefined(target)) {
                    if(thevision == "")
                    thevision = "default";
					target iprintlnbold( "Your Vision Changed To ^1" + thevision );
                    target visionsetnakedforplayer(thevision, 3);
                }
                else
                player iprintln("^2Player ^7Not Found!");
            break;

            case "/visionall":
                thevision = level.args[1];

                if(thevision == "")
                thevision = "default";
                
                visionsetnaked(thevision, 3);
                iprintlnbold("Vision Changed To ^1" + thevision);
            break;

            case "/say":
                if (!isdefined(level.args[1]))
                    continue;
                
                msg = str(level.args[2]);
                for(i=2;i<level.args.size;i++)
                {
                    msg = msg + " " + str(level.args[i]);
                    //iprintln(msg);
                }
                iprintlnbold(msg);
            break;

            case "/ufo":
                if ( player.sessionstate == "playing" )
				{
                    player.weapons = player GetWeaponsListPrimaries();
                    //iprintln(player.weapons.size);
                    for(i=0; i<player.weapons.size; i++)
                    {
                        //iprintln(i);
                        player.ammo[i] = player GetWeaponAmmoStock(player.weapons[i]);
                    }

                    player.ufodied = undefined;
                    player.ufoloc = player.origin;
                    player.ufoang = player getplayerangles();

                    //player.tagforward = AnglesToForward(player getplayerangles());

					forward = AnglesToForward( player GetPlayerAngles() );

                    player.ufoent = [];
                    player.ufoent[0] = Spawn("script_model", player.ufoloc);
                    player.ufoent[0] setmodel(player.model);
                    player.ufoent[0].angles = (0,player GetPlayerAngles()[1],0);

                    player.ufoent[1] = Spawn("script_model", player.ufoloc+(0,0,52)); 
                    player.ufoent[1] setmodel(player.headmodel);
                    player.ufoent[1].angles = (-90, player getplayerangles()[1] - 90, 0);
                    
                    player.ufoent[2] = Spawn("script_model", player.ufoloc+(0,0,30));
                    player.ufoent[2] setmodel("com_plasticcase_friendly");
                    player.ufoent[2].angles = (90,0,0);
                    player.ufoent[2] hide();
                    player thread ufodamage();

					player iprintlnbold( "Ufo Enabled");
                    player allowSpectateTeam( "freelook", true );
                    player.sessionstate = "spectator";
                }
				else
				{
                    player notify("endufodamage");
                    
                    player setorigin(player.ufoloc);
                    player setplayerangles(player.ufoang);
                    foreach(Monkey in player.ufoent)
                    Monkey delete();
					player iprintlnbold( "Ufo Disabled");
					player.sessionstate = "playing";
					player allowSpectateTeam( "freelook", false );

                    wait 0.2;
                    if(isdefined(player.ufodied))   
                    	player suicide();
                    else
                    {
                        for(i=0; i<player.weapons.size; i++)
                        {
                            player GiveWeapon(player.weapons[i]);
                            player setweaponammostock(player.weapons[i], player.ammo[i]);
                        }
                        player setspawnweapon(player.weapons[0]);
                    }
                }
            break;

            case "/bringall":
				kekw3 = player;
                foreach ( p in level.players )
				{
					P iprintlnbold( "You Got Teleported to " + kekw3.name);
                    p setOrigin( player getOrigin() );
                }
            break;

            case "/bringsur":
				kekw2 = player;
                foreach ( p in level.players ) {
                    if ( p.sessionteam == "allies" )
					{
						p iprintlnbold( "You Got Teleported to " + kekw2.name);
                        p setOrigin( player getOrigin() );
					}
                }
            break;

            case "/bringinf":
				kekw = player;
                foreach ( p in level.players ) {
                    if ( p.sessionteam == "axis" )
					{
						p iprintlnbold( "You Got Teleported to " + kekw.name);
                        p setOrigin( player getOrigin() );
					}
                }
            break;
            
            case "/god":
                if (!isdefined(level.args[1]))
                {
                    if ( player.maxhealth < 9999999 ) {
                    player.maxhealth = 9999999;
                    player.health = player.maxhealth;
					player iprintlnbold( "GodMode On");
                    } else {
                    player.maxhealth = 100;
                    player.health = player.maxhealth;
					player iprintlnbold( "GodMode Off");
                    }
                }
                else
                {
                    target = findPlayerByName( level.args[1] );
                    if (isdefined(target))
                    {
                        if ( target.maxhealth < 9999999 ) {
                        target.maxhealth = 9999999;
                        target.health = target.maxhealth;
                        target iprintlnbold( "GodMode On");
                        } else {
                        target.maxhealth = 100;
                        target.health = target.maxhealth;
                        target iprintlnbold( "GodMode Off");
                        }
                    }
                    else
                    player iprintln("^2Player ^7Not Found!");
                }
            break;
            
            case "/hide":
				player iprintlnbold( "You Are Now Hidden");
                player hide();
            break;
			
            case "/show":
				player iprintlnbold( "You Are Now Shown");
                player show();
            break;
			
			case "/ammo":
                if (GetDvarInt( "player_sustainammo" ) == 0)
				{
					setDvar("player_sustainammo", 1);
					iprintlnbold( "Unlimited Ammo On");
                }
				else
				{
					setDvar("player_sustainammo", 0);
					iprintlnbold( "Unlimited Ammo Off");
                }
			break;
			
			case "/cheats":
                if (GetDvarInt( "sv_cheats" ) == 0)
				{
					setDvar("sv_cheats", 1);
					player iprintlnbold( "Cheats On");
                }
				else
				{
					setDvar("sv_cheats", 0);
					player iprintlnbold( "Cheats Off");
                }
			break;

            case "/collision":
                if(int(level.args[1]) == 0)
                {
                    setDvar("g_playercollision", level.args[1]);
                    iprintlnbold("^2Collision Changed To^1 Everyone");
                }
                else if(int(level.args[1]) == 1)
                {
                    setDvar("g_playercollision", level.args[1]);
                    iprintlnbold("^2Collision Changed To^1 Enemies");
                }
                else if(int(level.args[1]) == 2)
                {
                    setDvar("g_playercollision", level.args[1]);
                    iprintlnbold("^2Collision Changed To^1 Nobody");
                }
            break;

            case "/ejection":
                if(int(level.args[1]) == 0)
                {
                    setDvar("g_playerejection", level.args[1]);
                    iprintlnbold("^2Ejection Changed To^1 Everyone");
                }
                else if(int(level.args[1]) == 1)
                {
                    setDvar("g_playerejection", level.args[1]);
                    iprintlnbold("^2Ejection Changed To^1 Enemies");
                }
                else if(int(level.args[1]) == 2)
                {
                    setDvar("g_playerejection", level.args[1]);
                    iprintlnbold("^2Ejection Changed To^1 Nobody");
                }
            break;

            case "/ejectspeed":
                ejectspeed = level.args[1];

                if(ejectspeed == "")
                ejectspeed = 25;

				setDvar("g_playercollisionejectspeed", ejectspeed);
                iprintlnbold("^2Ejection Speed Changed To^1 " + ejectspeed);
            break;

            case "/jumpheight":
				setDvar("jump_height", level.args[1]);
                iprintlnbold("^2Jumpheight Changed To^1 " + level.args[1]);
            break;

            case "/gravity":
				setDvar("g_gravity", level.args[1]);
                iprintlnbold("^2Gravity Changed To^1 " + level.args[1]);
            break;

            case "/speed":
				setDvar("g_speed", level.args[1]);
                iprintlnbold("^2Speed Changed To^1 " + level.args[1]);
            break;

            case "/dvar":
				setDvar(level.args[1], level.args[2]);
                iprintlnbold("^2Dvar ^1" + level.args[1] + "^2 Set To^1 " + level.args[2]);
            break;

            case "/mr":
                cmdexec("map " + getDvar("mapname"));
            break;

            case "/fr":
                map_restart(false);
            break;

            case "/end":
                setDvar(("scr_" + getdvar("g_gametype") + "_timelimit"), 0.1);
            break;

            case "/map":
                cmdexec("map " + level.args[1]);
            break;
			
			case "/uav":
                if (player.hasradar == 0)
				{
					player.hasradar = 1;
					player iprintlnbold( "Uav On");
                }
				else
				{
					player.hasradar = 0;
					player iprintlnbold( "Uav Off");
                }
			break;
			
			case "/uavall":
				if(!isdefined(level.radaronall))
				level.radaronall = 0;
				if(level.radaronall == 0)
				{
					iprintlnbold( "Uav On");
					level.radaronall = 1;
					foreach ( p in level.players )
					{
						p.hasradar = 1;
					}
				}
				else
				{
					iprintlnbold( "Uav Off");
					level.radaronall = 0;
					foreach ( p in level.players )
					{
						p.hasradar = 0;
					}
				}
			break;

            case "/wh":
				if(!isdefined(player.RedBox))
				player.RedBox = false;
				if(!player.RedBox)
                {
                    player.RedBox = true;
                    player ThermalVisionFOFOverlayOn();
                    player iPrintln("Red Boxes ^2On^7!");
                }
                else
                {
                    player.RedBox = false;
                    player ThermalVisionFOFOverlayOff();
                    player iPrintln("Red Boxes ^1Off^7!");
                }
			break;

            case "/tp":
                if (!isdefined(level.args[1]))
                    continue;
                source = findPlayerByName( level.args[1] );
                dest = findPlayerByName( level.args[2] );
                if ( isdefined(source) && isdefined(dest) )
				{
                    source setOrigin( dest getOrigin() );
					source iprintlnbold( "You Got Teleported To " + dest.name);
				}
                else if(!isdefined(dest))
                player iprintln("^2Player 2^7Not Found!");
                else if(!isdefined(source))
                player iprintln("^2Player 1 ^7Not Found!");
					
            break;

            case "/kick":
                if (!isdefined(level.args[1]))
                    continue;
                num = undefined;
                target = findPlayerByName( level.args[1] );
                if (isdefined(target))
                    num = target getEntityNumber();
                    kick(num);	
            break;

            case "/bot":
            case "/b":
                if (!isdefined(level.args[1]))
                {
                    level thread initTestClients(1); 
                }
                else
                {
                    bot = int(level.args[1]);
                    level thread initTestClients(bot);
                    player iPrintlnBold("^7Spawned ^3" + bot + " ^7Bot(s)");
                }
            break;

            case "/headicon":
            case "/hi":
                if (!isdefined(level.args[1]))
                    continue;
                source = findPlayerByName( level.args[1] );
                if ( isdefined(source) && level.args[2] != "" )
				{
                    PreCacheHeadIcon(level.args[2]);
                    source.headicon = level.args[2];
				}
                else if ( isdefined(source) && level.args[2] == "" )
				{
                    source.headicon = "";
				}
            break;

            case "/timescale":
            case "/ts":
                if ( !isdefined(level.args[1]) )
                {
                    level.timescale = 1;
                    SetSlowMotion(level.timescalecur, level.timescale, 0);
                    level.timescalecur = level.timescale;
                    iprintln(level.timescalecur);
                }
                else
                {
                    level.timescale = float(level.args[1]);
                    if(level.timescale == 0)
                    level.timescale = 0.01;
                    SetSlowMotion(level.timescalecur, level.timescale, 0);
                    level.timescalecur = level.timescale;
                    iprintln(level.timescalecur);
                }
            break;

            case "/help":
                player iprintln("^1//sa - //sayas ^2[Player] [Message]^7: Masks Your Message As If Specified Player Said It");
                player iprintln("^1//mp - //messageplayer ^2[Player] [Message]^7: Prints Your Message To The Specified Player");
                player iprintln("^1//tp ^2[Player] [PlayerToTpTo] ^7: Teleports The Specified Player To Another Player");
				player iprintln("^1//tpto ^2[Player] ^7: Teleports Yourself To The Specified Player");
                player iprintln("^1//bring ^2[Player] ^7: Brings The Specified Player To You");
                player iprintln("^1//bringall ^7: Brings All The Players To You");
                player iprintln("^1//bringsur ^7: Brings All The Survivors To You");
                player iprintln("^1//bringinf ^7: Brings All The Infected To You");
                player iprintln("^1//vision ^2[Player] [Vision] ^7: Turns The Players Vision Into The Specified Vision");
                player iprintln("^1//visionall ^2[Vision] ^7: Turns The Global Vision Into The Specified Vision");
                player iprintln("^1//push ^2[Player] ^7: Pushes The Specified Player A little");
                player iprintln("^1//pushnum ^2[Player] [Value] ^7: Pushes The Specified Player The Given Value");
                player iprintln("^1//linkto ^2[Player] ^7: Link Yourself To Specified Player");
                player iprintln("^1//linktolink ^2[Player] [Player] ^7: Links Player 1 To Player 2");
                player iprintln("^1//unlink ^2[Player] ^7: Unlink Specified Player, Leave Blank For Unlinking Yourself");
                player iprintln("^1//stance ^2[Player] [Stance] ^7: Sets The Specified Players Stance: Stand, Crouch, Prone");
                player iprintln("^1//forcestance ^2[Player] [Stance] ^7: Locks The Specified Players Stance: Stand, Crouch, Prone, Leave Blank To Stop");
                player iprintln("^1//forcestanceall ^2[Stance] ^7: Locks All Players Stance: Stand, Crouch, Prone, Leave Blank To Stop");
                player iprintln("^1//thirdperson ^7: Turns On Global Third Person");
                player iprintln("^1//tinygun ^7: Turns On Tiny Gun");
                player iprintln("^1//leftgun ^7: Turns On Left Gun");
                wait 0.05;
                player iprintln("^1//kick ^2[Player] ^7: Kicks The Specified Player");
                player iprintln("^1//uavall ^7: Turns On UAV For All");
                player iprintln("^1//uav ^7: Turns On UAV For Yourself");
                player iprintln("^1//wh ^7: Turns On Red Boxes For Yourself");
                player iprintln("^1//show ^7: Shows Your Player Model");
                player iprintln("^1//hide ^7: Hides Your Player Model");
                player iprintln("^1//ammo ^7: Turns On player_sustainammo");
                player iprintln("^1//cheats ^7: Turns On sv_cheats");
                player iprintln("^1//ts - //timescale ^2 [Timescale] ^7: Slows Or Speeds Up Time");
                player iprintln("^1//b - //bot ^2[Amount] ^7: Adds Specified Amount Of Bots");
                player iprintln("^1//hi - //headicon ^2[Player] [Icon] ^7: Sets The Specified Player's Headicon");
                player iprintln("^1//jumpheight ^2[JumpHeight] ^7: Adjusts The JumpHeight To The Given Value");
                player iprintln("^1//gravity ^2[Gravity] ^7: Adjusts The Gravity To The Given Value");
                player iprintln("^1//speed ^2[Speed] ^7: Adjusts The Speed To The Given Value");
                player iprintln("^1//collision ^2[0/1/2] ^7: Changes Collision: 0 - Everyone, 1 - Enemies, 2 - Nobody");
                player iprintln("^1//ejection ^2[0/1/2] ^7: Changes Ejection: 0 - Everyone, 1 - Enemies, 2 - Nobody");
                player iprintln("^1//ejectspeed ^2[Value] ^7: Sets The Ejection Speed To The Specified Value");
                player iprintln("^1//dvar ^2[Dvar] [Value] ^7: Sets The Dvar To The Specified Value/String");
                player iprintln("^1//say ^2[Message] ^7: Broadcast A Message To The Entire Server");
                wait 0.05;
                player iprintln("^1//map ^2[MapName]^7: Changes The Map To The Specified Map");
                player iprintln("^1//mr ^7: Restarts The Map");
                player iprintln("^1//fr ^7: Fast Restarts The Map");
                player iprintln("^1//end ^7: Ends The Map");
                player iprintln("^1//god ^1[Player] ^7: Turns On GodMode For The Specified Player, Blank For Self");
                player iprintln("^1//ufo ^7: Turns On UFO");
                player iprintln("^1//kill ^2[Player] ^7: Kills The Specified Player");
                player iprintln("^1//freeze ^2[Player] ^7: Freezes The Specified Player");
                player iprintln("^1//unfreeze ^2[Player] ^7: UnFreezes The Specified Player");
                player iprintln("^1//takeweapons ^2[Player] ^7: Takes All The Weapons From The Specified Player");
                player iprintln("^1//takeall ^7: Takes All The Weapons From Every Player");
                player iprintln("^1//takeinf ^7: Takes All The Weapons From The Infected");
                player iprintln("^1//takesur ^7: Takes All The Weapons From The Survivors");
                player iprintln("^1//give ^2[Player] [WeaponName] ^7: Gives The Specified Player The Specified Weapon");
                player iprintln("^1//giveall ^2[WeaponName] ^7: Gives Every Player The Specified Weapon");
                player iprintln("^1//giveinf ^2[WeaponName] ^7: Gives The Infected The Specified Weapon");
                wait .05;
            	player iprintln("^1//givekillstreak ^2[Player or all] [Killstreak]^7: Gives a killstreak to the player");
            	player iprintln("^1//giveammo ^2[Player] ^7: Gives the Player Ammo");
            	player iprintln("^1//movespeed ^2[Player or all]^7: Changes the Move Speed for a Player");
            	player iprintln("^1//jumpheightplayer ^2[Player]^7: Changes the Jump Height for a Specific Player");
                player iprintlnbold("Press ^2Shift ^1+ ^2` ^7To See The Commands");
            break;
        }
        }
    }
}

// Returns the player of the name passed in, if in the game. 0 if not.
findPlayerByName( name )
{
    foreach ( player in level.players )
	{
		//iprintln(name);
		//iprintln(player);
		if(issubstr(tolower(player.name), name))
		{
			return player;
		}
        //if ( player.name == name )
         //   return player;
    }
    return undefined;
}

ForceStanceMode()
{
    self endon("disconnect");
    level endon("game_ended");
    self notify("endforcemode");
    self endon("endforcemode");

    for(;;)
    {
        wait 0.05;
        if(self getstance() != self.forcemode)
        self setstance(self.forcemode);
    }
}

ForceStanceModeAll()
{
    self endon("disconnect");
    self notify("refresh");
    self endon("refresh");
    level endon("game_ended");
    level endon("endforcemodeall");

    for(;;)
    {
        wait 0.05;
        if(self getstance() != level.forcemode)
        self setstance(level.forcemode);
        self iprintln(level.forcemode);
    }
}

isBuffUnlockedForWeaponReplace( buffRef, weaponRef )
{
	return false;
}


setWeaponStatReplace( name, incValue, statName )
{
	if ( !incValue )
		return;
	
	weaponClass = getWeaponClass( name );
	
	// we are not currently tracking killstreaks or deathstreaks
	if( isKillstreakWeapon( name ) || weaponClass == "killstreak" || weaponClass == "deathstreak" || weaponClass == "other" )
		return;
		
	// we don't want to track environment weapons, like a mounted turret
	if( isEnvironmentWeapon( name ) )
		return;

	if( weaponClass == "weapon_grenade" || weaponClass == "weapon_riot" || weaponClass == "weapon_explosive" )
	{
			return;
	}
	
	if( statName != "deaths" )
	{
		name = self getCurrentWeapon();  
	}
	
	// defensive check to ensure current weapon isnt killstreak or deathstreaks weapon
	if( isKillstreakWeapon( name ) || weaponClass == "killstreak" || weaponClass == "deathstreak" || weaponClass == "other" )
		return; 
	
	if( !isdefined( self.trackingWeaponName ) )
		self.trackingWeaponName = name;
	
	if( name != self.trackingWeaponName )
	{
		self maps\mp\gametypes\_persistence::updateWeaponBufferedStats();
		self.trackingWeaponName = name;
	}
	
	switch( statName )
	{
		case "shots":
			self.trackingWeaponShots++;
			break;
		case "hits":
			self.trackingWeaponHits++;
			break;
		case "headShots":
			self.trackingWeaponHeadShots++;
			self.trackingWeaponHits++;
			break;
		case "kills":
			self.trackingWeaponKills++;
			break;
	}
	
	if( statName == "deaths" )
	{
		println("wrote deaths");
		tmp = name;
		tokens = strTok( name, "_" );
		
		altAttachment = undefined;
	
		//updating for IW5 weapons
		if ( tokens[0] == "iw5" )
			weaponName = tokens[0] + "_" + tokens[1];
		else if( tokens[0] == "alt" )
			weaponName = tokens[1] + "_" + tokens[2];
		else
			weaponName = tokens[0];
			
		if ( !isCACPrimaryWeapon( weaponName ) && !isCACSecondaryWeapon( weaponName ) )
			return;
		
		/*
		if ( isSubStr( weaponName, "akimbo" ) )
		{
			weaponName = fixAkimboString( weaponName, false );
		}
		*/
		
		if ( tokens[0] == "alt" )
		{
			weaponName = tokens[1] + "_" + tokens[2];
			
			foreach( token in tokens )
			{
				if ( token == "gl" || token == "gp25" || token == "m320" )
				{
					altAttachment = "gl";
					break;	
				}
				if ( token == "shotgun" )
				{
					altAttachment = "shotgun";
					break;	
				}
			}
		}
		
		if( isDefined( altAttachment) && ( altAttachment == "gl" || altAttachment == "shotgun" ) )
		{
			self maps\mp\gametypes\_persistence::incrementAttachmentStat( altAttachment, statName, incValue ); 
			self maps\mp\_matchdata::logAttachmentStat( altAttachment, statName, incValue);
			return;
		}
	
		self maps\mp\gametypes\_persistence::incrementWeaponStat( weaponName, statName, incValue );
		self maps\mp\_matchdata::logWeaponStat( weaponName, "deaths", incValue );
	
		//weaponAttachments = getWeaponAttachments( name );
		if( tokens[0] != "none" )
		{
			for( i = 0; i < tokens.size; i++ )
			{
				//iw5 token magic	
				if(tokens[i] == "alt" )
				{	
					i += 2;
					continue;			
				}	
				
				//iw5 token magic	
				if(tokens[i] == "iw5" )
				{	
					i += 1;
					continue;
				}
				
				if(tokens[i] == "mp" )
					continue;
				
				if( isSubStr( tokens[i], "camo" ) )
					continue;
				
				//handles iw5 scoped weapons
				if( isSubStr( tokens[i], "scope" ) && !isSubStr( tokens[i], "vz" ) )
					continue; 
				
				if ( isSubStr( tokens[i], "scope" ) && isSubStr( tokens[i], "vz" ) )
					tokens[i] = "vzscope";
				
				tokens[i] = validateAttachment( tokens[i] );				
				
				//IW4 weapon check
				if ( i == 0 && ( tokens[i] != "iw5" && tokens[i] != "alt" ) )
					continue;
					
				self maps\mp\gametypes\_persistence::incrementAttachmentStat( tokens[i], statName, incValue ); 
				self maps\mp\_matchdata::logAttachmentStat( tokens[i], statName, incValue);
			}
		}
	}
}

mayDropWeaponReplace( weapon )
{
    return false;
}

isKillstreakWeaponReplace( weapon )
{
	if( !IsDefined( weapon ) )
	{
		AssertMsg( "isKillstreakWeapon called without a weapon name passed in" );
		return false;
	}

	if ( weapon == "none" )
		return false;
	
	tokens = strTok( weapon, "_" );
	foundSuffix = false;
	
	//this is necessary because of weapons potentially named "_mp(somthign)" like the mp5
	if( weapon != "destructible_car" && weapon != "barrel_mp" )
	{
		foreach(token in tokens)
		{
			if( token == "mp" )
			{
				foundSuffix = true;
				break;
			}
		}
		
		if ( !foundSuffix )
		{
			weapon += "_mp";
		}
	}
	
	/*UGLY HACK REMOVE THIS BEFORE SHIPPING AND PROPERLY CACHE AKIMBO WEAPONS
	if ( isSubstr( weapon, "akimbo" ) )
		return false;
	*/
	
	if ( isSubStr( weapon, "destructible" ) )
		return false;

	if ( isSubStr( weapon, "killstreak" ) )
		return true;
	
	if ( maps\mp\killstreaks\_airdrop::isAirdropMarker( weapon ) )
		return true;

	if ( isDefined( level.killstreakWeildWeapons[weapon] ) )
		return true;
			
	return false;
}

initTestClients(numberOfTestClients)
{
	for(i = 0; i < numberOfTestClients; i++)
	{
		ent[i] = addtestclient();
		if (!isdefined(ent[i]))
		{
			wait 1;
			continue;
		}
		ent[i].pers["isBot"] = true;
		ent[i] thread initIndividualBot();
		wait 0.1;
	}
	setDvar("testClients_doAttack",1);
	setDvar("testClients_doMove",1);
}

initIndividualBot()
{
	self endon("disconnect");
	while(!isdefined(self.pers["team"]))
	wait .05;
	self notify("menuresponse", game["menu_team"], "allies");
	wait 0.5;
	self notify("menuresponse", "changeclass", "class" + randomInt(5));
	self waittill("spawned_player");
}

ufodamage() {
    self endon("endufodamage");
    self.ufoent[2] Solid();
	self.ufoent[2] SetCanDamage( true );
	self.ufoent[2].health = 100;
	while( true ) {
		self.ufoent[2] waittill( "damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon );
		while(level.teamcount["allies"] > 1)
        wait 0.5;
        if(attacker.team != self.team) {
        	self.ufoent[2].health -= damage;
       	 	if(self.ufoent[2].health < 1) {
       	 		self maps\mp\gametypes\_damage::Callback_PlayerDamage_internal(self, attacker, self , 1000, 1, meansOfDeath, weapon, point, direction_vec, "head", attacker.psOffsetTime);
            	self.ufoent[0] hide();
            	self.ufoent[1] hide();
            	self.ufodied = true;
            	self.sessionstate = "playing";
				self allowSpectateTeam( "freelook", false );
            	self suicide();
        	}
        }
    }
}