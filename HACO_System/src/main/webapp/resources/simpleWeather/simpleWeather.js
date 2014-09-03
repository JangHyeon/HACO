// Docs at http://simpleweatherjs.com

/* 
* Test Locations
* Austin lat/long: 30.2676,-97.74298
* Austin WOEID: 2357536
*/
$(document).ready(function() {
  //loadWeather('Suwon',''); //@params location, woeid
	navigator.geolocation.getCurrentPosition(function(position) {
		loadWeather(position.coords.latitude+','+position.coords.longitude); //load weather using your lat/lng coordinates
	  });  
});

function loadWeather(location, woeid) {
  $.simpleWeather({
    location: location,
    woeid: woeid,
    unit: 'c',
    success: function(weather) {
      html = '<h2><i class="icon-'+weather.code+'"></i> '+weather.temp+'&deg;'+weather.units.temp+'</h2>';
      html += '<ul><li>'+weather.city+', '+weather.region+'</li>';
      html += '<li class="currently">'+weather.currently+'</li>';
      html += '<li>'+weather.alt.temp+'&deg;f</li></ul>';  
      
      $("#weather").html(html);
    },
    error: function(error) {
      $("#weather").html('<p>'+error+'</p>');
    }
  });
}