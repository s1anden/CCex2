//trace("start in ymp");
//var audioTally:Number = 0;
#include "as/ymp_xml.as"

// create the XML object
ymp_scriptXML = new XML();

var sequence = new Array;
ymp_scriptXML.onLoad = xmlLoad;

var sndLoadList = new Array;

_root.timer_txt.text = "00:00:00:00";
_root.cue_txt.text = "00:00:00:00";
_root.cueFontColorStr = "666666";
_root.currentMaxH = 0;

if (!mode){
	var mode = "imgMode";
}

if (!imgVectorInstance){
	var imgVectorInstance = "z";
}

#include "as/ymp_btnHandlers.as"
#include "as/ymp_controllerFunctions.as"
#include "as/ymp_functions.as"
#include "as/ymp_loader.as"
#include "as/ymp_clock.as"

_root.controller_mc.playPause.gotoAndStop("play");
//trace("finish in ymp");