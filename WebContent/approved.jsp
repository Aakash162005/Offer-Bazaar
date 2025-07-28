<%@page import="java.sql.PreparedStatement"%>
<%@page import="dataConection.ConnectDB"%>
<%@page import="java.sql.Connection"%>
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
        String aId = request.getParameter("aId");
        if (aId != null) {
            Connection con = ConnectDB.getConnect();
            PreparedStatement ps1 = con.prepareStatement("UPDATE advertiserreg SET aStatus=? WHERE aId=?");
            ps1.setString(1, "Disapproved");
            ps1.setInt(2, Integer.parseInt(aId));

            int i = ps1.executeUpdate();

            if (i > 0) {
                response.sendRedirect("adminApproved.jsp");
            } else {
                response.sendRedirect("accessDenied.html");
            }
        } else {
            response.sendRedirect("accessDenied.html");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>