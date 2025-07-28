package beckend;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataConection.ConnectDB;

/**
 * Servlet implementation class admin_Login
 */
public class admin_Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public admin_Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		try
		{
			String adminEmail = request.getParameter("adminEmail");
			String adminPass = request.getParameter("adminPass");
			
			Connection con = ConnectDB.getConnect();
			PreparedStatement ps = con.prepareStatement("Select * from adminlogin where adminEmail = ? and adminPass = ?");
			ps.setString(1, adminEmail);
			ps.setString(2, adminPass);
			ResultSet rs =  ps.executeQuery();
			
			if(rs.next())
			{
				response.sendRedirect("admin_Home.html");
			}
			else
			{
				response.sendRedirect("accessDenied.html");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
