package sharingapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Context;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.Transaction;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.memcache.ErrorHandlers;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@Path("/checkform")
public class CheckForm{
	@GET
	@Path("/record/{month}/{day}/{year}")
	public String checkRecord(@PathParam("month") String month,
			@PathParam("day") String day,
			@PathParam("year") String year){
		
		UserService userService = UserServiceFactory.getUserService();
		String userName = userService.getCurrentUser().toString();
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		String date = month+"/"+day+"/"+year;
		Key parentKey = KeyFactory.createKey("User", userName);
		Key dateKey = KeyFactory.createKey(parentKey, "date", date);
		System.out.println("into form !");
		try{
			if(datastore.get(dateKey) != null){
				return "{\"result\":\"true\"}";
			}else
				return "{\"result\":\"false\"}";
		}catch(EntityNotFoundException e){
			return "{\"result\":\"false\"}";
		}
	}
}