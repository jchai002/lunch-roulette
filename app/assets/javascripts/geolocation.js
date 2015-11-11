$(document).ready(function(){
	var lng = $("#something_long");
	var lat = $("#something_lat");
	
function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(setPosition);
    }
}
function setPosition(position) {
    lat.val(position.coords.latitude)
     lng.val(position.coords.longitude)
     console.log(lng.val(),lat.val())
    
}

getLocation()

 

});
