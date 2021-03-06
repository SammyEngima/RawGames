#include common_scripts\utility;
#include maps\_utility;

main()
{
	flag_init( "pullup_weapon" );
	flag_init( "introscreen_complete" ); // Notify when complete	
	flag_init( "safe_for_objectives" );	
	delaythread( 10, ::flag_set, "safe_for_objectives" );

	precacheshader("black");

	if (getDvar("introscreen") == "")
		setDvar("introscreen", "1");
	
	//String1 = Title of the level
	//String2 = Place, Country or just Country
	//String3 = Month Day, Year
	//String4 = Optional additional detailed information
	//Pausetime1 = length of pause in seconds after title of level
	//Pausetime2 = length of pause in seconds after Month Day, Year
	//Pausetime3 = length of pause in seconds before the level fades in 
	
	switch ( level.script )
	{
	case "ac130":
		precacheString( &"AC130_INTROSCREEN_LINE_1" );
		precacheString( &"AC130_INTROSCREEN_LINE_2" );
		precacheString( &"AC130_INTROSCREEN_LINE_3" );
		precacheString( &"AC130_INTROSCREEN_LINE_4" );
		introscreen_delay(&"AC130_INTROSCREEN_LINE_1", &"AC130_INTROSCREEN_LINE_2", &"AC130_INTROSCREEN_LINE_3", &"AC130_INTROSCREEN_LINE_4", 0.2, 0.2, 0.2);
		break;
	case "blackout":
		precacheString(&"INTROSCREEN_TITLE");
		precacheString(&"INTROSCREEN_PLACE");
		precacheString(&"INTROSCREEN_DATE");
		precacheString(&"INTROSCREEN_INFO");
		introscreen_delay(&"INTROSCREEN_TITLE", &"INTROSCREEN_PLACE", &"INTROSCREEN_DATE", &"INTROSCREEN_INFO", 0.2, 0.2, 0.2);
		break;
	case "bog_a":
		precacheString(&"INTROSCREEN_TITLE");
		precacheString(&"INTROSCREEN_PLACE");
		precacheString(&"INTROSCREEN_DATE");
		precacheString(&"INTROSCREEN_INFO");
		introscreen_delay(&"INTROSCREEN_TITLE", &"INTROSCREEN_PLACE", &"INTROSCREEN_DATE", &"INTROSCREEN_INFO", 0.2, 0.2, 0.2);
		break;
	case "bog_b":
		precacheString( &"BOG_B_INTROSCREEN_LINE_1" );
		precacheString( &"BOG_B_INTROSCREEN_LINE_2" );
		precacheString( &"BOG_B_INTROSCREEN_LINE_3" );
		precacheString( &"BOG_B_INTROSCREEN_LINE_4" );
		introscreen_delay(&"BOG_B_INTROSCREEN_LINE_1", &"BOG_B_INTROSCREEN_LINE_2", &"BOG_B_INTROSCREEN_LINE_3", &"BOG_B_INTROSCREEN_LINE_4", 0.2, 0.2, 0.2);
		break;
	case "village_assault":
		precacheString( &"VILLAGE_ASSAULT_INTROSCREEN_LINE_1" );
		precacheString( &"VILLAGE_ASSAULT_INTROSCREEN_LINE_2" );
		precacheString( &"VILLAGE_ASSAULT_INTROSCREEN_LINE_3" );
		precacheString( &"VILLAGE_ASSAULT_INTROSCREEN_LINE_4" );
		precacheString( &"VILLAGE_ASSAULT_INTROSCREEN_LINE_5" );
		introscreen_delay(&"VILLAGE_ASSAULT_INTROSCREEN_LINE_1", &"VILLAGE_ASSAULT_INTROSCREEN_LINE_2", &"VILLAGE_ASSAULT_INTROSCREEN_LINE_3", &"VILLAGE_ASSAULT_INTROSCREEN_LINE_4", 0.2, 0.2, 0.2);
		break;
	case "village_defend":
		precacheString( &"VILLAGE_DEFEND_INTROSCREEN_LINE_1" );
		precacheString( &"VILLAGE_DEFEND_INTROSCREEN_LINE_2" );
		precacheString( &"VILLAGE_DEFEND_INTROSCREEN_LINE_3" );
		precacheString( &"VILLAGE_DEFEND_INTROSCREEN_LINE_4" );
		introscreen_delay(&"VILLAGE_DEFEND_INTROSCREEN_LINE_1", &"VILLAGE_DEFEND_INTROSCREEN_LINE_2", &"VILLAGE_DEFEND_INTROSCREEN_LINE_3", &"VILLAGE_DEFEND_INTROSCREEN_LINE_4", 0.2, 0.2, 0.2);
		break;
	case "cargoship":
		precacheString(&"INTROSCREEN_TITLE");
		precacheString(&"INTROSCREEN_PLACE");
		precacheString(&"INTROSCREEN_DATE");
		precacheString(&"INTROSCREEN_INFO");
		introscreen_delay(&"INTROSCREEN_TITLE", &"INTROSCREEN_PLACE", &"INTROSCREEN_DATE", &"INTROSCREEN_INFO", 2, 3, 3);
		break;
	case "launchfacility_a":
		precacheString(&"INTROSCREEN_TITLE");
		precacheString(&"INTROSCREEN_PLACE");
		precacheString(&"INTROSCREEN_DATE");
		precacheString(&"INTROSCREEN_INFO");
		introscreen_delay(&"INTROSCREEN_TITLE", &"INTROSCREEN_PLACE", &"INTROSCREEN_DATE", &"INTROSCREEN_INFO", 2, 3, 3);
		break;
	case "airlift":
		precacheString(&"INTROSCREEN_TITLE");
		precacheString(&"INTROSCREEN_PLACE");
		precacheString(&"INTROSCREEN_DATE");
		precacheString(&"INTROSCREEN_INFO");
		introscreen_delay(&"INTROSCREEN_TITLE", &"INTROSCREEN_PLACE", &"INTROSCREEN_DATE", &"INTROSCREEN_INFO", 2, 3, 3);
		break;
	case "icbm":
		break;
	case "scoutsniper":
		introscreen_delay(&"INTROSCREEN_TITLE", &"INTROSCREEN_PLACE", &"INTROSCREEN_DATE", &"INTROSCREEN_INFO", 2, 3, 3);
		break;
	case "example":
		/*
		precacheString(&"INTROSCREEN_EXAMPLE_TITLE");
		precacheString(&"INTROSCREEN_EXAMPLE_PLACE");
		precacheString(&"INTROSCREEN_EXAMPLE_DATE");
		precacheString(&"INTROSCREEN_EXAMPLE_INFO");
		introscreen_delay(&"INTROSCREEN_EXAMPLE_TITLE", &"INTROSCREEN_EXAMPLE_PLACE", &"INTROSCREEN_EXAMPLE_DATE", &"INTROSCREEN_EXAMPLE_INFO");
		*/
		break;
	case "bridge":
		thread flying_intro();
		break;
	default:
		// Shouldn't do a notify without a wait statement before it, or bad things can happen when loading a save game.
		wait 0.05; 
		level notify("finished final intro screen fadein");
		wait 0.05; 
		level notify("starting final intro screen fadeout");
		wait 0.05; 
		level notify("controls_active"); // Notify when player controls have been restored
		wait 0.05; 
		flag_set("introscreen_complete"); // Do final notify when player controls have been restored
		break;
	}
}

