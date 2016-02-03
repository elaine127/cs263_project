<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TripPlan Welcom Page</title>
<link type="text/css" rel="stylesheet" href="/stylesheets/header.css"/>
</head>
<body>
<%
	UserService userService = UserServiceFactory.getUserService();
    User userName = userService.getCurrentUser();
    if (userName != null) {
        pageContext.setAttribute("user", userName);
%>
<div class="headernav">
	<h3 float="left">Welcome! ${fn:escapeXml(userName)}</h3>
	<ul>
	<li><a href="<%=userService.createLogoutURL("welcome.jsp")%>">Sign out</a></li>
	<li><a href="allrecords.jsp">MyHistory</a></li>
	<li><a href="newrecord.jsp">RecordToday</a></li>
	<li><a href="welcome.jsp">Home</a></li>
	</ul>
</div>
<%} else{ %>

<div class="headernav">
	<ul>
			<li><a href="<%=userService.createLoginURL(request.getRequestURI())%>">SignIn</a></li>
			<li><a href="<%=userService.createLoginURL(request.getRequestURI())%>">MyPlans</a></li>
			<li><a href="<%=userService.createLoginURL(request.getRequestURI())%>">PlanATrip</a></li>
			<li><a href="<%=userService.createLoginURL(request.getRequestURI())%>">Home</a></li>
	</ul>
</div>
<%
}
%>
<div id="Layer1" clear="both"
		style="position: absolute; width: 100%; height: 100%; z-index: -1">
		<img src="images/back.jpg" height="100%" width="100%" />
</div >	

</body>
</html>