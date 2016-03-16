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


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="icon" href="../../favicon.ico">
    <link type="text/css" rel="stylesheet" href="/stylesheets/bootstrap.min.css" >
	<!-- <link type="text/css" rel="stylesheet" href="/stylesheets/css/header.css" />
	 --><!-- <link type="text/css" rel="stylesheet" href="/stylesheets/innerNav.css" />
	 -->

	<style>
		#formpage {clear ="both";}
	</style>

<title>Record Detail</title>
</head>
<body>
	<%
		UserService userService = UserServiceFactory.getUserService();
		String userName = userService.getCurrentUser().toString();
		pageContext.setAttribute("userName",userName);
		String date = request.getParameter("date");
		pageContext.setAttribute("date", date);
		
		Key parentKey = KeyFactory.createKey("User", userName);
		Key dateKey = KeyFactory.createKey(parentKey, "date", date);
		
		Key foodKey = KeyFactory.createKey(dateKey, "food", "food");
		Key exeriseKey = KeyFactory.createKey(dateKey, "exerise", "exerise");
		Key weightKey = KeyFactory.createKey(dateKey, "weight", "weight");
		
		pageContext.setAttribute("exeriseKey", exeriseKey);
		pageContext.setAttribute("foodKey", foodKey);
		pageContext.setAttribute("weightKey", weightKey);
		
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

<div class="container">
      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
      <h1 align="center">My Record Detail:</h1>
      </div>
     <%
     MemcacheService syncCache = MemcacheServiceFactory.getMemcacheService();
     DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
     
	 if(syncCache.get(foodKey) != null ){
			Entity e = (Entity)syncCache.get(foodKey);
			String breakfast = (String)e.getProperty("breakfast");
			String lunch = (String)e.getProperty("lunch");
			String dinner = (String)e.getProperty("dinner");
			pageContext.setAttribute("breakfast", breakfast);
			pageContext.setAttribute("lunch", lunch);
			pageContext.setAttribute("dinner", dinner);
	 }else{
		   Query q3 = new Query("food").setAncestor(dateKey);
			PreparedQuery pq3 = datastore.prepare(q3);
			
			for(Entity result: pq3.asIterable()){
				String breakfast = (String)result.getProperty("breakfast");
				String lunch = (String)result.getProperty("lunch");
				String dinner = (String)result.getProperty("dinner");
				pageContext.setAttribute("breakfast", breakfast);
				pageContext.setAttribute("lunch", lunch);
				pageContext.setAttribute("dinner", dinner);
			}
				
			}
	 %>
	 <% 
	 if(syncCache.get(exeriseKey) != null ){
			Entity e = (Entity)syncCache.get(exeriseKey);
			String exerise = (String)e.getProperty("exerise");
			pageContext.setAttribute("exerise", exerise);
	 }else{
		    Query q2 = new Query("exerise").setAncestor(dateKey);
			PreparedQuery pq2 = datastore.prepare(q2);
			for(Entity result: pq2.asIterable()){
				String exerise = (String)result.getProperty("exerise");
				pageContext.setAttribute("exerise", exerise);
				}
	 }
	 if(syncCache.get(weightKey) != null ){
			Entity e = (Entity)syncCache.get(weightKey);
			String weight = (String)e.getProperty("weight");
			pageContext.setAttribute("weight", weight);
	}else{
		    Query q1 = new Query("weight").setAncestor(dateKey);
			PreparedQuery pq1 = datastore.prepare(q1);
			for(Entity result: pq1.asIterable()){
				String weight = (String)result.getProperty("weight");
				pageContext.setAttribute("weight", weight);
			}	
			}
	
     %>
     
	<div class = "row">
	<div class = "col-xs-6">
 	<div class="leftbody">
	 	
	
	<div class="col-xs-4">
		 <dl>
    		<dt>breakfast</dt>
    		<dd>- ${fn:escapeXml(breakfast)}</dd>
    		<dt>lunch</dt>
   			<dd>- ${fn:escapeXml(lunch)}</dd>
   			<dt>dinner</dt>
   			<dd>- ${fn:escapeXml(dinner)}</dd>
  		</dl> 
  		</div>
	<div class="col-xs-4">
	    <dl>
    		<dt>Exercise</dt>
    		<dd>- ${fn:escapeXml(exerise)}</dd>
  		</dl>
  		</div>
	<div class="col-xs-2">
	    <dl>
    		<dt>Weight(kg)</dt>
    		<dd>- ${fn:escapeXml(weight)}</dd>
  		</dl>
  		</div>		
	 </div>
	 </div>
	 
    <div class ="col-xs-6">
	<div class="rightbody">
	
	
	<li><a href="food.jsp?date=${fn:escapeXml(date)}">update </a></li>
	
   </div>
   </div>
   </div>
   
<!--   	<div>
  		<button type="submit" class="btn btn-primary btn-sm">Click to send to my email</button>
  	</div> -->
  	
   </div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="/js/bootstrap.min.js"></script>

</body>
</html>