	var currentStep = 0;
	var lecture = true;
	var audio = true;
	var parentDocument = parent.document;
	var instruct = parentDocument.getElementById('instruct');
	var audioPlayer = parentDocument.getElementById('audio');

	function displayText(step) {
		if (!lecture) {
			currentStep = step;
		}
		
		instruct.innerHTML = text[step];
		
	}

	function setup() {
		for (step=1; step<= STEPS; step++) {
			d3.select('#step' + step)
				.style('cursor', 'pointer')
				.on('click', function(){displayText(this.id.replace("step",""))});
		}

	
		
	}

	function changeMode() {
		if (lecture) {
			d3.select('#mode').text('Lecture');
			beginReview();
		} else if (!lecture) {
			d3.select('#mode').text('Review');
			beginLecture();			
		}
	}





	function playAudio(step) {
		// parentDocument.getElementById('mp3').setAttribute('src',audio[step][0]);
		// parentDocument.getElementById('ogg').setAttribute('src',audio[step][1]);
		// parentDocument.getElementById('wav').setAttribute('src',audio[step][2]);
		parentDocument.getElementById('audio').play();
	}
	
	function beginLecture() {
		lecture = true;
		currentStep = 0;
		for (i=1; i <= STEPS; i++) {
			d3.select('#step' + i).attr('visibility','hidden');
		}
		instruct.innerHTML = "";
	}

	function beginReview() {
		lecture = false;
		for (i=1; i <= STEPS; i++) {
			d3.select('#step' + i).attr('visibility','visible');
		}
		instruct.innerHTML = "";
	}

	function next(){
		if (currentStep < STEPS) {
			currentStep++;
			displayText(currentStep);
			if (lecture) {
				d3.select('#step' + currentStep).attr('visibility','visible');
			}
			if (audio) {
				playAudio(currentStep);
			}
		}
	}

	function prev(){
		if (currentStep > 0) {
			if (lecture) {
				d3.select('#step' + currentStep).attr('visibility','hidden');
			}
			currentStep--;
			displayText(currentStep);
			if (audio) {
				playAudio(currentStep);
			}
		}
	}
