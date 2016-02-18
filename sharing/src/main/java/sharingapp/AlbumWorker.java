package sharingapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
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
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.Transaction;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.images.ImagesService;
import com.google.appengine.api.images.ImagesServiceFactory;
import com.google.appengine.api.memcache.ErrorHandlers;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@Path("/albumworker")
public class AlbumWorker {
	@POST
	@Path("/createalbum")
	public void createAlbum(@Context HttpServletRequest request) throws Exception {
		String userName = request.getParameter("userName");
		String albumName = request.getParameter("albumName");
		String notes = request.getParameter("notes");
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key albumKey = KeyFactory.createKey("Album", userName + albumName);
		List<BlobKey> list = new ArrayList<BlobKey>();
		
		Entity album = new Entity(albumKey);
		album.setProperty("UserName", userName);
		album.setProperty("albumName", albumName);
		album.setProperty("notes", notes);
		album.setProperty("list", list);
		datastore.put(album);

	}
	
	@POST
	@Path("/addphoto")
	public void addPhoto(@Context HttpServletRequest request) throws Exception{
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Transaction txn = datastore.beginTransaction();
//		try {
		String userName = request.getParameter("userName");
		String albumName = request.getParameter("albumName");
		String blobKey = request.getParameter("blobKey");
		
		BlobKey k = new BlobKey(blobKey);
//		
		Key albumKey = KeyFactory.createKey("Album", userName + albumName);
		Entity album = datastore.get(albumKey);
		
		//List<BlobKey> l = (ArrayList<String>) album.getProperty("list");
		List<BlobKey> list = (List<BlobKey>) album.getProperty("list");
		if(list == null){
			list = new ArrayList<BlobKey>();	}
		list.add(k);
		album.setProperty("list", list);
		//if(list != null){
		//album.setProperty("albumName", "hi");
	//	}
		datastore.put(album);
		txn.commit();
		
//		}finally {
//			if (txn.isActive()) {
//				txn.rollback();
//			}
//		}
		
		
	}
	
		


}