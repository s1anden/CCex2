
_root.songOffset = 0;
_root.currentSlide = 0;
_root.audioTally = 0;
_root.sequence = new Array;

//regardless audio or no...

_root.controller_mc.prevBtn._alpha = 50;



stop();





preloader.swapDepths(970);

preloader_box.swapDepths(960);



preLoad2(this);





function preLoad2(what):Void 
{
	//trace("start preLoad2 in preloadFrameTwo");
	var count = 0;

	preloader._visible = true;

	preloader_box._alpha = 100;

	var percent:Number = 50;

	var per:Number;

	var loader_mc2:MovieClip = createEmptyMovieClip("l", getNextHighestDepth());

	loader_mc2.onEnterFrame = function() 
	{

		percent = 50+(count/24)*100/2;

		per = Math.round(percent);

		preloader.percentTextBox.text = per+"%";



		if (count > 24) 
		{

			delete this.onEnterFrame;

			preloader._visible = false;

			fadeTimer = setInterval(fadePreloader, 50);

		}

		count ++;

	};
	//trace("finish preLoad2 in preloadFrameTwo");
}


function fadePreloader() 
{
	//trace("start fadePreloader in preloadFrameTwo");

	if (preloader_box._alpha > 0) 
	{

		preloader_box._alpha = preloader_box._alpha - 10;

	} 
	else 
	{

		preloader_box._alpha = 0;

		clearInterval(fadeTimer);
			
		playNext();
	
		_root.controller_mc.prevBtn._alpha = 50;
			
		_root.controller_mc.nextBtn._alpha = 100;

	}
	//trace("finish fadePreloader in preloadFrameTwo");
}

