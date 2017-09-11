$("option[value='Россия']").prop("selected", true);
  $("#mlo").on("click", function() {
    $("#mother-language-other").prop("disabled", false).prop("required", true);
    $("#mother-language").prop("required", false).prop("disabled", true);
});
$("#slo").on("click", function() {
  $("#speaking-language-other").prop("disabled", false).prop("required", true);
  $("#communicative-language").prop("required", false).prop("disabled", true);
});
$("#elo").on("click", function() {
  $("#education-language-other").prop("disabled", false).prop("required", true);
  $("#education-language").prop("required", false).prop("disabled", true);
});
