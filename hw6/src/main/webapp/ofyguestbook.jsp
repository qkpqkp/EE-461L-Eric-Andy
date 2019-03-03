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
<%@ page import="guestbook.SubscribedUser" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<html>
  <head>
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  	

 </head>
 
  <body>
  	<header>
 		<img src='/WEB-IMG/main.jpg' alt="pokemon" height="400" width="100%">
 	</header>
 	
<%
	ObjectifyService.register(SubscribedUser.class);
    String guestbookName = request.getParameter("guestbookName");
    if (guestbookName == null) {
        guestbookName = "default";
    }
    pageContext.setAttribute("guestbookName", guestbookName);
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
      	pageContext.setAttribute("p_user", user);
   	
%>
	<form action="/subscribe" method="post">
 		<div><input type="submit" value="Subscribe" /></div>
 		<input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>
 	</form>
<p>Hello, <b>${fn:escapeXml(p_user.nickname)}</b>! You can 
<a href="post.jsp">post </a> or 
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.</p>
<%
    } else {
%>
<p>Hello! Please
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
in order to 
<a href="post.jsp">post</a>
</p>
<%
    }
%>
 
<%
    // Run an ancestor query to ensure we see the most up-to-date
    // view of the Greetings belonging to the selected Guestbook.
    
    ObjectifyService.register(Greeting.class);
	List<Greeting> greetings = ObjectifyService.ofy().load().type(Greeting.class).list();   
	Collections.sort(greetings); 
	
    if (greetings.isEmpty()) {
        %>
        <p>Guestbook '${fn:escapeXml(guestbookName)}' has no messages.</p>
        <%
    } else {
        %>
        <button onclick="hide()" id="b1">Hide</button>
    	<button onclick="show()">List all the posts!</button>
    	<script type="text/javascript">
            		function hide(){
            			
            			document.getElementById('hide').style.display="none";
            			
            		}
            	
            		function show(){
            			
            			document.getElementById('hide').style.display="block";
                	}
            		window.onload = function(){
            		    document.getElementById('b1').click();
            		}
         </script>
         
        <%
        int content_id=0;
        for (int j=0;j<5;j++) {
        	
        	Greeting greeting=greetings.get(j);
        	pageContext.setAttribute("title",
                    greeting.getTitle());
            pageContext.setAttribute("content",
                                     greeting.getContent());
            pageContext.setAttribute("date",greeting.getDate());
            %><hr><%
            if (greeting.getUser() == null) {
            	 %>           	 
                 <p><b>${fn:escapeXml(title)}</b> Post by an anonymous person on <b>${fn:escapeXml(date)}</b></p>
                 <%
            } else {
                pageContext.setAttribute("user",
                                         greeting.getUser());
                %>
                <p class="title"><b>${fn:escapeXml(title)}</b> Post by <b>${fn:escapeXml(user.nickname)}</b> on <b>${fn:escapeXml(date)}</b></p>                
                <%
            }
            
            %>
            <blockquote>${fn:escapeXml(content)}</blockquote>
            <%
        }
        %>
        <div id="hide">
        <%
        for (int j=5;j<greetings.size();j++) {
        	Greeting greeting = greetings.get(j);
        	pageContext.setAttribute("title",
                    greeting.getTitle());
        	pageContext.setAttribute("content",
                    greeting.getContent());
        	pageContext.setAttribute("date",greeting.getDate());
        	%><hr><%
            if (greeting.getUser() == null) {
            	 %>           	 
                 <p>An anonymous person wrote:</p>
                 <%
            } else {
                pageContext.setAttribute("user",
                                        greeting.getUser());
                %>
                <p><b>${fn:escapeXml(title)}</b> Post by <b>${fn:escapeXml(user.nickname)}</b> on <b>${fn:escapeXml(date)}</b></p>
                <%
            }
        	
            %>
            <blockquote>${fn:escapeXml(content)}</blockquote>
            
			<%
			
        }
        %>
        </div>
        <%
        
    }
%>
 
  </body>
</html>