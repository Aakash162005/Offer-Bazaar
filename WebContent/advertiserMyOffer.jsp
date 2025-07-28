<%@page import="beckend.advertiserPojo"%>
<%@page import="java.sql.*"%>
<%@page import="dataConection.ConnectDB"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">	
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Offers - OfferBazaar</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        :root {
            --primary: #4CAF50; /* Trustworthy green */
            --secondary: #FF9800; /* Action orange */
            --accent: #2196F3; /* Information blue */
            --dark: #2C3E50;
            --light: #F8F9FA;
            --gray: #6C757D;
            --light-gray: #E9ECEF;
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
            padding-bottom: 40px;
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
        
        /* Offers Content */
        .content {
            padding: 30px;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--light-gray);
        }
        
        .page-header h2 {
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .page-header h2 i {
            color: var(--accent);
        }
        
        .new-offer-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 25px;
            background: var(--primary);
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            box-shadow: 0 4px 10px rgba(76, 175, 80, 0.3);
        }
        
        .new-offer-btn:hover {
            background: #3d8b40;
            box-shadow: 0 6px 15px rgba(76, 175, 80, 0.4);
            transform: translateY(-2px);
        }
        
        /* Offers Table */
        .offers-table-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: var(--shadow);
            overflow-x: auto;
        }
        
        .offers-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .offers-table th {
            text-align: left;
            padding: 15px 20px;
            border-bottom: 2px solid var(--light-gray);
            color: var(--gray);
            font-weight: 600;
        }
        
        .offers-table td {
            padding: 15px 20px;
            border-bottom: 1px solid var(--light-gray);
            vertical-align: middle;
        }
        
        .offers-table tbody tr {
            transition: var(--transition);
        }
        
        .offers-table tbody tr:hover {
            background: rgba(76, 175, 80, 0.05);
        }
        
        .offer-title {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .offer-image {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            background: linear-gradient(45deg, #6a11cb 0%, #2575fc 100%);
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
        }
        
        .offer-title-text {
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .offer-category {
            font-size: 14px;
            color: var(--gray);
        }
        
        .discount-tag {
            background: rgba(76, 175, 80, 0.1);
            color: var(--primary);
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 600;
            display: inline-block;
        }
        
        .date-cell {
            font-weight: 600;
            color: var(--dark);
        }
        
        .status-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }
        
        .status-active {
            background: rgba(76, 175, 80, 0.1);
            color: var(--primary);
        }
        
        .status-expiring {
            background: rgba(255, 152, 0, 0.1);
            color: var(--secondary);
        }
        
        .status-expired {
            background: rgba(108, 117, 125, 0.1);
            color: var(--gray);
        }
        
        .actions-cell {
            display: flex;
            gap: 10px;
        }
        
        .action-btn {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
            border: none;
            font-size: 16px;
        }
        
        .edit-btn {
            background: rgba(33, 150, 243, 0.1);
            color: var(--accent);
        }
        
        .edit-btn:hover {
            background: var(--accent);
            color: white;
        }
        
        .delete-btn {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }
        
        .delete-btn:hover {
            background: #dc3545;
            color: white;
        }
        
        .view-btn {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }
        
        .view-btn:hover {
            background: #28a745;
            color: white;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }
        
        .empty-state-icon {
            font-size: 80px;
            color: var(--light-gray);
            margin-bottom: 20px;
        }
        
        .empty-state-title {
            font-size: 1.8rem;
            margin-bottom: 15px;
            color: var(--gray);
        }
        
        .empty-state-text {
            font-size: 1.1rem;
            color: var(--gray);
            margin-bottom: 30px;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
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
                gap: 15px;
            }
            
            .new-offer-btn {
                width: 100%;
                justify-content: center;
            }
        }
        
        @media (max-width: 600px) {
            .offers-table {
                min-width: 600px;
            }
            
            .offers-table-container {
                padding: 15px;
                overflow-x: auto;
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
        .profile-logo {
  width: 50px;          /* You can adjust the size */
  height: 50px;
  border-radius: 50%;    /* Makes the image circular */
  object-fit: cover;     /* Ensures image doesn't stretch */
  border: 2px solid #ccc; /* Optional: adds a subtle border */
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
                <a href="advertiser_Home.jsp" >
                    <i class="fas fa-chart-line"></i>Dashboard
                </a>
            </li>
            <li>
                <a href="advertiserMyOffer.jsp" class="active" >
                    <i class="fas fa-tags"></i>My Offers
                </a>
            </li>
            <li>
                <a href="advertiserNewOffer.html"  >
                    <i class="fas fa-plus-circle"></i>Create Offer
                    
                </a>
            </li>
            <li>
                <a href="advertiserDeleteOffer.html">
                    <i class="fas fa-chart-pie"  ></i>Delete Offer
                   
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="fas fa-users"></i>
                    <span>Customers</span>
                </a>
            </li>
            <li>
                <a href="advertiserProfile.html"  >
                    <i class="fas fa-store"></i> Advertiser Profile
                </a>
            </li>
            <li>
                <a href="advertiserEditOffer.html" >
                    <i class="fas fa-cog"></i>Edit Offer
                </a>
            </li>
            <li>
                <a href="index.html">
                    <i class="fas fa-sign-out-alt"></i>Logout
                </a>
            </li>
        </ul>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <div class="header">
            <div class="header-left">
                <h1>My Offers</h1>
                <p class="greeting">Manage your offers, <strong><%= advertiserPojo.getaBusinessName() %></strong>!</p>
            </div>
            <div class="header-right">
                <div class="admin-profile">
                    <div class="admin-avatar"><img src="image/user.png" alt="Default Profile" class="profile-logo" ></div>
                    <div class="admin-info">
                        <h3><%=advertiserPojo.getaName() %></h3>
                        <p>Premium Advertiser</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Content -->
        <div class="content">
            <div class="page-header">
                <h2><i class="fas fa-tags"></i> Your Offers</h2>
                <a href="advertiserNewOffer.html" class="new-offer-btn">
                    <i class="fas fa-plus"></i>
                    Create New Offer
                </a>
            </div>
            
        
            
            <div class="offers-table-container animate">
                <!-- Table with offers -->
                <table class="offers-table">
                    <thead>
                        <tr>
                           <th>Title</th>
                            <th>Discount</th>
                            <th>Start</th>
                            <th>End</th>
                            <th>Actions</th>

                        </tr>
                    </thead>
                       <tbody>
<%
    Connection con = ConnectDB.getConnect();
    int aId = advertiserPojo.getaId();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM offer WHERE aId = ?");
    ps.setInt(1, aId); // Fixed: use correct parameter index
    ResultSet rs = ps.executeQuery();

    while(rs.next()) {
%>
    <tr>
        <td>
            <div class="offer-title-text"><%= rs.getString(2) %></div>
        </td>
        <td>
            <span class="discount-tag"><%= rs.getString(4) %></span>
        </td>
        <td class="date-cell"><%= rs.getString(5) %></td>
        <td class="date-cell"><%= rs.getString(6) %></td>
        <td class="actions-cell">
            <a href="offerDelete.jsp?oId=<%= rs.getInt(1) %>">
                <button class="action-btn delete-btn" title="Delete Offer">
                    <i class="fas fa-trash"></i>
                </button>
            </a>
        </td>
    </tr>
<%
    }
%>
</tbody>

                </table>
                
                <!-- Empty State (commented out - for when there are no offers) -->
                <!--
                <div class="empty-state">
                    <div class="empty-state-icon">
                        <i class="fas fa-tags"></i>
                    </div>
                    <h3 class="empty-state-title">No Offers Found</h3>
                    <p class="empty-state-text">You haven’t posted any offers yet. Let’s fix that!</p>
                    <a href="#" class="new-offer-btn">
                        <i class="fas fa-plus"></i>
                        Create Your First Offer
                    </a>
                </div>
                -->
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add animation delay
            const tableContainer = document.querySelector('.offers-table-container');
            tableContainer.style.animationDelay = "0.2s";
            
            // Delete button functionality
            const deleteButtons = document.querySelectorAll('.delete-btn');
            deleteButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const offerTitle = this.closest('tr').querySelector('.offer-title-text').textContent;
                    
                    if(confirm(`Are you sure you want to delete the offer "${offerTitle}"? This action cannot be undone.`)) {
                        const row = this.closest('tr');
                        row.style.opacity = '0';
                        row.style.transition = 'opacity 0.3s ease';
                        
                        setTimeout(() => {
                            row.remove();
                            // Check if all offers are deleted to show empty state
                            if(document.querySelectorAll('.offers-table tbody tr').length === 0) {
                                showEmptyState();
                            }
                        }, 300);
                    }
                });
            });
            
            // Edit button functionality
            const editButtons = document.querySelectorAll('.edit-btn');
            editButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const offerTitle = this.closest('tr').querySelector('.offer-title-text').textContent;
                    alert(`Edit action triggered for: ${offerTitle}`);
                });
            });
            
            // View button functionality
            const viewButtons = document.querySelectorAll('.view-btn');
            viewButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const offerTitle = this.closest('tr').querySelector('.offer-title-text').textContent;
                    alert(`View action triggered for: ${offerTitle}`);
                });
            });
            
            // Function to show empty state
            function showEmptyState() {
                const table = document.querySelector('.offers-table');
                table.style.display = 'none';
                
                const emptyStateHTML = `
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-tags"></i>
                        </div>
                        <h3 class="empty-state-title">No Offers Found</h3>
                        <p class="empty-state-text">You haven’t posted any offers yet. Let’s fix that!</p>
                        <a href="#" class="new-offer-btn">
                            <i class="fas fa-plus"></i>
                            Create Your First Offer
                        </a>
                    </div>
                `;
                
                document.querySelector('.offers-table-container').insertAdjacentHTML('beforeend', emptyStateHTML);
            }
        });
    </script>
 
</body>
</html>