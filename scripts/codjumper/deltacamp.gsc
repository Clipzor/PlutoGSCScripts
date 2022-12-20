#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
	if(getdvar("mapname") == "so_deltacamp") // checks for deltacamp map
	{
		level waittill("prematch_over");
		visionsetnaked(getdvar("mapname")); // sets vision after prematch to fix vision on this map
	}	
}

