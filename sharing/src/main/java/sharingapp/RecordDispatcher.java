package sharingapp;

import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
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


@Path("/enqueue")
public class RecordDispatcher {

//	@Context
//	ServletContext context;
	
	@POST
	@Path("/newrecord")
	//@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Consumes("application/x-www-form-urlencoded")
//	@FormParam("planName") String planName,,
	public Response newRecord(@FormParam("YYYY") String yyyy, @FormParam("MM") String mm,@FormParam("DD") String dd,
			 @Context HttpServletResponse response) throws IOException, URISyntaxException
			 {
		UserService userService = UserServiceFactory.getUserService();
		User userName = userService.getCurrentUser();
		String date = yyyy + "-" + mm + "-" + dd;
		Queue queue = QueueFactory.getDefaultQueue();
		queue.add(withUrl("/context/recordworker/createrecord").param("date", date).param("userName", userName.toString()));
		return Response.temporaryRedirect(new URI("/food.jsp?date=" + date)).build();
			 }
	@POST
	@Path("/newfood")
	@Consumes("application/x-www-form-urlencoded")
	public Response newFood(@FormParam("breakfast") String breakfast, @FormParam("lunch") String lunch, @FormParam("dinner") String dinner,@Context HttpServletRequest request,
			 @Context HttpServletResponse response) throws IOException, URISyntaxException{
		UserService userService = UserServiceFactory.getUserService();
		User userName = userService.getCurrentUser();
		String date = request.getParameter("date");
		Queue queue = QueueFactory.getDefaultQueue();
		queue.add(withUrl("/context/foodworker/createfood").param("breakfast", breakfast).param("lunch", lunch).param("dinner", dinner).param("date", date).param("userName", userName.toString()));
		return Response.temporaryRedirect(new URI("/food.jsp?date=" + date)).build();
	}
	
	@POST
	@Path("/newexerise")
	@Consumes("application/x-www-form-urlencoded")
	public Response newExerise(@FormParam("exerise1") String exerise1, @FormParam("exerise2") String exerise2, @FormParam("exerise3") String exerise3, @Context HttpServletRequest request, @Context HttpServletResponse response) throws IOException, URISyntaxException{
		UserService userService = UserServiceFactory.getUserService();
		User userName = userService.getCurrentUser();
		String date = request.getParameter("date");
		Queue queue = QueueFactory.getDefaultQueue();
		queue.add(withUrl("/context/exeriseworker/createexerise").param("exerise1", exerise1).param("exerise2", exerise2).param("exerise3", exerise3).param("date", date).param("userName", userName.toString()));
		return Response.temporaryRedirect(new URI("/exerise.jsp?date=" + date)).build();
		
	}

	@POST
	@Path("/newweight")
	@Consumes("application/x-www-form-urlencoded")
	public Response newExerise(@FormParam("weight") String weight, @Context HttpServletRequest request, @Context HttpServletResponse response) throws IOException, URISyntaxException{
		UserService userService = UserServiceFactory.getUserService();
		User userName = userService.getCurrentUser();
		String date = request.getParameter("date");
		Queue queue = QueueFactory.getDefaultQueue();
		queue.add(withUrl("/context/weightworker/createweight").param("weight", weight).param("date", date).param("userName", userName.toString()));
		return Response.temporaryRedirect(new URI("/weight.jsp?date=" + date)).build();
		
	}
	@POST
	@Path("/deleterecord")
	@Consumes("application/x-www-form-urlencoded")
	public Response deleteRecord(@Context HttpServletRequest request, @Context HttpServletResponse response) throws IOException, URISyntaxException{
		UserService userService = UserServiceFactory.getUserService();
		User userName = userService.getCurrentUser();
		String date = request.getParameter("date");
		
		Queue q = QueueFactory.getDefaultQueue();
		q.add(withUrl("/context/recordworker/deleterecord").param("date", date).param("userName", userName.toString()));
		return Response.temporaryRedirect(new URI("/allrecords.jsp")).build();
		
		
	}
		
}
