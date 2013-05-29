var kWidth = 600;
var kHeight = 800;

var gCanvasElement;
var gDrawingContext;

var gSteps;
var gNumSteps;
var gCurrentStep;
var gCurrentStepIndex;
var gCaption;

function Step(image, words, audio, x, y) {
	this.image = image;
  this.words = words;
  this.audio = audio;
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
	for (var i = 0; i <= 1; i++) {

	}
}

function drawScreen() {

  gDrawingContext.clearRect(0, 0, kWidth, kHeight);

  gDrawingContext.beginPath();
  for (var x = 0.5; x < gWidth; x += 10) {
  	gDrawingContext.moveTo(x, 0);
  	gDrawingContext.lineTo(x, gHeight);
  }

  for (var y = 0.5; y < gHeight; y += 10) {
  	gDrawingContext.moveTo(0, y);
  	gDrawingContext.lineTo(gWidth, y);
  }

  gDrawingContext.strokeStyle = "#eee";
  gDrawingContext.lineWidth = 1;
  gDrawingContext.stroke();

  for (var i = 0; i < gCurrentStepIndex; i++) {
  	drawStep(gSteps[i]);
  }

}

function drawStep(s) {
	var x = s.x;
	var y = s.y;
	var image = s.image;
	// var words = s.words;
	if (image != null) {
		gDrawingContext.drawImage(image, x, y);
	}
}

function nextStep() {
  if (currentStepIndex >= (gNumSteps - 1)) {
    return;
  }
  else {
    currentStepIndex++;
    currentStep = gSteps[currentStepIndex];
    drawStep(currentStep);
    document.getElementById("caption").innerHTML = currentStep.words;
  }
}

function prevStep() {
  if (currentStepIndex <= 0) {
    return;
  }
  else {
    currentStepIndex--;
    currentStep = gSteps[currentStepIndex];
    drawScreen();
    document.getElementById("caption").innerHTML = currentStep.words;
  }
}

function newPres(steps) {
  var step;
  for (i = 0; i < steps.length; i++) {
    step = steps[i];
    gSteps.push(new Step(step[0], step[1], step[2], step[3], step[4]));
  }
  gNumSteps = gSteps.length;
  gCurrentStepIndex = 0;
  gCurrentStep = gSteps[gCurrentStepIndex];

  gCaption.innerHTML = currentStep.words;
  drawScreen();
}

function initPres(canvas, steps, captionElem) {
  if (canvas == null) {
    var canvasElement = document.createElement("canvas");
  }
  var steps = steps;
  canvasElement.id = "pres";
  document.getElementById("screen").appendChild(canvasElement);
  gCanvasElement = canvasElement;
  gCanvasElement.width = kWidth;
  gCanvasElement.height = kHeight;
  gCanvasElement.style.border = "1px solid black";
  gCanvasElement.style.margin = "auto";
  // gCanvasElement.addEventListener("click", presOnClick, false);
  gDrawingContext = gCanvasElement.getContext("2d");
  gCaption = captionElem;
  newPres(steps);
}

