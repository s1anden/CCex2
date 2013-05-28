function init()
{
	//trace("start init in ymp_functions");

	preloadSlides = true;
	
	//under review mode, the id number of the picture selected
	_root.pic_index = -1;

	if(_root.audioTally)
	{
		_root.audiobox = true;
		_root.textbox = false;
		_root.my_sp2._visible = true;
		_root.my_sp._visible = false;
	}
	else
	{
		_root.audiobox = false;
		_root.textbox = true;
		_root.my_sp._visible = true;
		_root.my_sp2._visible = false;
	}
	
	//under review mode, if a picture was clicked
	_root.pressed = false;
	//review mode was clicked or not
	_root.clicked = false;
	
	_root.ymp_txtbox._visible = false;

	lastSlide = 0;
	_root.currentSlide = 0;


	//recVarSlideCntr = -2;


	//curState = _root.currentSlide + " of " + _root.sequence.length;
	//trace("IN INIT       " + curState);
	preloadSlides = false;


	if (mode == "imgMode")
	{
		// "jpeg slide show"
	} 
	else 
	{
		// vector layering
		_root.my_sp.spContentHolder.imgMasked.holder_0000._visible = false;
		_root.my_sp2.spContentHolder.imgMasked.holder_0000._visible = false;
	}

	//doTxt();
	//stop();
	//trace("finish init in ymp_functions");
}


function update()
{
	//trace("start update in ymp_functions");

	if (preloadSlides == false)
	{
		showThisSlide();
	}

/*	if ((_root.recording) && (recVarSlideCntr eq -1))
	{
		//dumb trap
	} */
	else 
	{
		if(_root.currentSlide eq 1)
		{
			_root.controller_mc.prevBtn._alpha = 50;
			_root.controller_mc.nextBtn._alpha = 100;

			//trace("reset!");
			_root.currentSlide = -2;
			_root.songOffset = 0;
			_root.cps = -1;
			_root.thisSong = 0;
			//	_root.controller_mc.playPause.gotoAndStop("play");
		}
		else if((_root.currentSlide) eq _root.sequence.length)
		{
			_root.controller_mc.prevBtn._alpha = 100;
			_root.controller_mc.nextBtn._alpha = 50;
		}
		else 
		{
			_root.controller_mc.prevBtn._alpha = 100;
			_root.controller_mc.nextBtn._alpha = 100;
		}

		stopAllSounds();
	}

	//scrolls down
	_root.my_sp.onComplete();
	_root.my_sp.vPosition = _root.my_sp.maxVPosition;

	_root.my_sp2.onComplete();
	_root.my_sp2.vPosition = _root.my_sp2.maxVPosition;

}


function timeme ()
{
	//trace("start timeme in ymp_functions");
	now = new Date();
	var hours = now.getHours();
	var minutes = now.getMinutes();
	var seconds = now.getSeconds();
	_root["nowtime"+i] = (Number(hours)*3600)+(Number(minutes)*60)+seconds;
	_root.newstarttime = _root["nowtime"+i] - _root.nowtime1;
	i++;
	//trace("finish timeme in ymp_functions");
}


function getSlide(thisSlide) 
{
	//trace("start getSlide in ymp_functions");
	var slide = thisSlide;
	//trace("finish getSlide in ymp_functions");
	return _root.sequence[slide].s;
}


function getTC(thisTC) 
{
	//trace("start getTC in ymp_functions");
	var TC = thisTC;
	//trace("finish getTC in ymp_functions");
	return _root.sequence[TC].tc;
}


