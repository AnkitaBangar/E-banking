<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*,com.onlinebank.BankCommons"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.security.MessageDigest" %>
<%!
	public int sendemail(String emailto, String emailtype, String frAcname, String toAcname,int frAcNo, int toAcNo, int amount, int currebal){
		int result;
		
		String emailsubject = "";
		String emailbody = "";
		String sql = "";
		if(emailtype == "transferto"){
			sql = "SELECT email FROM user_details WHERE uname ='"+toAcname+"'";
			//System.out.println(sql);
		}else{
			sql = "SELECT email FROM user_details WHERE uname ='"+frAcname+"'";
			//System.out.println(sql);
		}
		
		String loggedinuseremail = null;
		loggedinuseremail = BankCommons.getEmail(sql);
		
		
		if(emailtype == "registration"){
			emailsubject = "Registration Confirmation for On-line Banking";
			emailbody = "<h3>Greetings from Trimurti Bank ltd!!!</h3>";
			emailbody += "<br/> Hi "+frAcname+",";
			emailbody += "<br/><br/> Thank you for your registration with our bank";
			emailbody += "<br/> Inorder to activate your account, Please <a href='http://localhost:8080/onlinebank/activateac.jsp?acun="+frAcname+"&action=1&dologin=1' target='_blank'> click here</a>";
			emailbody += "<br/><br/>Thanks & Regards,";
			emailbody += "<br/>Trimurti Bank Ltd,";
			emailbody += "<br/>Nerul Navi Mumbai,";
			emailbody += "<br/>Customer Care No: 1800 000 000";
			//return emailsubject+" <br/>"+emailbody;
		}
		if(emailtype == "deposite"){
			emailsubject = "Bank Alert Deposite!!";
			emailbody = "<h3>Greetings from Trimurti Bank ltd!!!</h3>";
			emailbody += "<br/> Hi "+frAcname+",";
			emailbody += "<br/><br/> Thank you for using Trimurti Bank On-line Services";
			emailbody += "<br/> We have received a request for fund deposite to your Account # "+ frAcNo +" of amount <b>"+ amount + "</b>" ;
			emailbody += "<br/> Your Account # "+ frAcNo +" has been Credited with amount <b>"+ amount + "</b>" ;
			emailbody += "<br/> Your Account # "+ frAcNo +" current balance is amount <b>"+ currebal + "</b>" ;
			emailbody += "<br/><br/>Thanks & Regards,";
			emailbody += "<br/>Trimurti Bank Ltd,";
			emailbody += "<br/>Nerul Navi Mumbai,";
			emailbody += "<br/>Customer Care No: 1800 000 000";
			//return emailsubject+" <br/>"+emailbody;
		}
		if(emailtype == "withdraw"){
			emailsubject = "Bank Alert Withdraw!!";
			emailbody = "<h3>Greetings from Trimurti Bank ltd!!!</h3>";
			emailbody += "<br/> Hi "+frAcname+",";
			emailbody += "<br/><br/> Thank you for using Trimurti Bank On-line Services";
			emailbody += "<br/> We have received a request for fund withdraw from "+ frAcname +" Account # "+ frAcNo +" of amount <b>"+ amount + "</b>" ;
			emailbody += "<br/> Your Account # "+ frAcNo +" has been Debited with amount <b>"+ amount + "</b>" ;
			emailbody += "<br/> Your Account # "+ frAcNo +" current balance is amount <b>"+ currebal + "</b>" ;
			emailbody += "<br/><br/>Thanks & Regards,";
			emailbody += "<br/>Trimurti Bank Ltd,";
			emailbody += "<br/>Nerul Navi Mumbai,";
			emailbody += "<br/>Customer Care No: 1800 000 000";
			//return emailsubject+" <br/>"+emailbody;
		}
		if(emailtype == "transferto"){
			emailsubject = "Bank Alert Transfer!!";
			emailbody = "<h3>Greetings from Trimurti Bank ltd!!!</h3>";
			emailbody += "<br/> Hi "+toAcname+",";
			emailbody += "<br/><br/> Thank you for using Trimurti Bank On-line Services";
			emailbody += "<br/> You have received a fund from "+ frAcname +" Account # "+ frAcNo +" of amount <b>"+ amount + "</b>" ;
			emailbody += "<br/> Your Account # "+ toAcNo +" has been Credited with amount <b>"+ amount + "</b>" ;
			emailbody += "<br/> Your Account # "+ toAcNo +" current balance is amount <b>"+ currebal + "</b>" ;
			emailbody += "<br/><br/>Thanks & Regards,";
			emailbody += "<br/>Trimurti Bank Ltd,";
			emailbody += "<br/>Nerul Navi Mumbai,";
			emailbody += "<br/>Customer Care No: 1800 000 000";
			//return emailsubject+" <br/>"+emailbody;
		}
		if(emailtype == "transferfr"){
			emailsubject = "Bank Alert Transfer!!";
			emailbody = "<h3>Greetings from Trimurti Bank ltd!!!</h3>";
			emailbody += "<br/> Hi "+frAcname+",";
			emailbody += "<br/><br/> Thank you for using Trimurti Bank On-line Services";
			emailbody += "<br/> We have received a request of fund transfer from  your Account # "+ frAcNo +" of amount <b>"+ amount + " to Account # "+ toAcNo +" </b>" ;
			emailbody += "<br/> Your Account # "+ frAcNo +" has been Debited with amount <b>"+ amount + "</b>" ;
			emailbody += "<br/> Your Account # "+ frAcNo +" current balance is amount <b>"+ currebal + "</b>" ;
			emailbody += "<br/><br/>Thanks & Regards,";
			emailbody += "<br/>Trimurti Bank Ltd,";
			emailbody += "<br/>Nerul Navi Mumbai,";
			emailbody += "<br/>Customer Care No: 1800 000 000";
			//return emailsubject+" <br/>"+emailbody;
		}
		
		// Recipient's email ID needs to be mentioned.
		String to = null;
		if(emailto != ""){
			to = emailto;
		}else{
			to = loggedinuseremail;
		}
		
		// Sender's email user ID needs to be mentioned
		String user = "anki2590@gmail.com"; //put ur mail id here

		// Sender's email Password needs to be mentioned
		String pass = "Ankita468"; // your mail id password

		// Sender's email ID needs to be mentioned
	   String from = "anki2590@gmail.com"; // put ur mail id here
		



	   // Assuming you are sending email from localhost
	   String host = "smtp.gmail.com";


		boolean sessionDebug = false;
		
		// Get system properties object
		Properties props = System.getProperties();
		// Setup mail server
		props.put("mail.host", host);
		// Setup mail server transfer protocol
		props.put("mail.transport.protocol", "smtps");
		// Setup mail server is auth required
		props.put("mail.smtps.auth", "true");
		// Setup mail server using port
		props.put("mail.smtps.port", "465");
		// Setup mail server over SSL or not
		props.put("mail.smtps.ssl.trust", host);

	   

	   // Get the default Session object.
	   Session mailSession = Session.getDefaultInstance(props, null);

	   try{
		  // Create a default MimeMessage object.
		  MimeMessage message = new MimeMessage(mailSession);
		  // Set From: header field of the header.
		  message.setFrom(new InternetAddress(from));
		  // Set To: header field of the header.
		  message.setRecipient(Message.RecipientType.TO,
								   new InternetAddress(to));
		  //add BCC email id to send mail
		  message.setRecipient(Message.RecipientType.BCC,
								   new InternetAddress("onlinebank@trimurtinfotech.com"));
		  
		  // Set Subject: header field
		  message.setSubject(emailsubject);
		 
		  // Send the actual HTML message, as big as you like
		  
		  message.setContent(emailbody,"text/html" );
		  // Send message

		   Transport transport = mailSession.getTransport("smtps");
			transport.connect(host, user, pass);
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();
		  
		  result = 1;
	   }catch (MessagingException mex) {
		  mex.printStackTrace();
		  result = 0;
	   }
	   return result;
	}
	
%>
<%
//int rs = 0;
//int rs1 = 0;
//rs = sendemail("","transferto","admin","test",1567277,935347 ,100,200);
//rs1 = sendemail("","transferfr","admin","test",1567277,935347 ,100,200);
//System.out.println(rs+"Test");
%>
