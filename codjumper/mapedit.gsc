#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
	/*
	This is just your average mapedit script with some added functionality, see the functions all the way at the bottom of the list
	it allows for some new things like a secret trigger that once touched allows more of a edit to spawn in, for example of someone on inf
	makes a hard spot u can add more edit to make other ways to get up for infected. stuff like that, also has jumppads included and some more things	
	theres a explanation for secret stuff in the bootleg mapedit
	*/


	level.doCustomMap = 0;
	level.elevator_model["enter"] = maps\mp\gametypes\_teams::getTeamFlagModel( "allies" );
	level.elevator_model["exit"] = maps\mp\gametypes\_teams::getTeamFlagModel( "axis" );
	level.waittime = 0;
	level.flag_ref = 0;
	
	precacheModel( level.elevator_model["enter"] );
	precacheModel( level.elevator_model["exit"] );

	level thread onPlayerConnect();

	if(getDvar("mapname") == "mp_bootleg"){ /** Bootleg **/
		level thread Bootleg();		
	}
	else if(getDvar("mapname") == "mp_seatown"){ /** Seatown **/
		level thread Seatown();		
	}
	else if(getDvar("mapname") == "mp_aground_ss"){ /** Aground **/
		level thread Aground();		
    }
	else if(getDvar("mapname") == "mp_lambeth"){ /** Fallen **/
		level thread Fallen();		
	}
	else if(getDvar("mapname") == "mp_radar"){ /** Outpost **/
		level thread Outpost();		
	}
	else if(getDvar("mapname") == "mp_paris"){ /** Resistance **/
		level thread Resistance();		
	}
	else if(getDvar("mapname") == "mp_hardhat"){ /** Hardhat **/
		level thread Hardhat(randomint(6));		
	}
	else if(getDvar("mapname") == "mp_alpha"){ /** Lockdown **/
		level thread Lockdown();		
	}
	else if(getDvar("mapname") == "mp_bravo"){ /** Mission **/
		level thread Mission();		
	}
	else if(getDvar("mapname") == "mp_dome"){ /** Dome **/
		level thread Dome();		
	}
	else if(getDvar("mapname") == "mp_plaza2"){ /** Arkaden **/
		level thread Arkaden(randomint(6));		
	}
	else if(getDvar("mapname") == "mp_underground"){ /** Underground **/
		level thread Underground(randomint(6));		
	}
	else if(getDvar("mapname") == "mp_terminal_cls"){ /** Terminal **/
		level thread Terminal();		
	}
	else if(getDvar("mapname") == "mp_mogadishu"){ /** Bakaara **/
		level thread Bakaara();		
	}
	else if(getDvar("mapname") == "mp_carbon"){ /** Carbon **/
		level thread Carbon();		
	}
	else if(getDvar("mapname") == "mp_interchange"){ /** Interchange **/
		level thread Interchange();		
	}
	else if(getDvar("mapname") == "mp_village"){ /** Village **/
		level thread Village();		
	}
	else if(getDvar("mapname") == "mp_rust"){ /** Rust **/
		level thread Rust();	
	}
	else if(getDvar("mapname") == "mp_exchange"){ /** Downturn **/
		level thread Downturn();		
	}
	else if(getDvar("mapname") == "mp_courtyard_ss"){ /** Erosion **/
		level thread Erosion();		
	}
	else if(getDvar("mapname") == "mp_highrise"){ /** Highrise **/
		level thread Highrise();		
	}
	else if(getDvar("mapname") == "mp_nuked"){ /** Nuketown **/
		level thread Nuketown();		
	}
	else if(getDvar("mapname") == "mp_nightshift"){ /** Skidrow **/
		level thread Skidrow();		
	}
	else if(getDvar("mapname") == "mp_favela"){ /** Favela **/
		level thread Favela();		
	}
	else if(getDvar("mapname") == "mp_quarry"){ /** Quarry **/
		level thread Quarry();		
	}
}

onPlayerConnect() 
{
    for(;;) 
	{
        level waittill("connected", player);

        player thread onPlayerSpawned();

		player thread setVision();
    }
}

onPlayerSpawned() 
{
    self endon("disconnect");
    for(;;) {
        self waittill("spawned_player");
		
		self FreezeControls(false);
    }
}

setVision() 
{
	self waittill("spawned_player");
	self VisionSetNakedForPlayer( getdvar("mapname"), 0 );
}

///////////////////////////////////////////////////////////////////////// Mapedits //////////////////////////////////////////////////////

Bootleg()
{
	CreateBlocks((50, 0, 0), (0, 0, 0));
	level thread SecretZone((0,0,0), 100); // this is the secret area fly to 0 0 0 in the map
	level waittill("spawnsecret"); // and anything after will spawn 

	i=0;   CreateBlocks((80+i, 0, 0), (0, 0, 0));i+=30;
	wait 1;CreateBlocks((80+i, 0, 0), (0, 0, 0));i+=30;
	wait 1;CreateBlocks((80+i, 0, 0), (0, 0, 0));i+=30;
	wait 1;CreateBlocks((80+i, 0, 0), (0, 0, 0));i+=30;
	wait 1;CreateBlocks((80+i, 0, 0), (0, 0, 0));i+=30;
	wait 1;CreateBlocks((80+i, 0, 0), (0, 0, 0));i+=30;
	wait 1;CreateBlocks((80+i, 0, 0), (0, 0, 0));i+=30;
	wait 1;CreateBlocks((80+i, 0, 0), (0, 0, 0));i+=30;
	wait 1;CreateBlocks((80+i, 0, 0), (0, 0, 0));i+=30;
	wait 1;CreateBlocks((80+i, 0, 0), (0, 0, 0));i+=30;
	wait 1;CreateBlocks((80+i, 0, 0), (0, 0, 0));i+=30;
}

Seatown()
{
	Createmodel("chicken_black_white", (-1140, 1430, 300), (0,45,0));
	CreateBlocks((703, 216, 403), (0, 0, 0));
	CreateBlocks((906, 642, 368), (0, 90, 0));
	CreateBlocks((817, 1166, 170), (0, 0, 61));
}
		
Aground()
{
	CreateBlocks((360, -110, -10), (0, 0, 0));
    CreateBlocks((410, -110, -20), (0, 0, 0));

    CreateBlocks((460, -110, -30), (0, 0, 0));
    CreateBlocks((460, -80, -30), (0, 0, 0));
    CreateBlocks((460, -50, -30), (0, 0, 0));
    CreateBlocks((460, -20, -30), (0, 0, 0));

    CreateBlocks((510, -110, -30), (0, 0, 0));
    CreateBlocks((510, -80, -30), (0, 0, 0));
    CreateBlocks((510, -50, -30), (0, 0, 0));
    CreateBlocks((510, -20, -30), (0, 0, 0));
}
		