introscreen_feed_lines( lines )
{
	//get array keys returns the keys in reverse order
	keys = getarraykeys( lines );
	keys = maps\_utility::array_reverse( keys );
	
	for ( i=0; i < keys.size; i++ )
	{
		key = keys[ i ];
		interval = 1;
		time = ( i * interval ) + 1;
		delayThread( time, ::introscreen_corner_line, lines[ key ], ( lines.size - i - 1 ), interval, key );
	}	
}

introscreen_generic_black_fade_in( time )
{
	introblack = newHudElem();
	introblack.x = 0;
	introblack.y = 0;
	introblack.horzAlign = "fullscreen";
	introblack.vertAlign = "fullscreen";
	introblack.foreground = true;
	introblack setShader("black", 640, 480);

	wait time;
	
	// Fade out black
	introblack fadeOverTime(1.5); 
	introblack.alpha = 0;
}

introscreen_create_line(string)
{
	index = level.introstring.size;
	yPos = (index * 30);
	
	if (level.console)
		yPos -= 60;
	
	level.introstring[index] = newHudElem();
	level.introstring[index].x = 0;
	level.introstring[index].y = yPos;
	level.introstring[index].alignX = "center";
	level.introstring[index].alignY = "middle";
	level.introstring[index].horzAlign= "center";
	level.introstring[index].vertAlign = "middle";
	level.introstring[index].sort = 1; // force to draw after the background
	level.introstring[index].foreground = true;
	level.introstring[index].fontScale = 1.75;
	level.introstring[index] setText(string);
	level.introstring[index].alpha = 0;
	level.introstring[index] fadeOverTime(1.2); 
	level.introstring[index].alpha = 1;
}

