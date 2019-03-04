package guestbook;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
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

import java.util.List;
import java.util.logging.Logger;
@SuppressWarnings("serial")
public class CronJob extends HttpServlet {
	
	private static final Logger _logger = Logger.getLogger(CronJob.class.getName());
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		
        
        List<SubscribedUser> users = ObjectifyService.ofy().load().type(SubscribedUser.class).list();
        
        Long day = (long) 86400000;
        Date current_date = new Date();
        
        current_date.setTime(System.currentTimeMillis()-day);
        System.out.println("CronJob works!");
        for (SubscribedUser u:users) {
        	String to = u.toString();
        	String from = "Eric_Andy@spartan-calling-231623.appspotmail.com";

            // Assuming you are sending email from localhost
            String host = "localhost";

            // Get system properties
            Properties properties = System.getProperties();

            // Setup mail server
            properties.setProperty("mail.smtp.host", host);

            // Get the default Session object.
            Session session = Session.getDefaultInstance(properties);

            try {
               // Create a default MimeMessage object.
               MimeMessage message = new MimeMessage(session);

               // Set From: header field of the header.
               message.setFrom(new InternetAddress(from));

               // Set To: header field of the header.
               message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

               // Set Subject: header field
               message.setSubject("This is the Subject Line!");

               // Now set the actual message
               List<Greeting> greetings = ObjectifyService.ofy().load().type(Greeting.class).list();
               Collections.sort(greetings);
               String Mail_Text ="";
               
               for(Greeting greeting:greetings) {
            	   if(greeting.getDate().after(current_date)) {
            		   Mail_Text+=greeting.getTitle()+" post by "+greeting.getUser().toString()+" on "+ greeting.getDate().toString()+"\n";
            		   Mail_Text+=greeting.getContent()+"\n\n";
            	   }
               }
               System.out.println(Mail_Text);
               message.setText(Mail_Text);

               // Send message
               Transport.send(message);
               System.out.println("Sent message successfully....");
            } catch (MessagingException mex) {
               mex.printStackTrace();
            }

        }
	}
}