Resistance()
{
	CreateBlocks((120, -105, 50), (0, 90, 270));
	CreateBlocks((110, -105, 35), (0, 90, 295));
	CreateBlocks((-586, -245, 446), (0, 0, 0));
	CreateBlocks((-184, -285, 665), (0, 0, 0));

	CreateBlocks((1100, 1668, 130), (0, 0, 0));
}
		
Dome()
{
	CreateWalls((1215, 2282, -260),(1227, 2408, -150));

	CreateWalls((1167, 1620, -260),(1178, 1748, -150));

	CreateWalls((-534, 1610, -280),(-553, 1750, -150));

	CreateBlocks((4, 271, -160), (0, 26, 0));
	CreateBlocks((751, -58, -372), (0, 46, 49));

	CreateBlocks((-200, 657, -296), (0, 86, 0));
 	CreateBlocks((116, 498, -352), (0, 116, 302));
}
		
Mission()
{	
	CreateBlocks((-1900, 1010, 1480), (0, -90, 0));
    CreateBlocks((-1900, 1010, 1520), (0, -90, 0));

    CreateBlocks((-1710, 1140, 1490), (90, 90, 0));

    CreateBlocks((-705, 488, 1595), (90, 90, 0));
}
		
Lockdown()
{
	CreateBlocks((-1320, 1450, 230), (0, 0, 0));
	CreateBlocks((-1375, 1450, 230), (0, 0, 0));
	CreateBlocks((-1430, 1450, 230), (0, 0, 0));
	CreateBlocks((-1485, 1450, 230), (0, 0, 0));
}
		
Outpost()
{

}
		
Hardhat(input)
{	
	if(input == 0 || input == 2 || input == 4)
	{
		CreateWalls((2110, 1500, 380), (2110, 1500.1, 900));	
		CreateWalls((2110, 2415, 380), (2110, 2415.1, 900));	
		CreateWalls((2110, 3170, 380), (2110, 3170.1, 900));	

		CreateWalls((1990, 3550, 540), (1780, 3550, 540.1));
		CreateWalls((1990, 3550, 600), (1780, 3550, 600.1));
		CreateWalls((1990, 3550, 660), (1780, 3550, 660.1));

		CreateWalls((1630, 4075, 380), (1310, 4075, 380.1));	
		CreateWalls((1630, 4075, 440), (1310, 4075, 440.1));
		CreateWalls((1630, 4075, 500), (1000, 4075, 500.1));
		CreateWalls((1630, 4075, 560), (1000, 4075, 560.1));	

		CreateWalls((2055, 2340, 820), (2055, 1555, 820.1));
		CreateBlocks((-765, 2936, 220),(0, 150, 0));
		CreateGrids((1725.0, 2720.0, 631.0),(1925.0, 2720.0, 631.0),(35, 127, 0));
		CreateGrids((1470.0, 2980.0, 480.0),(1625.0, 2880.0, 480.0),(35, 127, 0));
		CreateElevator((-80.0, 1200.0, 375.68), (-1880.0, 1845.0, 225.68),(0, 35, 0),true);
		CreateElevator((1200.0, -1690.0, 280.68), (-1900.0, 3950.0, 32.68),(0, -20, 0),true);
		CreateElevator((1220.0, 1510.0, 345.68), (1220.0, 1400.0, 325.68),(0, 0, 0));
	}
	else if(input == 1 || input == 3 || input == 5)
	{
		CreateWalls((-710, 760, 920), (-930, 760, 920.1));
			
		CreateWalls((-930, 1515, 900), (-930, 1680, 900.1));

		CreateWalls((-380, 1721, 660), (-1030, 1721, 660.1));
		CreateWalls((-2030, 1720, 720), (-380, 1720, 720.1));
		CreateWalls((-2030, 1720, 780), (-380, 1720, 780.1));
		CreateWalls((-2030, 1720, 840), (-380, 1720, 840.1));
		CreateWalls((-1800, 1719, 900), (-950, 1719, 900.1));

		CreateWalls((-2030, 1415, 660), (-1545, 1415, 660.1));
		CreateWalls((-2030, 1415, 720), (-1545, 1415, 720.1));
		CreateWalls((-2030, 1415, 780), (-1545, 1415, 780.1));
		CreateWalls((-2030, 1415, 840), (-1545, 1415, 840.1));

		CreateWalls((-1505, 405, 540), (-1190, 405, 540.1));
		CreateWalls((-1505, 405, 600), (-1190, 405, 600.1));
		CreateWalls((-1505, 405, 660), (-1190, 405, 660.1));
		CreateWalls((-1505, 405, 720), (-1190, 405, 720.1));
		CreateWalls((-1505, 405, 780), (-1190, 405, 780.1));
		CreateWalls((-1505, 406, 840), (-1190, 406, 840.1));

		CreateWalls((-1545, 730, 540), (-1545, 440, 540.1));
		CreateWalls((-1545, 990, 600), (-1545, 440, 600.1));
		CreateWalls((-1545, 1415, 660), (-1545, 440, 660.1));
		CreateWalls((-1545, 1415, 720), (-1545, 440, 720.1));
		CreateWalls((-1545, 1415, 780), (-1545, 440, 780.1));
		CreateWalls((-1545, 1415, 840), (-1545, 440, 840.1));
		CreateWalls((-1544, 1415, 900), (-1544, 1000, 900.1));

		CreateWalls((-2040, 1700, 720), (-2040, 1440, 720.1));
		CreateWalls((-2040, 1700, 780), (-2040, 1440, 780.1));
		CreateWalls((-2040, 1700, 840), (-2040, 1440, 840.1));

		CreateWalls((-365, 1680, 840), (-365, 1350, 840.1));
		CreateWalls((-365, 1680, 780), (-365, 1350, 780.1));
		CreateWalls((-365, 1680, 720), (-365, 1350, 720.1));
		CreateWalls((-365, 1680, 660), (-365, 1350, 660.1));

		CreateWalls((-700, 1475, 900), (-930, 1475, 900.1));
		CreateWalls((-695, 1520, 900), (-695, 1580, 900.1));

		CreateBlocks((-935, 1447, 510),(0, 90, 0));
		CreateBlocks((-935-1, 1447, 510-15),(0, 90, 0));
		CreateBlocks((-935-2, 1447, 510-30),(0, 90, 0));
		CreateBlocks((-935-3, 1447, 510-45),(0, 90, 0));
		CreateBlocks((-935-4, 1447, 510-60),(0, 90, 0));
		CreateBlocks((-935-5, 1447, 510-75),(0, 90, 0));
		CreateBlocks((-935-6, 1447, 510-90),(0, 90, 0));
		CreateBlocks((-935-7, 1447, 510-105),(0, 90, 0));
		CreateBlocks((-935-8, 1447, 510-120),(0, 90, 0));
		CreateBlocks((-935-9, 1447, 510-135),(0, 90, 0));

		CreateBlocks((-1160, 740, 525),(0, 90, 0));
		CreateBlocks((-1160+1, 740, 525-15),(0, 90, 0));
		CreateBlocks((-1160+2, 740, 525-30),(0, 90, 0));
		CreateBlocks((-1160+3, 740, 525-45),(0, 90, 0));
		CreateBlocks((-1160+4, 740, 525-60),(0, 90, 0));
		CreateBlocks((-1160+5, 740, 525-75),(0, 90, 0));
		CreateBlocks((-1160+6, 740, 525-90),(0, 90, 0));
		CreateBlocks((-1160+7, 740, 525-105),(0, 90, 0));
		CreateBlocks((-1160+8, 740, 525-120),(0, 90, 0));
		CreateBlocks((-1160+9, 740, 525-135),(0, 90, 0));
		CreateBlocks((-1160+10, 740, 525-150),(0, 90, 0));
		CreateBlocks((-1160+11, 740, 525-165),(0, 90, 0));
		CreateBlocks((-1160+12, 740, 525-180),(0, 90, 0));
		CreateBlocks((-1160+13, 740, 525-195),(0, 90, 0));
		CreateBlocks((-1160+14, 740, 525-210),(0, 90, 0));
		CreateBlocks((-1160+15, 740, 525-225),(0, 90, 0));

		CreateBlocks((-560, 1310, 466),(0, 90, 0));
		CreateBlocks((-560+1, 1310, 466-15),(0, 90, 0));
		CreateBlocks((-560+2, 1310, 466-30),(0, 90, 0));
		CreateBlocks((-560+3, 1310, 466-45),(0, 90, 0));
		CreateBlocks((-560+4, 1310, 466-60),(0, 90, 0));
		CreateBlocks((-560+5, 1310, 466-75),(0, 90, 0));
		CreateBlocks((-560+6, 1310, 466-90),(0, 90, 0));

		CreateElevator((1200.0, -1680.0, 280),(-1925.0, 1560.0, 594),(0, 0, 0),true);

		CreateElevator((-420, 1180, 377), (810, 410, 578),(0, 0, 0));

		CreateBlocks((740, 636, 720),(0, 0, 0));
		CreateBlocks((910, 890, 290),(-75, 90, 0));
		CreateBlocks((940, 890, 290),(-75, 90, 0));
	}
}
		
