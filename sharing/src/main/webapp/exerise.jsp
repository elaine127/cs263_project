<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" rel="stylesheet" href="/stylesheets/header.css" />
<link type="text/css" rel="stylesheet" href="/stylesheets/innerNav.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Record Food</title>
</head>
<body>
	<%
		UserService userService = UserServiceFactory.getUserService();
		String userName = userService.getCurrentUser().toString();
		pageContext.setAttribute("userName",userName);
		String date = request.getParameter("date");
		pageContext.setAttribute("date", date);
	%>
	<div class="container">
		<div id="header" class="headernav">
			<h3 float="right">Welcome! ${fn:escapeXml(userName)}</h3>
			<ul>
				<li><a href="<%=userService.createLogoutURL("welcome.jsp")%>">Sign out</a></li>
				<li><a href="allrecords.jsp">MyHistory</a></li>
				<li><a href="newrecord.jsp">RecordToday</a></li>
				<li><a href="welcome.jsp">Home</a></li>
			</ul>
		</div>
		<div>
			<p>Please record here</p>
		</div>
		<div class="body">
			<div class="leftbody">
				<div class="nav" align="center">
				<ul>
					<li><a style="color: black" href="food.jsp?date=${fn:escapeXml(date)}">Food</a></li>
					<li><a style="color: black; background: #0489B1" href="exerise.jsp?date=${fn:escapeXml(date)}">Exerise</a></li>
					<li><a style="color: black" href="weight.jsp?date=${fn:escapeXml(date)}">Weight</a></li>
				</ul>
				</div>
				<fieldset style="margin-left: 8px; margin-right: 2px">
				<form id ="submitform1" name="form1" action="/context/enqueue/newexerise?date=${fn:escapeXml(date)}" method="post">
					<p>Please enter your exerise details:</p>
					<div>
						<p>exerise1</p>
						<select name="exerise1">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
						</select>
						<p>exerise2</p>
						<select name="exerise2">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
						</select>
						<p>exerise3</p>
						<select name="exerise3">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
						</select>
						
					</div>
					<!-- <p>Notes:<input type="text" name="notes" style="width: 90%"></p> -->
					<p><input type="submit" value="Submit"></p>
				</form>
				</fieldset>
			</div>
			
			<div class="rightbody">
			</div>
		</div>
	</div>
</body>
</html>