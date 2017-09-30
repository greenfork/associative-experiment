var isThisNewInput = true; // is this a clear new reaction input field?
var keyLog = [];
var quizStartTime = $('#quiz-start-time').attr('data');
var quizTimeLimit = $('#quiz-time-limit').attr('data');

$(document).ready(function(){
  document.getElementById('person-stimuli-0-reaction').focus();
});

$(':input.form-control').on('keyup', function(event){
  if (event.which == 13 || event.keyCode == 13) {
    setHiddenValue(Math.floor(Date.now() / 1000), this, 'endTime');
    setHiddenValue(JSON.stringify(keyLog), this, 'keyLog');
    isThisNewInput = true;
    keyLog = [];
    // change input and check if it is time to submit form
    if(processQuestions()) {
      $('input:visible:eq(0)').focus();
    }
    return false;
  } else {
    // when not 'Enter' key is pressed, set the start-time if it wasn't set before
    if(isThisNewInput) {
      setHiddenValue(Math.floor(Date.now() / 1000), this, 'startTime');
      isThisNewInput = false;
    }
    // log any keys pressed by the user
    keyLog = logKeys(event, keyLog);
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

// checks if the time is over
// @return true if time is NOT over, @return false otherwise
// values quizStartTime and quizTimeLimit are global and come from backend
// @quizStartTime - timestamp; @quizTimeLimit - number of seconds for this quiz
function checkTimeLimit() {
  var elapsedTime = Math.floor(Date.now() / 1000) - quizStartTime;
  if(elapsedTime > quizTimeLimit) {
    return false;
  } else {
    return true;
  }
}

// if changing the question is impossible or time is over - go to the next page
// @return false when going to next page, @return true otherwise
function processQuestions() {
  if(checkTimeLimit() == false || nextInput() == false) {
    document.getElementById('form').submit();
    return false;
  }
  return true;
}

// sets the value of the hidden fields: startTime, endTime, keyLog
// @value is value to set; @input is input field; @type is defined as startTime, endTime, keyLog
// @return true on successful setting, false otherwise
function setHiddenValue(value, input, type) {
  var $question = $(input).closest('.question');
  switch(type) {
    case 'startTime':
      $field = $question.find('.start-time');
      break;
    case 'endTime':
      $field = $question.find('.end-time');
      break;
    case 'keyLog':
      $field = $question.find('.key-log');
      break;
  }
  if($field.length != 0) {
    $field.attr('value', value);
    return true;
  }
  return false;
}

// logs every key and corresponding timestamp (in miliseconds)
// @key is a new key event; @keyLog is current key log
// @return new key log with the addition
function logKeys(keyEvent, keyLog) {
  var log = keyLog;
  log.push({key: getCharRepresentation(keyEvent), timestamp: Math.floor(Date.now())});
  return log;
}

// workaround for a keyup event to record an ASCII char representation
function getCharRepresentation(keyEvent) {
  var c = keyEvent.which;
  var e = keyEvent;
  var _to_ascii = {
        '188': '44',
        '109': '45',
        '190': '46',
        '191': '47',
        '192': '96',
        '220': '92',
        '222': '39',
        '221': '93',
        '219': '91',
        '173': '45',
        '187': '61', //IE Key codes
        '186': '59', //IE Key codes
        '189': '45'  //IE Key codes
    };
    var shiftUps = {
          "96": "~",
          "49": "!",
          "50": "@",
          "51": "#",
          "52": "$",
          "53": "%",
          "54": "^",
          "55": "&",
          "56": "*",
          "57": "(",
          "48": ")",
          "45": "_",
          "61": "+",
          "91": "{",
          "93": "}",
          "92": "|",
          "59": ":",
          "39": "\"",
          "44": "<",
          "46": ">",
          "47": "?"
    };
    if (_to_ascii.hasOwnProperty(c)) {
        c = _to_ascii[charCode];
    }
    if (!e.shiftKey && (c >= 65 && c <= 90)) {
        c = String.fromCharCode(c + 32);
    } else if (e.shiftKey && shiftUps.hasOwnProperty(c)) {
        c = shiftUps[c];
    } else {
        c = String.fromCharCode(c);
    }
    if(e.which == 8) {
      return 'backspace';
    }
    return c;
}
