$(document).ready(function(){
    document.getElementById('qinp0').focus();
});

$(document).on('keyup', function(event){
    if (event.which == 13 || event.keyCode == 13) {
        if(processQuestions()) {
            $('input:visible:eq(0)').focus();
        }
        return false;
    }
    return true;
});

// change the current question to the next one
// @return true if next question is present
// @return false if next question is absent
function nextInput() {
    var counter = document.getElementById('current_question');
    var $input = $('input:visible:eq(0)');
    var $questionNext = $input.closest('.question').next('.question');
    if($questionNext.length !== 0) {
        // toggle the visibility of the questions
        $input.closest('.question').addClass('hidden');
        $questionNext.removeClass('hidden');
        // add 1 to the counter
        var questionNumber = parseInt($(counter).text());
        $(counter).text(questionNumber + 1);
        return true;
    } else {
        return false;
    }
}

// if changing the question is impossible - go to the next page
// @return false when going to next page, @return true otherwise
function processQuestions() {
    if(nextInput() == false) {
        document.getElementById('form').submit();
        return false;
    }
    return true;
}
