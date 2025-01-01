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


 .vieworder{

                                         margin: 0px 0px 0px 305px;

                                         height: 660px;

                                         width: 1230px;

                                         background-color: darkgrey ;

                                         overflow: scroll;

                                        

                           }

                                        

                           table {

                           width: 100%;

                           border-collapse: collapse;

                           margin-top: 20px;

                           width: 100%;

                           height:100%;

                           }

 

                           th, td {

                           padding: 8px;

                           text-align: left;

                           border-bottom: 1px solid #ddd;

 

                           }

 

                           th {

                           background-color: #f2f2f2;

                           }

 

                           tr:hover {

                           background-color: grey;

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
    <div class="vieworder" >

              <table>
	               <tr>
		               <th>Order ID</th>
		               <th>Order Date</th>
		               <th>Product Name</th>
		               <th>Brand</th>
		               <th>Total cost</th>
		               <th>Customer Name</th>
	              </tr>
	              <sql:query var="orders" dataSource="${conn}">
						SELECT orders.order_id, customers.cus_name,dates.date, products.product_name, products.brand, order_line.product_total_cost 
						FROM customers JOIN orders ON customers.cus_code = orders.order_customer 
						JOIN dates ON orders.order_date = dates.date_code  JOIN order_line ON orders.order_id = order_line.order_id
						JOIN products ON products.product_code = order_line.product_id ;
	              </sql:query>
	              
	              <c:forEach var="order" items="${orders.rows}">
		              <tr>
			               <td>${order.order_id}</td>
			               <td>${order.date}</td>
			               <td>${order.product_name}</td>
			               <td>${order.brand}</td>
			               <td>${order.product_total_cost}</td>
			               <td>${order.cus_name}</td>
		              </tr>       
	              </c:forEach>
              </table>
     </div>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="<%=request.getContextPath()%>/script/script.js"></script>
  </body>
  </html>