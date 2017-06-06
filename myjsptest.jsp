<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
 
<html>
<head>
<title>SELECT Operation</title>
</head>
<body>
 
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/cdcol"
     user="root"  password=""/>
 
<sql:query dataSource="${snapshot}" var="result">
SELECT * from cds;
</sql:query>
 
<table border="1" width="100%">
<tr>
   <th>Titel</th>
   <th>Interpret</th>
   <th>Jahr</th>
   <th>ID</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
   <td><c:out value="${row.titel}"/></td>
   <td><c:out value="${row.interpret}"/></td>
   <td><c:out value="${row.jahr}"/></td>
   <td><c:out value="${row.id}"/></td>
</tr>
</c:forEach>
</table>
 
</body>
</html>