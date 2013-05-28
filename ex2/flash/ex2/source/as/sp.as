/**
 Requires:
  - ScrollPane in library
*/


my_sp.contentPath = "imgs";
my_sp2.contentPath = "imgs";

//my_sp.focusEnabled = false;

listenerObject = new Object();
listenerObject.keyDown = function(eventObject)
{
	if (Key.getCode() == Key.RIGHT) 
	{ 
		_root.superPlay = 1;
		playNext();
 	} 
	else if (Key.getCode() == Key.LEFT)
	{ 
		_root.superPlay = 1;
		playPrev();
 	} 
	else if (Key.getCode() == Key.SPACE)
	{ 
		playPauseToggle();
		if(_root.currentSlide < 2)
		{
			_root.superPlay = 1;
			playNext();
		}
 	}
}


my_sp.addEventListener("keyDown", listenerObject);
my_sp2.addEventListener("keyDown", listenerObject);
