// first set of listeners
var loader = new MovieClipLoader();
myListener = new Object();


myListener.onLoadStart = function (target_mc)
{
	//trace("start myListener.onLoadStart in ymp_loader");
	var loadProgress = loader.getProgress(target_mc);
	_root.preloadFinished = false;
	//trace("finish myListener.onLoadStart in ymp_loader");
}


myListener.onLoadProgress = function (target_mc, loadedBytes, totalBytes)
{
	//trace("start myListener.onLoadProgress in ymp_loader");
	_root.preloadFinished = false;
	//trace("finish myListener.onLoadProgress in ymp_loader");
}


myListener.onLoadComplete = function (target_mc)
{
	//trace("start myListerner.onLoadComplete in ymp_loader");
	var loadProgress = loader.getProgress(target_mc);
	//trace("finish myListerner.onLoadComplete in ymp_loader");
}


myListener.onLoadInit = function (target_mc)
{
	//trace("start myListerner.onLoadInit in ymp_loader");
	_root.preloadFinished = true;
	target_mc.slideLoaded = true;
	//trace("finish myListerner.onLoadInit in ymp_loader");
}


myListener.onLoadError = function (target_mc, errorCode)
{
	//trace("start myListerner.onLoadError in ymp_loader");
	trace ("ERROR loading");
	//trace("finish myListerner.onLoadError in ymp_loader");
}

loader.addListener(myListener);












