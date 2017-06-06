<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*,com.onlinebank.BankCommons"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.security.MessageDigest" %>
<%
//java Code

String acuname = request.getParameter("acun");
String action = request.getParameter("action");
int dologin = 0;
if(request.getParameter("dologin") != null){
	dologin = Integer.valueOf((String)request.getParameter("dologin"));
}

String sql_up = "UPDATE user_details SET is_active = '"+action+"' WHERE uname = '"+acuname+"'";
int up = BankCommons.update(sql_up);

if(up == 1 ){
	if(dologin == 1){
		session.invalidate();
		request.setAttribute("Message", "Your account is successfully activated. <br/>Please login with your credentials.");
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
	} else {
		request.setAttribute("Message", "Username "+acuname+" is successfully updated.");
		RequestDispatcher rd = request.getRequestDispatcher("active_accounts.jsp");
		rd.forward(request, response);
	}
	
}else{
	if(dologin == 1){
		session.invalidate();
		request.setAttribute("errorMessage", "Username "+acuname+" is unable to updated.<br/>Please contact bank for more details.");
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
	} else {
		request.setAttribute("errorMessage", "Username "+acuname+" is unable to updated.");
		RequestDispatcher rd = request.getRequestDispatcher("active_accounts.jsp");
		rd.forward(request, response);
	}
}

%>