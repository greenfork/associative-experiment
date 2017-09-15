// form submit validation
$("#submit").on('click', function(event) {
  // freeze button for a couple of seconds upon click
  (function(button){
    button.setAttribute('disabled', 'disabled');
    setTimeout(function(){
      button.removeAttribute('disabled');
    }, 1500);
  })(this);

  var validated = true;
  try {
    $(":input[data-required='required']").each(function(index, elem) {
      var type = elem.getAttribute('type');

      if(type != "radio" && type != "checkbox") {
        var value = elem.value;
        if(value == "" || value == "--" || value == "---" || value.length == 0) {
          // show alert message
          var alertId = elem.getAttribute('name').replace('[', '-').replace(']', '') + '-alert';
          $("#" + alertId).removeClass("hidden").addClass("show");
          // form is not validated
          validated = false;
        }
      }

      else {
        // elem is of type radio or checkbox
        var name = elem.getAttribute('name');
        var checked = false;
        $(":input[name='" + name + "']").each(function(ind, el) {
          if($(el).prop("checked")) {
            checked = true;
          }
        });

        if(!checked) {
          // show alert message
          var alertId = elem.getAttribute('name').replace('[', '-').replace(']', '') + '-alert';
          $("#" + alertId).removeClass("hidden").addClass("show");
          // form is not validated
          validated = false;
        }
      }
    });

    if(!validated) {
      event.preventDefault();
    }
  }
  catch(err) {
    console.error(err);
  }
});
