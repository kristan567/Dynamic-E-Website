 <%@page import="resources.MyConstants"%>
<%@page import="controller.statemanagement.SessionManagement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page import="controller.dbconnection.DbConnection" %>

<sql:setDataSource var="conn" driver="<%=MyConstants.DRIVER_NAME %>"
     				url="<%=MyConstants.DB_URL %>"  
     				user="<%=MyConstants.DB_USER_NAME %>" password="<%=MyConstants.DB_USER_PASSWORD %>"/> 
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AttireHub - Home</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/styles.css">
    <style>

		body{
			height: 100vh;
		}
		
		.container{
			display: flex;
			height: auto;
		}
		
		.profile{
			margin: 50px 10px 0px 0px;
			width: 90%;
			height: 90vh;
			background-color: white;
			flex:1;
			border-radius: 20px;
			position: sticky;
		}
		
		.profile:hover{
			background-color: white ;
			box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.2), -1px -1px 8px rgba(0, 0,  0, 0.2 ) ;
			transition: 2s all;               
		}
		
		.profile img{
			border-radius: 50%;
		}
		
		.push{
			margin: 20px 0px 0px 0px ;     /* tyo photo sahit sabailai tala push haneko */
		}
		
		table{
			width:100%
		}
		
		th{
			font-size: 25px;
			background-color: grey;
		}
		
		td{
			padding: 20px 10px;
		}
		
		.purchase-history{
			flex:1;
			margin:50px 0px 0px 0px;
			width: 850px;
			height:90vh;
			background-color: white;
			border-radius: 20px;
			overflow: scroll;
		}
		
		.purchase-history:hover{
			background-color:white ;
			box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.2), -1px -1px 8px rgba(0, 0,  0, 0.2 ) ;
			transition: 2s all;              
		}
		
		.info{
			margin: 8px 0px 0px 0px;                                        
		}
		
		.edit-form{
			background-color:  #2874F0;
			background-repeat: no-repeat;
			background-size: cover;
			background-position: 0em 0em;
			transform: scaleX(1);
			padding: 40px;
			border-radius: 10px;
			box-shadow: 0 0 10px rgba(0,0,0,0.3);
			text-align: center;
			max-width: 800px;
			width: 100%;
			display:flex;
			justify-content: center;
			align-items: center;
			position: absolute;
			top: 60%;
			left: 50%;
			transform: translate(0%,-70%);
			transition: 1s;
			color: black;
			z-index: 55;
			display: none; 
		}
		
		input[type="submit"], button{
			margin: 0 5px;
			padding: 10px;
			border: none;
			background-color: #054a93;
			color: #fff;
			font-size: 16px;
			cursor: pointer;
			border-radius: 10px;
			transition: background-color 0.3s ease-in-out;
		}
		
		.edit-form input[type="text"],
		.edit-form input[type="password"],
		.edit-form input[type="date"],
		.edit-form input[type="file"]
		{
			padding: 10px;
			margin-bottom: 15px;
			width: 90%;
			border-radius: 5px;
			border: none;
			background-color: white;
			font-size: 20px;
		}
		
		.radio{
			font-size: 30px;
		}
		
		.writing1{
			margin: 0px 0px 0px 60px;
		}

    </style>

  </head>
  <body>
  <!-- error message box -->
    <%String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <%if(errorMessage != null){ %>
    	<div  class = "errorMessageOverlay"></div>
	<div class = "errorMessage">
		<img alt="error icon" src="<%= request.getContextPath() %>/icons/circle-exclamation-solid.svg"><br>
		<center><h2><b><%= errorMessage %></b></h2></center>
		<br>
		<button onclick="removeInvalidModal()">Okay</button>
	</div>
	<%} %>
	
	<%String successMessage = (String) request.getAttribute("successMessage"); %>
    <%if(successMessage != null){ %>
    	<div  class = "successMessageOverlay"></div>
	<div class = "successMessage">
		<img alt="error icon" src="<%= request.getContextPath() %>/icons/thumbs-up-solid.svg"><br>
		<center><h2><b><%= successMessage %></b></h2></center>
		<br>
		<button onclick="removeSuccessModal()">Okay</button>
	</div>
	<%} %>
  
  <!-- Register and login boxes -->
    <div class="overlay" onclick="removeModal()"></div>
    <div class="login-box" id = "login-box">
        <div class="left">
            <center>
            <img src="<%= request.getContextPath() %>/images/logo-1.png" class="logo">
            </center>
            <h1>AttireHub</h1><br>

            <div class="links">
                <a href="#"><img src="<%= request.getContextPath() %>/icons/facebook.svg" alt=""></a>
                <a href="#"><img src="<%= request.getContextPath() %>/icons/instagram.svg" alt=""></a>
                <a href="#"><img src="<%= request.getContextPath() %>/icons/twitter.svg" alt=""></a>
            </div> <br><br>

            <div class="contact-info">
                <img src="<%= request.getContextPath() %>/icons/mobile-solid.svg" alt="">: +977 9843****** <br><br>
                <img src="<%= request.getContextPath() %>/icons/phone-solid.svg" alt="">: +977 01-536**** <br><br>
                <img src="<%= request.getContextPath() %>/icons/map-location-dot-solid.svg" alt="">: Ason, Kathmandu, Nepal <br>
            </div>
        </div>

        <div class="right">
            <h2>Login to Your Account</h2><br>
            <form action = "LoginServlet" method = "post">
                <label for="email">Email</label><br><br>
                <input type="text" name="email" id="email" required>

                <label for="password">Password</label>
                <div class="password-field">
                    <input type="password" name="password" id="password" required>

                    <div class="hidden-view" onclick="viewPassword()">
                        <img  class="hide-pw-gogs" src="<%= request.getContextPath() %>/images/hidden.png" alt="password hide">
                        <img class="hide-pw-face" src="<%= request.getContextPath() %>/images/view.png" alt="password logo">
                    </div>
                </div>
                <a href="#" class="forgot-pw">Forgot Password?</a><br><br>
                
                <input type="submit" value="Login"><br>
                <br>
                <p>Don't have an account? <a href="#" onclick="showRegisterForm()()">Register here</a></p>
            </form>
        </div>
    </div>






    <div class="register-box" id="register-box"> 
        <div class="left">
            <center>
                <img src="<%= request.getContextPath() %>/images/logo-1.png" class="logo">
                </center>
                <h1>AttireHub</h1><br>
    
                <div class="links">
                    <a href="#"><img src="<%= request.getContextPath() %>/icons/facebook.svg" alt=""></a>
                    <a href="#"><img src="<%= request.getContextPath() %>/icons/instagram.svg" alt=""></a>
                    <a href="#"><img src="<%= request.getContextPath() %>/icons/twitter.svg" alt=""></a>
                </div> <br><br>
    
                <div class="contact-info">
                    <img src="<%= request.getContextPath() %>/icons/mobile-solid.svg" alt="">: +977 9843****** <br><br>
                    <img src="<%= request.getContextPath() %>/icons/phone-solid.svg" alt="">: +977 01-536**** <br><br>
                    <img src="<%= request.getContextPath() %>/icons/map-location-dot-solid.svg" alt="">: Ason, Kathmandu, Nepal <br>
                </div>
        </div>
        <div class="right">
            <form action="RegisterServlet" method = "post" enctype = "multipart/form-data">
                <h2>Register Your Account</h2>
                <label for="image">Upload Photo</label>
                <input type="file" name="image" id="image" required>

                <div class="register-col">
                    <div class="register-row">
                        <label for="fname">First Name</label>
                        <input type="text" name="fname" id="fname" required>
                    </div>

                    <div class="register-row">
                        <label for="lname">Last Name</label>
                        <input type="text" name="lname" id="lname" required>
                    </div>

                </div>

                <div class="register-col">
                    <div class="register-row">
                        <label for="dob">Date of Birth</label>
                        <input type="date" name="dob" id="dob" required>
                    </div>

                    <div class="register-row">
                        <label for="gender">Gender</label>
                        <div class="radio-btn">
                            <input type="radio" name="gender" id="gender" value="male" checked ><label for="male">Male</label>
                            <input type="radio" name="gender" id="gender" value="female" required ><label for="female">Female</label>
                            <input type="radio" name="gender" id="gender" value="other" required ><label for="other">Other</label>
                        </div>
                    </div>

                </div>

                <div class="register-col">
                    <div class="register-row">
                        <label for="register-email">Email</label>
                        <input type="text" name="register-email" id="register-email" required>
                    </div>
                    <div class="register-row">
                        <label for="register-phone">Phone Number</label>
                        <input type="text" name="register-phone" id="register-phone" required>
                    </div>
                </div>

                <div class="register-col">
                    <div class="register-row">
                        <label for="register-password">Password</label>
                        <input type="password" name="register-password" id="register-password" required>
                    </div>
                    <div class="register-row">
                        <label for="confirm-password">Confirm Password</label>
                        <input type="password" name="confirm-password" id="confirm-password" required>
                    </div>
                </div>

                

                <input type="submit" value="Register"><br><br>
                <p>Already have an account? <a href="#" onclick="showLoginForm()">Login</a></p>
            </form>
        </div>

    </div>










    <header>
        <nav>
            <div class="nav-logo">
                <img src="./images/logo-1.png" alt="">
                <span><b>AttireHub</b></span>
            </div>
            <div class="tabs">
                <ul>
                    <li><b><a href="<%= request.getContextPath() %>/index.jsp">Home</a></b></li>
                    <li><b><a href="<%= request.getContextPath() %>/pages/shop.jsp">Shop</a></b></li>
                    <li><b><a href="<%= request.getContextPath() %>/pages/aboutus.jsp">About Us</a></b></li>
                    <li><b><a href="<%= request.getContextPath() %>/pages/contactus.jsp">Contact Us</a></b></li>
                </ul>
                <div class="buttons">
                    <!-- login/register buttons -->
                    <!-- login/register buttons -->
 	 				<% 
	 				SessionManagement ses = new SessionManagement();
	                String user = (String)session.getAttribute("user");
	 				if (!ses.checkUser(user)) { %>
                    <!-- Display sign in and sign up buttons if there's no session -->
                    <button onclick="showLoginForm()">Sign In</button>
                    <button onclick="showRegisterForm()">Sign Up</button>
                <% } else { %>
                    <!-- Display user's information if there's an active session -->
                    <div class="user-info"> 
                    <%
                    	String Email = (String)session.getAttribute("user");
                    %>                  
                    <sql:query var="getUserInfo" dataSource="${conn}">
                    	SELECT * FROM customers WHERE cus_email = "<%=Email%>";
                    </sql:query>
                    <c:forEach var="user" items="${getUserInfo.rows}">
		                    <div class = "user-Image">
		                    	<img src = "http://localhost:8080/images/Users/${user.cus_photo}">
		                    </div>
		                    <div class="user-details">
		                    	<span>Welcome, <c:out value="${user.cus_name}"></c:out></span><br>
		                    	<div class = "profile-buttons">
			                    	<a href="<%= request.getContextPath() %>/pages/cart.jsp"><button> View Cart </button></a>
			                    	<a href="<%= request.getContextPath() %>/pages/profile.jsp"><button> View Profile</button></a>
			                    	<form action="<%= request.getContextPath() %>/LogoutServlet" method="post">
			                        	<button type="submit">Logout</button>
			                    	</form>
		                    	</div>
		                    
		                    </div>
                    </c:forEach>
                    </div>
                <% } %>
                </div>   
            </div>
        </nav>
    </header>

