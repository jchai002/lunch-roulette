$(document).ready(function () {

  $("#new_search").submit (function(event) {
    event.preventDefault();
    $.post('/searches', $(this).serialize()).done(function(response) {
      $('#result').empty().append(response);
    }).fail(function() {
      console.log("omg why");
    })
  })

});