<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ page import="java.util.Collections" %>
<%@ page import="guestbook.Greeting" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html>
<head>
<title>post</title>
<link type="text/css" rel="stylesheet" href="/stylesheets/post.css" />
</head>
<body>
	<%
	UserService userService = UserServiceFactory.getUserService();
   	User user = userService.getCurrentUser();
   	String guestbookName = request.getParameter("guestbookName");
    if (guestbookName == null) {
        guestbookName = "default";
    }
    pageContext.setAttribute("guestbookName", guestbookName);
    if (user != null) {
      	pageContext.setAttribute("p_user", user);
    }
	if (pageContext.getAttribute("p_user")==null){
		
	%>
	<p>Input a title</p>
		<div><textarea name="title" rows="1" cols="20"></textarea></div>
		<p>Input the content below</p>
    	<div><textarea name="content" rows="3" cols="60"></textarea></div>
      	  <div>
      	  	<a href="<%=userService.createLoginURL(request.getRequestURI()) %>">
      	   	<button >Post Greeting</button>
      	   </a>
      	 </div>
      	  <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>
    <% 
	} else{
		%>
		<form action="/sign" method="post">
		<p>Input a title</p>
		<div><textarea name="title" rows="1" cols="20"></textarea></div>
		<p>Input the content below</p>
      	<div><textarea name="content" rows="3" cols="60"></textarea></div>
      	<div><input type="submit" value="Submit" /></div>
      	<input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>
    	</form>
    	<%
	}
	%>	
</body>
</html>