Underground(input) // random map edit every load
{
	CreateBlocks((-1121, 2714, -232), (0, 90, 72));
 	CreateBlocks((178, 1060, -160), (0, 0, 60));
	CreateBlocks((-112, 1060, -160), (0, 0, 60));
	CreateBlocks((-1187, 1566, -191), (0, 0, 56));

	if(input == 0 || input == 2 || input == 4)
	{
		CreateWalls((-1209, 3930, -120),(-1000, 4141, 0));		
		CreateWalls((-785, 4300, 0), (-785, 3850, -180));	
		CreateWalls((-2420, 2685, -220), (-2420, 2685.1, 120));	
		CreateWalls((2110, 3170, 380), (2110, 3170.1, 800));	
		CreateWalls((-2130, 1910, -30), (-2130, 2050, -30.1));	
		CreateWalls((-2130, 1910, -30), (-2290, 1910, -30.1));	
		CreateWalls((-2290, 1760, -30), (-2290, 1910, -30.1));	
		CreateWalls((-2290, 1760, -30), (-2550, 1760, -30.1));	
		CreateWalls((-1290, 2510, 10), (-1610, 2510, 10.1));				
		CreateWalls((-2725, 1960, -70), (-2725, 1160, -70.1));	
		CreateWalls((-2725, 1160, -70), (-2660, 1160, -70.1));	
		CreateWalls((-2300, 1270, -20), (-2300, 1400, -20.1));
		CreateWalls((-2500, 1225, -200), (-2570, 1225, 0));
		CreateWalls((-1860, 1150, -115), (-1860, 1200, -115.1));
		CreateWalls((-1910, 920, -157), (-1870, 920, -157.1));
		CreateBlocks((-1915, 1215, -167), (0,0,0));
		CreateElevator((-680.0, 3210.0, -125.68), (-950.0, 4000.0, -125.68),(0, -110, 0),true);
		CreateElevator((30.0, -1380.0, 5.68), (-950.0, 4000.0, -125.68),(0, -110, 0),true);
		CreateElevator((-2400.0, 1300.0, -210.68), (30.0, 1570.0, -255.68),(0, 0, 0));
	}
	else if(input == 1 || input == 3 || input == 5)
	{
		CreateBlocks((-864, 1685, -87),(0, 90, 0));
		CreateBlocks((-862, 1685, -94),(0, 90, 0));
		CreateBlocks((-860, 1685, -101),(0, 90, 0));
		CreateBlocks((-858, 1685, -108),(0, 90, 0));
		CreateBlocks((-856, 1685, -115),(0, 90, 0));

		CreateGrids((-920.0, 2100.0, -110.0),(-890.0, 1900.0, -110.0),(0, 0, 0));
		CreateGrids((-910.0, 1700.0, -80.0),(-880.0, 1640.0, -80.0),(0, 0, 0));
		CreateGrids((-910.0, 1500.0, -50.0),(-880.0, 1440.0, -50.0),(0, 0, 0));
		CreateGrids((-910.0, 1300.0, -20.0),(-880.0, 1170.0, -20.0),(0, 0, 0));

		CreateGrids((80.0, 1180.0, -60.0),(-20.0, 1240.0, -60.0),(0, 0, 0));

		CreateGrids((280.0, 1900.0, 0.0),(250.0, 1800.0, 0.0),(0, 0, 0));

		CreateGrids((410.0, 1750.0, -230), (410.0, 1850.0, -230),(75, 0, 0));
		CreateGrids((835.0, 1360.0, -230), (835.0, 1420.0, -230),(-60, 0, 0));
	}
}
		
Terminal()
{
	CreateBlocks((905, 5545, 345), (0, -90, 10));

    CreateBlocks((1395, 5640, 255), (0, -90, 0));
    CreateBlocks((1395, 5555, 345), (0, -90, -10));

    CreateBlocks((2140, 5560, 180), (0, 90, 75));
    CreateBlocks((2720, 5700, 180), (0, 0, 75));
    CreateBlocks((2660, 6005, 345), (0, 0, 20));
    CreateBlocks((2210, 6000, 345), (0, 0, 20));

	CreateGrids((1315.0, 3420.0, 60.0),(1315.0, 3380.0, 60.0),(55, 0, 0));
	CreateGrids((1940.0, 3450.0, 300.0),(1980.0, 3150.0, 300.0),(0, 45, 0));
	CreateGrids((2680.0, 3250.0, 300.0),(2640.0, 3430.0, 300.0),(0, 0, 0));
}
		
