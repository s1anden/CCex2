//initial variables
var timing:Boolean = false;
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
	if (timing) 
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

//		_root.timer_txt = "<font color=#"+_root.cueFontColorStr+">";
		_root.timer_txt = hours+":"+minutes+":"+seconds+":"+hundredths;
//		_root.timer_txt += "</font>";

		curTimeSecs = seconds;

		if (curTimeSecs != lastTimeSecs)
		{
			sync(minutes+":"+seconds);
		}
	}
};


function sync(thisMinSec)
{
	trace("start sync in ymp_clock");
	nextSync = getTC(useThisSlide);
	
	//trace("> "+thisMinSec + ", " + nextSync);

	if (thisMinSec == nextSync)
	{
		//_root.cueFontColorStr = "ff0000";
		//_root.cue_txt = "00:00:" + nextSync;

		if (mode == "imgMode")
		{
			// "jpeg slide show"
			hideThisSlide();
		} 
		else 
		{
			// vector layering
		}

		currentSlide++;
		update();

	} 
	else 
	{
		/*
		_root.cueFontColorStr = "666666";

		_root.cue_txt = "<font color=#000000>";
		_root.cue_txt += "00:00:" + nextSync;
		_root.cue_txt += "</font>";
		*/
	}

	//_root.cue_txt = "<font color=#"+_root.cueFontColorStr+">";
	_root.cue_txt = "00:00:" + nextSync;
	//_root.cue_txt += "</font>";
	trace("finish sync in ymp_clock");
}
