<%@page import="resources.MyConstants"%>
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
    <title>ADMIN - ViewOrders</title>
    <!-- <link rel="stylesheet" href="style.css"> -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/styles.css">
    <style type="text/css">
    body{
    	overflow: hidden;
    }
        button /*changing the size of the button tag*/
        {
            background-color: #008CBA;
            width: 140px;
            height: 50px;
            border: 2px solid;

            padding: 5px;
        }

        .but /*used for styling the button*/
        {
            background-color: #008CBA;
            border-radius: 20px;
            margin-top: 10px;
            margin-bottom: 10px;
        }

        button:hover /*changing color of the button when hovering your mouse over it*/
        {
            background-color: #ffb13d;
            transition: 0.3s;
        }

		*{
		    margin: 0;
		    padding: 0;
		    list-style: none;
		    text-decoration: none;
		}

.sidebar{
    position: fixed;
    left: 0;
    background: #042331;
}
.sidebar header{
    font-size: 22px;
    color: white;
    text-align: center;
    line-height: 70px;
    background: #063146;
    user-select: none;
}
.sidebar ul a{
    display: block;
    height: 100%;
    width: 100%;
    line-height: 65px;
    font-size: 20px;
    color: white;
    padding-left: 40px;
    box-sizing: border-box;
    border-top: 1px solid rgba(255, 255, 255, .1);
    border-bottom: 1px solid black;
}
ul li:hover a{
    padding-left: 50px;
}
.sidebar ul{
    margin-right: 16px;
}


 .main{
    background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 0%, rgba(0,212,255,1) 100%);
}
.main .contain{
   /* display: flex;*/
    justify-content: center;
    align-items: center;
    padding: 25px 30px;
    margin-left: 300px;
    margin-top: 8px;
    background: #fff;
}
.main .contain .title{
    font-size: 25px;
    font-weight: 500;
    position: relative;
}
.main .contain .title::before{
    content: '';
    position: absolute;
    left: 0;
    bottom: 0;
    height: 3px;
    width: 30px;
    background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 0%, rgba(0,212,255,1) 100%);;
}
.main .contain form .product-details{
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}
.main form .product-details .input-box{
    margin: 12px 0 6px 0;
}
.product-details .input-box .details{
    margin-bottom: -10px;
    display: flex;
    font-weight: 500;
    margin-bottom: 2px: ;
}
.product-details .input-box input{
    height: 25px;
    width: 110%;
    outline: none;
    border-radius: 5px;
    border: 1px solid #ccc;
    padding-left: 15px;
    margin-bottom: 6px;
    font-size: 14px;
    transition: all 0.3s ease;
}
.product-details .button{
    margin-top: 20px;
}
.photo-box{
    margin-top: 22px;
}
.photo-box input{
    height: 25px;
    width: 80%;
    outline: none;
    margin-top: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding-left: 15px;
}

form .gender-details{
    margin-top: -14px;
}
form .gender-details .gender-title{
    font-size: 17px;
    font-weight: 500;
}
form .gender-details .category{
    display: flex;
    width: 80%;
    margin: 10px 0;
    justify-content: space-between;
}
.gender-details .category label{
    display: flex;
    align-items: center;
    margin-right: 25px;
}
.gender-details .category .dot{
    height: 18px;
    width: 18px;
    background: #d9d9d9;

    border-radius: 50%;
    margin-right: 10px;
    border: 5px solid transparent;
}
#dot-1:checked ~ .category label .one,
#dot-2:checked ~ .category label .two,
#dot-3:checked ~ .category label .three{
    border-color: #d9d9d9;
    background: #9b59b6;

}
form input[type="radio"]{
    display: none;
}
form .button{
    height: 45px;
    margin: 45px 0;
}
form .button input{
    height: 100%;
    width: 50%;
    outline: none;
    color: #fff;
    border: none;
    font-size: 18px;
    border-radius: 5px;
    letter-spacing: 1px;
}

.main-container{
    width: 100%;

}
.main-container .searchbar{
    margin-left: 20px;
    width: 90%;
    margin-top: 10px;
}
.main-container .searchbar input[type = "text"]{
    width: 70%;
    height: 4vh;
    border-radius: 10px;
    padding: 1px 25px;
    background-color: #ada8a8;
    color: black;
}