Arkaden(input)
{
	if(input == 0 || input == 2 || input == 4)
	{
		CreateBlocks((-488, -1259, 815), (0, 90, 0));
		CreateBlocks((322, 918, 645), (0, 270, 72));
		CreateBlocks((332, 918, 645), (0, 90, 72));

		CreateGrids((-940.0, 1715.0, 650.0),(-940.0, 1775.0, 650.0),(70, 90, 0));
		CreateGrids((-940.0, 1705.0, 680.0),(-940.0, 1765.0, 680.0),(90, 90, 0));

		CreateGrids((-1560.0, 1810.0, 640.0),(-1440.0, 1810.0, 640.0),(0, 0, 70));
		CreateGrids((-1620.0, 1965.0, 770.0),(-740.0, 1965.0, 770.0),(0, 0, 0));
		CreateGrids((-1620.0, 1935.0, 770.0),(-1015.0, 1935.0, 770.0),(0, 0, 0));
	}
	else if(input == 1 || input == 3 || input == 5)
	{
		CreateBlocks((-1376, -55, 890),(0, 90, 0));
		CreateBlocks((-1377, -55, 880),(0, 90, 0));
		CreateBlocks((-1378, -55, 870),(0, 90, 0));
		CreateBlocks((-1379, -55, 860),(0, 90, 0));
		CreateBlocks((-1380, -55, 850),(0, 90, 0));
		CreateBlocks((-1381, -55, 840),(0, 90, 0));
		CreateBlocks((-1382, -55, 830),(0, 90, 0));
		CreateBlocks((-1383, -55, 820),(0, 90, 0));
		CreateBlocks((-1384, -55, 810),(0, 90, 0));
		CreateBlocks((-1385, -55, 800),(0, 90, 0));

		CreateBlocks((-635, 240, 900),(0, 0, 0));
		CreateBlocks((-695, 240, 900),(0, 0, 0));

		CreateRamps((-715, 185, 900),(-620, 30, 988));

		CreateGrids((-615.0, -355.0, 1000.0),(-615.0, 0.0, 1000.0),(0, 0, 0));
		CreateGrids((-915.0, 70.0, 710.0),(-915.0, -40.0, 710.0),(-75, 0, 0));
		CreateGrids((-930.0, 70.0, 670.0),(-930.0, -40.0, 670.0),(-65, 0, 0));
		CreateGrids((-1575.0, 635.0, 970.0),(-1515.0, 575.0, 970.0),(0, 0, 0));

		CreateBlocks((-1305, 540, 906),(45, 0, 90));
		CreateBlocks((-1335, 530, 930),(0, 90, 0));
		CreateBlocks((-780, -340, 820),(-65, -25, -90));
		CreateGrids((-1360.0, -11.0, 900.0),(-1320.0, -90.0, 900.0),(0, 0, 0));
		
		CreateBlocks((520, -870, 670),(-65, 0, 0));
		CreateBlocks((520, -900, 670),(-65, 0, 0));
	}
}
		
Bakaara()
{
	CreateBlocks((-812, 666, 81), (0, 90, 0));
	CreateBlocks((330, -900, 71), (0, 180, 0));
	CreateBlocks((930, -453, -22), (0, 0, 55));
	CreateBlocks((167, 2649, 245), (0, 90, 0));
	CreateBlocks((-120, 2628, 468), (90, 0, 0));
	CreateBlocks((-817, 203, 231), (360, 90, 0));
	CreateBlocks((558, 1425, 188), (180, 352, 180));
	CreateBlocks((969, 330, 206), (0, 0, 0));

	CreateWalls((-2245, -20, 190), (-2245, -50, 70));

	CreateElevator((-890.185, 1301.07, -31.875), (-2139.99, 221.195, 96.125),(0, -27, 0),true);
	CreateElevator((-1143.71, -61.7681, 96.125), (-236.498, -1203.43, -43.875),(0, 55, 0),true);
}
		
Carbon()
{
	CreateGrids((820, -3780, 4090), (820-60, -3780+200, 4090),(0, 20, 0));
            CreateGrids((700, -3740, 4070), (700-120, -3740+100, 4070),(-53, 20, 0));

            CreateBlocks((-45, -3260, 4110),(0, 0, 0));

            CreateBlocks((-15, -2750, 3970),(0, 10, 73));

            CreateBlocks((-122, -3622, 3930),(0, -10, -60));
            CreateBlocks((-310, -3590, 3930),(0, 0, -65));

            CreateBlocks((100, -3090, 4090.2),(0, 90, 0));
            CreateBlocks((100-1, -3090+1, 4091-15),(0, 90, 0));
            CreateBlocks((100-2, -3090+2, 4091-30),(0, 90, 0));
            CreateBlocks((100-3, -3090+3, 4091-45),(0, 90, 0));
            CreateBlocks((100-4, -3090+4, 4091-60),(0, 90, 0));
            CreateBlocks((100-5, -3090+5, 4091-75),(0, 90, 0));
            CreateBlocks((100-6, -3090+6, 4091-90),(0, 90, 0));
            CreateBlocks((100-7, -3090+7, 4091-105),(0, 90, 0));
            CreateBlocks((100-8, -3090+8, 4091-120),(0, 90, 0));
            CreateBlocks((100-9, -3090+9, 4091-135),(0, 90, 0));
            CreateBlocks((100-10, -3090+10, 4091-150),(0, 90, 0));
            CreateBlocks((100-11, -3090+11, 4091-165),(0, 90, 0));
}

Interchange()
{

}
	
Village()
{

}

Fallen()
{

}
	
Rust()
{
	CreateBlocks((1185, 1620, -200), (-10, 180, 0));
    CreateBlocks((1185, 1635, -170), (-10, 180, 0));

    CreateBlocks((1240, 1620, -200), (-10, 180, 0));
    CreateBlocks((1240, 1635, -175), (-10, 180, 0));

	CreateBlocks((1322, 15, 1), (0, 0, 0));
	CreateBlocks((1322, 55, 1), (0, 0, 0));
	CreateBlocks((1322, 95, 1), (0, 0, 0));
}
	
Downturn()
{

}
		
Erosion()
{
	CreateBlocks((485, -2150, 250), (0, 0, 0));
    CreateBlocks((-58, -1250, 533), (0, 0, 0));
    CreateBlocks((100, -1084, 533), (0, 90, 0));
}
		
