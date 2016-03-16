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

<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService"%>


<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">
    
    
	<!-- <link type="text/css" rel="stylesheet" href="/stylesheets/css/header.css" />
		<link type="text/css" rel="stylesheet" href="/stylesheets/innerNav.css" />
 -->	<link href="stylesheets/bootstrap.css" rel="stylesheet">
<!--     <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    -->
	<!--   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
 -->  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  
    <style>
		#formpage {clear ="both";}
	</style>


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

<div class = "container">
<div class="jumbotron">
<h2 > 
    <font size="4px"> <a href="gallery.jsp?albumName=${fn:escapeXml(albumName)}">Back to Album Gallery </a>
    </font>
</h2>
</div>

 <script type="text/javascript">
	$(document).ready(function(){
		$.getJSON("/context/album/allImages?albumName=${fn:escapeXml(albumName)}" , function(data){
			$.each(data,function(i, item){ 
				console.log(data.length);
 				$("#list").append(
 		 				/* 		style="padding-top: 0px;padding-left: 20px;width:200px;height:180px" */
 		 						
 								'<div id ="photo" class ="photo" style="width:240px; height:240px;float:left" >'
 								+'<img  style="padding-top: 10px;padding-left: 20px;width:230px;height:180px" src="'
 								+item.imageUrl
 								+'" /><br/><form action = "/context/album/deletephoto?albumName=${fn:escapeXml(albumName)}&blobKey='
 							    +item.blobKey
 							    +'" method ="POST"> <input class="btn btn-info" type="submit" style="display: block; margin: 0 auto;" value="delete" /></form></div>'
 							    );
			});	
 							
			});
	});
		
 </script>
 
<div id="list">
<!-- <h1>hello</h2> -->


</div>
</div>
<script src="/js/bootstrap.min.js"></script>
</body>
</html>