introscreen_fadeOutText()
{
	for(i = 0; i < level.introstring.size; i++)
	{
		level.introstring[i] fadeOverTime(1.5);
		level.introstring[i].alpha = 0;
	}

	wait 1.5;

	for(i = 0; i < level.introstring.size; i++)
		level.introstring[i] destroy();
}

introscreen_delay(string1, string2, string3, string4, pausetime1, pausetime2, timebeforefade)
{
	/#
	//Chaotically wait until the frame ends twice because handle_starts waits for one frame end so that script gets to init vars
	//and this needs to wait for handle_starts to finish so that the level.start_point gets set.
	waittillframeend; 
	waittillframeend; 
	
	skipIntro = level.start_point != "default";
	if ( getdvar( "introscreen" ) == "0" )
		skipIntro = true;
		
	if ( skipIntro )
	{
		waittillframeend;
		level notify("finished final intro screen fadein");
		waittillframeend;
		level notify ("starting final intro screen fadeout");
		waittillframeend;
		level notify("controls_active"); // Notify when player controls have been restored
		waittillframeend;
		flag_set("introscreen_complete"); // Do final notify when player controls have been restored
		flag_set( "pullup_weapon" );
		return;
	}
	#/
	
	if ( flying_intro() )
		return;
	
	if ( level.script == "ac130" )
	{
		ac130_intro();
		return;
	}
	
	if ( level.script == "cargoship" )
	{
		cargoship_intro();
		return;
	}
	if ( level.script == "village_assault" )
	{
		village_assault_intro();
		return;
	}
	if ( level.script == "launchfacility_a" )
	{
		launchfacility_a_intro();
		return;
	}	
	if ( level.script == "airlift" )
	{
		airlift_intro();
		return;
	}
	if ( level.script == "village_defend" )
	{
		village_defend_intro();
		return;
	}
	if ( level.script == "scoutsniper" )
	{
		scoutsniper_intro();
		return;
	}
	
	level.introblack = newHudElem();
	level.introblack.x = 0;
	level.introblack.y = 0;
	level.introblack.horzAlign = "fullscreen";
	level.introblack.vertAlign = "fullscreen";
	level.introblack.foreground = true;
	level.introblack setShader("black", 640, 480);

	level.player freezeControls(true);
	wait .05;

	level.introstring = [];
	
	//Title of level
	
	if(isdefined(string1))
		introscreen_create_line(string1);
	
	if(isdefined(pausetime1))
	{
		wait pausetime1;
	}
	else
	{
		wait 2;	
	}
	
	//City, Country, Date
	
	if(isdefined(string2))
		introscreen_create_line(string2);
	if(isdefined(string3))
		introscreen_create_line(string3);
	
	//Optional Detailed Statement
	
	if(isdefined(string4))
	{
		if(isdefined(pausetime2))
		{
			wait pausetime2;
		}
		else
		{
			wait 2;
		}
	}
	
	if(isdefined(string4))
		introscreen_create_line(string4);
	
	//if(isdefined(string5))
		//introscreen_create_line(string5);
	
	level notify("finished final intro screen fadein");
	
	if(isdefined(timebeforefade))
	{
		wait timebeforefade;
	}
	else
	{
		wait 3;
	}

	// Fade out black
	level.introblack fadeOverTime(1.5); 
	level.introblack.alpha = 0;

	level notify ("starting final intro screen fadeout");

	// Restore player controls part way through the fade in
	level.player freezeControls(false);
	level notify("controls_active"); // Notify when player controls have been restored

	// Fade out text
	introscreen_fadeOutText();

	flag_set("introscreen_complete"); // Notify when complete
}

