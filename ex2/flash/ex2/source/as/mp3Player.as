// Setup sound object
var s:Sound = new Sound();
s.onSoundComplete = playSong;
s.setVolume(100);

// Array of songs
var sa:Array = new Array();
// Currently playing song
var cps:Number = -1;

// Position of music
var pos:Number;


xml.load("songs.xml");
// Play the MP3 File


function nextSong()
{
	//trace("start nextSong in mp3Player");
	_root.controller_mc.playPause.gotoAndStop("play");
	//trace("finish nextSong in mp3Player");
}


function playSong(thisSong):Void 
{
	if(!_root.audiobox)
		return;
	//trace("start playSong in mp3Player");
	_root.soundIsOver = false;
	s = new Sound();

	//s.onSoundComplete = playSong;
	//s.onSoundComplete = playNext();

	s.setVolume(100);
	mute.gotoAndStop("on");

	//trace("thisSong:"+thisSong+", cps:"+cps);

	holderNumPrefix = getPrefix(thisSong);

	if (thisSong > 0)
	{
		//trace("holderNumPrefix :  " + holderNumPrefix);
		s.loadSound(root + "/" + imgPrefixTxt + holderNumPrefix + thisSong + sndSuffixTxt, false);
		//trace("FILE:"+holderNumPrefix + thisSong);
		
	} 
	else 
	{
		if(cps == sa.length - 1)
		{
			cps = 0;
			s.loadSound(sa[cps].earl, false);
		} 
		else 
		{
			s.loadSound(sa[++cps].earl, false);
		}
	
	}

	preloadSound(thisSong+1);
	
	// if the sound loads, play it; if not, trace failure loading
	s.onLoad = function(success:Boolean) 
	{
		if (success) 
		{
			s.start();
		} 
		else 
		{
			trace("mp3Sound failed");
		}
	};

	s.onSoundComplete = function() 
	{
		_root.soundIsOver = true;

		if (_root.superPlay == 1)
		{
			//should it be sequence.length - 1?
			if (currentSlide != sequence.length )
			{
				//trace("aOK2");
				playNext();
			} 
			else 
			{
				//end-of-show
				_root.controller_mc.playPause.gotoAndStop(20);
				pos = 0;
				_root.superPlay = -1;
			}
		} 
		else 
		{
			_root.superPlay = 1;
		}
	};
	//trace("finish playSong in mp3Player");
}


// Pauses the music
function pauseIt():Void 
{
	//trace("start pauseIt in mp3Player");
	pos = s.position;
	s.stop();
	_root.superPlay = 0;
	//trace("finish pauseIt in mp3Player");
}

// Unpauses the music
function unPauseIt():Void 
{
	//trace("start unPauseIt in mp3Player");
	s.start(pos/1000);
	_root.superPlay = 1;
	//trace("finish unPauseIt in mp3Player");
}

