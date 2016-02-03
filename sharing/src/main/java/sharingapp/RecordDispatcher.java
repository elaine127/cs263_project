package sharingapp;

import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;

import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;


@Path("/Enqueue")
public class RecordDispatcher {

	@POST
	@Path("/newrecord")
	@Consumes("application/x-www-form-urlencoded")
//	@FormParam("planName") String planName,,
	public void newRecord(@FormParam("YYYY") String yyyy, @FormParam("MM") String mm,@FormParam("DD") String dd,
			 @Context HttpServletResponse response) throws IOException
			 {
		UserService userService = UserServiceFactory.getUserService();
		User userName = userService.getCurrentUser();
		String date = yyyy + "-" + mm;
		Queue queue = QueueFactory.getDefaultQueue();
		//.param("planName", planName)
		queue.add(withUrl("/context/recordworker/createrecord").param("date", date).param("userName", userName.toString()));
		response.sendRedirect("/food.jsp?date=" + date);
			 }
	@POST
	@Path("/newfood")
	@Consumes("application/x-www-form-urlencoded")
	public void newFood(@FormParam("day") String day, @FormParam("notes") String notes,@Context HttpServletRequest request,
			 @Context HttpServletResponse response) throws IOException{
		UserService userService = UserServiceFactory.getUserService();
		User userName = userService.getCurrentUser();
		String date = request.getParameter("date");
		Queue queue = QueueFactory.getDefaultQueue();
		queue.add(withUrl("/context/foodworker/createfood").param("date", date).param("day", day).param("notes", notes).param("userName", userName.toString()));
		response.sendRedirect("/food.jsp?date="+date);
	}
	

		
}
