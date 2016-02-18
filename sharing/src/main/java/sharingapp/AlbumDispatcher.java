package sharingapp;

import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;


import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.blobstore.FileInfo;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.images.ImagesService;
import com.google.appengine.api.images.ImagesServiceFactory;

@Path("/album")
public class AlbumDispatcher {

//	@Context
//	ServletContext context;
	@POST
	@Path("/newalbum")
	@Consumes("application/x-www-form-urlencoded")
	public Response snewAlbum(@FormParam("albumName") String albumName,@FormParam("notes") String notes, @Context HttpServletRequest request, @Context HttpServletResponse response) throws IOException, URISyntaxException{
		UserService userService = UserServiceFactory.getUserService();
		User userName = userService.getCurrentUser();
		Queue queue = QueueFactory.getDefaultQueue();
		queue.add(withUrl("/context/albumworker/createalbum").param("albumName", albumName).param("notes", notes).param("userName", userName.toString()));
		return Response.temporaryRedirect(new URI("/addphotos.jsp?albumName="+albumName)).build();
		
	}
	@POST
	@Path("/upload")
	
	public Response newPhoto(@Context HttpServletRequest request, @Context HttpServletResponse response) throws IOException, URISyntaxException, InterruptedException{
		UserService userService = UserServiceFactory.getUserService();
		User userName = userService.getCurrentUser();
		String albumName = request.getParameter("albumName");
		BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
		Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(request);
     	System.out.println("hello");
		if(blobs.size()== 0|| blobs == null) 
			return Response.temporaryRedirect(new URI("welcome.jsp")).build();
	    else{
			List<BlobKey> blobKeys = blobs.get("myFile");
			Queue queue = QueueFactory.getDefaultQueue();
			for(BlobKey k : blobKeys){
				queue.add(withUrl("/context/albumworker/addphoto").param("userName", userName.toString()).param("albumName", albumName).param("blobKey", k.getKeyString()));
				Thread.sleep(100);
			}
			
			return Response.temporaryRedirect(new URI("/addphotos.jsp?albumName="+albumName)).build();		
	}
	}
	

	@GET
	@Path("/allalbums")

	public List<AlbumData> getAllAlbums() throws Exception {
		UserService userService = UserServiceFactory.getUserService();
		ImagesService imagesService = ImagesServiceFactory.getImagesService();
		User userName = userService.getCurrentUser();
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Filter propertyFilter = new FilterPredicate("userName",FilterOperator.EQUAL, userName.toString());
		Query q = new Query("albumName").setFilter(propertyFilter);
		PreparedQuery pq = datastore.prepare(q);
		List<AlbumData> la = new ArrayList<AlbumData>();
		for (Entity entity : pq.asIterable()) {
			List<String> list = (ArrayList<String>) entity.getProperty("list");
			String imageUrl = null;
			if(list != null){
				for(int i =0; i < list.size(); i++){
					BlobKey blobKey = new BlobKey(list.get(i));
					try{
						imageUrl = imagesService.getServingUrl(blobKey);
						break;
						
					}catch(java.lang.IllegalArgumentException e){
						
					}
				}
			}
			if(imageUrl ==null)
				imageUrl="/images/no_image.png";
			
			AlbumData ad = new AlbumData(entity.getProperty("albumName").toString(), entity.getProperty("notes").toString(), imageUrl);
			
			la.add(ad);		
	}
		return la;
		
	}
}

	
