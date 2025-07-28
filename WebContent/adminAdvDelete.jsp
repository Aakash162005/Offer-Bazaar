<%@page import="java.sql.PreparedStatement"%>
<%@page import="dataConection.ConnectDB"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Advertiser</title>
</head>
<body>
<%
    try {
        String aId = request.getParameter("aId");
        if (aId != null) {
            Connection con = ConnectDB.getConnect();
            PreparedStatement ps1 = con.prepareStatement("DELETE FROM advertiserreg WHERE aId = ?");
            ps1.setInt(1, Integer.parseInt(aId)); 

            int i = ps1.executeUpdate();

            if (i > 0) {
                response.sendRedirect("adminDisapproved.jsp");
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
