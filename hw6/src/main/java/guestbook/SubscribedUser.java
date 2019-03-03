package guestbook;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

@Entity
public class SubscribedUser{
	@Parent Key<String> user;
	@Id Long id;
	private SubscribedUser() {}
	public SubscribedUser(String user) {
		this.user=Key.create(String.class,user);
	}
	@Override
    public boolean equals(Object o) {
        if(o.getClass()!=SubscribedUser.class) {
        	return false;
        }
        if(o.toString()!=this.toString()) {
        	return false;
        }else {
        	return true;
        }
    }
	@Override
	public String toString() {
		return this.user.getString();
	}
}