_CornerLineThread( string, size, interval, index_key )
{
	level notify("new_introscreen_element");
	
	if( !isdefined( level.intro_offset ) )
		level.intro_offset = 0;
	else
		level.intro_offset++;
		
	y = _CornerLineThread_height();
	
	hudelem = newHudElem();
	hudelem.x = 20;
	hudelem.y = y;
	hudelem.alignX = "left";
	hudelem.alignY = "bottom";
	hudelem.horzAlign= "left";
	hudelem.vertAlign = "bottom";
	hudelem.sort = 1; // force to draw after the background
	hudelem.foreground = true;
	hudelem setText( string );
	hudelem.alpha = 0;
	hudelem fadeOverTime( 0.2 ); 
	hudelem.alpha = 1;

	hudelem.hidewheninmenu = true;
	hudelem.fontScale = 1.6;
	hudelem.color = (0.8, 1.0, 0.8);
	hudelem.font = "objective";
	hudelem.glowColor = (0.3, 0.6, 0.3);
	hudelem.glowAlpha = 1;
	duration = int((size * interval * 1000) + 4000);
	hudelem SetPulseFX( 30, duration, 700 );//something, decay start, decay duration

	thread hudelem_destroy( hudelem );
	
	if( !isdefined( index_key ) ) 
		return;
	if( !isstring( index_key ) )
		return;
	if( index_key != "date" )
		return;
}


_CornerLineThread_height()
{
	//return ( ( ( pos ) * 19 ) - 10 );
	return ( ( ( level.intro_offset ) * 19 ) - 82 );
}

introscreen_corner_line( string, size, interval, index_key )
{
	thread _CornerLineThread( string, size, interval, index_key );
}


hudelem_destroy( hudelem )
{
	wait 16; //amount of time for print to teletype out
	hudelem notify( "destroying" );
	level.intro_offset = undefined;

	time = .5;
	hudelem fadeOverTime( time ); 
	hudelem.alpha = 0;
	wait time;
	hudelem notify( "destroy" );
	hudelem destroy();
}


cargoship_intro_dvars()
{
	wait( 0.05 );
	setsaveddvar( "compass", 0 );
	SetSavedDvar( "ammoCounterHide", "1" );	
	SetSavedDvar( "hud_showStance", 0 );
}

cargoship_intro()
{
	thread cargoship_intro_dvars();
	
	level.player freezeControls(true);
	
	lines = [];
	lines[ lines.size ] = "'Crew Expendable'";
	lines[ "date" ] 	= "Day 01 - 01:23:[{FAKE_INTRO_SECONDS:32}]";
	lines[ lines.size ] = "Somewhere on the Barents Sea";
	lines[ lines.size ] = "Sgt. John 'Soap' MacTavish";
	lines[ lines.size ] = "22nd SAS Regiment";

	introscreen_feed_lines( lines );
	introscreen_generic_black_fade_in( 2 );
	
	wait( 1 );
	 // Do final notify when player controls have been restored
	level.player freezeControls( false );
	
	level notify("introscreen_complete");
	level.player freezeControls( false );
}

