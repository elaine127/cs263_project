<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.memcache.ErrorHandlers"%>
<%@ page import="com.google.appengine.api.memcache.MemcacheService"%>
<%@ page import="com.google.appengine.api.memcache.MemcacheServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.Query.SortDirection"%>



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
    <link type="text/css" rel="stylesheet" href="/stylesheets/css/bootstrap.min.css" >
	<link type="text/css" rel="stylesheet" href="/stylesheets/css/datepicker.css" />
	<style>
		#formpage {clear ="both";}
	</style>
<title>All Records</title>
</head>
<body>
	<%
		UserService userService = UserServiceFactory.getUserService();
		User userName = userService.getCurrentUser();
		pageContext.setAttribute("userName", userName);
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
          <a class="navbar-brand" href="#">Health Diary</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="welcome.jsp">Home</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#contact">Contact</a></li>
                        <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Menue <span class="caret"></span></a>
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
           </div><!--/.nav-collapse -->
      </div>
    </nav>
	<div class="container">

      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
      
      <h1 align="center">Record History:</h1>
      <%
      	DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
      	pageContext.setAttribute("userName", userName.toString());
      	Key parentKey = KeyFactory.createKey("User", userName.toString());
      	Query q = new Query("date").setAncestor(parentKey);
      	//.addSort("date",SortDirection.DESCENDING)
      	PreparedQuery pq = ds.prepare(q);
      	for(Entity e: pq.asIterable()){
      		String date = (String)e.getProperty("date");
      		pageContext.setAttribute("date", date);
      %>
      <div>
      	<form action="/context/enqueue/deleterecord?date=${fn:escapeXml(date)}" method="post">
      	<h1>
      		<a href ="plandetails.jsp?date=${fn:escapeXml(date)}">${fn:escapeXml(date)}</a>
      		<input type="submit" value="Delete This Plan">
      	</h1>
      	</form>
      </div>
      <%
      	}
      %>
      </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="stylesheets/js/bootstrap.min.js"></script>

</body>
</html>