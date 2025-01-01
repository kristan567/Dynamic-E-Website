 <%@page import="java.sql.ResultSet"%>
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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/styles.css">
    <style>
    	/**{
    		border: dashed black 1px;
    	}*/
    
    	.container{
    		width: 90%;
    		margin: 0% 5%;
    	}
    	
		.maindiv{
			display: flex;
		}
			
		.leftdiv{
			flex:1;
		} 
		
		.cart-product{
			display: flex;
			margin: 3% 1%;
			border-radius: 10px;
			box-shadow: 0 0 5px black;
		}
		
		.cart-product-image{
			flex:3;
		}
		
		.cart-product-image img{
			margin: 1%;
			width: 100%;
			height: 33vh;
		}
		
		.product-information{
			margin: 20px 0px 20px 30px;
			flex:4;
		}	
		
		.product-quantity input{
			border-radius: 10px;
			padding: 2px 5px;
		}
		
		.rightdiv{
		    position: sticky;
		    top: 75px;
		    right: 2px;
		    width: 50%;
		    height: 100%;
		    background-color: #f1f1f1;
		}  
		
		.rightdiv .message{
			box-shadow: 0 0 5px black;
			padding: 20px 5px;
			border-radius: 10px;
			font-size: 14px;
			
			
		}
		
		
		.rightdiv .bill{
			box-shadow: 0 0 5px black;
			border-radius: 10px;
			padding: 20px 5px;
			margin: 20px;
			text-align: center;
		}
		
		.rightdiv .bill span{
			font-size: 50px;
			font-weight: bolder;
		}
		
		input[type="submit"]{
			width: 70%;
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
                <img src="<%= request.getContextPath() %>/images/logo-1.png" alt="">
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
		<div class="maindiv">
			<div class="leftdiv">
				<!-- Extracting customer code -->
				<%
					DbConnection connection = new DbConnection(); 
					String email = (String)session.getAttribute("user");
					ResultSet cusResult = connection.selectUserUsingEmail(MyConstants.IS_REGISTERED_QUERY, email);
					int cusCode = 0;
					if(cusResult.next()){
						cusCode = cusResult.getInt("cus_code");
					}
				%>
				<sql:query var="carts" dataSource="${conn}">
					SELECT products.product_code, products.product_photo, products.product_name, products.product_price, products.brand, cart.product_quantity, cart.product_total_cost, customers.cus_code FROM products JOIN cart ON products.product_code=cart.product_id JOIN customers ON cart.cus_id = customers.cus_code WHERE customers.cus_code = <%=cusCode %>;
				</sql:query>
				<c:forEach var="cart" items="${carts.rows}" >
					<div class="cart-product" >
						<div class="cart-product-image">
							<img src="http://localhost:8080/images/Products/${cart.product_photo}">
						</div>
						<div class="product-information">
							<form action="<%=request.getContextPath()%>/EditCartServlet" method="post">
								<span class = "product-code" style="display: none;"><input type="text" name="product-code" value="${cart.product_code}"></span>
								<span class = "product-name"><h3>${cart.product_name}</h3></span><br>
								<span class = "product-brand"><b>Brand:</b>${cart.brand}</span><br>
								<span class = "product-price"><b>Price:</b> NRs. ${cart.product_price}<input type="number" name="product-price" value="${cart.product_price}" style="display:none;"></span><br><br>
								<span class = "product-quantity"><b>Quantity:</b><input type="number" name="product-quantity" value="${cart.product_quantity}"></span><br>
								<span class = "product-total-price"><b>Total:</b>NRs. ${cart.product_total_cost}</span><br><br>
								<span class = "remove-option">
									<input type="checkbox" id="remove-cart" name="remove[]" value="remove">
	                				<label >Remove Product From Cart</label><br>
                				</span>
								<input type="submit" value = "Edit">
								
							</form>	
						</div>
					</div>	
				</c:forEach>
		
				</div>         					                                        			

			<div class="rightdiv">
				<div class="message">
					<h2>Dear valued customer,</h2>

					<p>We hope this message finds you well. We wanted to take a moment to thank you for choosing our store for your clothing needs. We understand that paying for your purchases can be a stressful and confusing experience, which is why we wanted to provide you with some helpful information to make the process as easy and straightforward as possible.<p><br>
					
					<p>Firstly, we accept various forms of payment including cash, credit/debit cards, and mobile payments. Our checkout process is quick and simple, so you can get back to enjoying your day. We also offer layaway and financing options for those who need a little extra time to pay for their purchases. Our friendly staff will be happy to assist you with any questions you may have about these options.<p><br>
					
					<p>Additionally, we want to ensure that you feel confident in the security of your payment information. Our store uses the latest technology to ensure that your personal and financial information is kept safe and secure.<p><br>
					
					<p>We understand that unexpected circumstances can arise, which may make it difficult to make your payment on time. If this happens, we encourage you to reach out to us and let us know. We will do our best to work with you and find a solution that works for everyone.<p><br>
					
					<p>Once again, thank you for choosing our store for your clothing needs. We appreciate your business and look forward to serving you in the future.<p><br>
					
					<b>Best regards,<br>
					AttireHub</b>
										
				</div>
				<div class="bill">
					<h2>You Total bill is:</h2>
					<sql:query var="bills" dataSource="${conn}">
						SELECT customers.cus_code, SUM(cart.product_total_cost) AS grand_total FROM products JOIN cart ON products.product_code=cart.product_id JOIN customers ON cart.cus_id = customers.cus_code  WHERE customers.cus_code = <%=cusCode%> GROUP BY customers.cus_code;
					</sql:query>
					<c:forEach var="bill" items="${bills.rows}">
						<span>NRs.${bill.grand_total}</span>
						<form action="<%=request.getContextPath()%>/BuyServlet" method="post">
							<input type = "text" name = "total-price" value = "${bill.grand_total}" style="display: none;">
							<input type = "Submit" value = "Buy">
						</form>
					</c:forEach>
				</div>
			</div>   
		</div>              
	</div>
      	
      	
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
    
    
    
    
	<div class="product-overlay" onclick="removeProductOverlay()"></div>
   <div class = "popup-main" id="popup-main" >
   <div class = "popup" id= "popup">
   </div>
     <form action='<%= request.getContextPath() %>/AddToCartServlet' method = 'post' id="popup-form">
   </form>
   </div>
 
   <script src="<%=request.getContextPath()%>/script/script.js"></script>
  </body>
  </html>