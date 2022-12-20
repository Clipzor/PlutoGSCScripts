#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

init()
{
	// I never ended up using this as it was a bit much, but it was mainly just as a test to see if it could be done and was fun to think of aids effects lol

	// use this with caution, it absolutely does shit effects to people that u add in the list if they use voicechat
	// this is mainly for if u dont want to ban people for using voicechat wrong. but it pretty much makes it unplayable for them

	level thread onPlayerConnect();
}

onPlayerConnect()
{
  	for(;;) {
   		level waittill("connected", player);

		if(player.name == "BdawgTheSlaya" || player.name == "Tqhr" || player.name == "SLoth.Dark" || player.name == "SadSlothXL" || player.name == "addnamehere") // add peoples names in here that u dont want to be able to use voicechat
		{
			player thread talkingsender();
		}
	}
}

talkingsender()
{
    self endon( "disconnect" );

	self.warns = 0;
	self notifyonplayercommand("talktome", "+talk");
	self notifyonplayercommand("stoppedtalking", "-talk");

	self thread mintalker();
	
    while(1)
	{
        self waittill("talktome");

		self.talkingnow = 1;
		self thread keeptalkingkicker();
		self.warns++;

		if(self.warns == 1)
		{
			if(self.team == "allies")
			{
				num = randomint(4);
				if(num == 0)
				{
					self FreezeControls(true);
					self IPrintLnBold("^1You Are Voice Chat Banned, FROZEN IN PLACE");
				}
				else if(num == 1)
				{
					self AllowJump(false);
					self IPrintLnBold("^1You Are Voice Chat Banned, JUMPING DISABLED");
				}
				else if(num == 2)
				{
					self AllowADS(false);
					self IPrintLnBold("^1You Are Voice Chat Banned, ADS DISABLED");
				}
				else if(num == 3)
				{
					self SayAll("^1I AM A GAY SCREAMING BOZO AND I DONT KNOW HOW TO BEHAVE");
					self IPrintLnBold("^1You Are Voice Chat Banned, SEEMS LIKE UR GAY AF");
				}
			}
			else if(self.team == "axis")
			{
				num = randomint(3);
				if(num == 0)
				{
					self FreezeControls(true);
					self IPrintLnBold("^1You Are Voice Chat Banned, FROZEN IN PLACE");
				}
				else if(num == 1)
				{
					self AllowJump(false);
					self IPrintLnBold("^1You Are Voice Chat Banned, JUMPING DISABLED");
				}
				else if(num == 2)
				{
					self SayAll("^1I AM A GAY SCREAMING BOZO AND I DONT KNOW HOW TO BEHAVE");
					self IPrintLnBold("^1You Are Voice Chat Banned, SEEMS LIKE UR GAY AF");
				}
			}
		}
		else if(self.warns == 2)
		{
			num = randomint(7);
				if(num == 0)
				{
					self thread spinner();
					self IPrintLnBold("^1You Are Voice Chat Banned, YOU SPIN ME RIGHT ROUND BABY");
				}
				else if(num == 1)
				{
					self thread left();
					self IPrintLnBold("^1You Are Voice Chat Banned, LEFTY LOOSY");
				}
				else if(num == 2)
				{
					self thread right();
					self IPrintLnBold("^1You Are Voice Chat Banned, RIGHTY TIGHTY");
				}
				else if(num == 3)
				{
					self thread randsnap();
					self IPrintLnBold("^1You Are Voice Chat Banned, HAVE FUN SNAPPING");
				}
				else if(num == 4)
				{
					self thread seizure();
					self IPrintLnBold("^1You Are Voice Chat Banned, Seizure Mode Activated");
				}
				else if(num == 5)
				{
					self thread rubberband();
					self IPrintLnBold("^1You Are Voice Chat Banned, RubberBand Mode Activated");
				}
				else if(num == 6)
				{
					self thread nojumper();
					self IPrintLnBold("^1You Are Voice Chat Banned, Rock Mode Activated");
				}
		}
		else if(self.warns > 2)
		{
			self iprintlnbold("^1Too Many Warnings, Getting kicked");
			wait 2;
			kick(self getEntityNumber());  
		}

		wait 3;
    }
}

mintalker()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("stoppedtalking");
		self.talkingnow = 0;
	}
}

keeptalkingkicker()
{
	self endon("disconnect");
	self endon("stoppedtalking");
	wait 5;
	if(self.talkingnow == 1)
	{
		self thread kicker();
	}
}

kicker()
{
	self iprintlnbold("^1You Are Voice Chat Banned, Getting Kicked");
	wait 1;
	kick(self getEntityNumber()); 
}

spinner()
{
	self endon( "disconnect" );
	num = 0;
	for(;;)
	{
		num++;
		if(num > 360)
		num = 1;

		wait 0.05;
		ang = self GetPlayerAngles();
		self SetPlayerAngles((ang[0], ang[1], num));
	}
}

left()
{
	self endon( "disconnect" );
	num = 2;
	for(;;)
	{
		wait 0.05;
		ang = self GetPlayerAngles();
		self SetPlayerAngles((ang[0], ang[1] + num, ang[2]));
	}
}

right()
{
	self endon( "disconnect" );
	num = 2;
	for(;;)
	{
		wait 0.05;
		ang = self GetPlayerAngles();
		self SetPlayerAngles((ang[0], ang[1] - num, ang[2]));
	}
}

randsnap()
{
	self endon( "disconnect" );
	for(;;)
	{
		wait 1;

		ang = self GetPlayerAngles();
		randint = randomint(3);
		dir = randomint(2);
		if(randint == 0)
		{
			if(dir == 1)
				self SetPlayerAngles((ang[0] - 90, ang[1], ang[2]));
			else
				self SetPlayerAngles((ang[0] + 90, ang[1], ang[2]));
		}
		else if( randint == 1)
		{
			if(dir == 1)
				self SetPlayerAngles((ang[0], ang[1] - 90, ang[2]));
			else
				self SetPlayerAngles((ang[0], ang[1] + 90, ang[2]));
		}
		else if( randint == 2)
		{
			if(dir == 1)
				self SetPlayerAngles((ang[0], ang[1], ang[2] - 90));
			else
				self SetPlayerAngles((ang[0], ang[1], ang[2] + 90));
		}
	}
}

seizure()
{
	self endon( "disconnect" );
	for(;;)
	{
		wait 0.05;
		self visionsetnakedforplayer("blacktest", 0);
		wait 0.05;
		self visionsetnakedforplayer("coup_sunblind", 0);
	}
}

rubberband()
{
	self endon( "disconnect" );
	for(;;)
	{
		org = self.origin;
		spd = self getvelocity();
		wait 1;
		self setorigin(org);
		self setvelocity(spd);
		wait 2;
	}
}

nojumper()
{
	self endon( "disconnect" );
	self notifyonplayercommand("jumper", "+gostand");
	for(;;)
	{
        self waittill("jumper", "+gostand");
		getvel = self getvelocity();
		wait 0.1;
		self setvelocity((getvel[0], getvel[1], -300));
	}
}

