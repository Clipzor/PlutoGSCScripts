#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
	// my implementation of tic tac toe, i wont explain any of this as i think it could be interesting to learn i guess
	// ofcourse i properly did it in a shit way but it was a learning thing for me so idc
	// this is activated by using -ttt (player u want to face off) or -tttd for a deathly match instead
	// this is all in the voteformap script

	level.TicTacToe = false;
	level.explosionfx = loadfx("explosions/clusterbomb_exp");
}

TicStart(startpos, p1, p2, death)
{
	if(!level.TicTacToe)
	{
		level.TicTacToe = true;

		if(death == true)
		level.deadly = true;
		else if(death == false)
		level.deadly = false;

		level.tttplayer1 = p1;
		level.tttplayer2 = p2;

		level.tttplayer1.curpos = undefined;
		level.tttplayer1.curang = undefined;

		level.tttplayer2.curpos = undefined;
		level.tttplayer2.curang = undefined;

		level.tttplayer1.turn = false;
		level.tttplayer2.turn = false;

		level.choice = [];
		level.trig = [];
		level.numchosen = 0;

		for(i=1; i < 9; i++)
		{
			for(j = -100; j <= 100; j+= 100)
			{
				level.choice[i] = SpawnBlock((startpos[0] + 100, startpos[1] + j , startpos[2]), (90,0,0));
				level.trig[i] = Spawn( "trigger_radius", level.choice[i].origin, 0, 25, 100 );
				level.trig[i] thread monitorchoice(i);
				i++;
			}
			for(k = -100; k <= 100; k+= 100)
			{
				level.choice[i] = SpawnBlock((startpos[0], startpos[1] + k , startpos[2]), (90,0,0));
				level.trig[i] = Spawn( "trigger_radius", level.choice[i].origin, 0, 25, 100 );
				level.trig[i] thread monitorchoice(i);
				i++;
			}
			for(l = -100; l <= 100; l+= 100)
			{
				level.choice[i] = SpawnBlock((startpos[0] - 100, startpos[1] + l , startpos[2]), (90,0,0));
				level.trig[i] = Spawn( "trigger_radius", level.choice[i].origin, 0, 25, 100 );
				level.trig[i] thread monitorchoice(i);
				i++;
			}
		}

		while(true)
		{
			level.board = [];
			i = 1;
			for(j = -100; j <= 100; j+= 50)
			{
				level.board[i] = SpawnBoard((startpos[0] + 50, startpos[1] + j , startpos[2] - 5), (0,90,45));
				i++;
			}
			for(j = -100; j <= 100; j+= 50)
			{
				level.board[i] = SpawnBoard((startpos[0] - 50, startpos[1] + j , startpos[2] - 5), (0,90,45));
				i++;
			}

			for(j = -100; j <= 100; j+= 50)
			{
				level.board[i] = SpawnBoard((startpos[0] + j, startpos[1] + 50 , startpos[2] - 5), (0,0,45));
				i++;
			}
			for(j = -100; j <= 100; j+= 50)
			{
				level.board[i] = SpawnBoard((startpos[0] + j, startpos[1] - 50 , startpos[2] - 5), (0,0,45));
				i++;
			}
			break;
		}

		wait 2;

		first = randomint(2);
		if(first == 0)
		{
		level.tttplayer1.turn = true;
		level.tttplayer1 Iprintlnbold("^1" + level.tttplayer1.name + " ^7Starts");
		level.tttplayer2 Iprintlnbold("^1" + level.tttplayer1.name + " ^7Starts");
		}
		else if(first == 1)
		{
		level.tttplayer2.turn = true;
		level.tttplayer1 Iprintlnbold("^1" + level.tttplayer2.name + " ^7Starts");
		level.tttplayer2 Iprintlnbold("^1" + level.tttplayer2.name + " ^7Starts");
		}

		level notify("GameStart");
	}
	else if(level.TicTacToe)
	{
	p1 iprintlnbold("TicTacToe Already In Progress");
	}
}

