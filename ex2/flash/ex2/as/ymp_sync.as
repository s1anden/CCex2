
function sync(thisMinSec)
{
	trace("start sync in ymp_sync");
	nextSync = getTC(useThisSlide);

	if (thisMinSec == nextSync)
	{
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
	trace("end sync in ymp_sync");
}
