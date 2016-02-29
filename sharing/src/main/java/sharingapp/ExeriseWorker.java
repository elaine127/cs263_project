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

@Path("/exeriseworker")
public class ExeriseWorker {
	@POST
	@Path("/createexerise")
	public void createExerise(@Context HttpServletRequest httpRequest)
			throws Exception{

		String userName = httpRequest.getParameter("userName");
		String dateString = httpRequest.getParameter("date");
		String exerise = httpRequest.getParameter("exerise");
		
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key parentKey = KeyFactory.createKey("User", userName);
		Key dateKey = KeyFactory.createKey(parentKey, "date", dateString);
		Key exeriseKey = KeyFactory.createKey(dateKey, "exerise","exerise");
		
		Entity record = new Entity(exeriseKey);

		record.setProperty("date", dateString);
		record.setProperty("userName", userName);
		record.setProperty("exerise", exerise);
		datastore.put(record);
		
		MemcacheService syncCache = MemcacheServiceFactory.getMemcacheService();
		syncCache.setErrorHandler(ErrorHandlers.getConsistentLogAndContinue(Level.INFO));
		syncCache.put(exeriseKey, record);		
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