monitorchoice(number)
{
	level endon("GameOver");

	self.triggerpressed = false;

	level waittill("GameStart");

	for(;;) 
	{
		self waittill( "trigger", player );

		if(player == level.tttplayer1 || player == level.tttplayer2)
		{
			if(player UseButtonPressed() && player.turn && !self.triggerpressed)
			{
				self.triggerpressed = true;
				if(player == level.tttplayer1)
				{
					level.tttplayer1.turn = false;
					level.tttplayer2.turn = true;
					level.tttplayer2 Iprintlnbold("Your Turn");
					self.triggerpressed = true;
					level.choice[number] setModel("com_plasticcase_friendly");
					level.choice[number].winteam = "player1";
				}
				else if(player == level.tttplayer2)
				{
					level.tttplayer2.turn = false;
					level.tttplayer1.turn = true;
					level.tttplayer1 Iprintlnbold("Your Turn");
					self.triggerpressed = true;
					level.choice[number] setModel("com_plasticcase_enemy");
					level.choice[number].winteam = "player2";
				}

				level.numchosen++;

				if(player == level.tttplayer1)
				winteam = "player1";
				else if(player == level.tttplayer2)
				winteam = "player2";
				else
				winteam = "fuckyou";

				thread checkscore(winteam);
			}
			else if(player UseButtonPressed() && !player.turn && !self.triggerpressed)
			{
				player IprintlnBold("^1Its Not Your Turn Bitch");
				wait 0.5;
			}
		}
	}
}

checkscore(winning)
{
	if((level.choice[1].winteam == winning && level.choice[2].winteam == winning && level.choice[3].winteam == winning))
	thread endtttgame(winning);
	else if((level.choice[4].winteam == winning && level.choice[5].winteam == winning && level.choice[6].winteam == winning))
	thread endtttgame(winning);
	else if((level.choice[7].winteam == winning && level.choice[8].winteam == winning && level.choice[9].winteam == winning))
	thread endtttgame(winning);
	else if((level.choice[1].winteam == winning && level.choice[4].winteam == winning && level.choice[7].winteam == winning))
	thread endtttgame(winning);
	else if((level.choice[2].winteam == winning && level.choice[5].winteam == winning && level.choice[8].winteam == winning))
	thread endtttgame(winning);
	else if((level.choice[3].winteam == winning && level.choice[6].winteam == winning && level.choice[9].winteam == winning))
	thread endtttgame(winning);
	else if((level.choice[1].winteam == winning && level.choice[5].winteam == winning && level.choice[9].winteam == winning))
	thread endtttgame(winning);
	else if((level.choice[7].winteam == winning && level.choice[5].winteam == winning && level.choice[3].winteam == winning))
	thread endtttgame(winning);

	if(level.numchosen >= 9)
	thread endtttgame("tie");
}

endtttgame(winner)
{
	if(winner == "player1")
	{
		level.tttplayer1 Iprintlnbold("^1" + level.tttplayer1.name + " ^7Wins The Game");
		level.tttplayer2 Iprintlnbold("^1" + level.tttplayer1.name + " ^7Wins The Game");

		if(level.deadly == true)
		{
			playfx(level.explosionfx, level.tttplayer2.origin);
			level.tttplayer2 playsound("new_feature_unlocks");
			level.tttplayer2 suicide();
		}
	}
	else if(winner == "player2")
	{
		level.tttplayer1 Iprintlnbold("^1" + level.tttplayer2.name + " ^7Wins The Game");
		level.tttplayer2 Iprintlnbold("^1" + level.tttplayer2.name + " ^7Wins The Game");

		if(level.deadly == true)
		{
			playfx(level.explosionfx, level.tttplayer1.origin);
			level.tttplayer1 playsound("new_feature_unlocks");
			level.tttplayer1 suicide();
		}
	}
	else if(winner == "tie")
	{
		level.tttplayer1 Iprintlnbold("^1Tie^7, Nobody Wins");
		level.tttplayer2 Iprintlnbold("^1Tie^7, Nobody Wins");
	}
	else if(winner == "force")
	{
		level.tttplayer1 Iprintlnbold("^1ForceFully^7 Ended The Game, Nobody Wins");
		level.tttplayer2 Iprintlnbold("^1ForceFully^7 Ended The Game, Nobody Wins");
	}

	for(i = 1; i <= level.choice.size; i++){ 
	level.choice[i] delete();
	waitframe();
	}
	for(i = 1; i <= level.board.size; i++){ 
	level.board[i] delete();
	waitframe();
	}
	for(i = 1; i <= level.trig.size; i++){ 
	level.trig[i] delete();
	waitframe();
	}

	level.choice = undefined;
	level.trig = undefined;
	level.board = undefined;

	level.boom = undefined;

	level.tttplayer1 = undefined;
	level.tttplayer2 = undefined;
	level.numchosen = undefined;

	level.TicTacToe = false;
	level notify("GameOver");
}

SpawnBlock(pos, angle)
{
	block = spawn("script_model", pos );
	//block setModel("com_plasticcase_friendly");
	block.winteam = "none";
	block.angles = angle;
	return block;
}

SpawnBoard(pos, angle)
{
	block = spawn("script_model", pos );
	block setModel("com_plasticcase_trap_friendly");
	block.angles = angle;
	return block;
}
