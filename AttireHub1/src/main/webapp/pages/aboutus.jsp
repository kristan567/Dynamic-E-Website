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
        .container{
    		margin: 0% 5%;
    	}
    /* CSS for the whole content secition */
		.aboutUs{
		  position: relation;
		  width: 100%;
		  padding: 40px 100px;
		}
		
		.aboutUs .title{
		  display: flex;
		  justify-content: center;
		  align-items: center;
		  font-size: 2em;
		}
		
		.aboutUs .title h2{
		  font-weight: 500;
		}
		.content{
		    display: flex;
		    justify-content: center;
		}
		
		.article-cnt{
		    padding: 1em;
		    margin: 2em;
		    box-shadow: 0em 0em 0.5em black;
		    height: 23em;
		    width: 50em;
		    background-repeat: no-repeat;
		    background-size: cover;
		    overflow: hidden;
		    box-sizing: border-box;
		    padding-right: 20em;
		}
		
		.article-cnt:hover{
		    height: 31em;
		    padding-right: 1em;
		    transition: 2s;
		}
		
		.article-1{
		    padding: 1em;
		    box-shadow: 0em 0em 0.5em black;
		    margin: 1em 1em;
		    background-repeat: no-repeat;
		    background-size: cover;
		    height: 17em;
		    width: 36em;
		    padding-right: 11em;
		    box-sizing: border-box;
		    overflow: hidden;
		}
		
		.article-1:hover{
		    transition: 2s;
		    height: 25em;
		    padding-right: 0em;
		}
		
		.right-article{
		    height: 75vh;
		    margin: 2em 5em 2em 1em;
		    text-align: left;
		    border-radius: 1em;
		    box-shadow: 0em 0em 1em black;
		    padding: 1em;
		    position: sticky;
		    top: 50px;
		    background-image:linear-gradient(#F95B3D, #4654A3 ) ;
		}
		
		.right-article p{
			margin: 15px 10px;
			
		}
		
		.infoBox ul{
			display:flex;
			color: black;
			list-style: none;
			justify-content: center;
			align-items: center;
		}
		
		.infoBox ul li{
			display:flex;
			font-size:25px;
			color: black;
			margin: 0 10px;
		}
		
		.infoBox ul li a{
			display:flex;
			font-size:25px;
			color: black;
		}
		
		
		input[type = 'text']{
		    width: 75%;
		    border: none;
		    box-shadow: 0em 0em 0.2em;
		    padding: 0.2em;
		    background-color: #ada8a8;
		}
		
		
		.submit{
		    color: white;
		    background-color: green;
		    padding: 0.5em;
		    border-radius: 1em;
		    font-weight: bold;
		}
		
		.submit:hover{
		    cursor: pointer;
		    background-color: darkgreen;
		}
		
		.submit:active{
		    background-color: lightgreen;
		}
		        
		.article-gretting img{
		    height: 2em;
		    margin-bottom: -0.8em;
		}
		
		.questionBox div{
		    display: flex;
		    align-items: center;
		    margin-bottom: 4px;
		}
		
		.questionBox div span{
		    min-width: 35px;
		    height: 35px;
		    color: #fff;
		    background: #18b7ff;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    border-radius: 50%;
		    margin-right: 15px;
		}
		.questionBox div p{
		    color: #fff;
		}
		.info .infoBox div{
		    display: flex;
		    align-items: center;
		    margin-bottom: 10px;
		}
		.info .infoBox div span{
		    min-width: 40px;
		    height: 40px;
		    color: #fff;
		    background: #fff;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    font-size: 1.5em;
		    border-radius: 50%;
		    margin-right: 15px;
		
		}
		.info .infoBox div p{
		    color: #fff;
		    font-size: 1.1em;
		}
    </style>

  </head>
  <body>
  <!-- error message box -->
    <%String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <%if(errorMessage != null){ %>
    	<div  class = "errorMessageOverlay"></div>
	<div class = "errorMessage">
		<img alt="error icon" src="./icons/circle-exclamation-solid.svg"><br>
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
		<button onclick="removeInvalidModal()">Okay</button>
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
            <form action = "<%= request.getContextPath() %>/LoginServlet" method = "post">
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
            <form action="<%= request.getContextPath() %>/RegisterServlet" method = "post" enctype = "multipart/form-data">
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
              <div class="content">

            <!-- this div contains the left part of the blog page -->
            <div class="left-Article">

                <!-- blog 2 though it has class blog 1 -->
                <div class="article-1" style="background-position: -9em 0em; margin-left: 3em; background-color: #99ccff;">
                    <h1>ABOUT US <br> ATTIREHUB</h1>
                    
                    <p>Welcome to our online store for fashion-conscious individuals! We are passionate about providing high-quality and stylish clothing options that cater to a diverse range of tastes and preferences. At our e-commerce website, we believe that fashion is not just about looking good, but also about feeling confident and comfortable in your own skin. That's why we are committed to offering an extensive collection of clothes that not only look great but also fit perfectly and feel amazing to wear. </p>
                    <p>Whether you're looking for trendy outfits for a night out with friends, comfortable clothes for a lazy day at home, or professional attire for work, we've got you covered. Our collection includes a variety of styles, sizes, and colors, so you're sure to find something that suits your individual style and needs. We also prioritize affordability without compromising on quality, so you can shop with confidence knowing that you're getting the best value for your money. With our easy-to-use website, convenient shipping options, and excellent customer service, we strive to make your online shopping experience as enjoyable and stress-free as possible.</p>
                </div>

                <!-- blog 3 through it has class blog 1 -->
                <div class="article-1" style="background-color: #9999ff; background-position: -3em 0em;color: white; margin-left: 15em;" >
                    <h1>FREQUENTLY <br> ASKED QUESTIONS(FAQ)</h1>
                    <div class="questionBox">
                        <div>
                            <span><ion-icon name="help-circle-outline"></ion-icon></span>
                            <p>What is your return policy?</p>
                        </div>
                        <div>
                            <span><ion-icon name="arrow-forward-outline"></ion-icon></span>
                            <p>We understand that sometimes items may not fit or meet your expectations. That's why we offer a hassle-free return policy within 30 days of purchase.Simply contact our customer service team to initiate the return process.</p>
                        </div>
                        <div>
                            <span><ion-icon name="help-circle-outline"></ion-icon></span>
                            <p>What payment methods do you accept?</p>
                        </div>
                        <div>
                            <span><ion-icon name="arrow-forward-outline"></ion-icon></span>
                            <p>We accept a variety of payment methods, including major credit cards, E-sewa, and Khalti. We use secure payment gateways to ensure your information is kept safe.</p>
                        </div>
                        <div>
                            <span><ion-icon name="help-circle-outline"></ion-icon></span>
                            <p> Can I cancel or modify my order?</p>
                        </div>
                        <div>
                            <span><ion-icon name="arrow-forward-outline"></ion-icon></span>
                            <p>If your order has not yet shipped, you may be able to cancel or modify it. Please contact our customer service team as soon as possible to request a change.</p>
                        </div>
                      </div>
                    </div>
             

                <!-- Blog 4 thrpough it has class blog 1 -->
                <div class="article-cnt" style="background-position: 8em 0em; color: aliceblue; background-color: #366996;">
                    <h1>HOW<br>DO WE WORK?</h1>
                    <p>Our e-commerce website for selling clothes is dedicated to providing a convenient and enjoyable shopping experience for all of our customers. We have designed our website to be easy to navigate, making it simple to find the clothes you want in just a few clicks. Our collection includes a variety of styles, sizes, and colors, ensuring that there's something for everyone. Whether you're looking for casual wear, professional attire, or formal wear, we've got you covered.

                        Once you find the items you want, simply add them to your cart and proceed to checkout. We accept a variety of payment methods, including major credit cards, E-sewa, and Khalti. We use secure payment gateways to ensure that your information is kept safe. We offer standard and expedited shipping options, with most orders being delivered within 3-7 business days. We also offer international shipping to many countries, although shipping times and costs may vary depending on your location.
                        
                        When you receive your order, try on your new clothes and enjoy! We're confident that you'll love your purchase, but if for any reason you're not satisfied, we offer hassle-free returns within 30 days of purchase. Our customer service team is always available to assist you with any questions or concerns you may have. We're committed to providing excellent customer service and personalized attention to each and every one of our customers.
                        
                        In summary, at our e-commerce website for selling clothes, we strive to make the online shopping experience as convenient and enjoyable as possible. We offer a wide selection of high-quality clothes at affordable prices, easy and secure payment methods, fast and reliable shipping options, and hassle-free returns. With our commitment to excellent customer service, you can shop with confidence knowing that we're here to help you every step of the way.</p>

                    <p>Online shopping has revolutionized the way we buy goods and services, transforming the traditional retail industry. With the rise of e-commerce websites, people now have access to a global marketplace, enabling them to purchase products from anywhere in the world. This has increased competition, lowered prices, and provided consumers with more choices and convenience than ever before.</p>
                </div>
            </div>

            <!-- this div contains the right part of this page with a article form -->
            <div class="right-article">

                <!-- form heading -->
                <h3>ADVERTISEMENT</h3>

                <iframe width="440" height="220" src="https://www.youtube.com/embed/OaVsCM0Zeio" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

                
                <p>Looking to upgrade your wardrobe? Look no further than our e-commerce website for selling clothes! We offer a wide selection of high-quality, fashionable clothing for men and women at affordable prices. From casual wear to formal attire, we've got you covered.<br> <br>We're committed to providing excellent customer service and personalized attention to each and every one of our customers. So what are you waiting for? Visit our website today and start shopping!</p>
                <div class="infoBox">
                        <ul class="sci">
                            <li><a href=""><ion-icon name="logo-facebook"></ion-icon></a></li>
                            <li><a href=""><ion-icon name="logo-twitter"></ion-icon></a></li>
                            <li><a href=""><ion-icon name="logo-tiktok"></ion-icon></a></li>
                            <li><a href=""><ion-icon name="logo-instagram"></ion-icon></a></li>
                        </ul>
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
   
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

    <script src="<%= request.getContextPath() %>/script/script.js"></script>
  </body>
  </html>