package guestbook;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

@Entity
public class SubscribedUser{
	@Parent Key<Guestbook> guestbookName;
	@Id Long id;
	@Index String user;
	private SubscribedUser() {}
	public SubscribedUser(String user) {
		this.user=user;
	}
	
	@Override
	public String toString() {
		return this.user;
	}
}