function createSlides(ymp_seq)
{
	//trace("start createSlides in ymp_functions");
	for (i=1; i < ymp_seq + 1; i++)
	{
		holderNumPrefix = getPrefix(i);
		
		holderInstance = i;

		thisHolder = "holder_"+holderNumPrefix+holderInstance;

		if (mode == "imgMode")
		{
			// "jpeg slide show"
			duplicateMovieClip(_root.my_sp.spContentHolder.imgMasked.holder_0000, thisHolder, holderInstance);
			duplicateMovieClip(_root.my_sp2.spContentHolder.imgMasked.holder_0000, thisHolder, holderInstance);
			
		} 
		else 
		{

			// vector layering
			
			if (!useThisSlide)
			{
				useThisSlide = _root.currentSlide;
			}
			if (!sequence[useThisSlide].ymp_param_istitle)
			{
				duplicateMovieClip(_root.my_sp.spContentHolder.vectored.holder_0000, thisHolder, holderInstance);
				duplicateMovieClip(_root.my_sp2.spContentHolder.vectored.holder_0000, thisHolder, holderInstance);
				
				//_root.my_sp.spContentHolder.vectored[thisHolder]._alpha = 0;
				
				//trace("CREATED (v): "+_root.my_sp.spContentHolder.vectored[thisHolder]._name);

			} 
			else 
			{
				// create title flashText
				//_root.my_sp.spContentHolder.vectored[thisHolder].myTitleText = "hello world";
				duplicateMovieClip(_root.my_sp.spContentHolder.vectored.titleTextMc, thisHolder, Int(1000-holderInstance));
				duplicateMovieClip(_root.my_sp2.spContentHolder.vectored.titleTextMc, thisHolder, Int(1000-holderInstance));
		
				//trace("CREATED (t): "+_root.my_sp.spContentHolder.vectored[thisHolder]._name);
				_root.my_sp.spContentHolder.vectored[thisHolder].myTitleText = sequence[useThisSlide].ymp_title;
				_root.my_sp.spContentHolder.vectored[thisHolder].imaTitle = true;
				_root.my_sp.spContentHolder.vectored[thisHolder]._alpha = 100;

				//_root.my_sp.spContentHolder.vectored[thisHolder]._alpha = 100;
				_root.my_sp.spContentHolder.vectored[thisHolder]._alpha = 0;
				_root.my_sp.spContentHolder.vectored[thisHolder]._visible = false;
				
				_root.my_sp2.spContentHolder.vectored[thisHolder].myTitleText = sequence[useThisSlide].ymp_title;
				_root.my_sp2.spContentHolder.vectored[thisHolder].imaTitle = true;
				_root.my_sp2.spContentHolder.vectored[thisHolder]._alpha = 100;

				//_root.my_sp2.spContentHolder.vectored[thisHolder]._alpha = 100;
				_root.my_sp2.spContentHolder.vectored[thisHolder]._alpha = 0;
				_root.my_sp2.spContentHolder.vectored[thisHolder]._visible = false;

				currentSlide++;
				update();
				currentSlide--;

			}
			
		}
			
		//trace("%"+sequence[useThisSlide].ymp_title);
		loadThisSlide(_root.sequence[i-1].s, i);
	}
	//preloadSound(1);
	//_root.sndIntervalID = setInterval(preloadSound(1), 50);
	
	//trace("finish createSlides in ymp_functions");
}


function loadThisSlide(specificNum, thisCounter)
{
	//trace("start loadThisSlide in ymp_functions");
	if (!thisCounter)
	{
		useThisSlide = _root.currentSlide;
		//trace("no thisCounter!--> "+useThisSlide);
	}
	else 
	{
		useThisSlide = thisCounter;
		//trace("thisHolder:"+useThisSlide+" ... for xmlItem:"+int(sequence[useThisSlide-1].s));
	}

	holderNumPrefix = getPrefix(int(sequence[useThisSlide - 1].s));

	loadNumPrefix = getPrefix(useThisSlide);

	thisHolder = loadNumPrefix+(useThisSlide);


	loadThisImg = + root + "/" + imgPrefixTxt + holderNumPrefix + int(sequence[useThisSlide-1].s) + imgSuffixTxt;


	if (!sequence[useThisSlide-1].ymp_param_istitle)
	{

		//trace("loading ("+loadThisImg+") for "+thisHolder +"\n");
	
		if (mode == "imgMode")
		{
			// "jpeg slide show"
			if (_root.my_sp.spContentHolder.imgMasked["holder_"+thisHolder].slideLoaded != true)
			{
				loader.loadClip(loadThisImg, _root.my_sp.spContentHolder.imgMasked["holder_"+thisHolder]);
			}
			if (_root.my_sp2.spContentHolder.imgMasked["holder_"+thisHolder].slideLoaded != true)
			{
				loader.loadClip(loadThisImg, _root.my_sp2.spContentHolder.imgMasked["holder_"+thisHolder]);
			}
		}
		else
		{
				// vector layering

			if (_root.my_sp.spContentHolder.vectored["holder_"+thisHolder].slideLoaded != true)
			{
				_root.my_sp.spContentHolder.vectored["holder_"+thisHolder]._alpha = 0;
				loader.loadClip(loadThisImg, _root.my_sp.spContentHolder.vectored["holder_"+thisHolder]);
			}
			if (_root.my_sp2.spContentHolder.vectored["holder_"+thisHolder].slideLoaded != true)
			{
				_root.my_sp2.spContentHolder.vectored["holder_"+thisHolder]._alpha = 0;
				loader.loadClip(loadThisImg, _root.my_sp2.spContentHolder.vectored["holder_"+thisHolder]);
			}
		}
	} 
	
	if(sequence[useThisSlide-1].ymp_param_hasaudio)
	{
		loadThisSnd = + root + "/" + imgPrefixTxt + holderNumPrefix + int(sequence[useThisSlide-1].s) + sndSuffixTxt;

		_root.sndLoadList[int(sequence[useThisSlide-1].s)] = loadThisSnd;

		sa.push(new Song(loadThisSnd, "aName", "aTitle"));
		_root.audiobox = true;
		_root.textbox = false;
	}
	else
	{
		_root.audiobox = false;
		_root.textbox = true;
	}
	//trace("finish loadThisSlide in ymp_functions");
}