village_assault_intro()
{
	level.player freezeControls(true);
	
	lines = [];
	lines[ lines.size ] = &"VILLAGE_ASSAULT_INTROSCREEN_LINE_1";
	//lines[ "date" ] 	= &"VILLAGE_ASSAULT_INTROSCREEN_LINE_2";
	lines[ "date" ] 	= "Day 04 ? 02:00:[{FAKE_INTRO_SECONDS:32}]";
	lines[ lines.size ] = &"VILLAGE_ASSAULT_INTROSCREEN_LINE_3";
	lines[ lines.size ] = &"VILLAGE_ASSAULT_INTROSCREEN_LINE_4";
	lines[ lines.size ] = &"VILLAGE_ASSAULT_INTROSCREEN_LINE_5";

	introscreen_feed_lines( lines );
	introscreen_generic_black_fade_in( 2 );
	
	wait( 1 );
	 // Do final notify when player controls have been restored
	level.player freezeControls( false );
	
	level notify("introscreen_complete");
	level.player freezeControls( false );
}

launchfacility_a_intro_dvars()
{
	wait( 0.05 );
	setsaveddvar( "compass", 0 );
	SetSavedDvar( "ammoCounterHide", "1" );	
}

launchfacility_a_intro()
{
	thread launchfacility_a_intro_dvars();
	
	level.player freezeControls(true);
	
	lines = [];
	lines[ lines.size ] = "'All In'";
	lines[ "date" ] 	= "Day 06 ? 07:16:[{FAKE_INTRO_SECONDS:11}]";
	lines[ lines.size ] = "Altay Mountains, Russia";
	lines[ lines.size ] = "Sgt. John 'Soap' MacTavish";
	lines[ lines.size ] = "22nd SAS Regiment";

	introscreen_feed_lines( lines );
	introscreen_generic_black_fade_in( 1 );

	wait( 1 );
	 // Do final notify when player controls have been restored
	level.player freezeControls( false );
	
	level notify("introscreen_complete");
	level.player freezeControls( false );
}

airlift_intro_dvars()
{
	wait( 0.05 );
	setsaveddvar( "compass", 0 );
	SetSavedDvar( "ammoCounterHide", "1" );	
}

airlift_intro()
{
	thread airlift_intro_dvars();
	
	level.player freezeControls(true);
	
	lines = [];
	lines[ lines.size ] = "'Shock and Awe'";
	lines[ "date" ] 	= "Day 03 ? 18:00:[{FAKE_INTRO_SECONDS:02}]";
	lines[ lines.size ] = "SSgt. Paul Jackson";
	lines[ lines.size ] = "1st Bn., 7th Marine Regiment";

	introscreen_feed_lines( lines );
	introscreen_generic_black_fade_in( 3 );

	wait( 1 );
	 // Do final notify when player controls have been restored
	level.player freezeControls( false );
	
	level notify("introscreen_complete");
	level.player freezeControls( false );
}

village_defend_intro_dvars()
{
	wait( 0.05 );
	setsaveddvar( "compass", 0 );
	SetSavedDvar( "ammoCounterHide", "1" );	
}

