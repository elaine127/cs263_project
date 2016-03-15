package sharingapp;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;

@Path("/mailworker")
public class MailWorker{
	@POST
	@Path("/mail")
	public void sendEmail(@Context HttpServletRequest request) throws UnsupportedEncodingException{
		String host = "smtp.gmail.com"; 
		String from = "elaineyang127@gmail.com";  
		String pass = "Heatheryy1992~";  
		Properties props = System.getProperties();  
	    props.put("mail.smtp.starttls.enable", "true"); // 在本行添加  
	    props.put("mail.smtp.host", host);  
	    props.put("mail.smtp.user", from);  
	    props.put("mail.smtp.password", pass);  
	    props.put("mail.smtp.port", "587");  
	    props.put("mail.smtp.auth", "true");  

	    
		Session session = Session.getDefaultInstance(props, null);

		String msgBody = "Dear Customer,\n We are sending you this email to report your daily weight."
				+ "\nThe Date is: "
				+ request.getParameter("date")
				+ "\nYour daily weight is: "
				+ request.getParameter("weight")
				+"kg"
				+ "\n"
				+ "\n\n"
				+ "Thank you!"
				+ "\n"
				+ "HealthDairy.com";
		
		String userName = request.getParameter("userName");
		
		try{
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(from));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(userName));
			msg.setSubject("Report Daily Weight");
			msg.setText(msgBody);
			Transport transport = session.getTransport("smtp");  
			transport.connect(host, from, pass); 
			transport.sendMessage(msg, msg.getAllRecipients());
			transport.close();  
		}catch(AddressException e){
			e.printStackTrace();
		}catch(MessagingException e){
			e.printStackTrace();
		}
	}
}