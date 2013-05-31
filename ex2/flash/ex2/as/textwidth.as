/*
  Flash5 ActionScript Library for dynamic text manipulation version 1.4

  In all cases, when calculating the pixel width/height of text box, it is assumed that no word wrapping
  is done by Flash player. That is, if the text bounfing box is narrower than contents, the text will be auto-wrapped.
  Since it is impossible to know whether this has happened, therefore keep your text bounding boxes as wide as
  the maximum possible text line could be. Note, that you can still use manual line breaks in your texts.

  Object: charSet                       - object for initialisation of character set
    Constructor:
    x = new charSet(<character set movie clip>)
    x = new charSet(<character width array>)
  Methods:
    charSet.getArrayString		- returns the string with ActionScript code for defining the character width array without initial counting.
    charSet.getWidth(<string>)          - returns the pixel width of given string.
    charSet.getHeight(<string>)         - returns the pixel height of given string.

  Object: dynamicTextBox - object for manipulations with text box
  Constructor:
    x = new dynamicTextBox(<character set>, <timeline object>, <variable name>)
  Properties:
    dynamicTextBox.value                - the true (unwrapped) content of the text box.
    dynamicTextBox.wrapWidth            - current wrap width. If non-positive, text is unwrapped.
  Methods:
    dynamicTextBox.set(<new string>)    - changes the value of text and wraps it to the current width
    dynamicTextBox.wrap(<wrap width>)   - wraps the text to the given width
    dynamicTextBox.getWidth()           - returns the pixel width of text box.
    dynamicTextBox.getHeight()          - returns the pixel height of text box.

  Copyrighted by Pavils Jurjans 2001
  Email	: pavils@mailbox.riga.lv
  Web	: www.jurjans.lv
  Default source for this file can be found at:
	: www.jurjans.lv/flash/TextWidth.html

  This code is provided for free only with this copyright notice.
*/

function charSet(charSetMC) {
	if (charSetMC==null) return null;
	if (typeof(charSetMC) == "movieclip" && charSetMC.checkVal == checkVal) {
	var charWidths = new Array();
		with (charSetMC) {
			_visible = false;
			gotoAndStop (2);
			// Read the text line heights
			var heightReadings = new Array();
			for (var i=0; i<2; i++) {
				heightReadings[i] = 100*_height/_yscale;;
				nextFrame ();
			}
			this.lineHeight = heightReadings[0];
			this.lineSpacing = heightReadings[1]-2*this.lineHeight;
			// Read the widths of individual characters
			baseWidth = _width;
			for (var i=32; i<=255; i++) {
				nextFrame ();
				charWidths[i] =  100*(_width - baseWidth)/_xscale;
			}
		}
		this.charWidths = charWidths;
	}
	if (typeof(charSetMC) == "object" && charSetMC.__proto__ == Array.prototype) {
		this.charWidths = charSetMC;
		this.lineHeight = this.charWidths[1];
		this.lineSpacing = this.charWidths[2];
		this.charWidths[1] = 0;
		this.charWidths[2] = 0;
	}
	this.widthCache = new Array();
}
charSet.prototype.getArrayString = function() {
	var output = "";
	var val;
	for (var i=0; i<=255; ++i) {
		if (i==1) {		val = this.lineHeight;
		} else if (i==2) {	val = this.lineSpacing;
		} else {		val = this.charWidths[i];
		}
		output += Math.round(val*1000)/1000+",";
		if (i%32 == 31 && i!=255) output += "\n";
	}
	return "["+output.substring(0,output.length-1)+"]";
}
charSet.prototype.getWidth = function(str) {
	if (this.widthCache[str]!=null) return this.widthCache[str];
	var str = (str+"").split("\n");
	var mwth = 0;
	for (var i=0; i<str.length; ++i) {
		var wth = 0;
		for (var j=0; j<str[i].length; ++j) {
			wth += this.charWidths[str[i].charCodeAt(j)];
		}
		if (wth>mwth) mwth = wth;
	}
	this.widthCache[str] = mwth;
	return mwth;
}
charSet.prototype.getHeight = function(str) {
	var lines = (str.split("\r")).length;
	return lines*this.lineHeight+(lines-1)*this.lineSpacing;
}

dynamicTextBox = function(chSet, rootObj, varName) {
	if (rootObj==null) return null;
	this.chSet = chSet;
	this.rootObj = rootObj;
	this.varName = varName;
	this.value = rootObj[varName];
	this.wrapWidth = 0;
	this.wordsArr = null;
}
dynamicTextBox.prototype.set = function(strText) {
	this.value = (strText==null) ? "" : strText;
	this.wordsArr = null;
	this.wrap(this.wrapWidth);
}
dynamicTextBox.prototype.wrap = function(wrapWidth) {
	if (wrapWidth==null || wrapWidth<=0) {
		this.rootObj[this.varName] = this.value
		return;
	}
	var theText = this.value;

	if (this.wordsArr==null) {
		var inxTail = 0;
		var doLook = false;
		this.wordsArr = new Array();
		this.nwlinArr = new Array;
		for (var i=0;i<=theText.length;i++)
			if (i==theText.length || theText.charAt(i)==" " || theText.charAt(i)=="\r") {
				if (doLook) {
					var word = theText.substring(inxTail,i);
					var nwln = word.indexOf("\r");
					this.nwlinArr.push(nwln);
					this.wordsArr.push((nwln<0 ? word : word.substring(nwln)));
					inxTail = i;
					doLook = false;
				}
			} else {
				doLook = true;
			}
		this.widthArr = new Array;
		for (i=0;i<this.wordsArr.length;i++) this.widthArr[i]=this.chSet.getWidth(this.wordsArr[i]);
	}

	var nwLine = false;
	var finalText = " ";
	var curWord = 0;
	var curLen = 0;
	do {
		var word = this.wordsArr[curWord];
		if (this.nwlinArr[curWord]>=0) curLen=0;
		curLen += this.widthArr[curWord];
		if (curLen>wrapWidth) {
//			var i=-1; do i++; while (i<=word.length && word.charAt(i)==" "); word = word.substr(i);
			finalText += "\r"+word;
			curLen = this.chSet.getWidth(word);
			nwLine = true;
		} else {
			finalText += word;
			nwLine = false;
		}
		curWord++;
	} while (curWord<this.wordsArr.length);

	this.wrapWidth = wrapWidth;
	this.rootObj[this.varName] = finalText;
}
dynamicTextBox.prototype.getWidth = function() {
	return this.chSet.getWidth(this.rootObj[this.varName]);
}
dynamicTextBox.prototype.getHeight = function() {
	return this.chSet.getHeight(this.rootObj[this.varName]);
}