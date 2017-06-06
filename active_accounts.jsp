<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.*,com.onlinebank.BankCommons" errorPage="" %>
<%
//java Code
if( session.getAttribute("cust_name").equals("admin")){
	
}else{
	response.sendRedirect("main.jsp");
}
String uname = (String)session.getAttribute("cust_name");
String sql = "SELECT uname, email, is_active FROM user_details order by ID desc";
//System.out.println(sql);
ArrayList one = BankCommons.getAccountsActivated(sql);
//System.out.println(one);
int size = one.size();
if(size < 1) {
	response.sendRedirect("noAcc.jsp");
}
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
.style2 {color: #FFFFFF; font-weight: bold; }
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
<td width="160" >
<%@include file="menu.jsp"%>

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>	</td>
    <td colspan="2" style="padding:20px;line-height:20px;">
	<div class="box1">
	<marquee><h2><font color="#FF0000">Online Bank.</font></h2></marquee>
	</div>
	<br/>
	<br/>
	<form id="form1" name="form1" method="post" action="get-balance-fanal.jsp">
	  <table width="96%" border="0" align="center" cellpadding="2" cellspacing="2">
        <tr>
          <th colspan="3" bgcolor="#333333" scope="col"><font color="#FFFFFF">Following are the Repost for Status of Acount(s). </font></th>
        </tr>
		<tr>
          <td colspan="3">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="3"><font color="red"> <% if(null!=request.getAttribute("errorMessage")) { out.println(request.getAttribute("errorMessage")); } %> </font> <font color="green"> <% if(null!=request.getAttribute("Message")) { out.println(request.getAttribute("Message")); } %> </font></td>
        </tr>
        <tr>
          <td bgcolor="#2175BC"><div align="center" class="style2">Username. </div></td>
          <td bgcolor="#2175BC"><div align="center" class="style2">email</div></td>
          <td bgcolor="#2175BC"><div align="center" class="style2">Status</div></td>
        </tr>
		<%
		for(int i=0;i<one.size();i++) {
		ArrayList o = (ArrayList)one.get(i); 
		int status = Integer.valueOf((String) o.get(2));
		%>
        <tr>
          <td><div align="center"><%=(String)o.get(0)%></div></td>
          <td><div align="center"><%=(String)o.get(1)%></div></td>
          <td><div align="center"><%if(status == 1){%> <a href="http://localhost:8080/onlinebank/activateac.jsp?acun=<%=(String)o.get(0)%>&action=0">Decactivate</a> <% } else {%> <a href="http://localhost:8080/onlinebank/activateac.jsp?acun=<%=(String)o.get(0)%>&action=1">Activate</a><% }%></div></td>
        </tr>
		<% } %>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td width="14%">&nbsp;</td>
          <td width="14%">&nbsp;</td>
          <td width="15%">&nbsp;</td>
        </tr>
      </table>
      </form>
	</td>
  </tr>
  <tr style="height:30px;">
    <td colspan="3" style="background-color:#2175bc;">&nbsp;</td>
  </tr>
</table>
</body>

</html>