<div class="container">
	<div class="profile">
		<%
			String email = (String)session.getAttribute("user");
		%>
			<sql:query var="users" dataSource="${conn}">
				SELECT * FROM customers WHERE cus_email = "<%=email%>";
			</sql:query>
			
			<c:forEach var="user" items="${users.rows}">
				<div class="push">
					<center><img src="http://localhost:8080/images/Users/${user.cus_photo}" alt="Profile Picture" style=""></center><br>
                    <div class="writing1">
                    	<p><strong>Name:</strong> ${user.cus_name}</p><br>
						<p><strong>Contact No:</strong> ${user.cus_contact}</p><br>
						<p><strong>Email:</strong> ${user.cus_email}</p><br>
						<p><strong>Gender:</strong> ${user.cus_gender}</p><br>
						<p><strong>Date of birth:</strong> ${user.cus_DOB}</p><br>
						<br><br><br><br><br>
						<center><button onclick="displayEditForm()">Edit Info</button></center>
                    </div>
					<div class="edit-form">
						<form action = "<%=request.getContextPath() %>/EditCustomerServlet" method="post" enctype="multipart/form-data">
							<h2>Edit Personal Information</h2>
							<input type="text" name="edit-code" id="edit-name" value="${user.cus_code}" style="display:none">
				            <label for="edit-image">Upload Photo</label>
				            <input type="file" name="edit-image" id="edit-image" >

				            <div class="register-col">
				                <div class="register-row">
				                    <label for="edit-name">Name</label>
				                    <input type="text" name="edit-name" id="edit-name" value="${user.cus_name}">
				                </div>
				
				            </div>

				            <div class="register-col">
				                <div class="register-row">
				                    <label for="edit-dob">Date of Birth</label>
				                    <input type="date" name="edit-dob" id="edit-dob" value="${user.cus_DOB}">
				                </div>
				
				                <div class="register-row">
				                    <label for="edit-gender">Gender</label>
				                    <div class="radio-btn">
				                        <input type="radio" name="edit-gender" id="edit-gender" value="male" checked ><label class="radio" for="edit-male">Male</label>
				                        <input type="radio" name="edit-gender" id="edit-gender" value="female" required ><label class="radio" for="edit-female">Female</label>
				                        <input type="radio" name="edit-gender" id="edit-gender" value="other" required ><label class="radio" for="edit-other">Other</label>
				                    </div>
				                </div>
				
				            </div>

				            <div class="register-col">
				                <div class="register-row">
				                    <label for="register-email">Email</label>
				                    <input type="text" name="edit-register-email" id="edit-register-email" value="${user.cus_email}" readonly/>
				                </div>
				                <div class="register-row">
				                    <label for="edit-register-phone">Phone Number</label>
				                    <input type="text" name="edit-register-phone" id="edit-register-phone" value="${user.cus_contact}">
				                </div>
				            </div>
				
				            <div class="register-col">
				                <div class="register-row">
				                    <label for="edit-register-password">Password</label>
				                    <input type="password" name="edit-registered-password" id="edit-register-password">
				                </div>
				                <div class="register-row">
				                    <label for="confirm-password">Confirm Password</label>
				                    <input type="password" name="edit-confirm-password" id="edit-confirm-password">
				                </div>
				            </div>

            				<input type="submit" value="Submit">
            				
						</form>
						<button onclick="removeBox()">Cancel</button>
					</div>
				</div>				
			</c:forEach>
	
	

		
		
		
		
		</div>
		<div class="purchase-history">
		<div class="display1">
			<center><h2>Purchase History</h2></center><br>
			<hr style="width:50%; margin-left:200px;">
		</div>
		<div class="purchase-history-inner">
			<div class="info">
			<sql:query var="orders" dataSource="${conn}">
				SELECT orders.order_id, customers.cus_email,dates.date, products.product_name, products.brand, order_line.product_total_cost 
				FROM customers JOIN orders ON customers.cus_code = orders.order_customer 
				JOIN dates ON orders.order_date = dates.date_code  JOIN order_line ON orders.order_id = order_line.order_id
				JOIN products ON products.product_code = order_line.product_id  WHERE customers.cus_email = "<%=email%>";
			</sql:query>
				<table>
					<tr>
						<th>Order ID</th>
						<th>Order Date</th>
						<th>Product Name</th>
						<th>Brand</th>
						<th>Total Cost</th>
					</tr>
					<c:choose>
						<c:when test="${empty orders.rows}">
							<p class="nomatch-error">No Purchase History Recorded.</p>
						</c:when>
						<c:otherwise>
							<c:forEach var="order" items="${orders.rows}" varStatus="status">
								<tr>
									<td>${order.order_id}</td>
									<td>${order.date}</td>
									<td>${order.product_name}</td>
									<td>${order.brand}</td>
									<td>${order.product_total_cost}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
		</div>
	
	</div>
