var steps = 21;
var currentStep = 1;
var nextStep = function() {
	if (currentStep < steps) {
		d3.select("step1")).style("visibility", "visible");
		currentStep++;
	}
};

var next = function() {
	// var step1 = d3.select("#step1");
	// if (step1.attr("visibility") == "hidden") {
	// 	step1.attr("visibility","visible");
	// } else {
	// 	step1.attr("visibility","hidden");
	// }
	// document.getElementById('step1').setAttribute('visibility','visible');
	return 'red';
};