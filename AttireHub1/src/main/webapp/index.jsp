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
		.container{
			margin: 0% 5%;
		}
		
		.image-slider{
			width: 100%;
			height: 500px;
			margin: 0;
			overflow: hidden;
		}
		
		.image-slider img{
			width: 100%;
			height: 100%;
			transition: opacity 0.5s ease-in-out;
		}
		
		.adv-ser{
			background-color:white;
			height: 300px;
			width: 100%;
			float: left;  
			margin: 50px 0px 0px 0px;   
			border: 1px solid blck;
		}
		
		.ad{
			background-color:white;
			height: 300px;
			width: 500px;
			float: left;
			margin: 0px 0px 0px 0px;        
			border: 1px solid blck;
		}
		
		.men-cloth{
			background-color: white;
			height: 300px;
			width: 400px;
			float: left;
			margin: 0px 0px 0px 70px;        
			border: 1px solid blck;
		}
		
		.service{
			background-color:white;
			height: 30px;
			width: 300px;
			float: right;
			margin: 0px 0px 0px 0x;           
			border: 1px solid blck;
			background-repeat: no-repeat;
			background-size: cover;
			box-sizing: border-box;
			overflow: hidden;
			padding: 5px;
			border-radius: 15px;
		}
		
		.new-arrivals{
			background-color:white;
			height: 100%;
			width: 100%;
			margin: 50px 0px 0px 0px;         
			background-color: white;
		}
		
		.image-slider img{
			width: 100%;
			height: 100%;
		}
		
		.service:hover{
			background-color: #99ccff;
			transition: 1s;
			height: 18em;

		}

    </style>

  </head>
  <body>
  <!-- error message box -->
	
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
        <div class="image-slider" id="image-slider">
            <!-- this section cintains the codes for the image slider -->
            	<img src="<%=request.getContextPath()%>/images/slider-1.webp" alt = "">
            	
           </div>

 
        <div class="adv-ser">
            <div class="ad" >
				<img src="<%= request.getContextPath() %>/gifs/gif-1.gif" alt = "">
				
            </div>
            <div class= "men-cloth">
            	<img src="<%= request.getContextPath() %>/gifs/nirvana.gif"  style="width: 400px; height:300px;">
            </div>
            <div class="service">
					<h3>service</h3>
            </div>
        </div>
        
        <div class="header1" style="margin:400px 0px 0px 0px"><h2> New Arrivals</h2></div>
        <div class="new-arrivals"  >
            <div class="container-content">
                <!-- database query-->
     			<sql:query dataSource="${conn}" var="result">
                	<%=MyConstants.GET_HOT_DEALS_PRODUCTS_INFO %>
                </sql:query>
                                <!-- div for each product -->
                    <c:forEach var="product" items="${result.rows}" varStatus="status">
				        <!-- start a new row every 4th iteration -->

					        <div class="product-box">
					            <img src="http://localhost:8080/images/Products/${product.product_photo}">
					            <h4>${product.product_name}</h4>
					            <h4>Price:NPR ${product.product_price}</h4>
					            <button onclick="showPopup('${product.product_code}','${product.product_name}','${product.product_description}','${product.product_category}','${product.gender}','${product.product_stock_quantity}','${product.product_price}','${product.product_photo}','${product.brand}')">View</button>
					        </div>


				    </c:forEach>

     				
     				
               

                
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
   <script>
   var image  = ["images/slider-1.webp","images/slider-2.webp","images/slider-3.png", "images/slider-4.jpg"];
   var x = 0;
   var imageslider = document.getElementById("image-slider") ;
   setInterval(slider, 3000);

   function slider(){
   	 if(x < image.length){
   		x= x + 1;
   		
   	}else{
   		x = 1;
   	}
   	imageslider.innerHTML = "<img src=" + image[x - 1] + ">";
   	
   }
   </script>
   
   

    <script src="<%=request.getContextPath()%>/script/script.js"></script>
  </body>
  </html>