#include "ex2.as"
#include "ymp_xml.as"

//trace("start preloadFrameOne");




var question_file = _root.this_ymp_presentation;



var theVersion:Number = 7;

var theDomain:String = "cmu.edu";

var checkVersion:Boolean = true;

var checkDomain:Boolean = true;

var parsingDone:Boolean = false;

var count = 0;

var myxml;


preloader.activityTextBox._x = -30;

preloader.percentTextBox._x = 150;

preloader.activityTextBox.text = "LOADING";



checkVersionAndDomain(theVersion, theDomain);

//trace("finish preloadFrameOne");

function checkVersionAndDomain(theVersion, theDomain) 
{
	//trace("start checkVersionAndDomain in preloadFrameOne");
	//parse domain name

	//theVersion = 7 and theDomain = cmu.edu
	//trace("theVersion: " + theVersion + "  theDomain: " + theDomain);
	//get everything between the "://" and the next "/"

	//trace("_url: " + _url);
	//  file:///C|/Documents%20and%20Settings/Soojin/My%20Documents/intro%5Fchem%2D3.x/
	//  content/%5Fu6%5Fequilibrium/%5Fm1%5Fequilibrium/webcontent/flash/ex2/source/ex2.swf

	c1 = _url.indexOf("://")+3;

	c2 = _url.indexOf("/", c1);

	//trace("c1: " + c1 + " c2: " + c2);
	var domain = _url.substring(c1, c2);

	//trace("domain1: "+ domain);
	//throw away any prefixes before the second to last "."

	c3 = domain.lastIndexOf(".")-1;

	c4 = domain.lastIndexOf(".", c3)+1;
	//trace("c3: " + c3 + " c4: " + c4);
	domain = domain.substring(c4, domain.length);
	//trace("domain2: "+ domain);

	if ((_url.indexOf("strader") >= 0) or (_url.indexOf("chemcollective") >= 0) or (_url.indexOf("content") >= 0)) 
	{
		domain = theDomain;
	}
	//trace("domain3: "+ domain);
	//get version of flash player being used

	var versionString = $version.toString();

	var myVersionString = versionString.substring(versionString.length-8, versionString.length-7);

	var myVersionNum:Number = Number(myVersionString);
/*
	if ((checkDomain) and (domain != theDomain)) 
	{
		//trace("[1]");

		preloader._visible = false;

		preloader_box._visible = false;

		errorTextbox.htmlText = "This flash movie is a copyrighted work by the Open Learning Initiative at Carnegie Mellon University, and will not run elsewhere.  If you feel you are getting this message in error, please contact us at <font color='#0000ff'><u><a href='http://www.cmu.edu/oli'>http://www.cmu.edu/oli</a></u></font>";

	} 
	else if ((checkVersion) and (myVersionNum < theVersion)) 
	{

		//trace("[2]");

		preloader._visible = false;

		preloader_box._visible = false;

		errorTextbox.htmlText = "This Flash movie requires Flash Player version " + theVersion.toString() + " or later.  Please go to <font color='#0000ff'><u><a href='http://www.adobe.com'>http://www.macromedia.com</a></u></font> to download the latest player";

	} */
//	else 
//	{
		//trace("[3]");
		myxml = new XML();
		myxml.ignoreWhite = true;
		myxmlfile = question_file;
		myxml.onLoad = function(success)
		{
			if (success) 
			{
				//trace(this);
				//ymp_parse(this.firstChild);
			}
			else 
			{
				trace("errorrrrr");
			}
		};
		myxml.load(myxmlfile);
		_root.ymp_scriptXML.load(_root.this_ymp_presentation);
		
		intervalID = setInterval(checkLoaded, 50);

	//}
	//trace("finish checkVersionAndDomain in preloadFrameOne");
}



function checkLoaded() 
{
	
	//trace("start checkLoaded in preloadFrameOne");

	if (myxml.status) 
	{
		trace("loading error");
	} 
	else 
	{
		//trace("success   " + myxml.loaded);
		//xmlLoad(myxml.loaded);
		if (myxml.loaded) 
		{
			//trace("success1");

			clearInterval(intervalID);
			preloader.percentTextBox.text = "50%";
		} 
		else 
		{
			//trace("success2 shouldn't be here!");

			if (myxml.percentLoaded) 
			{
				//trace("success3");

				preloader.percentTextBox.text = myxml.percentLoaded/2+"%";
			}
		}

		if ((count>12) and (myxml.loaded)) 
		{

			//trace("success4");

			show(myxml);

			intervalID2 = setInterval(checkShow, 50);

		}

		count++;

	}
	//trace("finish checkLoaded in preloadFrameOne");
}


function checkShow() 
{
	//trace("start checkShow in preloadFrameOne");
	
	if (parsingDone) 
	{	
		//regardless audio or no...
		
		_root.controller_mc.prevBtn._alpha = 50;
		
		
		if(_root.audioTally > 0)
		{
		
			//nothing for now
		
			_root.currentSlide = -2;
		
			update();
		
		} 
		else 
		{
			// handle toggle out of the preloader
		
			_root.controller_mc.playPauseBtn._visible = false;
			
			_root.controller_mc.playPause._visible = false;
		}
		
		clearInterval(intervalID2);
		gotoAndPlay(_root.currentSlide);
	}
	//trace("finish checkShow in preloadFrameOne");
}


// function to display xml object
function show(node) 
{
	//trace("start show in preloadFrameOne");
	//trace ("node is " + node.firstChild.nodeName);

	if (node.firstChild != null) 
	{
		//trace("ok");

		for (i=0; i<node.childNodes.length; i++) 
		{
			if (node.childNodes[i].nodeName == "item") 
			{
				trace("found item");
			}

			show(node.childNodes[i]);

		}

	}

	if (node.firstChild.nodeName == "item") 
	{
		parsingDone = true;
	}
	//trace("finish show in preloadFrameOne");
}







