package sharingapp;

import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;

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


//Map this class to /ds route
@Path("/Enqueue")
public class RecordDispatcher {

	@POST
	@Path("/newrecord")
	@Consumes("application/x-www-form-urlencoded")
	public void newRecord(@FormParam("planName") String planName,
			@FormParam("YYYY") String yyyy, @FormParam("MM") String mm,
			@FormParam("DD") String dd, @Context HttpServletResponse response)
			throws Exception {
		UserService userService = UserServiceFactory.getUserService();
		User userName = userService.getCurrentUser();
		String date = yyyy + "-" + mm + "-" + dd;
		Queue queue = QueueFactory.getDefaultQueue();
		queue.add(withUrl("/context/recordworker/createrecord").param("planName", planName).param("date", date).param("userName", userName.toString()));
		response.sendRedirect("/food.jsp?planName=" + planName + "&date="+ date);
		
	}

		
}
