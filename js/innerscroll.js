var mapApp;
	var scrolledObject;

		//				   INNER SVG WINDOW WITH VERTICAL SCROLL - full
/*
Copyright (C) 2004  Domenico Strazzullo
nst@dotuscomus.com

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License at http://www.gnu.org/copyleft/gpl.html for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

var svgdoc;
var loop;
var v_disp;
var ln_scrl;
var pg_scrl;
var markY;
var newMarkY;
var markH;
var scaledmark;
var scaledmarkH;
var initial;
var ratio;
var scaledinnerwinY;
var adjusted;
var maxY;
var evtY;
var firstiteration;
function init (evt) {
	svgdoc = evt.target.ownerDocument;
	var main_viewbox = svgdoc.getElementById("main").getAttributeNS(null,"viewBox").split(" ");
	viewboxW = Number(main_viewbox[2]); //720
	viewboxH = Number(main_viewbox[3]); //600
	viewbox_ratio = viewboxW/viewboxH; //1.2
	loop = null;
	v_disp = 0;
	ln_scrl = 14;
	pg_scrl = svgdoc.getElementById("background").getAttributeNS(null,"height") - 20; //480
	innerwinH = parseFloat(svgdoc.getElementById("container").getAttributeNS(null,"height")); //800
	innerwinY = parseFloat(svgdoc.getElementById("container").getAttributeNS(null,"y")); //720
	var scrollbarH = parseFloat(svgdoc.getElementById("scrollbar").getAttributeNS(null,"height")); //430
	markY = parseFloat(svgdoc.getElementById("mark").getAttributeNS(null,"y")); //35
	newMarkY = markY; //35
	win_bar_ratio = innerwinH / scrollbarH; //1.86
	markH = scrollbarH / win_bar_ratio - 20 / win_bar_ratio; //220.43
	adjusted = innerwinH / (scrollbarH - markH); //3.82
	svgdoc.getElementById("mark").setAttributeNS(null,"height",markH);
	maxY = markY + scrollbarH - markH; //244.57
	firstiteration = true;
	reset();
}
function pgScrollset(evt,scrl_type) {
	getEvt(evt);
	svgdoc.getElementById("mark").setAttributeNS(null,"pointer-events","none");
	scaledmark = scaledinnerwinY + newMarkY / ratio;
	if(evtY > scaledmark + scaledmarkH) initial = "up";
	else if(evtY < scaledmark) initial = "dn";
	v_scroll(scrl_type);
}
function v_scroll(scrl_type,v_dir) {
	if(scrl_type == pg_scrl) {
		if(evtY > scaledmark + scaledmarkH) v_dir = "up";
		else if(evtY < scaledmark) v_dir = "dn";
		else v_dir = null;
		initial == v_dir ? do_scrl = true : do_scrl = false;
	}
	if(do_scrl) v_disp += scrl_type * (v_dir == "dn" && v_disp < 0) - scrl_type * (v_dir == "up" && v_disp > -innerwinH);
	if(v_disp < -innerwinH) v_disp = -innerwinH;
	if(v_disp > 0) v_disp = 0;
	newMarkY = markY + (-v_disp / adjusted);
	scaledmark = scaledinnerwinY + newMarkY / ratio
	svgdoc.getElementById("mark").setAttributeNS(null,"y",newMarkY);
	svgdoc.getElementById("content").setAttributeNS(null,"transform","translate(0," + v_disp + ")");
	tp = scrl_type;
	dir = v_dir;
	if(firstiteration) delay = 350;
	else delay = 50;
	firstiteration = false;
	loop = setTimeout('v_scroll(tp,dir)',delay);
}
function enable_drag(evt,grab) {
	getEvt(evt);
	grab ? svgdoc.getElementById("dragarea").setAttributeNS(null,"pointer-events","all") : svgdoc.getElementById("dragarea").setAttributeNS(null,"pointer-events","none");
	offsetY = evtY * ratio - newMarkY;
}
function drag (evt) {
	getEvt(evt);
	newMarkY = evtY * ratio - offsetY;
	if(newMarkY < markY) newMarkY = markY;
	else if(newMarkY > maxY) newMarkY = maxY;
	v_disp = (newMarkY - markY) * -adjusted;
	svgdoc.getElementById("mark").setAttributeNS(null,"y",newMarkY);
	svgdoc.getElementById("content").setAttributeNS(null,"transform","translate(0," + v_disp + ")");
}
function getEvt(evt) {
	evtY = evt.clientY;
}
function stopscroll() {
	if(loop != null) clearTimeout (loop);
	firstiteration = true;
	svgdoc.getElementById("mark").setAttributeNS(null,"pointer-events","all");
}
function reset() {
	var w = window.innerWidth;
	var h = window.innerHeight;
	win_ratio = w / h;
	if(win_ratio >= viewbox_ratio) {
		ratio = viewboxH / h;
		var newW = h * viewbox_ratio;
		var hor_offset = 0;
//		var ver_offset = (w - newW) / 2;
	}
	else {
		ratio = viewboxW / w;
		newH = w / viewbox_ratio;
		var hor_offset = (h - newH) / 2;
//		var ver_offset = 0;
	}
	scaledinnerwinY = innerwinY / ratio + hor_offset;
	scaledmarkH = markH / ratio;
}

function createScrollbar() {
	myMapApp = new mapApp(false,undefined);
	var scrollbarStyles = {"fill":"whitesmoke","stroke":"dimgray","stroke-width":1};
	var scrollerStyles = {"fill":"lightgray","stroke":"dimgray","stroke-width":1};
	var triangleStyles = {"fill":"dimgray"};
	var highlightStyles = {"fill":"dimgray","stroke":"dimgray","stroke-width":1};
	scrolledObject = new scrolledObject("content",0,0,0,-400,null,"sbvert")
	myMapApp.scrollbars["sbvert"] = new scrollbar("sbvert","scrollbar",705.5,50.5,15,499,scrolledObject.maxY,scrolledObject.minY,0.5,0,0.005,"top_bottom",scrollbarStyles,scrollerStyles,triangleStyles,highlightStyles,scrolledObject);
}