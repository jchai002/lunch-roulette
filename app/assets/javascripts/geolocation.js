$(document).ready(function(){
	var lng = $("#search_long");
	var lat = $("#search_lat");
	
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
