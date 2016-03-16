<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"  
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places">
</script> 
<link type="text/css" rel="stylesheet" href="/stylesheets/bootstrap.min.css" >
 
<script>
function initialize() {
  var mapProp = {
    center:new google.maps.LatLng(51.508742,-0.120850),
    zoom:5,
    mapTypeId:google.maps.MapTypeId.ROADMAP
  };
  var map=new google.maps.Map(document.getElementById("googleMap"), mapProp);
}
google.maps.event.addDomListener(window, 'load', initialize);
</script> 

<script>
	var geocoder;
	var map;
	var markers = Array();
	var infos = Array();
	function initialize() {
		// set initial position (New York)
 		var myLatlng = new google.maps.LatLng(document.getElementById('lat').value, document.getElementById('lng').value); 
		var myOptions = { // default map options
			zoom : 14,
			center : myLatlng,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		map = new google.maps.Map(document.getElementById('gmap_canvas'),myOptions);
		getAddress();
	}
	function clearOverlays() {
		if (markers) {
			for (i in markers) {
				markers[i].setMap(null);
			}
			markers = [];
			infos = [];
		}
	}
	
	function clearInfos() {
		if (infos) {
			for (i in infos) {
				if (infos[i].getMap()) {
					infos[i].close();
				}
			}
		}
	}
	
	function getParam(param) {
		var httprequest = {
			QueryString : function(val) {
				var uri = window.location.search;
				var re = new RegExp("" + val + "=([^&?]*)", "ig");
				return ((uri.match(re)) ? (decodeURI(uri.match(re)[0].substr(val.length + 1))) : '');
			}
		}
		return httprequest.QueryString(param);
	}
	
 	function addList(results, status, pagination) {
		if (status == google.maps.places.PlacesServiceStatus.OK) {
			for (var i = 0; i < results.length; i++) {
				if (results[i].photos)
					addPhoto(results[i]);
			}
			if (pagination.hasNextPage) {
				pagination.nextPage();
			}
		} else if (status == google.maps.places.PlacesServiceStatus.ZERO_RESULTS) {
			alert('Sorry, nothing is found');
		}
	} 
 	function addPhoto(obj) {
		document.getElementById('list').innerHTML += ('<div class ="row"><div onclick="showdetail(this);" class ="photo" style="width:63%; height:240px;float:left" >'
				+ obj.name
				+ '<br/>'
				+ '<input type="hidden" id="reference" name ="reference" value='+obj.place_id
				+'>'
				+ '<img  src="'
				+ obj.photos[0].getUrl({
					'maxWidth' : 200,
					'maxHeight' : 180
				})
				+ '" style="top: 50px; left:0px; width:200px;height:180px"/><br/>' + '</div></div>');
	}
 	
	function createMarkers(results, status, pagination) {
		if (status == google.maps.places.PlacesServiceStatus.OK) {
			for (var i = 0; i < results.length; i++) {
				createMarker(results[i]);
				//addList(results[i]);
			}
			if (pagination.hasNextPage) {
				sleep: 2;
				pagination.nextPage();
			}
		} else if (status == google.maps.places.PlacesServiceStatus.ZERO_RESULTS) {
			alert('Sorry, nothing is found');
		}
	}
	function createMarker(obj) {
			// prepare new Marker object
		var mark = new google.maps.Marker({
			position : obj.geometry.location,
			map : map,
			title : obj.name
		});
		markers.push(mark);
		
	    google.maps.event.addListener(mark, 'click', function() {
			var address;
			geocoder.geocode({'latLng' : obj.geometry.location}, function(results, status) {
				if (status == google.maps.GeocoderStatus.OK) {
					if (results[0]) {
						address = results[0].formatted_address;
						addInfoWindow(address, mark, obj);
					} else {
						alert('No results found');
					}
				} else {
					alert('Geocoder failed due to: ' + status);
				}
			});
		}); 
	}
	function showdetail(elmnt) {
		//elmnt.style.border-width = "1px";
		var placeID = elmnt.getElementsByTagName('input')[0].value;
		var request = {placeId : placeID};
		var service = new google.maps.places.PlacesService(map);
		service.getDetails(request,function(place, status) {
							if (status == google.maps.places.PlacesServiceStatus.OK) {
								map.setZoom(18);
								map.setCenter(place.geometry.location);
								var thisTitle = place.name;
								for (i = 0; i < markers.length; i++) {
									marker = markers[i];
									// If is same category or category not picked
									if (marker.title == thisTitle) {
										var infowindow = new google.maps.InfoWindow(
												{
													content :
													'<div class="infowin">'
															+ '<img src="' + place.icon + '" /><font style="font-size: 10px; color:black;">'
															+ '<font style="font-size: 30px"><b>'
															+ place.name
															+ '</b></font>'
															+ '<br /><b>Type: </b><br />'
															+ place.types
															+ '<br /><b>Rating: </b><br />'
															+ place.rating
															+ '<br /><b>Website: </b><br />'
															+ '<a href="'+place.website+'">'
															+ place.website
															+ '</a>'
															+ '<br /><b>Address: </b><br />'
															+ '<font style="font-size: 10px">'
															+ place.formatted_address
															+ '</font>'
															+ '</font> </div>'
												});
										clearInfos();
										infowindow.open(map, marker);
										infos.push(infowindow);
										break;
									}
								}
							}
							/* OpenWindow = window.open("", "newwin",
									"height=200, width=3000,toolbar=no, menubar=no");
							OpenWindow.document.close() */
						});
		//map.setCenter()
	}
	function addInfoWindow(address, mark, obj) {
		var infowindow = new google.maps.InfoWindow(
				{
					content : '<div class="infowin"> '
							+ '<img src="' + obj.icon + '" /><font style="font-size: 10px; color:black;">'
							+ '<font style="font-size: 30px"><b>'
							+ obj.name
							+ '</b></font>'
							+ '<br /><b>Type: </b><br />'
							+ obj.types
							+ '<br /><b>Rating: </b><br />'
							+ obj.rating
							+ '<br /><b>Address: </b><br />'
							+ '<font style="font-size: 10px">'
							+ address
							+ '</font>' + '</font> </div>'
				});
		clearInfos();
		infowindow.open(map, mark);
		infos.push(infowindow);
	}
	function getAddress() {
		geocoder = new google.maps.Geocoder();
		var address = getParam("query");
		geocoder.geocode({'address' : address},function(results, status) {
							if (status == google.maps.GeocoderStatus.OK) {
								var addrLocation = results[0].geometry.location;
								map.setCenter(addrLocation);
								document.getElementById('lat').value = results[0].geometry.location.lat();
								document.getElementById('lng').value = results[0].geometry.location.lng();
								var request = {
									location : addrLocation,
									radius : '2000',
									types : [ 'food' ]
								};
							    // send request
								service = new google.maps.places.PlacesService(map);
								service.search(request, addList);
								service.search(request, createMarkers);
						
							} else {
								alert('Geocode was not successful for the following reason: '+ status);
							}
						});
	}
	
	google.maps.event.addDomListener(window, 'load', initialize);
</script>

</head>
<body>
<%
	UserService userService = UserServiceFactory.getUserService();
	User userName = userService.getCurrentUser();
	pageContext.setAttribute("userName", userName);
	String date = request.getParameter("date");
	pageContext.setAttribute("date", date);
	String query = request.getParameter("query");
	pageContext.setAttribute("query", query);
%>
<nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="welcome.jsp">Health Diary</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="#">Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Contact</a></li>
            <li class="dropdown" class="active"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Menu <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li><a href="newrecord.jsp">Record Today</a></li>
                <li><a href="allrecords.jsp">Record History</a></li>
                <li><a href="album.jsp">My Album</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header">Nav header</li>
                <li><a href="#">Separated link</a></li>
                <li><a href="#">One more separated link</a></li>
              </ul>
            </li>
          </ul>
            <ul class="nav navbar-nav navbar-right">
            	<li><a href="../navbar/">Welcome! ${fn:escapeXml(userName)}</a></li>
            	<li><a href="<%=userService.createLogoutURL("welcome.jsp")%>">Sign out</a></li>
          	</ul>
           </div>
      </div>
</nav> 

	<div class="container">
      <div class="jumbotron">
      <!-- <h1>Food Map</h1> -->
      <div class = "row">
      <h2><a href="food.jsp?date=${fn:escapeXml(date)}">Back to Record</a></h2>
      </div>
      	<div class ="row">
		<div class="col-xs-4" style="overflow-y:scroll; height: 450px;">
			<div id="list" style="height: 600px;"></div>
		</div>
		  	
      	<div class="col-xs-6">
      		<input type="hidden" id="lat" name="lat" value="51.508742" /> 
			<input type="hidden" id="lng" name="lng" value="-74.0059731" />
			<div  id="gmap_canvas" style="width:530px;height:450px;"></div>
		</div>
		</div>
		</div>
   </div>
   
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    
</body>
</html>