village_defend_intro()
{
	thread village_defend_intro_dvars();
	
	level.player freezeControls(true);
	
	lines = [];
	lines[ lines.size ] = "The Village";
	lines[ "date" ] 	= "Day 04 - 09:40:[{FAKE_INTRO_SECONDS:17}]";
	lines[ lines.size ] = "Northern Azerbaijan";
	lines[ lines.size ] = "Sgt. John 'Soap' MacTavish";
	lines[ lines.size ] = "22nd SAS Regiment";

	introscreen_feed_lines( lines );
	introscreen_generic_black_fade_in( 3 );
	
	setsaveddvar( "compass", 1 );
	SetSavedDvar( "ammoCounterHide", "0" );
	SetSavedDvar( "hud_showStance", 1 );

	wait( 1 );
	 // Do final notify when player controls have been restored
	level.player freezeControls( false );
	
	level notify("introscreen_complete");
	level.player freezeControls( false );
}

scoutsniper_intro()
{
	thread scoutsniperIntroDvars();
	thread scoutsniperIntroPlayer();

	set_vision_set( "grayscale" );
	
	introblack = newHudElem();
	introblack.x = 0;
	introblack.y = 0;
	introblack.horzAlign = "fullscreen";
	introblack.vertAlign = "fullscreen";
	introblack.foreground = true;
	introblack setShader("black", 640, 480);

	wait .25;

	introtime = newHudElem();
	introtime.x = 0;
	introtime.y = 0;
	introtime.alignX = "center";
	introtime.alignY = "middle";
	introtime.horzAlign = "center";
	introtime.vertAlign = "middle";
	introtime.sort = 1;
	introtime.foreground = true;
	introtime setText( "15 years ago" );
	introtime.fontScale = 1.6;
	introtime.color = (0.8, 1.0, 0.8);
	introtime.font = "objective";
	introtime.glowColor = (0.3, 0.6, 0.3);
	introtime.glowAlpha = 1;
	introtime SetPulseFX( 30, 2000, 700 );//something, decay start, decay duration

	wait 2;

	lines = [];
	lines[ lines.size ] = "'All Ghillied Up'";
	lines[ lines.size ] = "Pripyat, Ukraine";
	lines[ lines.size ] = "Lt. Price";
	lines[ lines.size ] = "22nd SAS Regiment";

	introscreen_feed_lines( lines );
		
	wait 1;
	
	// Fade out black
	introblack fadeOverTime(1.5); 
	introblack.alpha = 0;

	wait 5.5;
	
	set_vision_set( "scoutsniper", 2 );

	wait( 3.5 );
	 // Do final notify when player controls have been restored	
	level notify("introscreen_complete");
	level.player freezeControls( false );
	
	wait( .5 );
	
	setsaveddvar( "compass", 1 );
	SetSavedDvar( "ammoCounterHide", "0" );
	SetSavedDvar( "hud_showStance", 1 );
}

scoutsniperIntroPlayer()
{
	ang = level.player getplayerangles();
	wait 1;
	level.player setstance("crouch");
	level.player freezeControls(true);
	level.player setplayerangles(ang);
}

scoutsniperIntroDvars()
{
	wait( 0.05 );
	setsaveddvar( "compass", 0 );
	SetSavedDvar( "ammoCounterHide", "1" );	
	SetSavedDvar( "hud_showStance", 0 );
}

bog_intro_sound()
{
	wait( 0.05 );
	level.player playsound( "ui_camera_whoosh_in" );
	setsaveddvar( "compass", 0 );
	SetSavedDvar( "ammoCounterHide", "1" );
}

