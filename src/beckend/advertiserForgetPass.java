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
 * Servlet implementation class advertiserForgetPass
 */
public class advertiserForgetPass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public advertiserForgetPass() {
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
			String aEmail = request.getParameter("aEmail");
			String aPass = request.getParameter("aPass");
			Connection con = ConnectDB.getConnect();
			PreparedStatement ps = con.prepareStatement("Update advertiserreg set aPass = ? where aEmail = ?");
			ps.setString(1, aPass);
			ps.setString(2, aEmail);
			int i = ps.executeUpdate();
			
			if(i>0)
			{
				response.sendRedirect("advertiser_Login.html");
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
