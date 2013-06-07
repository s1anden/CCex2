

	var STEPS = 21;
	var currentStep = 0;
	var lecture = true;

	function setup() {
		for (j=1; j<= 21; j++) {
			d3.select('#step' + j).style('cursor', 'pointer');
		}
	}

	function changeMode() {
		if (lecture) {
			beginReview();
			d3.select('#mode').html('Lecture')
		} else if (!lecture) {
			beginLecture();
			d3.select('#mode').html('Review');
		}
	}



	function displayText(step) {
		d3.select('#instruct').html(text[step]);
	}

	function playAudio(step) {

	}
	
	function beginLecture() {
		lecture = true;
		currentStep = 0;
		for (i=1; i <= 21; i++) {
			d3.select('#step' + i).attr('visibility','hidden');
		}
		d3.select('#instruct').html("");
	}

	function beginReview() {
		lecture = false;
		for (i=1; i <= 21; i++) {
			d3.select('#step' + i).attr('visibility','visible');
		}
		d3.select('#instruct').html("");
	}

	function next(){
		if (currentStep < STEPS && lecture) {
			currentStep++;
			d3.select('#step' + currentStep).attr('visibility','visible');
			displayText(currentStep);
			playAudio(currentStep);
		}
	}

	function prev(){
		if (currentStep > 0 && lecture) {
			d3.select('#step' + currentStep).attr('visibility','hidden');
			currentStep--;
			displayText(currentStep);
			playAudio(currentStep);
		}
	}
