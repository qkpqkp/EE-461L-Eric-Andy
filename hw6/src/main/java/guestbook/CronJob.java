package guestbook;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.logging.Logger;
@SuppressWarnings("serial")
public class CronJob extends HttpServlet {
	
	private static final Logger _logger = Logger.getLogger(CronJob.class.getName());
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		try {
			_logger.info("Cron Job has been executed");
			//Put your logic here
			//BEGIN
			//END
		}
		catch (Exception ex) {
			//Log any exceptions in your Cron Job
		}
	}
}