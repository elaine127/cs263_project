package sharingapp;

import java.util.Date;
import java.util.logging.Level;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.memcache.ErrorHandlers;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;

@Path("/recordworker")
public class RecordWorker {
	@POST
	@Path("/createrecord")
	public void createRecord(@Context HttpServletRequest httpRequest)
			throws Exception{

		String userName = httpRequest.getParameter("userName");
		String planName = httpRequest.getParameter("planName");
		String dateString = httpRequest.getParameter("date");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key parentKey = KeyFactory.createKey("User", userName);
		Key planKey = KeyFactory.createKey(parentKey, "Plan", planName);
		Entity plan = new Entity(planKey);
		plan.setProperty("planName", planName);
		plan.setProperty("date", dateString);
		plan.setProperty("userName", userName);
		datastore.put(plan);
	}
	
	@POST
	@Path("/deleterecord")
	public void deleteRecord(@Context HttpServletRequest httpRequest)
			throws Exception{
		String userName = httpRequest.getParameter("userName");
		String planName = httpRequest.getParameter("planName");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key parentKey = KeyFactory.createKey("User", userName);
		Key planKey = KeyFactory.createKey(parentKey, "Plan", planName);
		
		
	}
	

}
