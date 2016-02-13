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
		String dateString = httpRequest.getParameter("date");
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key parentKey = KeyFactory.createKey("User", userName);
		Key dateKey = KeyFactory.createKey(parentKey, "date", dateString);
		Entity record = new Entity(dateKey);
		
		record.setProperty("date", dateString);
		record.setProperty("userName", userName);
		
		datastore.put(record);
	}
	
	@POST
	@Path("/deleterecord")
	public void deleteRecord(@Context HttpServletRequest httpRequest)
			throws Exception{
		String userName = httpRequest.getParameter("userName");
		String date = httpRequest.getParameter("date");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
		Key parentKey = KeyFactory.createKey("User", userName);
		Key dateKey = KeyFactory.createKey(parentKey, "date", date);
		Key foodKey = KeyFactory.createKey(dateKey,"food", "food");
		Key exeriseKey = KeyFactory.createKey(dateKey,"exerise", "exerise");
		Key weightKey = KeyFactory.createKey(dateKey,"weight", "weight");
		
		datastore.delete(dateKey);
		datastore.delete(foodKey);
		datastore.delete(exeriseKey);
		datastore.delete(weightKey);
		
		MemcacheService syncCache = MemcacheServiceFactory.getMemcacheService();
		syncCache.delete(dateKey);
		syncCache.delete(foodKey);
		syncCache.delete(exeriseKey);
		syncCache.delete(weightKey);
		
		
//		Query q = new Query("food").setAncestor(dateKey);
//		PreparedQuery pd = datastore.prepare(q);
//		for(Entity e: pd.asIterable()){
//			datastore.delete(e.getKey());
//		}
//		Query q = new Query("exerise").setAncestor(dateKey);
//		PreparedQuery pd = datastore.prepare(q);
//		for(Entity e: pd.asIterable()){
//			datastore.delete(e.getKey());
//		}
//		Query q = new Query("food").setAncestor(dateKey);
//		PreparedQuery pd = datastore.prepare(q);
//		for(Entity e: pd.asIterable()){
//			datastore.delete(e.getKey());
//		}
		
		
//		MemcacheService syncCache = MemcacheServiceFactory.getMemcacheService();
//		syncCache.delete(dateKey);
//		
		
		
	}
	

}
