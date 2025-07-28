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
 * Servlet implementation class advertiser_Registration
 */
public class advertiser_Registration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public advertiser_Registration() {
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
		
		try {
            int aId = 0;  
            String aName = request.getParameter("aName");
            String aBusinessName = request.getParameter("aBusinessName");
            String aEmail = request.getParameter("aEmail");
            String aContact = request.getParameter("aContact");
            String aCity = request.getParameter("aCity");
            String aPass = request.getParameter("aPass");

            Connection con = ConnectDB.getConnect();

            PreparedStatement ps = con.prepareStatement("select * from advertiserreg where aEmail = ?");
            ps.setString(1, aEmail);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                
                response.sendRedirect("user_Login.html");  
            } else {
               
                PreparedStatement ps1 = con.prepareStatement("insert into advertiserreg values (?, ?, ?, ?, ?, ?, ?, ?)");
                ps1.setInt(1, aId);  
                ps1.setString(2, aName);
                ps1.setString(3, aBusinessName);
                ps1.setString(4, aEmail);
                ps1.setString(5, aContact);
                ps1.setString(6, aCity);
                ps1.setString(7, aPass);
                ps1.setString(8, "Disapproved");

                int i = ps1.executeUpdate();
                if (i > 0) 
                {
                    response.sendRedirect("advertiser_Login.jsp"); 
                }
                else
                {
                    response.sendRedirect("accessDenied.html"); 
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("accessDenied.html");  
        }
    
	}

}
