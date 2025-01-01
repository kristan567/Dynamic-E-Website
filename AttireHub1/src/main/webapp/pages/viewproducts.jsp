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
    <title>ADMIN - ViewProduct</title>
    <!-- <link rel="stylesheet" href="style.css"> -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/styles.css">
    <style type="text/css">
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
        
        /*CSS for view products*/
.contant h3{
    text-align: center;
    font-size: 20px;
    margin: 0;
    padding: 10px;
    margin-bottom: 10px;
}
.contant a{
    text-decoration: none;
}
.gallery{
	display: grid;
  	grid-template-columns: repeat(4, 1fr);
    justify-content: center;
    align-items: center;
    height:90vh;
    box-sizing: border-box;
    overflow: scroll;
     ;
}
.contant{
    width:  85%;
    height: 60vh;
    margin: 10px;
    box-sizing: border-box;
    float: left;
    text-align: center;
    border-radius: 20px;
    cursor: pointer;
    padding-top: 10px;
    box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25),
    0 10px 10px rgba(0, 0, 0,0.22);
    transition: .4s;
    background: #f2f2f2;
}

.contant:hover{
    box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16),
    0 3px 6px rgba(0, 0, 0,0.23);
    transform: translate(0px, -8px);
}
.contant img{
    width:  250px;
    height: 200px;
    text-align: center;
    margin: 0 auto;
    display: block;
}
.contant p{
    text-align: center;
    color: #1a0f00;
    padding-top: 0 8px;
}
.contant h6{
    align-content: center;
    font-size: 18px;
    text-align: center;
    color: #ffa31a;
    margin: 0;
    margin-top: 7px;
}
.contant ul{
    width: 70%;
    list-style: none;
    display: flex;
    justify-content: center;
    align-items: center;
    padding-top: 0;
    /*margin-left: 1px;*/
}
.contant li{
    align-items: flex-start;
    padding-top: 5px;
    }
    </style>

  </head>
  <body>
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
    <div style=" margin-left: 300px; width: 75%; height: 90vh;">
        <div style="width: 100%; height: 100vh; float: left; margin-left: 4%; margin-top: 20px;" class="gallery">
        <sql:query var="products" dataSource="${conn}">
        	SELECT * FROM products;
        </sql:query>
        <c:forEach var="product" items="${products.rows}">
            <div class="contant">
                <img src="http://localhost:8080/images/Products/${product.product_photo}"><br>
                <h3>${product.product_name}</h3>
                <p>${product.product_description}</p>
                <h6>Nrs.${product.product_price}</h6>
            </div>      
        </c:forEach>
		</div>
    </div>
    

    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="<%=request.getContextPath()%>/script/script.js"></script>


    
  </body>
  </html>