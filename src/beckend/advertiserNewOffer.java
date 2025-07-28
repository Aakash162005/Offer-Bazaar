package beckend;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataConection.ConnectDB;

/**
 * Servlet implementation class advertiserNewOffer
 */
public class advertiserNewOffer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public advertiserNewOffer() {
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
			int oId = 0;
			String oTitle = request.getParameter("oTitle");
			String oDescrip = request.getParameter("oDescrip");
			String oDiscount = request.getParameter("oDiscount");
			String oStartDate = request.getParameter("oStartDate");
			String oEndDate = request.getParameter("oEndDate");
			String oCity = request.getParameter("oCity");
			String oType = request.getParameter("oType");
			String image = request.getParameter("image");
			int aId = advertiserPojo.getaId();
			
			Connection con = ConnectDB.getConnect();
			PreparedStatement ps = con.prepareStatement("insert into offer values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			ps.setInt(1, oId);
			ps.setString(2 ,oTitle );
			ps.setString(3 ,oDescrip );
			ps.setString(4 ,oDiscount );
			ps.setString(5 ,oStartDate );
			ps.setString(6 ,oEndDate );
			ps.setString(7 ,oCity );
			ps.setString(8 ,oType );
			ps.setString(9 ,image );
			ps.setInt(10, aId);
			int i = ps.executeUpdate();
			
			if(i > 0)
			{
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
