<%@page import="beckend.advertiserPojo"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advertiser Dashboard - OfferBazaar</title>
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
        
        /* Dashboard Content */
        .content {
            padding: 30px;
        }
        
        /* Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            border-top: 4px solid var(--primary);
            position: relative;
            overflow: hidden;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        
        .stat-card:nth-child(2) {
            border-top-color: var(--secondary);
        }
        
        .stat-card:nth-child(3) {
            border-top-color: var(--accent);
        }
        
        .stat-icon {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 50px;
            opacity: 0.1;
        }
        
        .stat-title {
            font-size: 1.1rem;
            color: var(--gray);
            margin-bottom: 10px;
        }
        
        .stat-value {
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--dark);
        }
        
        .cta-button {
            display: inline-block;
            padding: 12px 25px;
            background: var(--light);
            color: var(--dark);
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            border: 1px solid var(--light-gray);
        }
        
        .stat-card:nth-child(1) .cta-button:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        
        .stat-card:nth-child(2) .cta-button:hover {
            background: var(--secondary);
            color: white;
            border-color: var(--secondary);
        }
        
        .stat-card:nth-child(3) .cta-button:hover {
            background: var(--accent);
            color: white;
            border-color: var(--accent);
        }
        
        /* Button Container */
        .button-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 40px 0;
        }
        
        .main-cta {
            padding: 15px 30px;
            background: var(--primary);
            color: white;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: var(--transition);
            box-shadow: 0 4px 10px rgba(76, 175, 80, 0.3);
        }
        
        .main-cta:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 15px rgba(76, 175, 80, 0.4);
        }
        
        .main-cta.secondary {
            background: var(--accent);
            box-shadow: 0 4px 10px rgba(33, 150, 243, 0.3);
        }
        
        .main-cta.secondary:hover {
            box-shadow: 0 7px 15px rgba(33, 150, 243, 0.4);
        }
        
        /* Recent Activity */
        .section-title {
            font-size: 1.5rem;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--light-gray);
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .section-title i {
            color: var(--primary);
        }
        
        .activity-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
        }
        
        .activity-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: var(--shadow);
        }
        
        .activity-card h3 {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--light-gray);
        }
        
        .activity-card h3 i {
            color: var(--secondary);
        }
        
        .activity-list {
            list-style: none;
        }
        
        .activity-list li {
            padding: 15px 0;
            border-bottom: 1px solid var(--light-gray);
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .activity-list li:last-child {
            border-bottom: none;
        }
        
        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: rgba(76, 175, 80, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 18px;
        }
        
        .activity-info h4 {
            margin-bottom: 5px;
        }
        
        .activity-info p {
            color: var(--gray);
            font-size: 0.9rem;
        }
        
        .activity-time {
            margin-left: auto;
            color: var(--gray);
            font-size: 0.9rem;
            white-space: nowrap;
        }
        
        /* City Card */
        .city-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: var(--shadow);
            text-align: center;
            margin-top: 25px;
        }
        
        .city-card i {
            font-size: 50px;
            color: var(--accent);
            margin-bottom: 15px;
        }
        
        .city-card h3 {
            font-size: 1.3rem;
            margin-bottom: 10px;
            color: var(--dark);
        }
        
        .city-card p {
            color: var(--gray);
            margin-bottom: 20px;
        }
        
        .city-name {
            font-size: 1.8rem;
            color: var(--accent);
            font-weight: 700;
            margin: 10px 0;
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
            
            .stats-container {
                grid-template-columns: 1fr;
            }
            
            .button-container {
                flex-direction: column;
                align-items: center;
            }
        }
        
        @media (max-width: 480px) {
            .admin-profile {
                flex-direction: column;
                text-align: center;
            }
            
            .activity-container {
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
                <a href="advertiser_Home.jsp" class="active">
                    <i class="fas fa-chart-line"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li>
               <a href="advertiserMyOffer.jsp">
                    <i class="fas fa-tags"></i>My Offers
                </a>
            </li>
            <li>
                <a href="advertiserNewOffer.html">
                    <i class="fas fa-plus-circle"></i>Create Offer
                    
                </a>
            </li>
            <li>
                <a href="advertiserDeleteOffer.html">
                    <i class="fas fa-chart-pie"></i>
                    <span>Delete Offer</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="fas fa-users"></i>
                    <span>Customers</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="fas fa-store"></i>
                    <span>Business Profile</span>
                </a>
            </li>
            <li>
                <a href="advertiserEditOffer.html"  >
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
                <h1>Advertiser Dashboard</h1>
                <p class="greeting">Welcome, <strong><%=advertiserPojo.getaBusinessName() %></strong>! 👋</p>
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
            <!-- Stats Cards -->
            <div class="stats-container">
                <div class="stat-card animate">
                    <i class="fas fa-tags stat-icon"></i>
                    <div class="stat-title">Total Offers Posted</div>
                    <div class="stat-value">12</div>
                    <a href="advertiserMyOffer.jsp" class="cta-button">View Offers</a>
                </div>
                
                <div class="stat-card animate" style="animation-delay: 0.2s">
                    <i class="fas fa-hourglass-half stat-icon"></i>
                    <div class="stat-title">Offers Expiring Soon</div>
                    <div class="stat-value">3</div>
                    <a href="EditOffer.jsp" class="cta-button">Renew Offers</a>
                </div>
                
                <div class="stat-card animate" style="animation-delay: 0.4s">
                    <i class="fas fa-map-marker-alt stat-icon"></i>
                    <div class="stat-title">Your City</div>
                    <div class="city-name"><%=advertiserPojo.getaCity()%></div>
                    <a href="#" class="cta-button">Change City</a>
                </div>
            </div>
            
            <!-- CTA Buttons -->
            <div class="button-container">
                <a href="advertiserNewOffer.html" class="main-cta">
                    <i class="fas fa-plus"></i>
                    Post New Offer
                </a>
                <a href="advertiserMyOffer.jsp" class="main-cta secondary">
                    <i class="fas fa-list"></i>
                    View My Offers
                </a>
            </div>
            
            <!-- Recent Activity Section -->
            <h2 class="section-title">
                <i class="fas fa-history"></i>
                Recent Activity
            </h2>
            
            <div class="activity-container">
                <div class="activity-card">
                    <h3><i class="fas fa-chart-line"></i> Offer Performance</h3>
                    <ul class="activity-list">
                        <li>
                            <div class="activity-icon" style="background: rgba(33, 150, 243, 0.1); color: var(--accent);">
                                <i class="fas fa-eye"></i>
                            </div>
                            <div class="activity-info">
                                <h4>Coffee Lover's Deal</h4>
                                <p>1,842 views this week</p>
                            </div>
                            <div class="activity-time">+12% from last week</div>
                        </li>
                        <li>
                            <div class="activity-icon" style="background: rgba(76, 175, 80, 0.1); color: var(--primary);">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div class="activity-info">
                                <h4>Buy One Get One Free</h4>
                                <p>128 redemptions</p>
                            </div>
                            <div class="activity-time">Conversion rate: 6.9%</div>
                        </li>
                        <li>
                            <div class="activity-icon" style="background: rgba(255, 152, 0, 0.1); color: var(--secondary);">
                                <i class="fas fa-star"></i>
                            </div>
                            <div class="activity-info">
                                <h4>Customer Ratings</h4>
                                <p>Average rating: 4.7/5</p>
                            </div>
                            <div class="activity-time">32 new reviews</div>
                        </li>
                    </ul>
                </div>
                
                <div class="activity-card">
                    <h3><i class="fas fa-bell"></i> Expiring Offers</h3>
                    <ul class="activity-list">
                        <li>
                            <div class="activity-icon" style="background: rgba(255, 152, 0, 0.1); color: var(--secondary);">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                            <div class="activity-info">
                                <h4>Morning Coffee Special</h4>
                                <p>Expires in 2 days</p>
                            </div>
                            <div class="activity-time">Renew now</div>
                        </li>
                        <li>
                            <div class="activity-icon" style="background: rgba(255, 152, 0, 0.1); color: var(--secondary);">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                            <div class="activity-info">
                                <h4>Student Discount</h4>
                                <p>Expires in 5 days</p>
                            </div>
                            <div class="activity-time">Renew now</div>
                        </li>
                        <li>
                            <div class="activity-icon" style="background: rgba(255, 152, 0, 0.1); color: var(--secondary);">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                            <div class="activity-info">
                                <h4>Weekend Brunch Deal</h4>
                                <p>Expires in 7 days</p>
                            </div>
                            <div class="activity-time">Renew now</div>
                        </li>
                    </ul>
                </div>
            </div>
            
            <!-- City Information Card -->
            <div class="city-card">
                <i class="fas fa-city"></i>
                <h3>Your Business Location</h3>
                <p>Your offers are currently visible to customers in:</p>
                <div class="city-name">New York</div>
                <p>You're reaching 1.2 million potential customers</p>
            </div>
        </div>
        
        <!-- Footer -->
        <div class="footer">
            <p>OfferBazaar Advertiser Dashboard &copy; 2023 | Promote your business effectively</p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add animation delays
            const cards = document.querySelectorAll('.animate');
            cards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.2}s`;
            });
            
           
            
            // Simulate live data updates
            setInterval(() => {
                // Simulate changing stats
                const offers = document.querySelector('.stat-card:nth-child(1) .stat-value');
                const expiring = document.querySelector('.stat-card:nth-child(2) .stat-value');
                
                // Generate small random changes
                const offersChange = Math.floor(Math.random() * 2);
                const expiringChange = Math.floor(Math.random() * 3) - 1;
                
                // Update values
                offers.textContent = Math.max(0, parseInt(offers.textContent) + offersChange);
                expiring.textContent = Math.max(0, parseInt(expiring.textContent) + expiringChange);
            }, 15000);
        });
    </script>
</body>
</html>