flying_intro()
{
	flying_levels = [];
	flying_levels[ "bog_a" ] = true;
	flying_levels[ "bog_b" ] = true;
	flying_levels[ "blackout" ] = true;
	
	if ( !isdefined( flying_levels[ level.script ] ) )
		return false;
	thread bog_intro_sound();
	
	level.player freezeControls( true );
	
	zoomHeight = 16000;
	
	lines = [];
	if ( level.script == "bog_a" )
	{
		cinematicingame("fade_bog_a");
		lines[ lines.size ] = "The Bog";
		lines[ "date" ] 	= "Day 03 - 05:00:[{FAKE_INTRO_SECONDS:11}]";
		lines[ lines.size ] = "SSgt. Paul Jackson";
		lines[ lines.size ] = "1st Force Recon Co., U.S.M.C.";
	}
	else if ( level.script == "bog_b" )
	{
		cinematicingame("fade_bog_b");
		lines[ lines.size ] = &"BOG_B_INTROSCREEN_LINE_1";	//"War Pig"
		lines[ "date" ] 	= &"BOG_B_INTROSCREEN_LINE_2";	//"Day 3 ? 1630 hrs"
		lines[ lines.size ] = &"BOG_B_INTROSCREEN_LINE_3";	//"Sgt. Paul Jackson"
		lines[ lines.size ] = &"BOG_B_INTROSCREEN_LINE_4";	//"1st Bn, 7th Marine Regiment"
		zoomHeight = 6500;
	}
	else if ( level.script == "blackout" )
	{
		cinematicingame("fade_bog_a");
		lines[ lines.size ] = "Northeast Azerbaijan";
		lines[ "date" ] 	= "Day 01 - 03:11:[{FAKE_INTRO_SECONDS:22}]";
		lines[ lines.size ] = "SSgt. British Carver Guy";
	}
	
	introscreen_feed_lines( lines );

	origin = level.player.origin;
	level.player.origin = origin + ( 0, 0, zoomHeight );
	ent = spawn( "script_model", (69,69,69) );
	ent.origin = level.player.origin;
	
	ent setmodel( "tag_origin" );
	ent.angles = level.player.angles;
	level.player linkto( ent );
	ent.angles = ( ent.angles[ 0 ] + 89, ent.angles[ 1 ], 0 );
	
	ent moveto ( origin + (0,0,0), 2, 0, 2 );
	wait ( 1.5 );
	ent rotateto( ( ent.angles[ 0 ] - 89, ent.angles[ 1 ], 0 ), 0.5, 0.3, 0.2 );
	wait ( 0.5 );
	flag_set( "pullup_weapon" );

	wait( 0.2 );
	level.player unlink();
	level.player freezeControls( false );
	
	thread play_sound_in_space( "ui_screen_trans_in", level.player.origin );
	
	wait( 0.2 );
	
	thread play_sound_in_space( "ui_screen_trans_out", level.player.origin );
	
	wait( 0.2 );
	
	level notify("introscreen_complete"); // Do final notify when player controls have been restored
		
	wait( 2 );
	
	setsaveddvar( "compass", 1 );
	SetSavedDvar( "ammoCounterHide", "0" );
	
	ent delete();
	
	autosave_by_name( "levelstart" );
	return true;
}

ac130_intro()
{
	level.player freezeControls(true);
	
	lines = [];
	lines[ lines.size ] = &"AC130_INTROSCREEN_LINE_1";	//"Death From Above"
	lines[ lines.size ] = &"AC130_INTROSCREEN_LINE_2";	//"Chechnya"
	//lines[ "date" ] 	= &"AC130_INTROSCREEN_LINE_3";	//"2200 Hours"
	lines[ "date" ] 	= "22:00:[{FAKE_INTRO_SECONDS:32}]";
	lines[ lines.size ] = &"AC130_INTROSCREEN_LINE_4";	//"Aboard an AC-130 Spectre Gunship"
	
	introscreen_feed_lines( lines );
	
	introblack = newHudElem();
	introblack.x = 0;
	introblack.y = 0;
	introblack.horzAlign = "fullscreen";
	introblack.vertAlign = "fullscreen";
	introblack.sort = 1000;
	introblack setShader("black", 640, 480);

	wait 9.5;
	
	level notify( "introscreen_almost_complete" );
	
	wait 1.5;
	
	// Fade out black
	introblack fadeOverTime(1.5); 
	introblack.alpha = 0;

	wait( 1 );
	level.player freezeControls( false );
	
	level notify( "introscreen_complete" );
	
	level.player freezeControls( false );
}
