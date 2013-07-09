// Record the answers to the questions on the page in this variable. The answers should be in the following format: {"question 1 id attr":question 1 answer,"question 2 id attr":question 2 answer,...} Each type of question has a different format for the answer:
// 	Multiple-choice (1 possible answer): "value attribute of correct option"
// 	Diagram labelling, Matching: {"id attr of box 1":"id attr of matching label","id attr of box 2":"id attr of matching label",etc...}
// 	Multiple-select (1+ possible answers):["value attr of correct option 1","value attr of correct option 2",etc....]
// 	Ordering/Arranging:["id attr of first/top item","id attr of second item",....."id attr of last/bottom item"]  <  in the CORRECT order
// 	Fill in the blank:["acceptable answer 1","acceptable answer 2","acceptable answer 3"]
var answers = {"samp01":"A","samp02":{"samp02-drop_01":"anode","samp02-drop_02":"electrons-right","samp02-drop_03":"salt-bridge","samp02-drop_04":"cathode","samp02-drop_05":"metal-salt"},"samp03":{"samp03-drop_01":"dipole","samp03-drop_02":"acid","samp03-drop_03":"titration"},"samp04":["A","D","E"],"samp05":{"samp05-drop_01":"ag","samp05-drop_02":"cu","samp05-drop_03":"sn","samp05-drop_04":"zn","samp05-drop_05":"mg"},"samp06":["five","5","5.0"]};
var incorrect = {"samp01":"The correct answer is A.","samp02":"The correct answers are (clockwise, from bottom left: Anode, Electrons >>>, Salt Bridge, Cathode, Metal Salt.","samp03":"The correct answers are (top to bottom): Dipole, Acid, Titration.","samp04":"The correct answers are A, D, and E.","samp05":"The correct answers are (top to bottom): Ag, Cu, Sn, Zn, Mg.","samp06":"The correct answer is 5."};

$(function () {
	$(".draggable").draggable({snap: ".droppable", snapMode: "inner", containment: "parent"});
	$(".droppable").droppable({
		tolerance:"intersect",
		drop:function(event,ui) {
			$(this)
				.html(ui.draggable.html())
				.droppable('option','accept',ui.draggable);
			$(ui.draggable)
				.css("opacity","0.0");
			$(":input[name='" + $(this).attr('id') + "']")
				.val(ui.draggable.attr('id'));
		},
		out:function(event,ui) {
			$(this)
				.html("")
				.droppable('option','accept','.draggable');
			$(ui.draggable)
				.css("opacity","1.0")
				.css("width","auto")
				.css("height","auto")
				.css("padding","5px");
			$("input[name=" + $(this).prop('id') + "]")
				.val("");
		}
	});

	$(".sortable").sortable({
		revert:true,
		create: function() {
			$("input[name='"+$(this).attr('id').replace('sort-','')+"']").val($(this).sortable("toArray"));
		},
		update: function() {
			$("input[name='"+$(this).attr('id').replace('sort-','')+"']").val($(this).sortable("toArray"));
		}
	});

	$("ul, li").disableSelection();

	$(".hint").data('pos',-1);

	$(".showHints").click(function() {
		if ($(this).siblings('.hint').data('pos') == -1) {
		    $(this).siblings('.hint').children('span').first().css('display','inline');
		    if ($(this).siblings('.hint').children('span').length > 1) {
		        $(this).siblings('.hint').children('.nextHint').css('display','inline');
		    }
		    $(this).siblings('.hint').data('pos',0);
		    $(this).html('Hide');
		} else {
			$(this).siblings('.hint').children().css('display','none');
			$(this).siblings('.hint').data('pos',-1);
			$(this).html('Hint');
		}
	    return false;
	});

	$('.nextHint').click(function() {
	    $(this).parent().children('span').eq($(this).parent().data('pos')).css('display','none');
	    $(this).parent().data('pos',$(this).parent().data('pos')+1);
	    $(this).parent().children('span').eq($(this).parent().data('pos')).css('display','inline');
	    if ($(this).parent().data('pos') == 1) {
	        $(this).siblings('.prevHint').css('display','inline');
	    }
	    if ($(this).parent().data('pos') == $(this).siblings('span').length-1) {
	        $(this).css('display','none');
	    }
	    return false;
	});

	$('.prevHint').click(function() {
	    $(this).parent().children('span').eq($(this).parent().data('pos')).css('display','none');
	    $(this).parent().data('pos',$(this).parent().data('pos')-1);
	    $(this).parent().children('span').eq($(this).parent().data('pos')).css('display','inline');
	    if ($(this).parent().data('pos') == $(this).parent().children('span').length-2) {
	        $(this).siblings('.nextHint').css('display','inline');
	    }
	    if ($(this).parent().data('pos') == 0) {
	        $(this).css('display','none');
	    }
	    return false;
	});
});

function check(question) { 
	var complete = true;
	var correct = true;
	if (question.hasClass('multiple-choice')) {
		if ($("input[name='"+question.attr('id')+"']:checked").length == 0){
			complete = false;
		} else if (answers[question.attr('id')] != $("input[name='"+question.attr('id')+"']:checked").val()) {
			correct = false;
		}
	} else if (question.hasClass('match')) {
		jQuery.each(answers[question.attr('id')], function(key,value) {
			if ($("input[name='"+key+"']").val() == "") {
				complete = false;
				return false;
			} else if ($("input[name='"+key+"']").val() != value) {
				correct = false;
			}
		});
	} else if (question.hasClass('select-all')) {
		if ($("input[name='"+question.attr('id')+"']:checked").length == 0) {
			complete = false;
		} else {
			$("input[name='"+question.attr('id')+"']").each(function(){ 
				if ((($(this).is(':checked')) && (jQuery.inArray($(this).val(),answers[question.attr('id')]) == -1)) || ((! $(this).is(':checked')) && (jQuery.inArray($(this).val(),answers[question.attr('id')]) != -1))) {
					correct = false;
					return false;
				} 
			});
		}
	} else if (question.hasClass('arrange')) {
		if (answers[question.attr('id')] != $("input[name='"+question.attr('id')+"']").val()) {
			correct = false;
		}
	} else if (question.hasClass('fill-in')) {
		if ($("input[name='"+question.attr('id')+"']").val() == ""){
			complete = false;
		} else if (jQuery.inArray($("input[name='"+question.attr('id')+"']").val(),answers[question.attr('id')]) == -1){
			correct = false;
		}
	}
	if (!complete) {
		$("#results-" + question.attr('id')).css('display','block').html("You have not fully completed this question.").addClass("incorrect").removeClass('correct');
	} else if (!correct) {
		$("#results-"+question.attr('id')).css('display','block').addClass('incorrect').removeClass('correct').html("Incorrect. " + incorrect[question.attr('id')]);
	} else if (correct && complete) {
		$("#results-"+question.attr('id')).css('display','block').addClass('correct').removeClass('incorrect').html("Correct!");
	}
	return false;
}

function resetForms() {
	$(".tutor input").each(function() {
		$(this).removeAttr('disabled','');
	});

	$(".tutor").each(function() {
		// $(this).children('input').each(function(){
		// 	$(this).attr('disabled','');
		// });

		$(this).each(function() {
			this.reset();
		});
	});


}