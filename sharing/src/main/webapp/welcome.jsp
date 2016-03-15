<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Welcome Health Diary</title>

    <!-- Bootstrap core CSS --><!-- 
    <link rel="stylesheet" type="text/css" href="/stylesheets/css/demo.css" />
    <link rel="stylesheet" type="text/css" href="/stylesheets/css/style.css" />
    <link rel="stylesheet" type="text/css" href="/stylesheets/css/elastislide.css" />
     -->
    <link href='http://fonts.googleapis.com/css?family=PT+Sans+Narrow&v1' rel='stylesheet' type='text/css' />
    <link href='http://fonts.googleapis.com/css?family=Pacifico' rel='stylesheet' type='text/css' />
   
    <link rel="stylesheet" href="stylesheets/css/bootstrap.min.css" >
    <!-- <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    --> 
    </head>

  <body>
 <%
    UserService userService = UserServiceFactory.getUserService();
    User userName = userService.getCurrentUser();
    pageContext.setAttribute("userName",userName);
    //String userName = userService.getCurrentUser().toString();
    if (userName == null) {
  %>
<!-- Fixed navbar -->
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
                <li><a href="<%=userService.createLoginURL(request.getRequestURI())%>">Record Today</a></li>
                <li><a href="<%=userService.createLoginURL(request.getRequestURI())%>">Record History</a></li>
                <li><a href="<%=userService.createLoginURL(request.getRequestURI())%>">My plan</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header">Nav header</li>
                <li><a href="#">Separated link</a></li>
                <li><a href="#">One more separated link</a></li>
              </ul>
            </li>
          </ul>
           </div><!--/.nav-collapse -->
      </div>
    </nav>
    <div class="container">

      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
        <h1>Keep Record</h1>
        <p>This app is a easy diary to record your daily life including diet, exercise, weight.</p>
        <p>My Album offers you a convenient management of your daily photos.</p>
        <p>Please drop down menu for detail</p>
        <p>Please sign in </p>
         <a class="btn btn-lg btn-primary" href="<%=userService.createLoginURL(request.getRequestURI())%>" role="button">Sign In</a>
       </p>
      </div>

    </div> <!-- /container -->
    
<%
    }else{
    pageContext.setAttribute("user", userName);	
%>
    <!-- Fixed navbar -->
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
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Menu <span class="caret"></span></a>
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
        <h1>Keep Record</h1>
        <p>This app is a easy diary to record your daily life including diet, exercise, weight.</p>
        <p>My Album offers you a convenient management of your daily photos.</p>
        <p>Please drop down menu for detail</p>
        
      </div>

    </div> <!-- /container -->
    
    <%
    }
    %>
    

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    
     <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    </body>
</html>