function showThisSlide(specificNum)
{
	//trace("start showThisSlide in ymp_functions");

	if (_root.currentSlide >= lastSlide)
	{
		//--------------------------------------------------------------------------------------------
		// GOING FORWARD
		//--------------------------------------------------------------------------------------------

		if (!specificNum)
		{
			useThisSlide = _root.currentSlide;
			//trace("useThisSlide: "+ _root.currentSlide);
		}
		else 
		{
			useThisSlide = specificNum;
			//trace("useThisSlide(specificNum): "+ specificNum);
		}
		//trace("useThisSlide: "+ _root.currentSlide);

		holderNumPrefix = getPrefix(useThisSlide - 1);

		if(useThisSlide == 10)
			holderNumPrefix = "00";
		if(useThisSlide == 100)
			holderNumPrefix = "0";
		if(useThisSlide == 1000)
			holderNumPrefix = "";

		thisHolder = "holder_"+holderNumPrefix+useThisSlide;

		//if(_root.clicked)
		//{
			if(_root.sequence[useThisSlide-1].txt.length > 0)
			{
				_root.the_txt = _root.sequence[useThisSlide-1].txt;// +"\n\r";
				_root.ymp_txtbox._visible = _root.textbox;
				doTxt();
			} 
			else 
			{
				//_root.the_txt = "(intentionally blank)";
				_root.the_txt = "";
				_root.ymp_txtbox._visible = false;
			}
		//}
		//else
		//{
			if (mode == "imgMode")
			{
				// "jpeg slide show"
				_root.my_sp.spContentHolder.imgMasked[thisHolder]._visible = true;
				_root.my_sp2.spContentHolder.imgMasked[thisHolder]._visible = true;
			}
			else 
			{
				// vector layering
				_root.my_sp.spContentHolder.vectored[thisHolder]._visible = true;
				_root.my_sp.spContentHolder.vectored[thisHolder]._alpha = 100;
				_root.my_sp2.spContentHolder.vectored[thisHolder]._visible = true;
				_root.my_sp2.spContentHolder.vectored[thisHolder]._alpha = 100;
			}
			//--------------------------------------------------------------------------------------------
			// setup the dTxt
			//--------------------------------------------------------------------------------------------
			
			if(_root.sequence[useThisSlide-1].txt.length > 0)
			{
				_root.the_txt = _root.sequence[useThisSlide-1].txt;// +"\n\r";
				_root.ymp_txtbox._visible = _root.textbox;
				doTxt();
			} 
			else 
			{
				//_root.the_txt = "(intentionally blank)";
				_root.the_txt = "";
				_root.ymp_txtbox._visible = false;
			}
			//--------------------------------------------------------------------------------------------
			// move the dTxt into pos
			//--------------------------------------------------------------------------------------------
			
			if (!sequence[_root.currentSlide - 1].ymp_param_istitle)
			{
				//cliff'd
			}
			//--------------------------------------------------------------------------------------------
			// position this vector holder
			//--------------------------------------------------------------------------------------------
	
			_root.my_sp.spContentHolder.vectored[thisHolder]._x = 
						Number(_root.sequence[useThisSlide-1].xAbsolute) - 40;
			_root.my_sp.spContentHolder.vectored[thisHolder]._y = 
						Number(_root.sequence[useThisSlide-1].yAbsolute) - 30;
			_root.my_sp2.spContentHolder.vectored[thisHolder]._x = 
						Number(_root.sequence[useThisSlide-1].xAbsolute) - 40;
			_root.my_sp2.spContentHolder.vectored[thisHolder]._y = 
						Number(_root.sequence[useThisSlide-1].yAbsolute) - 30;
		//}
	} 
	else 
	{
		//--------------------------------------------------------------------------------------------
		// GOING BACK: save stuff for later reuse
		//--------------------------------------------------------------------------------------------
		holderNumPrefix = getPrefix(useThisSlide - 2);
	}
	lastSlide = currentSlide;

}

