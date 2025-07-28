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
 * Servlet implementation class userRegistration
 */
public class userRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userRegistration() {
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
            int uId = 0;  
            String uName = request.getParameter("uName");
            String uEmail = request.getParameter("uEmail");
            String uContact = request.getParameter("uContact");
            String uPass = request.getParameter("uPass");

            Connection con = ConnectDB.getConnect();

            PreparedStatement ps = con.prepareStatement("select * from userregistration where uEmail = ?");
            ps.setString(1, uEmail);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                
                response.sendRedirect("user_Login.html");  
            } else {
               
                PreparedStatement ps1 = con.prepareStatement("insert into userregistration values (?, ?, ?, ?, ?)");
                ps1.setInt(1, uId);  
                ps1.setString(2, uName);
                ps1.setString(3, uEmail);
                ps1.setString(4, uContact);
                ps1.setString(5, uPass);

                int i = ps1.executeUpdate();
                if (i > 0) 
                {
                	response.sendRedirect("user_Login.jsp");
                }
                else
                {
                    response.sendRedirect("accessDenied.html"); 
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
           // response.sendRedirect("accessDenied.html");  
        }
    
	}

}