Highrise()
{	
	CreateElevatorSize((-1793, 8552, 3150), (-1375, 6288, 2648.13), 200, 300);
	CreateElevatorSize((-1333, 8333, 3164), (-1375, 6288, 2648.13), 200, 300);

	CreateBlocks((940, 7675, 2870), (0, 0, 0));
	CreateBlocks((940, 7640, 2845), (0, 0, 0));

	CreateBlocks((675, 7675, 2870), (0, 0, 0));
	CreateBlocks((675, 7640, 2845), (0, 0, 0));

	CreateBlocks((423, 7675, 2870), (0, 0, 0));
	CreateBlocks((423, 7640, 2845), (0, 0, 0));

	CreateBlocks((-49, 6717, 3090), (90, 180, 0));
	CreateBlocks((-49, 6717, 3090+70), (90, 180, 0));

	CreateBlocks((-49, 6715-85, 3090), (90, 180, 0));
	CreateBlocks((-49, 6715-85, 3090+70), (90, 180, 0));

	CreateBlocks((-49, 6715-170, 3090), (90, 180, 0));
	CreateBlocks((-49, 6715-170, 3090+70), (90, 180, 0));

	CreateBlocks((-49, 6715-255, 3090), (90, 180, 0));
	CreateBlocks((-49, 6715-255, 3090+70), (90, 180, 0));

	CreateBlocks((-49, 6715-340, 3090), (90, 180, 0));
	CreateBlocks((-49, 6715-340, 3090+70), (90, 180, 0));

	CreateBlocks((-49, 6715-425, 3090), (90, 180, 0));
	CreateBlocks((-49, 6715-425, 3090+70), (90, 180, 0));

	CreateBlocks((-49, 6715-510, 3090), (90, 180, 0));
	CreateBlocks((-49, 6715-510, 3090+70), (90, 180, 0));

	CreateBlocks((-49, 6715-595, 3090), (90, 180, 0));
	CreateBlocks((-49, 6715-595, 3090+70), (90, 180, 0));

	CreateBlocks((-49, 6715-680, 3090), (90, 180, 0));
	CreateBlocks((-49, 6715-680, 3090+70), (90, 180, 0));

	CreateBlocks((32, 6871, 3080), (0, 0, 0));

	//CreateBlocks((-1347, 4686, 1682), (0, 30, 0));
	CreateBlocks((-1265, 4732, 1762), (0, 124, 62)); // maybe too easy?

	CreateGrids((-2260, 7970, 2260), (-2410, 7970, 2260), (0,-50,67));
	CreateGrids((-2245, 8020, 2180), (-2150, 8020, 2180), (0,40,67));

	CreateBlocks((-643, 6621, 2772), (0, 0, 294));
	CreateBlocks((-632, 7137, 2770), (0, 180, 294));
	CreateBlocks((-406, 6779, 2752), (0, 124, 306));

	/*
	CreateBlocks((-1776, 8515, 3228), (0, 155, 0)); //
	CreateBlocks((-1758, 8558, 3228), (0, 155, 0)); // crane top blockers
	CreateBlocks((-1363, 8351, 3248), (0, -115, 0));//
	CreateBlocks((-1641, 8455, 3265), (0, 155, 0)); //
	CreateBlocks((-1626, 8490, 3265), (0, 155, 0)); //
	*/

	CreateBlocks((-2596, 6140, 2964), (0, 90, 34));

	i=0;
	CreateBlocks((-2795, 7632, 3260), (0, 90, 0)); i++;
	CreateBlocks((-2795, 7632-60*i, 3260), (0, 90, 0)); i++;
	CreateBlocks((-2795, 7632-60*i, 3260), (0, 90, 0)); i++;
	CreateBlocks((-2795, 7632-60*i, 3260), (0, 90, 0)); i++;
	CreateBlocks((-2795, 7632-60*i, 3260), (0, 90, 0)); i++;
	CreateBlocks((-2795, 7632-60*i, 3260), (0, 90, 0)); i++;
	CreateBlocks((-2795, 7632-60*i, 3260), (0, 90, 0)); i++;
	CreateBlocks((-2795, 7632-60*i, 3260), (0, 90, 0)); i++;
	CreateBlocks((-2795, 7632-60*i, 3260), (0, 90, 0)); i++;
	CreateBlocks((-2795, 7632-60*i, 3260), (0, 90, 0)); i++;
	CreateBlocks((-2795, 7632-60*i, 3260), (0, 90, 0)); i++;
	CreateBlocks((-2795, 7632-60*i, 3260), (0, 90, 0)); i++;
	CreateBlocks((-2795, 7632-60*i, 3260), (0, 90, 0)); i++;

	i=0;
	CreateBlocks((-2750+60*i, 6900, 3260), (0, 0, 0)); i++;
	CreateBlocks((-2750+60*i, 6900, 3260), (0, 0, 0)); i++;
	CreateBlocks((-2750+60*i, 6900, 3260), (0, 0, 0)); i++;
}

Nuketown()
{

}

Skidrow()
{
	CreateBlocks((265, 244, 139), (0, 90, 0));
	CreateBlocks((195, -75, 105), (90, 90, 0));
	CreateBlocks((-1027, -975, 325), (0, 0, 0));
	CreateBlocks((-1925, -1590, 170), (0, 180, 6));
 	CreateBlocks((-1651, -1658, 158), (90, 0, 0));
 	CreateBlocks((-1027, -975, 325), (0, 0, 0));
	CreateBlocks((285, -75, 105), (90, 90, 0));
  	CreateBlocks((715, -255, 64), (0, 270, 0));

	CreateBlocks((495, 45, 390), (90, 90, 0));
 	CreateBlocks((500, -43, 390), (90, -90, 0));
	
	CreateBlocks((-1535, -266, 516), (0, 0, 0));
	CreateBlocks((-1334, -87, 516), (0, 90, 0));
	CreateBlocks((-1050, -1056, 492), (0, 90, 0));
	CreateBlocks((-438, 325, 516), (0, 90, 0));
	CreateBlocks((767, 302, 524), (0, 0, 0));
	CreateBlocks((1095, 310, 524), (0, 0, 0));
	
	CreateBlocks((-180, -25, 360), (90, 90, 0));

	CreateBlocks((-1190, -1320, 140), (0, 0, 0));
	CreateBlocks((-1140, -1320, 140), (0, 0, 0));
}

Favela()
{

}

