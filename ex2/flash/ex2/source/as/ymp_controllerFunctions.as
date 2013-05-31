
function playPauseToggle(withThisSong)
{
	//trace("start playPauseToggle in ymp_controllerFunctions");
	//var songOffset:Number = _root.audioTally - sequence.length + ogOffset;
	//trace("!songOffset:"+_root.songOffset+" = "+_root.audioTally + " - " + _root.sequence.length);
	
	//trace("**************");
	//trace(_root.currentSlide + ", playPauseToggle("+withThisSong+") + "+sequence[useThisSlide-1].ymp_param_hasaudio);
	
//	if(sequence[Number(_root.currentSlide-2 + songOffset - 1)].ymp_param_hasaudio == "true")
	//{
	//	if(sequence[useThisSlide-1].ymp_param_hasaudio)
		//{
			curPlay = withThisSong;
	
			if(_root.controller_mc.playPause._currentframe == 1)
			{
				_root.pauseIt();
				_root.controller_mc.playPause.gotoAndStop(20);
			} 
			else if(_root.controller_mc.playPause._currentframe == 20)
			{
	//			_root.playSong(_root.currentSlide-1);
				_root.unPauseIt();
				_root.controller_mc.playPause.gotoAndStop(1);
	//			_root.playSong(songOffset + curPlay);
			}
		//}
//	}
	//trace("finish playPauseToggle in ymp_controllerFunctions");
}


//_root.controller_mc.nextBtn.onPress = function(){
function playNext()
{
	//trace("start playNext in ymp_controllerFunctions");
	if (currentSlide < 1)
	{
		_root.currentSlide = 0;
		currentSlide++;
		_root.controller_mc.prevBtn._alpha = 100;

		if (mode == "imgMode")
		{
			// "jpeg slide show"
			hideThisSlide();
		} 
		else 
		{
			// vector layering
		}
		
		//trace("1st.playNext()!"+Number(currentSlide));


		_root.superPlay = 1;
//		playPauseToggle(Number(currentSlide-2));
		currentSlide++;
		update();
		//currentSlide--;

		if(sequence[currentSlide].ymp_param_hasaudio and _root.audiobox)
		{
			_root.playSong(_root.currentSlide-1);
		}
		if(_root.controller_mc.playPause._currentframe == 20)
		{
			_root.controller_mc.playPause.gotoAndStop(1);
		}			
	
	} 
	else if (currentSlide == sequence.length)
	{

	} 
	else 
	{
		_root.controller_mc.prevBtn._alpha = 100;

		if (mode == "imgMode")
		{
			// "jpeg slide show"
			hideThisSlide();
		} 
		else 
		{
			// vector layering
		}

		//trace("playNext()!"+Number(currentSlide));

		_root.superPlay = 1;
		currentSlide++;
//		playPauseToggle(Number(currentSlide));
		update();
		//currentSlide--;
		if(sequence[currentSlide-1].ymp_param_hasaudio)
		{
			_root.playSong(_root.currentSlide-1);
		}
		if(_root.controller_mc.playPause._currentframe == 20)
		{
			_root.controller_mc.playPause.gotoAndStop(1);
		}			
	}
	//trace("finish playNext in ymp_controllerFunctions");
}


//_root.controller_mc.prevBtn.onPress = function(){
function playPrev()
{
	//trace("start playPrev in ymp_controllerFunctions");
	var songOffset:Number = _root.audioTally - sequence.length;
	
	//trace("PREV!!!");

	if(Number(currentSlide-1) > -1)
	{
		hideThisSlide();
		currentSlide--;
		update();

		if(sequence[currentSlide-1].ymp_param_hasaudio)
		{
			_root.playSong(_root.currentSlide-1);
		}
		if(_root.controller_mc.playPause._currentframe == 20)
		{
			_root.controller_mc.playPause.gotoAndStop(1);
		}			
		if(_root.currentSlide < 2)
		{
			_root.controller_mc.playPause.gotoAndStop(20);
		}
	}
	//trace("finish playPrev in ymp_controllerFunctions");
}

