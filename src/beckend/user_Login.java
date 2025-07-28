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
 * Servlet implementation class user_Login
 */
public class user_Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public user_Login() {
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
			String uEmail = request.getParameter("uEmail");
			String uPass = request.getParameter("uPass");
			System.out.printf(uPass , uEmail);
			Connection con = ConnectDB.getConnect();
			PreparedStatement ps = con.prepareStatement("Select * from userregistration where uEmail = ? and uPass = ?");
			ps.setString(1, uEmail);
			ps.setString(2, uPass);
			ResultSet rs =  ps.executeQuery();
			
			if(rs.next())
			{
				userPojo.setuId(rs.getInt(1));
				userPojo.setuName(rs.getString(2));
				userPojo.setuEmail(rs.getString(3));
				userPojo.setuContact(rs.getString(4));
				response.sendRedirect("user_Home.jsp");
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
