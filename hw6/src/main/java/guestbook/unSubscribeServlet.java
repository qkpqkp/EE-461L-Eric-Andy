package guestbook;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;
public class unSubscribeServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
		UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        String guestbookName = req.getParameter("guestbookName");
        Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);
        List<SubscribedUser> users = ObjectifyService.ofy().load().type(SubscribedUser.class).list();
        
        
        
        for (SubscribedUser u:users) {
        	
        	if(u.toString().equals(user.getNickname())) {	
        		ofy().delete().entity(u).now();
        		resp.sendRedirect("/ofyguestbook.jsp?unsubscription=success");
        		return;
        	}
        }

        resp.sendRedirect("/ofyguestbook.jsp?unsubscription=fail");
	}
}