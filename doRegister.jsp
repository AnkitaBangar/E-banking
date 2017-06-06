<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*,com.onlinebank.BankCommons"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.security.MessageDigest" %>
<%@include file="email.jsp"%>
<%
//java Code

String uname = request.getParameter("username");
String password = request.getParameter("password");

MessageDigest alg = MessageDigest.getInstance("MD5");
alg.reset();
alg.update(password.getBytes());
byte[] digest = alg.digest();
StringBuffer hashedpasswd = new StringBuffer();
String hx;
for (int i=0;i<digest.length;i++){
	hx =  Integer.toHexString(0xFF & digest[i]);
	//0x03 is equal to 0x3, but we need 0x03 for our md5sum
	if(hx.length() == 1){hx = "0" + hx;}
	hashedpasswd.append(hx);
}
password = hashedpasswd.toString();


String question = request.getParameter("question");
String answer = request.getParameter("answer");
String address = request.getParameter("address");
String email = request.getParameter("email");
String mobile = request.getParameter("mobile");
String sql = "INSERT INTO user_details (uname, upass, sec_question, answer, address, email, mobile, is_active ) VALUES ('"+uname+"','"+password+"','"+question+"','"+answer+"','"+address+"','"+email+"','"+mobile+"','0')";
//System.out.println(sql);
int rs =0;
int update = BankCommons.update(sql);
if(update == 1){
	rs = sendemail(email,"registration",uname,"",0,0,0,0);
}

//System.out.println(sql);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Online Bank by Trimurti Infotech</title> 
<link rel="shortcut icon" href="images/trimurtinfotech_icon.jpg" type="image/jpg">
<link href="css/menu.css" rel="stylesheet" type="text/css" />
<style type="text/css">

<!--
html,body{
    background-image: url(images/img.gif);
}
</style>
</head>

<body>
<table width="900" border="1" align="center" cellpadding="0" cellspacing="0" style="font-weight:normal; background-color:#FFFFFF">
  <tr>
    <th colspan="3" scope="col" style="height:90px; background-color:#2175bc;"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="900" height="90">
      <param name="movie" value="images/banks.swf" />
      <param name="quality" value="high" />
      <embed src="images/banks.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="900" height="90"></embed>
    </object></th>
  </tr>
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr>
<td width="160" ><p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>	</td>
    <td colspan="2" style="padding:20px;">
	<div class="box1">
	<% 
	if(update == 1){
		if(rs == 1){
			%>
			Account is Created Successfully and confirmation email sent to <%= email%>.<br/>If you have activated your account <a href="index.jsp">Click Here</a> to Login to Your Account.
			<%
		} else {
			%>
			Account is Created Successfully. <font color="#FF0000"> but failed to send confirmation email. Please check your email id [<%= email%>] Registered.</font><br/> Please Contact bank for any details.<br/> if your account is activated <a href="index.jsp">Click Here</a> to Login to Your Account.</font>
			<%
		}
	}else {
	%>
	<font color="#FF0000">Sorry!. Account is not created. Username [<%= uname%>] is already taken. Please try with new Username.<br/>Click Here to <a href="register.jsp">Register Again</a></font>
	<%
	}
	 %>
	</div>
	</td>
  </tr>
  <tr style="height:30px;">
    <td colspan="3" style="background-color:#2175bc;">&nbsp;</td>
  </tr>
</table>
</body>

</html>
