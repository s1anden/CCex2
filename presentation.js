var kWidth = 600;
var kHeight = 500;

var gCanvasElement;
var gDrawingContext;

var gSteps = ["hello"];
var gNumSteps, gCurrentStep;

function Location(x, y) {
	this.x = x;
	this.y = y;
}

function getCursorPosition(e) {
	var x, y;
	if (e.pageX != undefined && e.pageY != undefined) {
		x = e.pageX;
		y = e.pageY;
	}
	else {
		x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
		y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
	}
	x -= gCanvasElement.offsetLeft;
	y -= gCanvasElement.offsetTop;

	var location = new Location(x, y);
	return location;
}

function presOnClick(e) {
	var location = getCursorPosition(e);
	for (var i = 0; i < 1; i++) {

	}
}

function drawScreen() {

  gDrawingContext.clearRect(0, 0, kWidth, kHeight);

  gDrawingContext.beginPath();

  gDrawingContext.moveTo(0, 70.5);
  gDrawingContext.lineTo(600, 70.5);
  gDrawingContext.lineWidth = 2;
  gDrawingContext.strokeStyle = "#999";
  gDrawingContext.stroke();

  gDrawingContext.beginPath();
  gDrawingContext.moveTo(0,399.5);
  gDrawingContext.lineTo(600, 399.5);
  gDrawingContext.lineWidth = 5;
  gDrawingContext.stroke();

  gDrawingContext.fillStyle = "#FDFCCC";
  gDrawingContext.fillRect(0,402,600,500);

  gDrawingContext.beginPath();
  for (var x = 0.5; x < 600; x += 10) {
  	gDrawingContext.moveTo(x, 0);
  	gDrawingContext.lineTo(x, 500);
  }

  for (var y = 0.5; y < 500; y += 10) {
  	gDrawingContext.moveTo(0, y);
  	gDrawingContext.lineTo(600, y);
  }


  gDrawingContext.strokeStyle = "#eee";
  gDrawingContext.lineWidth = 1;
  gDrawingContext.stroke();

  gDrawingContext.font = "bold 36px sans-serif";
  gDrawingContext.textBaseline = "middle";
  gDrawingContext.textAlign = "right";
  gDrawingContext.fillStyle = "blue";
  gDrawingContext.fillText(">>", 590, 35);

  gDrawingContext.textAlign = "left";
  gDrawingContext.fillText("<<", 10, 35);

  for (var i = 0; i < gCurrentStep; i++) {
  	drawStep(gSteps[i]);
  }

}

function drawStep(s) {
	var x = s.x;
	var y = s.y;
	var image = s.image;
	// var words = s.words;
	var words = "This is a long line of text \n with the goal of testing multiline \n ability.";
	var sound = s.sound;
	if (image != null) {
		gDrawingContext.drawImage(image, x, y);
	}
	if (words != null) {
		gDrawingContext.font = "12px sans-serif";
		gDrawingContext.textBaseline = "top";
		gDrawingContext.textAlign = "left";
		gDrawingContext.fillStyle = "black";

		var wordsArray = words.split("\n");
		for (i = 0; i < wordsArray.length; i++) {
			gDrawingContext.fillText(wordsArray[i], 10, 410 + i*16);
		}
	}
}

function newPres() {


  drawScreen();
}

function initPres() {

  var canvasElement = document.createElement("canvas");
  canvasElement.id = "pres";
  document.body.appendChild(canvasElement);
  gCanvasElement = canvasElement;
  gCanvasElement.width = kWidth;
  gCanvasElement.height = kHeight;
  gCanvasElement.style.border = "1px solid black";
  gCanvasElement.style.margin = "auto";
  // gCanvasElement.addEventListener("click", presOnClick, false);
  gDrawingContext = gCanvasElement.getContext("2d");
  newPres();
}

