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
		if (audio) {
			audioPlayer.pause();
			playAudio(step);
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

	function changeAudio() {
		if (audio) {
			audio = false;
			audioPlayer.pause();
			d3.select('#mute').attr('visibility','visible');
		} else {
			audio = true;
			d3.select('#mute').attr('visibility','hidden');
		}
	}



	function playAudio(step) {
		if (audioPlayer.canPlayType && audioPlayer.canPlayType("audio/mpeg")) {
			audioPlayer.src = audioFiles[step][0];
		} else if (audioPlayer.canPlayType && audioPlayer.canPlayType("audio/ogg")) {
			audioPlayer.src = audioFiles[step][1];
		} else if (audioPlayer.canPlayType && audioPlayer.canPlaytype("audio/x-wav")) {
			audioPlayer.src = audioFiles[step][2];
		}
		audioPlayer.play();
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
		}
	}

	function prev(){
		if (currentStep > 0) {
			if (lecture) {
				d3.select('#step' + currentStep).attr('visibility','hidden');
			}
			currentStep--;
			displayText(currentStep);
		}
	}
