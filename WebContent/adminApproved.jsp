<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*"%>
<%@page import="dataConection.ConnectDB"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registered Users - OfferBazaar Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        :root {
            --primary: #4CAF50;
            --secondary: #FF9800;
            --accent: #2196F3;
            --dark: #2C3E50;
            --light: #F8F9FA;
            --gray: #6C757D;
            --light-gray: #E9ECEF;
            --success-bg: rgba(76, 175, 80, 0.1);
            --warning-bg: rgba(255, 152, 0, 0.1);
            --danger-bg: rgba(244, 67, 54, 0.1);
            --shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s ease;
        }
        
        body {
            background-color: #f0f2f5;
            color: var(--dark);
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
        }
        
        /* Sidebar */
        .sidebar {
            width: 260px;
            background: var(--dark);
            color: white;
            height: 100vh;
            position: fixed;
            transition: var(--transition);
            z-index: 100;
        }
        
        .logo {
            padding: 25px 20px;
            display: flex;
            align-items: center;
            gap: 15px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .logo-icon {
            font-size: 28px;
            color: var(--primary);
        }
        
        .logo-text {
            font-size: 22px;
            font-weight: 700;
        }
        
        .logo-highlight {
            color: var(--primary);
        }
        
        .nav-links {
            padding: 20px 0;
        }
        
        .nav-links li {
            list-style: none;
            margin-bottom: 5px;
        }
        
        .nav-links a {
            display: flex;
            align-items: center;
            padding: 15px 25px;
            color: #bbb;
            text-decoration: none;
            transition: var(--transition);
            font-size: 16px;
            font-weight: 500;
        }
        
        .nav-links a:hover, .nav-links a.active {
            background: rgba(255,255,255,0.05);
            color: white;
            border-left: 4px solid var(--primary);
        }
        
        .nav-links a i {
            margin-right: 15px;
            font-size: 20px;
            width: 24px;
            text-align: center;
        }
        
        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 260px;
            transition: var(--transition);
        }
        
        /* Header */
        .header {
            background: white;
            padding: 20px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow);
            position: sticky;
            top: 0;
            z-index: 99;
        }
        
        .header-left h1 {
            font-size: 1.8rem;
            color: var(--dark);
        }
        
        .greeting {
            font-size: 1.1rem;
            color: var(--gray);
            margin-top: 5px;
        }
        
        .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .admin-profile {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .admin-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 18px;
        }
        
        .admin-info h3 {
            font-size: 16px;
        }
        
        .admin-info p {
            font-size: 14px;
            color: var(--gray);
        }
        
        /* Page Content */
        .content {
            padding: 30px;
        }
        
        .page-header {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--light-gray);
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .page-title {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .page-title h1 {
            font-size: 1.8rem;
        }
        
        .page-title i {
            color: var(--accent);
            background: rgba(33, 150, 243, 0.1);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }
        
        .page-description {
            color: var(--gray);
            margin-top: 10px;
            max-width: 700px;
            line-height: 1.6;
        }
        
        .add-user-btn {
            background: var(--primary);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .add-user-btn:hover {
            background: #3d8b40;
            transform: translateY(-2px);
        }
        
        /* Stats Overview */
        .stats-overview {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }
        
        .stat-icon.total {
            background: rgba(33, 150, 243, 0.1);
            color: var(--accent);
        }
        
        .stat-icon.active {
            background: rgba(76, 175, 80, 0.1);
            color: var(--primary);
        }
        
        .stat-icon.inactive {
            background: rgba(255, 152, 0, 0.1);
            color: var(--secondary);
        }
        
        .stat-icon.new {
            background: rgba(156, 39, 176, 0.1);
            color: #9c27b0;
        }
        
        .stat-info {
            flex: 1;
        }
        
        .stat-value {
            font-size: 1.8rem;
            font-weight: 700;
            line-height: 1.2;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: var(--gray);
        }
        
        /* Filter Section */
        .filter-section {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: var(--shadow);
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            align-items: center;
        }
        
        .filter-group {
            flex: 1;
            min-width: 200px;
        }
        
        .filter-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--dark);
            font-weight: 500;
        }
        
        .filter-group select, .filter-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--light-gray);
            border-radius: 8px;
            background: white;
            font-size: 15px;
            transition: var(--transition);
        }
        
        .filter-group select:focus, .filter-group input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(33, 150, 243, 0.2);
        }
        
        .search-btn {
            background: var(--accent);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .search-btn:hover {
            background: #0b7dda;
            transform: translateY(-2px);
        }
        
        /* Table Styles */
        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: var(--shadow);
            overflow: hidden;
            position: relative;
            min-height: 400px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: var(--light);
        }
        
        th, td {
            padding: 18px 20px;
            text-align: left;
            border-bottom: 1px solid var(--light-gray);
        }
        
        th {
            color: var(--gray);
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
        }
        
        td {
            color: var(--dark);
        }
        
        tbody tr {
            transition: var(--transition);
        }
        
        tbody tr:hover {
            background: rgba(233, 236, 239, 0.3);
        }
        
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        
        .status-active {
            background: var(--success-bg);
            color: #2e7d32;
        }
        
        .status-inactive {
            background: var(--warning-bg);
            color: #e68a00;
        }
        
        .status-suspended {
            background: var(--danger-bg);
            color: #c62828;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        
        .action-btn {
            padding: 8px 12px;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
            border: none;
            background: var(--light);
            color: var(--dark);
            font-size: 0.9rem;
        }
        
        .action-btn:hover {
            background: var(--accent);
            color: white;
        }
        
        .view-btn:hover {
            background: var(--accent);
        }
        
        .edit-btn:hover {
            background: var(--primary);
        }
        
        .suspend-btn:hover {
            background: var(--secondary);
        }
        
        .delete-btn:hover {
            background: var(--danger);
        }
        
        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            padding: 25px;
            gap: 10px;
        }
        
        .pagination button {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            border: 1px solid var(--light-gray);
            background: white;
            cursor: pointer;
            transition: var(--transition);
            font-weight: 600;
        }
        
        .pagination button:hover, .pagination button.active {
            background: var(--accent);
            color: white;
            border-color: var(--accent);
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 100%;
        }
        
        .empty-state i {
            font-size: 80px;
            color: #c2c2c2;
            margin-bottom: 20px;
            opacity: 0.7;
        }
        
        .empty-state h3 {
            font-size: 1.8rem;
            margin-bottom: 15px;
            color: var(--gray);
            font-weight: 400;
        }
        
        .empty-state p {
            color: var(--gray);
            max-width: 500px;
            margin: 0 auto 30px;
            line-height: 1.6;
            font-size: 1.1rem;
        }
        
        /* Footer */
        .footer {
            padding: 20px 30px;
            background: white;
            margin-top: 40px;
            border-top: 1px solid var(--light-gray);
            text-align: center;
            color: var(--gray);
            font-size: 0.9rem;
        }
        
        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
            }
            
            .logo-text, .nav-links a span {
                display: none;
            }
            
            .logo {
                justify-content: center;
            }
            
            .nav-links a {
                justify-content: center;
                padding: 15px;
            }
            
            .nav-links a i {
                margin-right: 0;
                font-size: 24px;
            }
            
            .main-content {
                margin-left: 80px;
            }
        }
        
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }
            
            .admin-profile {
                margin-top: 10px;
            }
            
            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            table {
                display: block;
                overflow-x: auto;
            }
            
            .filter-section {
                flex-direction: column;
                align-items: stretch;
            }
        }
        
        @media (max-width: 480px) {
            .admin-profile {
                flex-direction: column;
                text-align: center;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 8px;
            }
            
            .action-btn {
                width: 100%;
                justify-content: center;
            }
            
            .stats-overview {
                grid-template-columns: 1fr;
            }
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .animate {
            animation: fadeIn 0.6s ease forwards;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">
            <i class="fas fa-store logo-icon"></i>
            <div class="logo-text">Offer<span class="logo-highlight">Bazaar</span></div>
        </div>
        
        <ul class="nav-links">
            <li>
                <a href="admin_Home.html">
                    <i class="fas fa-home"></i>Dashboard
                    
                </a>
            </li>
            <li>
                <a href="adminApproved.jsp" class="active" >
                    <i class="fas fa-users"></i>Approved Advertisers
                </a>
            </li>
            <li>
                <a href="adminDisapproved.jsp" >
                    <i class="fas fa-user-friends"></i>Disapproved Advertisers
                    
                </a>
            </li>
            <li>
                 <a href="adminOffer.jsp" >
                    <i class="fas fa-user-friends"></i>All Offers
                    
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="fas fa-city"></i>
                    <span>Cities</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="fas fa-chart-bar"></i>
                    <span>Analytics</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="fas fa-cog"></i>
                    <span>Settings</span>
                </a>
            </li>
            <li>
                <a href="index.html">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </li>
        </ul>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <div class="header">
            <div class="header-left">
                <h1>Registered Advertiser</h1>
                <p class="greeting">Manage and monitor advertiser on the platform</p>
            </div>
            <div class="header-right">
                <div class="admin-profile">
                    <div class="admin-avatar">A</div>
                    <div class="admin-info">
                        <h3>Admin User</h3>
                        <p>Super Administrator</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Content -->
        <div class="content">
            <div class="page-header">
                <div class="page-title">
                    <i class="fas fa-user-friends"></i>
                    <div>
                        <h1>Registered Advertiser</h1>
                        <p class="page-description">Manage and monitor advertiser on the platform. View user details, activity, and manage access.</p>
                    </div>
                </div>
                <button class="add-user-btn">
                    <i class="fas fa-plus"></i> <a herf="adminDisapproved.jsp">Add advertiser</a>
                </button>
            </div>
            
            <!-- Stats Overview -->
            <div class="stats-overview">
                <div class="stat-card animate">
                    <div class="stat-icon total">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-info">
                        <div class="stat-value">1,842</div>
                        <div class="stat-label">Total Users</div>
                    </div>
                </div>
                
                <div class="stat-card animate" style="animation-delay: 0.1s">
                    <div class="stat-icon active">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div class="stat-info">
                        <div class="stat-value">1,502</div>
                        <div class="stat-label">Active Users</div>
                    </div>
                </div>
                
                <div class="stat-card animate" style="animation-delay: 0.2s">
                    <div class="stat-icon inactive">
                        <i class="fas fa-user-clock"></i>
                    </div>
                    <div class="stat-info">
                        <div class="stat-value">276</div>
                        <div class="stat-label">Inactive Users</div>
                    </div>
                </div>
                
                <div class="stat-card animate" style="animation-delay: 0.3s">
                    <div class="stat-icon new">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="stat-info">
                        <div class="stat-value">64</div>
                        <div class="stat-label">New This Month</div>
                    </div>
                </div>
            </div>
            
            <!-- Filter Section -->
            <div class="filter-section animate">
                <div class="filter-group">
                    <label for="status-filter"><i class="fas fa-filter"></i> User Status</label>
                    <select id="status-filter">
                        <option value="all">All Statuses</option>
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                        <option value="suspended">Suspended</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="role-filter"><i class="fas fa-user-tag"></i> User Role</label>
                    <select id="role-filter">
                        <option value="all">All Roles</option>
                        <option value="user">Standard User</option>
                        <option value="vip">VIP User</option>
                        <option value="admin">Administrator</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="search"><i class="fas fa-search"></i> Search Users</label>
                    <input type="text" id="search" placeholder="Search by name or email...">
                </div>
                
                <button class="search-btn">
                    <i class="fas fa-filter"></i> Apply Filters
                </button>
            </div>
            
            <!-- Users Table -->
            <div class="table-container animate" style="animation-delay: 0.2s">
                <table>
                    <thead>
                        <tr>
                            <th>User name</th>
                            <th>Business Name</th>
                            <th>Email</th>
                            <th>Contact</th>
                            <th>Location</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                   	 Connection con = ConnectDB.getConnect();
                   	 PreparedStatement ps = con.prepareStatement("select * from advertiserreg where aStatus = ? ");
                   	 ps.setString(1, "Approved");
                     ResultSet rs = ps.executeQuery();
                    
                    while(rs.next())
                    {
                    %>
                        <tr>
                            <td>
                                <div style="display: flex; align-items: center; gap: 12px;">
                                    <div class="admin-avatar" style="width: 36px; height: 36px; font-size: 16px;">SJ</div>
                                    <div>
                                        <div style="font-weight: 600;"><%= rs.getString(2) %></div>
                                        <div style="font-weight: 400;"><%= rs.getString(3) %></div>
                                        <div style="font-size: 0.9rem; color: var(--gray);"></div>
                                    </div>
                                </div>
                            </td>
                            <td><%= rs.getString(3) %></td>
                            <td><%= rs.getString(4) %></td>
                             <td><%= rs.getString(5) %></td>
                            <td><%= rs.getString(6) %></td>
                            <td> 
                            	<a href="approved.jsp?aId=<%=rs.getInt(1)%>">
  							  <button class="action-btn delete-btn" title="Disapprove User">Approved</button>
  								</a>
                            </td>
                            <td>
                                <div class="action-buttons">
                                     <td> <a href="adminAdvDelete.jsp?aId=<%=rs.getInt(1)%>"><button class="action-btn delete-btn" title="Delete Offer"><i class="fas fa-trash"></i>
                                          </button>
                                          </a> 
                                </td>
                                </div>
                            </td>
                        </tr>
    <%
  	    }
    %>
                        
                    </tbody>
                </table>
                
         
        
        <!-- Footer -->
        <div class="footer">
            <p>OfferBazaar Admin Dashboard &copy; 2023 | Secure Platform for Local Business Offers</p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add animation delays
            const cards = document.querySelectorAll('.animate');
            cards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.2}s`;
            });
            
            // Handle action buttons
            const viewButtons = document.querySelectorAll('.view-btn');
            const editButtons = document.querySelectorAll('.edit-btn');
            
            viewButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const row = this.closest('tr');
                    const name = row.querySelector('td:first-child div > div:first-child').textContent;
                    alert(`Viewing profile: ${name}`);
                });
            });
            
            editButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const row = this.closest('tr');
                    const name = row.querySelector('td:first-child div > div:first-child').textContent;
                    alert(`Editing user: ${name}`);
                });
            });
            
           
            
            // Search functionality
            const searchBtn = document.querySelector('.search-btn');
            searchBtn.addEventListener('click', function() {
                const status = document.getElementById('status-filter').value;
                const role = document.getElementById('role-filter').value;
                const searchTerm = document.getElementById('search').value;
                
                alert(`Searching users: Status=${status}, Role=${role}, Search=${searchTerm}`);
            });
            
            // Toggle empty state (for demonstration)
            const toggleEmptyState = document.querySelector('#toggleEmpty');
            if(toggleEmptyState) {
                toggleEmptyState.addEventListener('click', function() {
                    const table = document.querySelector('table');
                    const emptyState = document.querySelector('.empty-state');
                    
                    if(table.style.display === 'none') {
                        table.style.display = '';
                        emptyState.style.display = 'none';
                    } else {
                        table.style.display = 'none';
                        emptyState.style.display = 'block';
                    }
                });
            }
        });
    </script>
</body>
</html>
