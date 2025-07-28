package beckend;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.xml.internal.ws.addressing.policy.AddressingPolicyValidator;

import dataConection.ConnectDB;

/**
 * Servlet implementation class advertiser_Login
 */
public class advertiser_Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public advertiser_Login() {
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
			PreparedStatement ps = con.prepareStatement("Select * from advertiserreg where aEmail = ? and aPass = ?");
			ps.setString(1, aEmail);
			ps.setString(2, aPass);
			ResultSet rs =  ps.executeQuery();
			
			if(rs.next())
			{
				advertiserPojo.setaId(rs.getInt(1));
				advertiserPojo.setaName(rs.getString(2));
				advertiserPojo.setaBusinessName(rs.getString(3));
				advertiserPojo.setaEmail(rs.getString(4));
				advertiserPojo.setaContact(rs.getString(5));
				advertiserPojo.setaCity(rs.getString(6));
				response.sendRedirect("advertiser_Home.jsp");
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
