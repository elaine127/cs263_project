package sharingapp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

@Path("/albumworker")
public class AlbumWorker {
	@POST
	@Path("/createalbum")
	public void createAlbum(@Context HttpServletRequest request)
			throws Exception {
		String userName = request.getParameter("userName");
		String albumName = request.getParameter("albumName");
		String notes = request.getParameter("notes");
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key albumKey = KeyFactory.createKey("Album", userName + albumName);
		List<BlobKey> list = null;
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
		String userName = request.getParameter("userName");
		String albumName = request.getParameter("albumName");
		String blobKey = request.getParameter("blobKey");
		
		Key albumKey = KeyFactory.createKey("Album", userName + albumName);
		Entity album = datastore.get(albumKey);
		ArrayList<String> l =(ArrayList<String>)album.getProperty("list");
		if(l.size() == 0||l == null){
			l = new ArrayList<String>();
		}
		l.add(blobKey);
		album.setProperty("list", l);
		datastore.put(album);
		
	}
	


}