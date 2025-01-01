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
    <title>AttireHub - Contact Us</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/styles.css">
	<style>
        .container{
    		margin: 0% 5%;
    	}
	.contactUs{
	  width: 90%;
	  padding: 40px 100px;
	}

.contactUs .title{
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 2em;
}

.contactUs .title h2{
  font-weight: 500;
}
.form{
    grid-area: form;
}
.info{
    grid-area: info;
}
.map{
    grid-area: map;
}
.contact{
    padding: 40px;
    background: #0e3959;
    box-shadow: 0 5px 35px rgba(0, 0, 0, 0.15);
}

.box{
    position: relative;
    display: grid;
    grid-template-columns: 2fr 1fr;
    grid-template-rows: 5fr 4fr;
    grid-template-areas: 
    "form info"
    "form map";
    grid-gap: 20px;
    margin-top: 20px;
}
.contact h3{
    color: #fff;
    font-weight: 500;
    font-size: 1.4em;
    margin-bottom: 10px;
}
.formBox{
    position: relative;
    width: 100%;
}
.formBox .row50{
    display: flex;
    gap: 20px;
}
.inputBox{
    display: flex;
    flex-direction: column;
    margin-bottom: 10px;
    width: 100%;
}
.formBox.row100 .inputBox{
    width: 100%;
}
.inputBox span{
    color: #18b7ff;
    margin-top: 10px;
    margin-bottom: 5px;
    font-weight: 500;
}
.inputBox input{
    padding: 7px;
    font-size: 1.1em;
    outline: none;
    border: 1px solid #333;
    width: 80%
}
.inputBox textarea{
    padding: 10px;
    font-size: 1.1em;
    outline: none;
    border: 1px solid #333;
    resize: none;
    min-height: 150px;
    margin-bottom: 10px;
    width: 90%;
}
.inputBox input[type="submit"]{
    background: #ff578b;
    color: #fff;
    border: none;
    font-size: 1.1em;
    max-width: 120px;
    font-weight: 500;
    cursor: pointer;
    padding: 14px 15px;
}
.inputBox ::placeholder{
    color: #999;
}

.info h3{
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
    background: #18b7ff;
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
.info .infoBox div a{
    color: #fff;
    text-decoration: none;
    font-size: 1.1em;
}
.sci{
    margin-top: 40px;
    display: flex;
}
.sci li{
    list-style: none;
    margin-right: 15px;
}
.sci li a{
    color: #fff;
    font-size: 2em;
    color: #ccc;
}
.sci li a:hover{
    color: #fff;
}
.map{
    padding: 0;
}
.map iframe{
    width: 100%;
    height: 100%;
}

.row50{
display:flex;
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
		<img alt="error icon" src="<%= request.getContextPath() %>/icons/thumbs-up-solid.svg"><br>ook.svg"><br>
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
                <p>Don't have an account? <a href="#" onclick="showRegisterForm()">Register here</a></p>
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
                <% } %>
                </div>   
            </div>
        </nav>
    </header>

    <!-- <div style=" width: 100%; height: 166.3129973474801vh; "> -->
        <div class="contactUs">
            <div class="title">
                <h2>Contact Us</h2>
            </div>
            <div class="box">
                <!-- Contact Form -->
                <div class="contact form">
                    <h3>Send a Message</h3>
                    <form>
                        <div class="formbox">
                            <div class="row50">
                                <div class="inputBox">
                                    <span>First Name</span>
                                    <input type="text" placeholder="John">
                                </div>
                                <div class="inputBox">
                                    <span>Last Name</span>
                                    <input type="text" placeholder="Cena">
                                </div>
                            </div>
                            <div class="row50">
                                <div class="inputBox">
                                    <span>Email</span>
                                    <input type="text" placeholder="Johncena@gmail.com">
                                </div>
                                <div class="inputBox">
                                    <span>Phone Number</span>
                                    <input type="text" placeholder="9812345678">
                                </div>
                            </div>
                            <div class="row100">
                                <div class="inputBox">
                                    <span>Message</span>
                                    <textarea placeholder="Write your message here..."></textarea>
                                </div>
                            </div>
                            <div class="row100">
                                <div class="inputBox">
                                    <input type="submit" value="Submit">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- Info Box -->
                <div class="contact info">
                    <h3>Contact Info</h3>
                    <div class="infoBox">
                        <div>
                            <span><ion-icon name="location-outline"></ion-icon></span>
                            <p>Jhosyee Shop, Ason, <br>NEPAL</p>
                        </div>
                        <div>
                            <span><ion-icon name="mail"></ion-icon></span>
                            <a href="#">AttireHub@gmail.com</a>
                        </div>
                        <div>
                            <span><ion-icon name="call"></ion-icon></span>
                            <a href="#">+977 9812345678</a>
                        </div>
                        <ul class="sci">
                            <li><a href=""><ion-icon name="logo-facebook"></ion-icon></a></li>
                            <li><a href=""><ion-icon name="logo-twitter"></ion-icon></a></li>
                            <li><a href=""><ion-icon name="logo-tiktok"></ion-icon></a></li>
                            <li><a href=""><ion-icon name="logo-instagram"></ion-icon></a></li>
                        </ul>
                    </div>
                </div>
                <!-- Map -->
                <div class="contact map">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3532.3139706422116!2d85.31239180000001!3d27.707590699999997!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb18ffc9c69a2d%3A0x8061872efee793b0!2sAson%2C%20Kathmandu%2044600!5e0!3m2!1sen!2snp!4v1683107860792!5m2!1sen!2snp" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                </div>
            </div>
        </div>
    <!-- </div> -->

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
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    
  	<script src="<%= request.getContextPath() %>/script/script.js"></script>
  </body>
  </html>