select{
    width: 70%;
    height: 4vh;
    border-radius: 10px;
    color: black;
}
    </style>

  </head>
  <body>
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
    <header>
        <nav>
            <div class="nav-logo">
                <img src="<%=request.getContextPath()%>/images/logo-1.png" alt="">
                <span><b>AttireHub</b></span>
            </div>
            <div class="tabs">
                <div class="buttons">
                <!-- Display user's information if there's an active session -->
                    <div class="user-info"> 
                    <%
                    	String Email = (String)session.getAttribute("user");
                    %>                  
                    <sql:query var="admins" dataSource="${conn}">
                    	SELECT * FROM admins WHERE admin_email = "<%=Email%>";
                    </sql:query>
                    <c:forEach var="admin" items="${admins.rows}">
		                    <div class = "user-Image">
		                    	<img src = "http://localhost:8080/images/Admins/${admin.admin_photo}">
		                    </div>
		                    <div class="user-details">
		                    	<span>Welcome, <c:out value="${admin.admin_name}"></c:out></span><br>
		                    	<div class = "profile-buttons">
			                    	<form action="<%= request.getContextPath() %>/LogoutServlet" method="post">
			                        	<button type="submit">Logout</button>
			                    	</form>
		                    	</div>
		                    
		                    </div>
                    </c:forEach>
                    </div>
                </div>   
            </div>
        </nav>
    </header>

    <div class="sidebar" style="border: 1px solid black; width: 20%; height: 90vh; float: left;">

        <header>Dashboard</header>

        <ul>
            <li><a href="<%= request.getContextPath() %>/admin.jsp">Add Products</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/viewproducts.jsp">View Products</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/updateproducts.jsp">Update Products</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/vieworder.jsp">View Order</a></li>
        </ul>
    </div>
    <div class="main" style="border: 1px solid black; margin-left: 300px; width: 100%; height: 100vh;">
    <div style="width: 60%; height: 20vh; float: left;margin-left: 2% ;margin-top: 20px;">
        <div class="contain" style="border: 1px solid black; width: 500px; height: 80vh">
            <div class="title">Add Products</div>
            <form action="<%=request.getContextPath()%>/ProductInsertServlet" method="post" enctype = "multipart/form-data">
                <div class="product-details">
                    <div class="input-box">
                        <span class="details">Upload Photo</span><br>
                        <input type="file" name="image" id="image" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Product Name</span><br>
                        <input type="text" name="name" placeholder="Product Name" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Product Price</span><br>
                        <input type="number" name="price" placeholder="Product Price" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Product Category</span><br>
                        <input type="text" name="category" placeholder="Product Category" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Product Brand</span><br>
                        <input type="text" name="brand" placeholder="Product Brand" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Product Description</span><br>
                        <input type="text" name="description" placeholder="Product Description" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Product Stock</span><br>
                        <input type="text" name="stock" placeholder="Product Stock" required>
                    </div>
                    <div class="input-box">
                        <span class="details">Hot Deals</span><br>
                        <select name = "deals">
                        	<option value="no">No</option>
                        	<option value="yes">Yes</option>
                        </select>
                    </div>


                    <div class="gender-details">
                        <input type="radio" name="gender" id="dot-1" value="male" checked>
                        <input type="radio" name="gender" id="dot-2" value="female" required>
                        <input type="radio" name="gender" id="dot-3" value="other" required>
                        <span class="gender-title"><br>Gender</span>
                        <div class="category">
                            <label for="dot-1">
                                <span class="dot one"></span>
                                <span class="gender">Male</span>
                            </label>
                            <label for="dot-2">
                                <span class="dot two"></span>
                                <span class="gender">Female</span>
                            </label>
                            <label for="dot-3">
                                <span class="dot three"></span>
                                <span class="gender">Other</span>
                            </label>
                        </div>
                        <div class="button">
                        <input type="submit" value="Add">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="<%=request.getContextPath()%>/script/script.js"></script>
  </body>
  </html>