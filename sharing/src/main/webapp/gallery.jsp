<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<%@ page import="com.google.appengine.api.memcache.MemcacheService"%>
<%@ page import="com.google.appengine.api.memcache.ErrorHandlers"%>
<%@ page import="com.google.appengine.api.memcache.MemcacheServiceFactory"%>

<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>

<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@ page import="com.google.appengine.api.datastore.Query.SortDirection"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title></title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  
  <link rel="stylesheet" type="text/css" href="/stylesheets/bootstrap.min.css" >
    
  <link rel="stylesheet" href="/stylesheets/demo.css">
  
<!--   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
 -->  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
   
</head>

<body>
<%
UserService userService = UserServiceFactory.getUserService();
String userName = userService.getCurrentUser().toString();
pageContext.setAttribute("userName",userName);
String albumName = request.getParameter("albumName");
pageContext.setAttribute("albumName", albumName);
Key parentKey = KeyFactory.createKey("User", userName);
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
<div id="wrapper">
    <h1>${fn:escapeXml(albumName)}</h1>
    
    <h2 align="center"> 
    <font size="4px"> <a href="addphotos.jsp?albumName=${fn:escapeXml(albumName)}">Add photos </a>&nbsp;&nbsp;<a href="deletephoto.jsp?albumName=${fn:escapeXml(albumName)}"> Delete photos </a>
    </font>
	</h2>

    <!-- Slideshow 4 -->
    <div class="callbacks_container">
      <ul class="rslides" id="slider4">
 
      </ul>
    </div>
  <!--    <ul class="events">
      <li><h3>Example 4 callback events</h3></li>
    </ul> -->
    <h2 align="center"> 
    <font size="4px"> <a href="album.jsp">Back to Albums </a>
    </font>
	</h2>
    </div>
     
 <script type="text/javascript">
	$(document).ready(function(){
		$.getJSON("/context/album/allImages?albumName=${fn:escapeXml(albumName)}" , function(data){
			$.each(data,function(i, item){ 
 		
 				$("#slider4").append(
 		 				/* 		style="padding-top: 0px;padding-left: 20px;width:200px;height:180px" */
 								'<li>'
 								+'<img src="'
 								+item.imageUrl
 								+'" alt=""></li>'
 								); 
			});	
			// Slideshow 4
		      $("#slider4").responsiveSlides({
		        auto: false,
		        pager: false,
		        nav: true,
		        speed: 500,
		        namespace: "callbacks",
		        before: function () {
		          $('.events').append("<li>before event fired.</li>");
		        },
		        after: function () {
		          $('.events').append("<li>after event fired.</li>");
		        }
		      });
		});
	});
</script>

<script src="/js/responsiveslides.min.js"></script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->
<!-- <script src="/js/bootstrap.min.js"></script> -->
      
    </body>
</html>