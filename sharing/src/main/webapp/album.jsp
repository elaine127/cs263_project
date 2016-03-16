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

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">
    <!-- Bootstrap core CSS -->
    <link type="text/css" rel="stylesheet" href="/stylesheets/bootstrap.min.css" >

	
	<style>
		#formpage {clear ="both";}
	</style>
<title>All Records</title>

</head>

<body>

<%
UserService userService = UserServiceFactory.getUserService();
String userName = userService.getCurrentUser().toString();
pageContext.setAttribute("userName",userName);
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
                <li><a href="album.jsp">My Albums</a></li>
        
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
      <!-- Main component for a primary marketing message or call to action -->
      <div  class="jumbotron">
      <h1>My Albums</h1>
      </div>
      <div class="es-carousel">
     	 <ul id="list">
      </ul> 
      </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="stylesheets/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		$.getJSON("/context/album/allalbums", function(data){
			console.log(data.length);
			$.each(data,function(i, item){
				$("#list").append(
						'<div id ="photo" class ="photo" style="width:240px; height:260px;float:left" >'
						+'<h4  align="center" style="margin-top:2px; margin-bottom:3px">AlbumName: '
						+item.albumName
						+'</h4>'
						+'<a href="gallery.jsp?albumName='
					    +item.albumName
					    +'"\>'
					    +'<img style="padding-top: 0px;padding-left: 20px;width:230px;height:180px" src="'
					    + item.imageUrl
					    +'" /><br/>'
					    + '</a>'
					    + '<p  align="center" style="margin-top:2px; margin-bottom:3px">'
					    + item.notes
					    + '</p> <form action="/context/album/deletealbum?albumName='
					    + item.albumName
					    +'" method="post"> <input class="btn btn-primary btn-sm" type="submit" style="display: block; margin: 0 auto;" value="delete"></form>'
					    + '</div>'
						);
			});
			$("#list").append(
					    '<div id="newlink" style="width:240px; height:240px;float:left" >'
					    + '<h2 style="margin:50px;"> <a href="newalbum.jsp">Add New Album </a>'
					    + '</h2>'
					    + '</div>'
						);
		});
	});
</script>
</body>
</html>