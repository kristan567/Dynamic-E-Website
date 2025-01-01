 <%@page import="controller.statemanagement.SessionManagement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="resources.MyConstants"%>
<%@page import="java.sql.Connection"%>
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
    <title>AttireHub - Shop</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/styles.css">
    <style>

     .container{
        display: flex;
        margin:  1% 5%;
    }

    .filters{
        padding: 1%;
        margin: 1%;
        border-radius: 10px;
        width: auto;
    }

    
.container-content {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-gap: 20px;
  margin: 10px;
}

.product-box{
	width: 100%;
	height: 60vh;
	overflow: hidden;
	border-radius:10px;
	text-align: center;
	cursor: pointer;
	box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25),
	0 10px 10px rgba(0, 0, 0,0.22);
	transition: .4s;
	background: #f2f2f2;
	text-align: left;
	white-space: nowrap;
	
}

.product-box:hover{
	box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16),
	0 3px 6px rgba(0, 0, 0,0.23);
	transform: translate(0px, -8px);
}
.product-box img{
	height: 47vh;
	width: 100%;
	text-align: center;
	margin: 5px auto;
	display: block;
}
.product-box h4{
	text-align: left;
	white-space: nowrap;
	overflow-x: auto;
	
}

.product-box h4{
	text-align: center;
	
}

