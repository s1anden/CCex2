
_root.ymp_txtbox.sp_window.onPress = function()
{
	return;
}

_root.ymp_txtbox.sp_window.onRelease = function()
{
	return;
}

_root.ymp_txtbox.sp_window.onReleaseOutside = function()
{
	return;
}

_root.ymp_txtbox.Triggers.onPress = function()
{
	return;
}

_root.ymp_txtbox.Triggers.onRelease = function()
{
	return;
}

_root.ymp_txtbox.Triggers.onReleaseOutside = function()
{
	return;
}
_root.ymp_txtbox.onPress = function()
{
	return;
}

_root.ymp_txtbox.onRelease = function()
{
	return;
}

_root.ymp_txtbox.onReleaseOutside = function()
{
	return;
}

/**
 * next three are functions for when the mouse is clicked outside the buttons
 */
_root.controller_mc.controller_bg_mc.onPress = function()
{
	//_root.controller_mc.startDrag(this);
}

_root.controller_mc.controller_bg_mc.onRelease = function()
{
	//_root.controller_mc.stopDrag();
}

_root.controller_mc.controller_bg_mc.onReleaseOutside = function()
{
	//_root.controller_mc.stopDrag();
}

_root.controller_mc1.audio_box.onPress = function()
{
	if(!_root.sequence[2].ymp_param_hasaudio)
	{
		return;
	}
	_root.audiobox = true;
	_root.textbox = false;
		
	_root.ymp_txtbox._visible = _root.textbox;
	
	_root.my_sp2._visible = true;
	_root.my_sp._visible = false;
	
	if(_root.clicked)
	{
		if(_root.pressed)
			_root.playSong(_root.pic_index);
		else
			_root.playSong(1);
	}
	else
		_root.playSong(currentSlide-1);
}

_root.controller_mc1.text_box.onPress = function()
{
	_root.pauseIt();
	_root.audiobox = false;
	_root.textbox = true;

	_root.ymp_txtbox._visible = _root.textbox;
		
	_root.my_sp._visible = true;
	_root.my_sp2._visible = false;

	if(_root.clicked)
	{
		if(_root.pressed)
			showText(_root.pic_index);
		else
			_root.playSong(1);
	}
	else
		showText(currentSlide-1);

}

_root.controller_mc2.lecture_box.onPress = function()
{
	_root.clicked = false;
	_root.pressed = false;
	hideAllSlides(sequenceCounter);	
	
	_root.currentSlide = 1;
	currentSlide = 1;
	_root.pic_index = 1;
	showThisSlide(currentSlide);
	playNext();
}

_root.controller_mc2.review_box.onPress = function()
{
	_root.pauseIt();

	showAllSlide();
	
	_root.my_sp.onComplete();
	_root.my_sp.vPosition = 0
	_root.my_sp2.onComplete();
	_root.my_sp2.vPosition = 0;
	
	if(_root.textbox)
		showText(1);

	_root.clicked = true;
	
	var x_coord = 0;
	var y_coord = 0;
	
	//if the mouse click is inside the scroll pane
	//get the id number of the picture that contains the clicked pixel
	//and load audio or text of that id
	listenerClick = new Object();
	listenerClick.onMouseDown = function()
	{
		if((_xmouse > 0) and (_xmouse < 580))
		{
			if((_ymouse > 63.8) and (_ymouse < 393.2))
			{
				x_coord = (_root._xmouse + 40);
				y_coord = (_root.my_sp._ymouse + _root.my_sp.vPosition + 30);
			}
		}
		
		if(x_coord and y_coord)
		{
			_root.pressed = true;
			Mouse.removeListener(this);
		}
		
		for(var i = 0 ; i < sequenceCounter; i++)
		{
			if((y_coord > Number(_root.sequence[i].yAbsolute)) and 
					(y_coord < Number(_root.sequence[i].yOffset) + Number(_root.sequence[i].yAbsolute)))
			{
				if((x_coord > Number(_root.sequence[i].xAbsolute)) and 
					(x_coord < Number(_root.sequence[i].xOffset) + Number(_root.sequence[i].xAbsolute)))
				{
					//initialize picindex in init
					_root.pic_index = i;
					_root.pressed = true;
					if(!_root.textbox)
					{
						if(_root.sequence[_root.pic_index].ymp_param_hasaudio)
							playSong(_root.pic_index);
					}
					else
					{
						showText(_root.pic_index);
					}
					break;
				}
			}
		}
		Mouse.addListener(this);
		x_coord = 0;
		y_coord = 0;
	}
	Mouse.addListener(listenerClick);
}



_root.controller_mc.nextBtn.onRelease = function()
{
	_root.superPlay = 0;
	playNext();
}

_root.controller_mc.prevBtn.onRelease = function()
{
	_root.superPlay = 0;
	playPrev();
}



_root.controller_mc.playPauseBtn.onRelease = function() 
{
	if(!_root.audiobox)
		return;
	if (_root.superPlay == 0){
		_root.unPauseIt();
	} else if (_root.superPlay == 1){
		_root.pauseIt();
	} else {
		_root.playSong(_root.currentSlide-1);
	}
	playPauseToggle();
}



function showText(pic_index)
{
	if(_root.sequence[pic_index].txt.length > 0)
	{
		_root.the_txt = _root.sequence[pic_index].txt
		_root.ymp_txtbox.sp_window.spContentHolder.DynTxt = _root.the_txt;
		_root.ymp_txtbox.sp_window.spContentHolder.myText = 
			new _root.dynamicTextBox(_root.myCharSet, _root.ymp_txtbox.sp_window.spContentHolder, "DynTxt");
				
		_root.ymp_txtbox.sp_window.spContentHolder.myText.wrap(
				Number(_root.ymp_txtbox.sp_window.spContentHolder.DynBox._width - 27.1));
						
		_root.ymp_txtbox.sp_window.spContentHolder.DynBox._height = _root.ymp_txtbox.sp_window._height;
						
		_root.wrapme = 1;
				
		_root.ymp_txtbox.sp_window.maxVPosition = 150;
	}
}