Quarry()
{
	/*CreateBlocks((-5075, -159, 375), (0, 90, 0)); //barn 14
    CreateBlocks((-5075, -159, 415), (0, 90, 0)); //barn 14
    CreateBlocks((-5075, -159, 450), (0, 90, 0)); //barn 14
    
    CreateBlocksRed((-3498, 147, 400), (90, 15, 0)); //small silo
    CreateBlocksRed((-3461, -445, 400), (90, -5, 0)); //small silo
    
    CreateBlocksRed((-3203, -885, 400), (90, 90, 0)); //lampost
    CreateBlocksRed((-3203, -885, 500), (90, 90, 0)); //lampost
    
    CreateWalls( (-5620, 1263, 200),(-5621, 1552, 201));
    CreateWalls( (-5620, 1263, 250),(-5621, 1552, 251));
    CreateWalls( (-5620, 1263, 300),(-5621, 1552, 301));
    
    CreateBlocks((-5567, -688, 49.), (0, 180, 0));*/

	CreateBlocks((-4020, -160, 340), (0, 90, 0));
	CreateBlocks((-5025, -375, 280), (0, 90, 0));

	CreateBlocks((-4590, -120, -103), (0, 90, 0));
	CreateBlocks((-4590, -180, -103), (0, 90, 0));
	CreateBlocks((-4515, -120, -103), (0, 90, 0));
	CreateBlocks((-4515, -180, -103), (0, 90, 0));

	CreateBlocks((-5555, -95, 375), (90, 0, 0));

	CreateBlocks((-5790, 1294, 232), (0, 0, -65));

	CreateBlocks((-5645, -1655, -115), (0, 90, 0));

	CreateBlocks((-5270, 1515, 55), (0, 90, 0));
	CreateBlocks((-5270, 1590, 55), (0, 90, 0));
	CreateBlocks((-5215, 1635, 55), (0, 0, 0));
	CreateBlocks((-5040, 1710, 55), (0, 0, 0));
	CreateBlocks((-4970, 1720, 55), (0, 0, 0));
	CreateBlocks((-4895, 1730, 55), (0, 0, 0));

	CreateBlocks((-5305, 1465, 55), (0, 90, 0));

	i=0;
	CreateBlocks((-5305, 1405-60*i, 55-20*i), (0, 90, 0));i++;
	CreateBlocks((-5305, 1405-60*i, 55-20*i), (0, 90, 0));i++;
	CreateBlocks((-5305, 1405-60*i, 55-20*i), (0, 90, 0));i++;
	CreateBlocks((-5305, 1405-60*i, 55-20*i), (0, 90, 0));i++;
	CreateBlocks((-5305, 1405-60*i, 55-20*i), (0, 90, 0));i++;

	CreateBlocks((-3680, 1880, 255), (0, 90, 0));
	CreateBlocks((-3610, 1530, 310), (0, 90, 0));
	CreateBlocks((-3610, 1610, 310), (0, 90, 0));
	CreateBlocks((-3400, -1655, 190), (30, 0, 0));

	CreateBlocks((-5840, 0, 130), (0, 90, 0));
	CreateBlocks((-5865, 0, 200), (0, 90, 0));

	CreateBlocks((-5140, 1785, 95), (0, 0, 0));
	CreateBlocks((-5100, 1785, 95), (0, 0, 0));
	CreateBlocks((-5060, 1785, 125), (45, 180, 0));
	CreateBlocks((-5190, 1785, 125), (45, 0, 0));

	i=0;
	CreateBlocks((-5825+47*i, 330+40*i, 380), (0, 40, 0));i++;
	CreateBlocks((-5825+47*i, 330+40*i, 380), (0, 40, 0));i++;
	CreateBlocks((-5825+47*i, 330+40*i, 380), (0, 40, 0));i++;
	CreateBlocks((-5825+47*i, 330+40*i, 380), (0, 40, 0));i++;
	CreateBlocks((-5825+47*i, 330+40*i, 380), (0, 40, 0));i++;
	CreateBlocks((-5825+47*i, 330+40*i, 380), (0, 40, 0));i++;

	i=0;
	CreateBlocks((-5620+i, 1540, 160-15*i), (0, 90, 0));i++;
	CreateBlocks((-5620+i, 1540, 160-15*i), (0, 90, 0));i++;
	CreateBlocks((-5620+i, 1540, 160-15*i), (0, 90, 0));i++;
	CreateBlocks((-5620+i, 1540, 160-15*i), (0, 90, 0));i++;
	CreateBlocks((-5620+i, 1540, 160-15*i), (0, 90, 0));i++;
	CreateBlocks((-5620+i, 1540, 160-15*i), (0, 90, 0));i++;

	i=0;
	CreateBlocks((-4800+i, 1880, 325-15*i), (0, 90, 0));i++;
	CreateBlocks((-4800+i, 1880, 325-15*i), (0, 90, 0));i++;
	CreateBlocks((-4800+i, 1880, 325-15*i), (0, 90, 0));i++;
	CreateBlocks((-4800+i, 1880, 325-15*i), (0, 90, 0));i++;
	CreateBlocks((-4800+i, 1880, 325-15*i), (0, 90, 0));i++;
	CreateBlocks((-4800+i, 1880, 325-15*i), (0, 90, 0));i++;
	CreateBlocks((-4800+i, 1880, 325-15*i), (0, 90, 0));i++;
	CreateBlocks((-4800+i, 1880, 325-15*i), (0, 90, 0));i++;
	CreateBlocks((-4800+i, 1880, 325-15*i), (0, 90, 0));i++;
	CreateBlocks((-4800+i, 1880, 325-15*i), (0, 90, 0));i++;
	CreateBlocks((-4800+i, 1880, 325-15*i), (0, 90, 0));i++;

	//CreateGrids((-4000, 400, 900), (-4100, 500, 1100), (0,0,0));
}


/////////////////////////////////////////////////////////////////////////////// MapEdit Functions ///////////////////////////////////////////////////////////////////

custom_killtrigger(pos1) // creates a custom deathbarrier from the set height, anything under will die
{
    while (true)
    {
        wait 0.1;

        foreach (player in level.players)
        {
            if (player.origin[2] < pos1 && isAlive(player))
            {
                player suicide();
            }
        }
    }
}

DeathBarrier(Pos1, Pos2) // creates a deathbarrier in a square box from p1 to p2
{
	
	level thread DeathBarrierThink(Pos1, Pos2);
	
}

