<%@page import="beckend.userPojo"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dataConection.ConnectDB"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - OfferBazaar</title>
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
            min-height: 100vh;
        }
        
        /* Header */
        .header {
            background: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .logo-icon {
            font-size: 32px;
            color: var(--primary);
        }
        
        .logo-text {
            font-size: 24px;
            font-weight: 700;
        }
        
        .logo-highlight {
            color: var(--primary);
        }
        
        .search-bar {
            flex-grow: 1;
            max-width: 500px;
            margin: 0 30px;
            position: relative;
        }
        
        .search-bar input {
            width: 100%;
            padding: 12px 20px 12px 50px;
            border: 2px solid var(--light-gray);
            border-radius: 50px;
            font-size: 16px;
            transition: var(--transition);
        }
        
        .search-bar input:focus {
            border-color: var(--accent);
            outline: none;
            box-shadow: 0 0 0 3px rgba(33, 150, 243, 0.2);
        }
        
        .search-bar i {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
        }
        
        .user-profile {
            display: flex;
            align-items: center;
            gap: 15px;
            position: relative;
            cursor: pointer;
        }
        
        .user-avatar {
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
        
        .profile-dropdown {
            position: absolute;
            top: 100%;
            right: 0;
            background: white;
            border-radius: 8px;
            box-shadow: var(--shadow);
            width: 200px;
            margin-top: 15px;
            overflow: hidden;
            display: none;
            z-index: 1000;
        }
        
        .profile-dropdown.active {
            display: block;
            animation: fadeIn 0.3s ease forwards;
        }
        
        .dropdown-item {
            padding: 12px 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: var(--transition);
        }
        
        .dropdown-item:hover {
            background-color: var(--light-gray);
        }
        
        .dropdown-item i {
            width: 20px;
            color: var(--gray);
        }
        
        .dropdown-divider {
            height: 1px;
            background-color: var(--light-gray);
        }
        
        /* Page Title */
        .page-title {
            text-align: center;
            padding: 50px 20px 30px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
        }
        
        .page-title h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .page-title p {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        
        .city-highlight {
            background: rgba(255, 255, 255, 0.2);
            padding: 3px 15px;
            border-radius: 20px;
            font-weight: 600;
            display: inline-block;
            margin: 0 5px;
        }
        
        /* Filters Section */
        .filters-section {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .filters-container {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: var(--shadow);
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .filter-group {
            flex: 1;
            min-width: 250px;
        }
        
        .filter-group label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: var(--dark);
        }
        
        .filter-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--light-gray);
            border-radius: 8px;
            font-size: 16px;
            transition: var(--transition);
        }
        
        .filter-control:focus {
            border-color: var(--accent);
            outline: none;
            box-shadow: 0 0 0 3px rgba(33, 150, 243, 0.2);
        }
        
        .filter-actions {
            display: flex;
            align-items: flex-end;
            gap: 10px;
        }
        
        .filter-btn {
            padding: 12px 25px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: var(--transition);
        }
        
        .filter-btn:hover {
            background: #3d8b40;
            transform: translateY(-2px);
        }
        
        .filter-btn.reset {
            background: var(--light);
            color: var(--dark);
            border: 1px solid var(--light-gray);
        }
        
        .filter-btn.reset:hover {
            background: #e2e6ea;
        }
        
        /* Offers Grid */
        .offers-section {
            max-width: 1400px;
            margin: 0 auto 50px;
            padding: 0 20px;
        }
        
        .offers-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 30px;
            margin-top: 30px;
        }
        
        .offer-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: var(--transition);
            display: flex;
            flex-direction: column;
        }
        
        .offer-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }
        
        .offer-image {
            height: 200px;
            background-size: cover;
            background-position: center;
            position: relative;
        }
        
        .discount-tag {
            position: absolute;
            top: 15px;
            right: 15px;
            background: var(--secondary);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 1.1rem;
        }
        
        .offer-content {
            padding: 25px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        
        .offer-title {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: var(--dark);
        }
        
        .offer-description {
            color: var(--gray);
            margin-bottom: 20px;
            line-height: 1.6;
            flex-grow: 1;
        }
        
        .offer-meta {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid var(--light-gray);
            color: var(--dark);
            font-weight: 500;
        }
        
        .offer-dates {
            display: flex;
            flex-direction: column;
        }
        
        .offer-date-label {
            font-size: 0.9rem;
            color: var(--gray);
        }
        
        .view-details-btn {
            display: block;
            text-align: center;
            padding: 15px;
            background: var(--primary);
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            margin-top: 15px;
        }
        
        .view-details-btn:hover {
            background: #3d8b40;
            transform: translateY(-2px);
        }
        
        /* Profile Modal */
        .profile-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 2000;
            display: none;
        }
        
        .profile-modal.active {
            display: flex;
        }
        
        .modal-content {
            background: white;
            border-radius: 15px;
            width: 100%;
            max-width: 600px;
            overflow: hidden;
            animation: modalIn 0.4s ease forwards;
        }
        
        .modal-header {
            padding: 20px 30px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .modal-title {
            font-size: 1.8rem;
        }
        
        .modal-close {
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .modal-close:hover {
            transform: rotate(90deg);
        }
        
        .modal-body {
            padding: 30px;
        }
        
        .profile-info {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        .profile-row {
            display: flex;
            gap: 20px;
        }
        
        .profile-field {
            flex: 1;
        }
        
        .profile-field label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--dark);
        }
        
        .profile-field input, 
        .profile-field select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--light-gray);
            border-radius: 8px;
            font-size: 16px;
        }
        
        .profile-actions {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }
        
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: var(--transition);
        }
        
        .btn-primary {
            background: var(--primary);
            color: white;
        }
        
        .btn-primary:hover {
            background: #3d8b40;
        }
        
        .btn-secondary {
            background: var(--light);
            color: var(--dark);
            border: 1px solid var(--light-gray);
        }
        
        .btn-secondary:hover {
            background: #e2e6ea;
        }
        
        /* Empty State */
        .empty-state {
            grid-column: 1 / -1;
            text-align: center;
            padding: 80px 20px;
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
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .explore-btn {
            display: inline-block;
            padding: 15px 30px;
            background: var(--accent);
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
        }
        
        .explore-btn:hover {
            background: #0b7dda;
            transform: translateY(-3px);
        }
        
        /* Footer */
        .footer {
            background: var(--dark);
            color: white;
            padding: 30px 20px;
            text-align: center;
        }
        
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .footer-links {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin: 20px 0;
            flex-wrap: wrap;
        }
        
        .footer-links a {
            color: #bbb;
            text-decoration: none;
            transition: var(--transition);
        }
        
        .footer-links a:hover {
            color: var(--primary);
        }
        
        .footer-bottom {
            margin-top: 20px;
            color: #bbb;
            font-size: 0.9rem;
        }
        
        /* Responsive */
        @media (max-width: 992px) {
            .header {
                flex-wrap: wrap;
                gap: 15px;
            }
            
            .search-bar {
                order: 3;
                max-width: 100%;
                margin: 10px 0 0;
            }
            
            .profile-row {
                flex-direction: column;
                gap: 15px;
            }
        }
        
        @media (max-width: 768px) {
            .filters-container {
                flex-direction: column;
            }
            
            .offers-grid {
                grid-template-columns: 1fr;
            }
            
            .page-title h1 {
                font-size: 2rem;
            }
        }
        
        @media (max-width: 480px) {
            .header {
                padding: 15px 20px;
            }
            
            .page-title h1 {
                font-size: 1.7rem;
            }
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes modalIn {
            from { opacity: 0; transform: translateY(-50px); }
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
    <!-- Header -->
    <header class="header">
        <div class="logo">
            <i class="fas fa-store logo-icon"></i>
            <div class="logo-text">Offer<span class="logo-highlight">Bazaar</span></div>
        </div>
        
        <div class="search-bar">
            <i class="fas fa-search">
            </i>
            <input type="text" placeholder="Search offers...">
        </div>
       
        <div class="user-profile" id="userProfile">
            <div class="user-avatar"><img src="image/user.png" alt="Default Profile" class="profile-logo" ></div>
            <div class="user-info">
                <h3><%=userPojo.getuName() %></h3>
            </div>
            <i class="fas fa-chevron-down"></i>
            
            <!-- Profile Dropdown -->
            <div class="profile-dropdown" id="profileDropdown">
                <div class="dropdown-item" id="profileOption">
                    <i class="fas fa-user"></i>
                    <span>My Profile</span>
                </div>
                <div class="dropdown-divider"></div>
                <div class="dropdown-item" id="logoutOption">
                   <a href="index.html"> <i class="fas fa-sign-out-alt"></i>Logout</a>
                </div>
            </div>
        </div>
    </header>
    
    <!-- Page Title -->
    <section class="page-title">
        <h1>Offers in <span class="city-highlight">India</span></h1>
        <p>Discover amazing deals</p>
    </section>
    
    
    
    <!-- Offers Grid -->
    <section class="offers-section">
        <div class="offers-grid">
            <!-- Database offers will appear here -->
            <%
              Connection con = ConnectDB.getConnect();
              PreparedStatement ps1 = con.prepareStatement("SELECT * FROM advertiserreg WHERE aStatus = ?");
              ps1.setString(1, "Approved");
              ResultSet rs1 = ps1.executeQuery();

              boolean hasOffers = false;

              while(rs1.next()) {
                  int aId = rs1.getInt(1);
                  PreparedStatement ps2 = con.prepareStatement("SELECT * FROM offer WHERE aId = ?");
                  ps2.setInt(1, aId);
                  ResultSet rs2 = ps2.executeQuery();

                  while(rs2.next()) {
                      hasOffers = true;
            %>
                      <div class="offer-card animate" style="animation-delay: 0.1s">
                          <div class="offer-image" style="background-image: url('<%= rs2.getString(9) %>') ;">
                              <div class="discount-tag"><%= rs2.getString(4) %></div>
                          </div>
                          <div class="offer-content">
                              <h3 class="offer-title"><%= rs2.getString(2) %></h3>
                              <p class="offer-description"><%= rs2.getString(3) %></p>
                              <div class="offer-meta">
                                  <div class="offer-dates">
                                      <span class="offer-date-label">Valid from</span>
                                      <span><%= rs2.getString(5) %></span>
                                  </div>
                                  <div class="offer-dates">
                                      <span class="offer-date-label">Expires</span>
                                      <span><%= rs2.getString(6) %></span>
                                  </div>
                              </div>
                              <a href="#" class="view-details-btn">View Details</a>
                          </div>
                      </div>
            <%
                  }
                  rs2.close();
                  ps2.close();
              }
              rs1.close();
              ps1.close();
              con.close();

              if (!hasOffers) {
            %>
                <div class="empty-state">
                    <div class="empty-state-icon">
                        <i class="fas fa-tags"></i>
                    </div>
                    <h3 class="empty-state-title">No Offers Available</h3>
                    <p class="empty-state-text">No offers available in this city right now. Try adjusting your filters or check back later!</p>
                    <a href="#" class="explore-btn">
                        <i class="fas fa-compass"></i>
                        Explore Other Cities
                    </a>
                </div>
            <%
              }
            %>
            </div>
    </section>
    
    <!-- Profile Modal -->
    <div class="profile-modal" id="profileModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">My Profile</h3>
                <button class="modal-close" id="closeModal">&times;</button>
            </div>
            <div class="modal-body">
                <div class="profile-info">
                    <div class="profile-row">
                        <div class="profile-field">
                            <label>User Name</label>
                            <input type="text" value="<%= userPojo.getuName() %>">
                        </div>
                       
                    </div>
                    
                    <div class="profile-field">
                        <label>Email</label>
                        <input type="email" value="<%= userPojo.getuEmail()%>">
                    </div>
                    
                    <div class="profile-row">
                        <div class="profile-field">
                            <label>Phone</label>
                            <input type="tel" value="<%=userPojo.getuContact()%>">
                        </div>
                        <div class="profile-field">
                            <label>Location</label>
                             <input type="text" value="City">
                        </div>
                    </div>
                    
                    <div class="profile-field">
                        <label>Password</label>
                        <input type="password" value="********">
                    </div>
                    
                    <div class="profile-actions">
                        <button class="btn btn-secondary">Cancel</button>
                        <button class="btn btn-primary">Save Changes</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-logo">Offer<span style="color: var(--primary);">Bazaar</span></div>
            <div class="footer-links">
                <a href="#">Home</a>
                <a href="#">Offers</a>
                <a href="#">Cities</a>
                <a href="#">About</a>
                <a href="#">Contact</a>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2023 OfferBazaar. All rights reserved. Unlock savings around you.</p>
            </div>
        </div>
    </footer>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Profile dropdown toggle
            const userProfile = document.getElementById('userProfile');
            const profileDropdown = document.getElementById('profileDropdown');
            
            userProfile.addEventListener('click', function(e) {
                profileDropdown.classList.toggle('active');
                e.stopPropagation();
            });
            
            // Close dropdown when clicking elsewhere
            document.addEventListener('click', function(e) {
                if (!userProfile.contains(e.target)) {
                    profileDropdown.classList.remove('active');
                }
            });
            
            // Profile modal
            const profileOption = document.getElementById('profileOption');
            const profileModal = document.getElementById('profileModal');
            const closeModal = document.getElementById('closeModal');
            
            profileOption.addEventListener('click', function() {
                profileModal.classList.add('active');
                profileDropdown.classList.remove('active');
            });
            
            closeModal.addEventListener('click', function() {
                profileModal.classList.remove('active');
            });
            
            // Logout functionality
            const logoutOption = document.getElementById('logoutOption');
            logoutOption.addEventListener('click', function() {
                if (confirm('Are you sure you want to logout?')) {
                    // In a real application, this would redirect to a logout endpoint
                    alert('You have been logged out successfully!');
                    // Redirect to login page after logout
                    window.location.href = 'login.jsp';
                }
            });
            
            // Add animation delays
            const elements = document.querySelectorAll('.animate');
            elements.forEach((element, index) => {
                element.style.animationDelay = `${index * 0.1}s`;
            });
            
            // Filter functionality
            const applyBtn = document.querySelector('.filter-btn:not(.reset)');
            const resetBtn = document.querySelector('.filter-btn.reset');
            const categorySelect = document.getElementById('category');
            const dateInput = document.getElementById('date');
            const discountSelect = document.getElementById('discount');
            
            applyBtn.addEventListener('click', function() {
                const category = categorySelect.value;
                const date = dateInput.value;
                const discount = discountSelect.value;
                
                // For demo purposes, we'll just show an alert
                alert(`Filters applied:\nCategory: ${category || 'All'}\nDate: ${date || 'Any'}\nDiscount: ${discount ? discount + '%+' : 'Any'}`);
            });
            
            resetBtn.addEventListener('click', function() {
                categorySelect.value = '';
                dateInput.value = '';
                discountSelect.value = '';
                alert('Filters have been reset');
            });
            
            // View Details button functionality
            const viewButtons = document.querySelectorAll('.view-details-btn');
            viewButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    const offerTitle = this.closest('.offer-card').querySelector('.offer-title').textContent;
                    alert(`Viewing details for: ${offerTitle}`);
                });
            });
            
            // Simulate city selection
            const cityParam = new URLSearchParams(window.location.search).get('city');
            if (cityParam) {
                document.querySelector('.city-highlight').textContent = cityParam;
                document.querySelector('.page-title h1').innerHTML = `Offers in <span class="city-highlight">${cityParam}</span>`;
            }
        });
    </script>
</body>
</html>