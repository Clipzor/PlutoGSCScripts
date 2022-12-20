#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
	// comment all this for use on a server

	// this is just for private match really or if u are only hosting 1 server
	// to disable all the scripts set cj to false

	cj = true;
	if(cj)
	{
		level thread scripts\codjumper\commands::init();
		level thread scripts\codjumper\codjumper::init();
		level thread scripts\codjumper\settings::init();
		level thread scripts\codjumper\fullbright::init();
		level thread scripts\codjumper\heightcheck::init();
		level thread scripts\codjumper\deltacamp::init();
		level thread scripts\codjumper\tictactoe::init();
		level thread scripts\codjumper\mapedit::init();
		level thread scripts\codjumper\voteformap::init();
	}


	// for servers down here
	
	// to use this set up the right net port that the specified server is using to only load those scripts on that server
	// This script will be the only one run if setup properly and from here all other scripts will load allowing for
	// multiple server with scripts to be run from the same directory

	/*
	if(getdvarint("net_port") == 27017) // codjumper
	{
		level thread scripts\codjumper\commands::init();
		level thread scripts\codjumper\codjumper::init();
		level thread scripts\codjumper\settings::init();
		level thread scripts\codjumper\fullbright::init();
		level thread scripts\codjumper\heightcheck::init();
		level thread scripts\codjumper\deltacamp::init();
		level thread scripts\codjumper\tictactoe::init();
		level thread scripts\codjumper\mapedit::init();
		level thread scripts\codjumper\voteformap::init();
	}
	else if(getdvarint("net_port") == 27016) //// infected or whatever, i recommend naming them
	{
		level thread scripts\scriptsforthatserver\scriptname::init();
	}
	*/
}