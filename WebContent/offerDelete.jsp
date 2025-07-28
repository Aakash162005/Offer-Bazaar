<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="dataConection.ConnectDB"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	try {
		String oId = request.getParameter("oId");
		if (oId != null) {
			Connection con = ConnectDB.getConnect();
			PreparedStatement ps1 = con.prepareStatement("delete from offer where oId=?");
			ps1.setInt(1, Integer.parseInt(oId));
			
			int i = ps1.executeUpdate();
			
			if (i > 0) {
				response.sendRedirect("advertiserMyOffer.jsp");
			} else {
				response.sendRedirect("accessDenied.html");
			}
		} else {
			response.sendRedirect("accessDenied.html");
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>