function showAllSlide()
{
	for(var i = 1; i < sequenceCounter; i++)
	{
		showThisSlide(i+1);
	}
}

function doTxt()
{
	//trace("start doTxt in ymp_functions");

	_root.ymp_txtbox.sp_window.contentPath = "sp_txtbox";

	if(_root.sequence[useThisSlide-1].txt.length > 0)
	{

		_root.ymp_txtbox.sp_window.spContentHolder.DynTxt = _root.the_txt;
		
		_root.ymp_txtbox.sp_window.spContentHolder.myText = 
				new _root.dynamicTextBox(_root.myCharSet, _root.ymp_txtbox.sp_window.spContentHolder, "DynTxt");
				
		_root.ymp_txtbox.sp_window.spContentHolder.myText.wrap(
				Number(_root.ymp_txtbox.sp_window.spContentHolder.DynBox._width - 27.1));
		
		_root.ymp_txtbox.sp_window.spContentHolder.DynBox._height = _root.ymp_txtbox.sp_window._height;
		
		_root.wrapme = 1;
	}
	
	//trace("finish doTxt in ymp_functions");
}


function scrollForward()
{
	trace("!scrollForward()");
}


function scrollBack()
{
	trace("!scrollBack()");
}


function hideThisSlide(specificNum)
{
	//trace("start hideThisSlide in ymp_functions");
	if (!specificNum)
	{
		useThisSlide = currentSlide;
	} 
	else 
	{
		useThisSlide = specificNum;
	}

	holderNumPrefix = getPrefix(useThisSlide);

	thisHolder = "holder_"+holderNumPrefix+useThisSlide;
if(!_root.clicked)
{
	if (mode == "imgMode")
	{
		// "jpeg slide show"
		_root.my_sp.spContentHolder.imgMasked[thisHolder]._visible = false;
		_root.my_sp2.spContentHolder.imgMasked[thisHolder]._visible = false;
	}
	else 
	{
		// vector layering
		//trace("hideThisSlide:"+thisHolder);
		_root.my_sp.spContentHolder.vectored[thisHolder]._visible = false;
		_root.my_sp.spContentHolder.vectored[thisHolder]._y = 0;
		_root.my_sp2.spContentHolder.vectored[thisHolder]._visible = false;
		_root.my_sp2.spContentHolder.vectored[thisHolder]._y = 0;
	}
}
	
	//--------------------------------------------------------------------------------------------
	// setup the dTxt
	//--------------------------------------------------------------------------------------------
	
	if(_root.sequence[useThisSlide-2].txt.length > 0)
	{
		_root.the_txt = _root.sequence[useThisSlide-2].txt;
		_root.ymp_txtbox._visible = _root.textbox;
		doTxt();
	} 
	else 
	{
		//_root.the_txt = "(intentionally blank)";
		_root.the_txt = "";
		_root.ymp_txtbox._visible = false;
	}
	//trace("finish hideThisSlide in ymp_functions");
}


function hideAllSlides(ymp_seq)
{
	//trace("start hideAllSlides in ymp_functions");
	for (i=1; i<sequenceCounter; i++)
	{
		hideThisSlide(i+1);
	}

	currentSlide = 0;

	if (preloadSlides == false)
	{
		firstTime = false;
	} 

/*	if(twice)
	{
		clearInterval(_root.hider);
	} 
	else 
	{
		twice = true;
	}*/
	//trace("finish hideAllSlides in ymp_functions");

}


function getPrefix( useThisSlide) 
{
	if (useThisSlide < 10)
	{
		return "000";
	} 
	else if (useThisSlide < 100)
	{
		return "00";
	} 
	else if (useThisSlide < 1000)
	{
		return "0";
	} 
	else if (useThisSlide < 10000)
	{
		return "";
	} 
	else 
	{
		return("ERROR IN GETPREFIX");
	}
}


