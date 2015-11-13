$(document).ready(function () {

  $("#new_search").submit (function(event) {
    event.preventDefault();
    $.post('/searches', $(this).serialize())
    .then(function(response) {
      $('#result').empty().append(response);

  function initDirMap() {
  var myLat = $('#search_lat').val();
  var myLng = $('#search_long').val();
  var bizLat = $('#business_lat').val();
  var bizLng = $('#business_long').val();
  var myLocation = {lat: parseFloat(myLat), lng: parseFloat(myLng)};
  var bizLocation = {lat: parseFloat(bizLat), lng: parseFloat(bizLng)};
  // Create a map object and specify the DOM element for display.
  var directionsService = new google.maps.DirectionsService;
  var directionsDisplay = new google.maps.DirectionsRenderer;
  var directionMap = new google.maps.Map(document.getElementById('map'), {
    center: myLocation,
    scrollwheel: false,
    zoom: 16,
    draggable:false
  });

  directionsDisplay.setMap(directionMap);

  calculateAndDisplayRoute(directionsService, directionsDisplay, myLocation, bizLocation);




		function calculateAndDisplayRoute(directionsService, directionsDisplay, origin, destination) {
		  directionsService.route({
		    origin: origin,
		    destination: destination,
		    travelMode: google.maps.TravelMode.WALKING
		  }, function(response, status) {
		    if (status === google.maps.DirectionsStatus.OK) {
		      directionsDisplay.setDirections(response);
		    } else {
		      window.alert('Directions request failed due to ' + status);
		    }
		  });
		};
	}

initDirMap()

  	})
    .fail(function() {
      console.log("omg why");
    })
  })

});