DeathBarrierThink(Pos1, Pos2) // dont use this use DeathBarrier
{

	A = false;
	B = false;
	C = false;
	
	while (1)
	{
		foreach (player in level.players)
		{
		
			Origin = player getOrigin();
			if(Pos1[0] <= Pos2[0])
				if (Origin[0] >= Pos1[0] && Origin[0] <= Pos2[0] && isAlive(player))
					A = true;
				else
					A = false;
			else
				if(Pos1[0] >= Pos2[0])
					if (Origin[0] <= Pos1[0] && Origin[0] >= Pos2[0] && isAlive(player))
						A = true;
					else
						A = false;
			
			if(Pos1[1] <= Pos2[1])
				if (Origin[1] >= Pos1[1] && Origin[1] <= Pos2[1] && isAlive(player))
					B = true;
				else
					B = false;
			else
				if (Pos1[1] >= Pos2[1])
					if (Origin[1] <= Pos1[1] && Origin[1] >= Pos2[1] && isAlive(player))
						B = true;
					else	
						B = false;
			
			if (Pos1[2] <= Pos2[2])
				if (Origin[2] >= Pos1[2] && Origin[2] <= Pos2[2] && isAlive(player))
					C = true;
				else
					C = false;
			else
				if (Origin[2] <= Pos1[2] && Origin[2] >= Pos2[2] && isAlive(player))
					C = true;
				else
					C = false;
			
			if (A && B && C)
			{
			player suicide();
			//player IPrintLn( "you die now" );
			}
		}
	wait .1;
	}

}

CreateElevator(enter, exit, angle, angleyes) // creates a flag/teleport from point a to b, put in angle to set angle u want, and u need to do true or false on angleyes, to fix a script error i got lazy fix ofc but oh well
{
	flag = spawn( "script_model", enter );
	flag setModel( level.elevator_model["enter"] );
	wait level.waittime;
	flag = spawn( "script_model", exit );
	flag setModel( level.elevator_model["exit"] );
	wait level.waittime;
	self thread ElevatorThink(enter, exit, angle, angleyes);
	Objective_Add(level.flag_ref+1, "active", enter);
	//Objective_Icon(level.flag_ref+1, undefined);
	level.flag_ref++;
}

ElevatorThink(enter, exit, angle, angleyes) // dont use this use CreateElevator
{
	self endon("disconnect");
	while(1)
	{
		foreach(player in level.players)
		{
			if(Distance(enter, player.origin) <= 50){
				player SetOrigin(exit);
				if(isdefined(angleyes))
				player SetPlayerAngles(angle);
			}
		}
		wait .25;
	}
}

CreateElevatorSize(enter, exit, radius, height) // creates a flag/teleport from point a to b, defineable radius and height
{
	self thread ElevatorThinkSize(enter, exit, radius, height);
}

ElevatorThinkSize(enter, exit, radius, height) // dont use this use createelevatorsize instead
{
	self endon("disconnect");
	trigger = Spawn( "trigger_radius", enter, 0, radius, height );
	for(;;) 
	{
		trigger waittill( "trigger", player );

		player SetOrigin(exit);
	}
}

CreateBlocks(pos, angle)  // creates a single green block
{
	block = spawn("script_model", pos );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
}

CreateBlocksRed(pos, angle) // creates a single red block
{
	block = spawn("script_model", pos );
	block setModel("com_plasticcase_enemy");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
}

CreateRamps(top, bottom) // creates a ramp/slope from point a to point b
{
	D = Distance(top, bottom);
	blocks = roundUp(D/30);
	CX = top[0] - bottom[0];
	CY = top[1] - bottom[1];
	CZ = top[2] - bottom[2];
	XA = CX/blocks;
	YA = CY/blocks;
	ZA = CZ/blocks;
	CXY = Distance((top[0], top[1], 0), (bottom[0], bottom[1], 0));
	Temp = VectorToAngles(top - bottom);
	BA = (Temp[2], Temp[1] + 90, Temp[0]);
	for(b = 0; b < blocks; b++){
		block = spawn("script_model", (bottom + ((XA, YA, ZA) * b)));
		block setModel("com_plasticcase_friendly");
		block.angles = BA;
		block Solid();
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		wait level.waittime;
	}
	block = spawn("script_model", (bottom + ((XA, YA, ZA) * blocks) - (0, 0, 5)));
	block setModel("com_plasticcase_friendly");
	block.angles = (BA[0], BA[1], 0);
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	wait level.waittime;
}

CreateGrids(corner1, corner2, angle) // spawns a platform from point a to point b, ( Try to always keep the platform the same height, otherwise it will use up all available carepackages)
{
	W = Distance((corner1[0], 0, 0), (corner2[0], 0, 0));
	L = Distance((0, corner1[1], 0), (0, corner2[1], 0));
	H = Distance((0, 0, corner1[2]), (0, 0, corner2[2]));
	CX = corner2[0] - corner1[0];
	CY = corner2[1] - corner1[1];
	CZ = corner2[2] - corner1[2];
	ROWS = roundUp(W/55);
	COLUMNS = roundUp(L/30);
	HEIGHT = roundUp(H/20);
	if(CX == 0)
	XA = CX;
	else
	XA = (CX/ROWS);
	if(CY == 0)
	YA = CY;
	else
	YA = (CY/COLUMNS);
	if(CZ == 0)
	ZA =  CZ;
	else
	ZA = (CZ/HEIGHT);
	center = spawn("script_model", corner1);
	for(r = 0; r <= ROWS; r++){
		for(c = 0; c <= COLUMNS; c++){
			for(h = 0; h <= HEIGHT; h++){
				block = spawn("script_model", (corner1 + (XA * r, YA * c, ZA * h)));
				block setModel("com_plasticcase_friendly");
				block.angles = (0, 0, 0);
				block Solid();
				block LinkTo(center);
				block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
				wait level.waittime;
			}
		}
	}
	center.angles = angle;
}

CreateWalls(start, end) // Creates a wall from point a to point b
{
    D = Distance((start[0], start[1], 0), (end[0], end[1], 0));
    H = Distance((0, 0, start[2]), (0, 0, end[2]));
    blocks = roundUp(D/55);
    height = roundUp(H/30);
    CX = end[0] - start[0];
    CY = end[1] - start[1];
    CZ = end[2] - start[2];
    XA = (CX/blocks);
    YA = (CY/blocks);
    if(CZ == 0)
	ZA =  CZ;
	else
	ZA = (CZ/height);
    TXA = (XA/4);
    TYA = (YA/4);
    Temp = VectorToAngles(end - start);
    Angle = (0, Temp[1], 90);
    for(h = 0; h < height; h++){
        block = spawn("script_model", (start + (TXA, TYA, 10) + ((0, 0, ZA) * h)));
        block setModel("com_plasticcase_friendly");
        block.angles = Angle;
        block Solid();
        block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        wait level.waittime/10;
        for(i = 1; i < blocks; i++){
            block = spawn("script_model", (start + ((XA, YA, 0) * i) + (0, 0, 10) + ((0, 0, ZA) * h)));
            block setModel("com_plasticcase_friendly");
            block.angles = Angle;
            block Solid();
            block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
            wait level.waittime/10;
        }
        block = spawn("script_model", ((end[0], end[1], start[2]) + (TXA * -1, TYA * -1, 10) + ((0, 0, ZA) * h)));
        block setModel("com_plasticcase_friendly");
        block.angles = Angle;
        block Solid();
        block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        wait level.waittime/10;
    }
}

