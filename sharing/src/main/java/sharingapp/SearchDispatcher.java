/**
 * 
 */
package sharingapp;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

/**
 * @author elaine
 *
 */
@Path("/search")
public class SearchDispatcher {
	
	@POST
	@Path("/food")
	public Response searchFood(@FormParam("searchCity") String city, @Context HttpServletRequest request,@Context HttpServletResponse response) throws IOException, URISyntaxException {
		String date = request.getParameter("date");
		System.out.println(city);
		System.out.println("search!");
		return Response.temporaryRedirect(new URI("/searchfood.jsp?query=" + URLEncoder.encode(city, "UTF-8")+ "&date=" + date)).build();	
	}

}