</div>
      	
<div class="edit-overlay" onclick="removeModal()"></div>     	
<div class="footer">
		<div class="footer-container">
			<div class="footer-row">
			    <div class="footer-col">
			        <h4>AttireHub</h4>
			        <ul>
			            <li><a href="#">About us</a></li>
			            <li><a href="#">Our Products</a></li>
			            <li><a href="#">Contact us</a></li>
			            <li><a href="#">Privacy Policy</a></li>
			        </ul>
			    </div>
			    
			    <div class="footer-col">
			        <h4>Get Help</h4>
			        <ul>
			            <li><a href="#">FAQ</a></li>
			            <li><a href="#">Shippings</a></li>
			            <li><a href="#">Returns</a></li>
			            <li><a href="#">Orders</a></li>
			        </ul>
			    </div>
			    <div class="footer-col">
			        <h4>About the shop</h4>
			        <p>AttireHub is an E-commerce clothing web-site where you find the best clothing items. Our website is easy to navigate, making it simple to find the clothes you want in just a few clicks.</p>
			    </div>
			    <div class="footer-col">
			        <h4>Follow us</h4>
			        <div class="social-link">
			            <ul>
			                <li><a href=""><ion-icon name="logo-facebook"></ion-icon></a></li>
			                <li><a href=""><ion-icon name="logo-twitter"></ion-icon></a></li>
			                <li><a href=""><ion-icon name="logo-tiktok"></ion-icon></a></li>
			                <li><a href=""><ion-icon name="logo-instagram"></ion-icon></a></li>
			            </ul>
			        </div>
			    </div>
			</div>
		</div>
    </div>
   
     <form action='<%= request.getContextPath() %>/AddToCartServlet' method = 'post' id="popup-form">
   </form>
   
   <script>
	   function displayEditForm(){	
		    document.querySelector(".edit-form").style.display = "block";
		}

	   function removeBox(){
		    document.querySelector(".edit-form").style.display = "none";
	   }
   </script>
   <script src="<%=request.getContextPath()%>/script/script.js"></script>
  </body>
  </html>