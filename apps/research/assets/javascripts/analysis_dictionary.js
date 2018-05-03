$(document).ready(function() {
  $('#date-selection input').datepicker($.datepicker.regional["ru"]);
  $('#date-selection input').datepicker('option', 'changeYear', true);
  $('#date-selection input').datepicker('option', 'changeMonth', true);
  $("#selection-output").val('html');
});

$("#xlsx-export").click(function(e) {
  e.preventDefault();
  $("#selection-output").val('xlsx');
  $("#submit").trigger('click');
  $("#selection-output").val('html');
});
