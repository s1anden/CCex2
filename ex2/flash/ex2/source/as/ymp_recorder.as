_root.ymp_recorder.btn_rec.onPress = function()
{
	trace("start _root.ymp_recorder.btn_rec.onPress");
	_root.recording = true;
	
	
	m = Microphone.get();
	//loading the mic
	attachAudio(m);



	//and attching its output
	// m.setUseEchoSuppression(false);
	//and usin echo suppresion, if available....


	if(!oneTimer)
	{
		hideAllSlides();
		_root.preloadCover._visible = false;
		oneTimer = true;
	}


	hideThisSlide();
	//	currentSlide++;

	if (currentSlide == sequence.length + 1)
	{
		currentSlide = 0;
	}

	if(firstTime != true)
	{
		trace("hit IT!");
	}
	trace("finish _root.ymp_recorder.btn_rec.onPress");
}


function start_rec()
{
	trace("start start_rec in ymp_recorder");
	if(!oneTimer)
	{
		hideAllSlides();
		_root.preloadCover._visible = false;
		oneTimer = true;
	}

	if(!_root.recTiming) 
	{
		if (_root.paused) 
		{
			_root.startTime = getTimer() - _root.elapsedTime;
		} 
		else 
		{
			_root.startTime = getTimer();
		}
		//start timer
		_root.paused = false;
		_root.recTiming = true;
	}

	hideThisSlide();
	//	currentSlide++;

	if (currentSlide == sequence.length + 1)
	{
		currentSlide = 0;
	}

	if(firstTime != true)
	{
		if(!_root.recTiming) 
		{
			_root.startTime = getTimer();
		} 
		else 
		{
			//stop the timer
			_root.recTiming = false;
			//reset the paused variable
			_root.paused = false;
			//reset the display textbox
			_root.timer_txt = "00:00:00:00";
			_root.cue_txt = "00:00:00:00";
		}

		//start timer
		_root.paused = false;
		_root.recTiming = true;

		firstTime = true;


		trace("timer ON!");

	}

	//	update();
	trace("finish start_rec in ymp_recorder");
}


//initial variables
var recTiming:Boolean = false;
var paused:Boolean = false;
var remaining:Number;
var elapsedTime:Number;
var elapsedHours: Number;
var elapsedM:Number;
var elapsedS:Number;
var elapsedH:Number;
var startTime:Number;
var remaining:Number;
var hours:String;
var minutes:String;
var seconds:String;
var hundredths:String;


_root.onEnterFrame = function() 
{
	trace("start _root.onEnterFrame in ymp_recorder");
	if (recTiming) 
	{

		_root.preloadCover._visible = false;

		lastTimeSecs = seconds;

		//calculate values
		elapsedTime = getTimer()-startTime;
		//hours
		elapsedHours = Math.floor(elapsedTime/3600000);
		remaining = elapsedTime-(elapsedHours*3600000);
		//minutes
		elapsedM = Math.floor(remaining/60000);
		remaining = remaining-(elapsedM*60000);
		//seconds
		elapsedS = Math.floor(remaining/1000);
		remaining = remaining-(elapsedS*1000);
		//hundredths
		elapsedH = Math.floor(remaining/10);
		//output to text box
		//add a 0 on the front of the numbers if the number is less than 10
		if (elapsedHours<10) 
		{
			hours = "0"+elapsedHours.toString();
		} 
		else 
		{
			hours = elapsedHours.toString();
		}
		if (elapsedM<10) 
		{
			minutes = "0"+elapsedM.toString();
		} 
		else 
		{
			minutes = elapsedM.toString();
		}
		if (elapsedS<10) 
		{
			seconds = "0"+elapsedS.toString();
		} 
		else 
		{
			seconds = elapsedS.toString();
		}
		if (elapsedH<10) 
		{
			hundredths = "0"+elapsedH.toString();
		} 
		else 
		{
			hundredths = elapsedH.toString();
		}

//		_root.timer_txt = hours+":"+minutes+":"+seconds+":"+hundredths;
		_root.timer_txt = minutes+":"+seconds+":"+hundredths;

		curTimeSecs = seconds;

		if (curTimeSecs != lastTimeSecs)
		{
//			sync(minutes+":"+seconds);
		}
	}
	trace("finish _root.onEnterFrame in ymp_recorder");
};