Createmodel(Model, pos, angle) // allows spawning of any model at any position ( wont have collision)
{
	block = spawn("script_model", pos );
	block setModel(Model);
	block.angles = angle;
	wait 0.01;
}

roundUp( floatVal ) // rounds up
{
	if ( int( floatVal ) != floatVal )
		return int( floatVal+1 );
	else
		return int( floatVal );
}

CreateForce(start, end) // spawns a invisible wall
{
    D = Distance((start[0], start[1], 0), (end[0], end[1], 0));
    H = Distance((0, 0, start[2]), (0, 0, end[2]));
    blocks = roundUp(D / 55);
    height = roundUp(H / 30);
    CX = end[0] - start[0];
    CY = end[1] - start[1];
    CZ = end[2] - start[2];
    XA = (CX / blocks);
    YA = (CY / blocks);
    ZA = (CZ / height);
    TXA = (XA / 4);
    TYA = (YA / 4);
    Temp = VectorToAngles(end - start);
    Angle = (0, Temp[1], 90);
    for (h = 0; h < height; h++) {
        block = spawn("script_model", (start + (TXA, TYA, 10) + ((0, 0, ZA) * h)));
        //block setModel(level.chopper_fx["light"]["belly"]);
        block.angles = Angle;
        block Solid();
        block CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
        wait 0.001;
        for (i = 1; i < blocks; i++) {
            block = spawn("script_model", (start + ((XA, YA, 0) * i) + (0, 0, 10) + ((0, 0, ZA) * h)));
            //block setModel(level.chopper_fx["light"]["belly"]);
            block.angles = Angle;
            block Solid();
            block CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
            wait 0.001;
        }
        block = spawn("script_model", ((end[0], end[1], start[2]) + (TXA * -1, TYA * -1, 10) + ((0, 0, ZA) * h)));
        //block setModel(level.chopper_fx["light"]["belly"]);
        block.angles = Angle;
        block Solid();
        block CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
        wait 0.001;
    }
}

CreateAsc(depart, arivee, angle, time) { // spawns a box that moves from point a to b in the specified time
    Asc = spawn("script_model", depart);
    Asc setModel("com_plasticcase_friendly");
    Asc.angles = angle;
    Asc Solid();
    Asc CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
    Asc thread Escalator(depart, arivee, time);
}

Escalator(depart, arivee, time) // dont use this use CreateAsc instead
{
	self.state = "open";
    while (1) {
        if (self.state == "open") {
            self MoveTo(depart, time);
            wait(time * 1.5);
            self.state = "close";
            continue;
        }
        if (self.state == "close") {
            self MoveTo(arivee, time);
            wait(time * 1.5);
            self.state = "open";
            continue;
        }
    }
}

createJumpZone(position, impulse, range) // this creates a jump pad that adds to your current velocity
{
	level endon("game_ended");
	
	zone = spawn("script_model", position);
	zone setModel("weapon_c4_bombsquad");
	
	for (;;)
	{
		foreach (player in level.players)
		{
			dist = distance(player.origin, position);
			if (dist < range && player isOnGround() == 0)
			{
				IPrintLn( "test?" );
				player setVelocity(player getVelocity()+(impulse));
				wait (0.2);
			}
		}
		wait (0.01);
	}
}

createJumpZoneNoVel(position, impulse, range) // this creates a jump pad that sets your velocity
{
	level endon("game_ended");
	
	zone = spawn("script_model", position);
	zone setModel("weapon_c4_bombsquad");
	
	for (;;)
	{
		foreach (player in level.players)
		{
			dist = distance(player.origin, position);
			if (dist < range && player isOnGround() == 0)
			{
				IPrintLn( "test?" );
				player setVelocity(impulse);
				wait (0.2);
			}
		}
		wait (0.01);
	}
}

MinimapMarker(position) // a way to add a marker on the map, if u want to have one on jump pads or whatever
{
	objective_add(level.flag_ref+1, "active", position);
	objective_icon(level.flag_ref+1, "compass_waypoint_bomb");
	level.flag_ref++;
}

movebackthink(Pos1, Pos2, velocity, set) // this is pretty janky but it kinda worked, makes it so people cannot go past a certain coardinate to stop people from running out of map way too far and be bitches, hard to use cause shit code
{
	self endon("disconnect");
	level endon("game_ended");
	
	A = false;
	B = false;
	C = false;
	
	while (1)
	{	
			Origin = self getOrigin();
			if(Pos1[0] <= Pos2[0])
				if (Origin[0] >= Pos1[0] && Origin[0] <= Pos2[0] && isAlive(self))
					A = true;
				else
					A = false;
			else
				if(Pos1[0] >= Pos2[0])
					if (Origin[0] <= Pos1[0] && Origin[0] >= Pos2[0] && isAlive(self))
						A = true;
					else
						A = false;
			
			if(Pos1[1] <= Pos2[1])
				if (Origin[1] >= Pos1[1] && Origin[1] <= Pos2[1] && isAlive(self))
					B = true;
				else
					B = false;
			else
				if (Pos1[1] >= Pos2[1])
					if (Origin[1] <= Pos1[1] && Origin[1] >= Pos2[1] && isAlive(self))
						B = true;
					else	
						B = false;
			
			if (Pos1[2] <= Pos2[2])
				if (Origin[2] >= Pos1[2] && Origin[2] <= Pos2[2] && isAlive(self))
					C = true;
				else
					C = false;
			else
				if (Origin[2] <= Pos1[2] && Origin[2] >= Pos2[2] && isAlive(self))
					C = true;
				else
					C = false;
			
			if (A && B && C)
			{
				if(isdefined(set))
				{
					self setVelocity(velocity);
				}
				else
				{
					self setVelocity(self getVelocity()+(velocity));
				}
			}
	wait .4;
	}
}

SecretZone(position, range) // can be used to create a secret spot, for example if a person enters this range ( lets say he gets oom through a specific spot) then it can call more map edits to load and spawn a flag for all people or whatever u can imagine
{	
	level endon("endseczone");
	trigger = Spawn( "trigger_radius", position, 0, range, 200 );
	for(;;) 
	{
		trigger waittill( "trigger", player );

		trigger delete();
		player setLowerMessage("secret", "^5Nice Job^2 " + player.name + "^5, You Opened The Secret");
		level notify("spawnsecret"); // use this notify in your normal mapedits, anything that goes after the waittill for this will spawn in after the secret has been reached
		iprintlnbold("^3Secret Opened");
		wait 5;
		player clearLowerMessage("secret");
		level notify("endseczone");
	}
}