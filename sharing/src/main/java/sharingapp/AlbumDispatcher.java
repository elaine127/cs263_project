package sharingapp;

import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;


import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
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

@Path("/album")
public class AlbumDispatcher {

//	@Context
//	ServletContext context;
	@POST
	@Path("/newalbum")
	@Consumes("application/x-www-form-urlencoded")
	public Response newAlbum(@FormParam("albumName") String albumName,@FormParam("notes") String notes, @Context HttpServletRequest request, @Context HttpServletResponse response) throws IOException, URISyntaxException{
		UserService userService = UserServiceFactory.getUserService();
		User userName = userService.getCurrentUser();
		Queue queue = QueueFactory.getDefaultQueue();
		queue.add(withUrl("/context/albumworker/createalbum").param("albumName", albumName).param("notes", notes).param("userName", userName.toString()));
		return Response.temporaryRedirect(new URI("/addphoto.jsp?albumName="+albumName)).build();
		
	}
	@POST
	@Path("/upload")
	@Consumes("application/x-www-form-urlencoded")
	public Response newPhoto(@Context HttpServletRequest request, @Context HttpServletResponse response) throws IOException, URISyntaxException{
		UserService userService = UserServiceFactory.getUserService();
		User userName = userService.getCurrentUser();
		String albumName = request.getParameter("albumName");
		BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
		Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(request);
		if(blobs.size()== 0|| blobs == null) 
			return Response.temporaryRedirect(new URI("welcome.jsp")).build();
		else{
			List<BlobKey> blobKeys = blobs.get("myFile");
			Queue queue = QueueFactory.getDefaultQueue();
			for(BlobKey k : blobKeys){
				queue.add(withUrl("/context/albumworker/addphoto").param("userName", userName.toString()).param("albumName", albumName).param("blobKey", k.getKeyString()));
			}
			return Response.temporaryRedirect(new URI("welcome.jsp")).build();
		}
	}
	
	
//	@GET
//	@Path("/allalbum")
//	@Consumes("application/x-www-form-urlencoded")
//	public String getAllAlbum() throws IOException, URISyntaxException
//			 {
//		UserService userService = UserServiceFactory.getUserService();
//		User userName = userService.getCurrentUser();
//		String date = yyyy + "-" + mm + "-" + dd;
//		Queue queue = QueueFactory.getDefaultQueue();
//		queue.add(withUrl("/context/recordworker/createrecord").param("date", date).param("userName", userName.toString()));
//		return Response.temporaryRedirect(new URI("/food.jsp?date=" + date)).build();
//			 }

	


	
	
		
}
