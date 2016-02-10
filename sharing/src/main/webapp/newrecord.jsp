<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	<link type="text/css" rel="stylesheet" href="/stylesheets/css/header.css" />
	<link type="text/css" rel="stylesheet" href="/stylesheets/css/datepicker.css" />
	<style>
		#formpage {clear ="both";}
	</style>


<title>Record Today</title>

<!--<script language="JavaScript">
	window.onload = function() {
		strYYYY = document.form1.YYYY.outerHTML;
		strMM = document.form1.MM.outerHTML;
		strDD = document.form1.DD.outerHTML;
		MonHead = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
		var y = new Date().getFullYear();
		var str = strYYYY.substring(0, strYYYY.length - 9);
		for (var i = (y - 30); i < (y + 30); i++) {
			str += "<option value='" + i + "'> " + i + "</option>\r\n";
		}
		document.form1.YYYY.outerHTML = str + "</select>";
		var str = strMM.substring(0, strMM.length - 9);
		for (var i = 1; i < 13; i++) {
			str += "<option value='" + i + "'> " + i + "</option>\r\n";
		}
		document.form1.MM.outerHTML = str + "</select>";
		document.form1.YYYY.value = y;
		document.form1.MM.value = new Date().getMonth() + 1;
		var n = MonHead[new Date().getMonth()];
		if (new Date().getMonth() == 1 && IsPinYear(YYYYvalue))
			n++;
		writeDay(n);
		document.form1.DD.value = new Date().getDate();
	}
	function YYYYMM(str) {
		var MMvalue = document.form1.MM.options[document.form1.MM.selectedIndex].value;
		if (MMvalue == "") {
			DD.outerHTML = strDD;
			return;
		}
		var n = MonHead[MMvalue - 1];
		if (MMvalue == 2 && IsPinYear(str))
			n++;
		writeDay(n)
	}
	function MMDD(str) {
		var YYYYvalue = document.form1.YYYY.options[document.form1.YYYY.selectedIndex].value;
		if (str == "") {
			DD.outerHTML = strDD;
			return;
		}
		var n = MonHead[str - 1];
		if (str == 2 && IsPinYear(YYYYvalue))
			n++;
		writeDay(n)
	}
	function writeDay(n) {
		var s = strDD.substring(0, strDD.length - 9);
		for (var i = 1; i < (n + 1); i++)
			s += "<option value='" + i + "'> " + i + "</option>\r\n";
		document.form1.DD.outerHTML = s + "</select>";
	}
	function IsPinYear(year) {
		return (0 == year % 4 && (year % 100 != 0 || year % 400 == 0))
	}
-->
</script>


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
                <li><a href="#">My plan</a></li>
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
        <h1>Record Today</h1>
        <p>This example is a quick exercise to illustrate how the default, static and fixed to top navbar work. It includes the responsive CSS and HTML, so it also adapts to your viewport and device.</p>
    	<div class="formpage" style="position: relative; left: 150px;">
		<form name="form1" id="submitform" action="/context/enqueue/newrecord" method="post">
			<fieldset>
				<!-- <p>Name Your New Record:<input type="text" name="RecordName"></p> -->
				<p>Enter Your Start Date:</p>
				<!-- First Name: <input type="text" name="first_name">
				<br />
				Last Name: <input type="text" name="last_name" /> -->
				
				<select name=YYYY onchange="YYYYMM(this.value)">
						<option value="">Year</option>
						<option value=1>1</option>
						<option value=2>2</option>
						<option value=3>3</option>
						<option value=4>4</option>
						<option value=5>5</option>
						<option value=6>6</option>
				</select>
				<select name=MM onchange="MMDD(this.value)">
						<option value="">Month</option>
						<option value=1>1</option>
						<option value=2>2</option>
						<option value=3>3</option>
						<option value=4>4</option>
						<option value=5>5</option>
						<option value=6>6</option>
				</select>
				<select name=DD >
						<option value="">Day</option>
						<option value=1>1</option>
						<option value=2>2</option>
						<option value=3>3</option>
						<option value=4>4</option>
						<option value=5>5</option>
						<option value=6>6</option>
				</select> 
				
				<p><input type="submit" value="Continue to record details"></p>
			</fieldset>
		</form>
	</div>
</div>
      </div>

    </div>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="stylesheets/js/bootstrap.min.js"></script>
    <script src="stylesheets/js/bootstrap-datepicker.js"></script>

</body>
</html>