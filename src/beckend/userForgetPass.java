package beckend;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataConection.ConnectDB;

/**
 * Servlet implementation class userForgetPass
 */
public class userForgetPass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userForgetPass() {
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
			Connection con = ConnectDB.getConnect();
			PreparedStatement ps = con.prepareStatement("Update userregistration set uPass = ? where uEmail = ?");
			ps.setString(1, uPass);
			ps.setString(2, uEmail);
			int i = ps.executeUpdate();
			
			if(i>0)
			{
				response.sendRedirect("user_Login.html");
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
