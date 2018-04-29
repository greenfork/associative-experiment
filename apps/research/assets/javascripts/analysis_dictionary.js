$(document).ready(function() {
  $('#date-selection input').datepicker($.datepicker.regional["ru"]);
  $('#date-selection input').datepicker('option', 'changeYear', true);
  $('#date-selection input').datepicker('option', 'changeMonth', true);
});
