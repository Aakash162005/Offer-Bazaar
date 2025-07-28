package dataConection;

import java.sql.*;
public class ConnectDB {
	
	
	public static Connection getConnect() 
	
	{
	       Connection con = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/offerbazaar","root","");
				
			}
			catch (ClassNotFoundException e) 
			{
				e.printStackTrace();
			}
			catch (SQLException e) 
			{
			
			e.printStackTrace();
			}
		return con;
	}

}

