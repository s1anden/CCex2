
// Beforeproceeding to far into the program, make sure the XML document has loaded
// Extract information from the XML file

function xmlLoad(ok) 
{
	//trace("start xmlLoad in ymp_xml");

	if (ok == true) 
	{
		//trace("here in xmlLoad");
		ymp_parse(this.firstChild);
	}
	//trace("URL ISSSSSSSSSSSSSSS: " + _url);
	//trace("finish xmlLoad in ymp_xml");
}

function ymp_parse(ymp_scriptXMLNode) 
{
	//trace("start ymp_parse in ymp_xml");
	sequenceCounter = 0;

	if (ymp_scriptXMLNode.nodeName.toUpperCase() == "YMP_PRESENTATION") 
	{
		output = "";
		//var goToNext = false;
		//dump the xml:
		//trace(ymp_scriptXMLNode);

		ymp_slice = ymp_scriptXMLNode.firstChild;

		while (ymp_slice != null) 
		{
			if (ymp_slice.nodeName.toUpperCase() == "YMP_SLICE") 
			{
				ymp_idx = "";
				ymp_tc = "";

				element = ymp_slice.firstChild;
				while (element != null) 
				{
					// slice elements
					if (element.nodeName.toUpperCase() == "YMP_IDX") 
					{
						ymp_idx = element.firstChild.nodeValue;
					}
					if (element.nodeName.toUpperCase() == "YMP_TC") 
					{
//						ymp_tc = "\"" + element.firstChild.nodeValue + "\"";
						ymp_tc = element.firstChild.nodeValue;
					}
					if (element.nodeName.toUpperCase() == "YMP_TXT") 
					{
						ymp_txt = element.firstChild.nodeValue;
					}
					if (element.nodeName.toUpperCase() == "YMP_XOFFSET") 
					{
						ymp_xOffset = element.firstChild.nodeValue;
					}
					if (element.nodeName.toUpperCase() == "YMP_YOFFSET") 
					{
						ymp_yOffset = element.firstChild.nodeValue;
					}

					if (element.nodeName.toUpperCase() == "YMP_XABSOLUTE") 
					{
						ymp_xAbsolute = element.firstChild.nodeValue;
					}
					if (element.nodeName.toUpperCase() == "YMP_YABSOLUTE") 
					{
						ymp_yAbsolute = element.firstChild.nodeValue;
					}


					// slice params
					if (element.nodeName.toUpperCase() == "YMP_PARAM_ISTOGGLE") 
					{
						ymp_param_isdisplaytxt = element.firstChild.nodeValue;
					}
					if (element.nodeName.toUpperCase() == "YMP_PARAM_ISTITLE") 
					{
						ymp_param_istitle = element.firstChild.nodeValue;
					}
					if (element.nodeName.toUpperCase() == "YMP_TITLE") 
					{
						ymp_title = element.firstChild.nodeValue;
					}
					if (element.nodeName.toUpperCase() == "YMP_PARAM_ISTOGGLE") 
					{
						ymp_param_istoggle = element.firstChild.nodeValue;
					}
					if (element.nodeName.toUpperCase() == "YMP_PARAM_HASAUDIO") 
					{
						_root.audioTally++;
						ymp_param_hasaudio = element.firstChild.nodeValue;						
					}


					if (element.nodeName.toUpperCase() == "YMP_PRESENTATION") 
					{
						trace("NESTED: in slice: "+ymp_idx);
						ymp_nest = element.firstChild;
						trace(ymp_nest);
					}

					element = element.nextSibling;
				}

//				output += "<font size='+2' color='#3366cc'><b>"+ymp_slice+": </b>"+ymp_idx+", "+ymp_tc+"</font><br><br>";
//				txt.htmltext=output;

//				var _root["s"+ymp_idx] = {s:+ymp_idx, tc:+ymp_tc};
				_root["s"+ymp_idx] = {s:+ymp_idx, tc:+ymp_tc, txt:ymp_txt, xOffset:ymp_xOffset, yOffset:ymp_yOffset, 
									xAbsolute:ymp_xAbsolute, yAbsolute:ymp_yAbsolute, ymp_param_isdisplaytxt:ymp_param_isdisplaytxt, 
									ymp_param_istitle:ymp_param_istitle, ymp_title:ymp_title, ymp_param_istoggle:ymp_param_istoggle, 
									ymp_param_hasaudio:ymp_param_hasaudio};
				_root.sequence[sequenceCounter] = _root["s"+ymp_idx];
				//if((sequenceCounter == 1) && _root.sequence[sequenceCounter].ymp_param_hasaudio)
				//	goToNext = true;
				sequenceCounter++;

				// reset vals
				ymp_idx = "";
				ymp_tc = "";
				ymp_txt = "";
				ymp_xOffset = "";
				ymp_yOffset = "";
				ymp_xAbsolute = "";
				ymp_yAbsolute = "";
				ymp_param_isdisplaytxt = "";
				ymp_param_istitle = "";
				ymp_title = "";
				ymp_param_istoggle = "";
				ymp_param_hasaudio = "";
				ymp_nest = "";
			}
			ymp_slice = ymp_slice.nextSibling;
		}
	}
	//trace("XML_length:"+_root.sequence.length);
	
	createSlides(_root.sequence.length);
	init();
	//_root.hider = setInterval(hideAllSlides,40,_root.sequence.length);
	//if(goToNext)
	//{
	//	currentSlide = 0;
	//	playNext();
	//}
	//trace("finish ymp_parse in ymp_xml");
}