.product-box button{
	background: #2183a2;
	width: 100%;
	height: 15%;
	font-weight: bold;
	cursor:pointer;

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

  <div class="container">
        <div class="filters">
            <h2>Filter By:</h2><br>
            <form action="<%= request.getContextPath() %>/pages/shop.jsp" method = "get">
                <h3><label>Gender:</label></h3>
                <sql:query var="genders" dataSource="${conn}">
                	SELECT DISTINCT gender FROM products ORDER BY gender;
                </sql:query>
                
                <c:forEach var="gender" items="${genders.rows}">
                	<input type="checkbox" id="gender_${gender.gender}" name="gender[]" value="${gender.gender}">
                	<label for="gender_${gender.gender}">${gender.gender}</label><br>
                </c:forEach><br>

        
                <h3><label>Category:</label></h3>
                
                <sql:query var="categories" dataSource="${conn}">
                	SELECT DISTINCT product_category FROM products ORDER BY product_category;
                </sql:query>
                
                <c:forEach var="category" items="${categories.rows}">
                	<input type="checkbox" id="category_${category.product_category}" name="category[]" value="${category.product_category}">
                	<label for="category_${category.product_category}">${category.product_category}</label><br>
                </c:forEach><br>
                
                <h3><label>Brand:</label></h3>
                
                <sql:query var="brands" dataSource="${conn}">
                	SELECT DISTINCT brand FROM products ORDER BY brand;
                </sql:query>
                
                <c:forEach var="brand" items="${brands.rows}">
                	<input type="checkbox" id="brand_${brand.brand}" name="brand[]" value="${brand.brand}">
                	<label for="brand_${brand.brand}">${brand.brand}</label><br>
                </c:forEach><br>
        
                <h3><label>Set Price Range</label></h3>
                <label for="min_price">Minimum Price:</label>
                <input type="number" id="min_price" name="min_price" min="0" value = "0" required><br>
        
                <label for="max_price">Maximum Price:</label>
                <input type="number" id="max_price" name="max_price" min="0" value = "0" required><br><br>
        
                <input type="submit" value="Filter Products">
            </form>
        </div>

		<div class="main-container">
			<center>
			<div class="searchbar">
			    <form action="<%= request.getContextPath() %>/pages/shop.jsp">
			        <input type="text" name="Search" placeholder="Search here...">
			        <input type="submit" name="Go" value="Search" id="search">
			    </form>
			</div>
			</center>
		
			<%
		     	String[] category = request.getParameterValues("category[]");
		     	String[] gender = request.getParameterValues("gender[]");
		     	String[] brand = request.getParameterValues("brand[]");
		     	String min = request.getParameter("min_price");
		     	String max = request.getParameter("max_price");
		     	
				String search = request.getParameter("Search"); 
		
		     	StringBuilder queryBuild = new StringBuilder("SELECT * FROM products WHERE ");
		     	if(gender!=null  && gender.length >0){
		     		queryBuild.append("gender IN ( ");
		     		for(String gen: gender){
		     			queryBuild.append('"'+gen+'"' + ", ");
		     		}
		     		queryBuild.delete(queryBuild.length()-2, queryBuild.length());
		     		queryBuild.append(") AND ");
		     	}
		
		     	if(category!=null  && category.length >0){
		     		queryBuild.append("product_category IN ( ");
		     		for(String cat: category){
		     			queryBuild.append('"'+cat+'"' + ", ");
		     		}
		     		queryBuild.delete(queryBuild.length()-2, queryBuild.length());
		     		queryBuild.append(") AND ");
		     	}
		
		     	if(brand!=null  && brand.length >0){
		     		queryBuild.append("brand IN ( ");
		     		for(String br: brand){
		     			queryBuild.append('"'+br+'"' + ", ");
		     		}
		     		queryBuild.delete(queryBuild.length()-2, queryBuild.length());
		     		queryBuild.append(") AND ");
		     	}
	         	int maxPrice = 0;
	         	int minPrice = 0;
		     	if(max != null && min != null &&!max.isEmpty() && !min.isEmpty() ){
		         	maxPrice = Integer.parseInt(max);
		         	minPrice = Integer.parseInt(min);
		         	if(maxPrice>minPrice) queryBuild.append("product_price BETWEEN "+ minPrice +" AND " + maxPrice);
		         	else queryBuild.delete(queryBuild.length()-5, queryBuild.length());
		     	}else{
		     		queryBuild.delete(queryBuild.length()-5, queryBuild.length());
		     	}
		
		     	if(category == null && gender == null && (max == null || max.isEmpty()) && (min == null  || min.isEmpty()) && brand == null){
		     		queryBuild.delete(queryBuild.length()-2, queryBuild.length());
		     	}
		
		     	queryBuild.append(";");
		     	
		     	

		     	if(category == null && gender == null && brand == null && maxPrice==0 && minPrice == 0 && (search == null || search.isEmpty())){
			%>
				<div class="container-content">
				    <!-- database query-->
					<sql:query dataSource="${conn}" var="result">
						<%=MyConstants.GET_PRODUCTS_INFO %>
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
		
			<%}else if( search!= null && !search.isEmpty()){%>
				<div class="container-content">
					<!-- database query-->
					<sql:query dataSource="${conn}" var="result">
						SELECT * FROM products WHERE product_name LIKE "%<%=search%>%";
					</sql:query>
			     	
					<c:choose>
						<c:when test="${empty result.rows}">
							<p class="nomatch-error">Sorry, no match found.</p>
						</c:when>
						<c:otherwise>
							<c:forEach var="product" items="${result.rows}" varStatus="status">
								<div class="product-box">
								<img src="http://localhost:8080/images/Products/${product.product_photo}">
								<h4>${product.product_name}</h4>
								<h4>Price:NPR ${product.product_price}</h4>
								<button onclick="showPopup('${product.product_code}','${product.product_name}','${product.product_description}','${product.product_category}','${product.gender}','${product.product_stock_quantity}','${product.product_price}','${product.product_photo}','${product.brand}')">View</button>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			<%}else if(gender != null || category != null || brand != null || maxPrice != 0 || minPrice != 0){ %>
				<div class="container-content">
					<sql:query dataSource="${conn}" var="result">
						<%=queryBuild.toString() %>
					</sql:query>
				
					<c:choose>
						<c:when test="${empty result.rows}">
							<p>Sorry, no match found.</p>
						</c:when>
						<c:otherwise>
							<c:forEach var="product" items="${result.rows}" varStatus="status">
								<!-- start a new row every 4th iteration -->
								<div class="product-box">
								   <img src="http://localhost:8080/images/Products/${product.product_photo}">
								<h4>${product.product_name}</h4>
								<h4>Price:NPR ${product.product_price}</h4>
								<button onclick="showPopup('${product.product_code}','${product.product_name}','${product.product_description}','${product.product_category}','${product.gender}','${product.product_stock_quantity}','${product.product_price}','${product.product_photo}','${product.brand}')">View</button>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			<%} %>
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

  <script src="<%= request.getContextPath() %>/script/script.js"></script>
  </body>
  </html>