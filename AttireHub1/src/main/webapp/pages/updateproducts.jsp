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
    <title>ADMIN - UpdateProducts</title>
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



    
.products h3{
    text-align: center;
    font-size: 20px;
    margin: 0;
    padding: 10px;
    margin-bottom: 10px;
}
.products a{
    text-decoration: none;
}

.searchbar input[type = "text"]{

        width: 70%;
        height: 4vh;
        border-radius: 10px;
        padding: 1px 25px;
        background-color: #ada8a8;
        color: black;

}
.gallery{
	display: grid;
  	grid-template-columns: repeat(4, 1fr);
    justify-content: center;
    align-items: center;
    height:90vh;
    overflow: scroll;
}
.products{
    width:  90%;
    margin: 15px;
    height: 71vh;
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

.products:hover{
    box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16),
    0 3px 6px rgba(0, 0, 0,0.23);
    transform: translate(0px, -8px);
}
.products img{
    width:  250px;
    height: 200px;
    text-align: center;
    margin: 0 auto;
    display: block;
}
.products p{
    text-align: center;
    color: #1a0f00;
    padding-top: 0 8px;
}
.products h6{
    align-content: center;
    font-size: 18px;
    text-align: center;
    color: #ffa31a;
    margin: 0;
    margin-top: 7px;
}
.products ul{
    width: 70%;
    list-style: none;
    display: flex;
    justify-content: center;
    align-items: center;
    padding-top: 0;
    /*margin-left: 1px;*/
}
.products li{
    align-items: flex-start;
    padding-top: 5px;
}

.products button{
    text-align: center;
    font-size: 20px;
    color: #fff;
    width: 121px;
    height: 6vh;
    border-color: #330033;
    outline: none;
    cursor: pointer;
    margin-top: 5px;
    border-bottom-right-radius: 30px;
    border-bottom-left-radius: 30px;
    border-top-left-radius: 30px;
    border-top-right-radius: 30px;
}
.edit .delete{
    background: #2183a2;
    width: 100%;
    height: 7.2vh;
}
        

 .popup-edit-main{
        background-color: white;
        transform: scaleX(1);
        padding: 20px 40px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.3);
        text-align: center;
        position: absolute;
        transform: translate(60%,1%);
        max-width: 700px;
        width: 80%;
        transition: 1s;
        color: black;
        border: 1px dashed black;
        top: -100%;
        bottom: 200%;
    }

    .popup-edit-show{
        z-index: 1;
        top:0%;
        bottom: 1.5%;
        position: fixed;
    }   
    
        .product-edit-overlay{
        background-color: rgba(0,0,0,0.5);
        width: 100%;
        height: 100vh;
        position: fixed;
        top: 0; 
        opacity: 0;
        z-index: -1;
        transition: 0.5s;
        left:0;
    }

    .show-product-edit-overlay{
        opacity: 1;
	    z-index: 1;
    }    
    
    
    
    
            .product-containter{
            width:  100%;
            height: 20vh;
            margin: 15px;
            box-sizing: border-box;
            text-align: center;
            border-radius: 20px;
            /*cursor: pointer;*/
            padding-top: 0px;
            /*box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25),
            0 10px 10px rgba(0, 0, 0,0.22);*/
            transition: .4s;
            /*background: #f2f2f2;*/
            background: #fff;
        }
        .product-containter img{
            width:  200px;
            height: 150px;
            text-align: center;
            margin: 0 auto;
            display: block;
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
	display: block;
}
.main form .product-details .input-box{
    margin: 12px 0 6px 0;
}
.product-details .input-box .details{
    margin-bottom: -10px;
    display: flex;
    font-weight: bold;
    
}
.product-details .input-box input{
    height: 25px;
    width: 100%;
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
    width: 90%;
    outline: none;
    margin-top: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding-left: 15px;
}

form .gender-details{
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
	margin-right: 10px;
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

<div class="sidebar" style="border: 1px solid black; width: 20%; height: 100vh; float: left;">
        <header>Dashboard</header>
        <ul>
            <li><a href="<%= request.getContextPath() %>/admin.jsp">Add Products</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/viewproducts.jsp">View Products</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/updateproducts.jsp">Update Products</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/vieworder.jsp">View Order</a></li>
        </ul>

    </div>
     <center>
        <div class="searchbar" style="margin-left: 140px; width: 650px; ">
            <form action="<%= request.getContextPath() %>/pages/updateproducts.jsp" method="get">
                <input type="text" name="Search" placeholder="Search here...">
                <input type="submit" name="Go" value="Search" id="search">
            </form>
        </div>
    </center>
    <div style="border: 1px solid black; margin-left: 300px; width: 79%; height: 90vh;" class="gallery">
       <%
       	String search = request.getParameter("Search");
       
       if(search != null && !search.isEmpty()){
       %>
       	    <sql:query var="products" dataSource="${conn}">
	        	SELECT * FROM products WHERE product_name LIKE "%<%=search%>%";
	        </sql:query>
			<c:forEach var="product" items="${products.rows}">
	            <div class="products">
	                <img src="http://localhost:8080/images/Products/${product.product_photo}"><br>
	                <h3>${product.product_name}</h3>
					<h6>${product.brand} : ${product.product_category}</h6>
	                <p>${product.product_description}</p>
	                <h6>$ ${product.product_price}</h6>
	                <button class="edit" onclick="showEditPopup(${product.product_code}, '${product.product_name}','${product.product_description}','${product.product_category}','${product.product_gender}','${product.product_stock_quantity}', '${product.product_price}', '${product.product_photo}','${product.brand}')">Edit</button>
	                <form action='<%= request.getContextPath() %>/DeleteProductServlet' method="post">
	                	<input type="text" name = "code" value="${product.product_code}" style="display:none;">
	                	<button type = "submit" class="delete">Delete</button>
	                </form>
	            </div>
			</c:forEach>
       <%}else{%>
	        <sql:query var="products" dataSource="${conn}">
	        	<%=MyConstants.GET_PRODUCTS_INFO %>
	        </sql:query>
			<c:forEach var="product" items="${products.rows}">
	            <div class="products">
	                <img src="http://localhost:8080/images/Products/${product.product_photo}"><br>
	                <h3>${product.product_name}</h3>
	               	<h6>${product.brand} : ${product.product_category}</h6>
	                <p>${product.product_description}</p>
	                <h6>NRs. ${product.product_price}</h6>
	                
	                <button class="edit" onclick="showEditPopup(${product.product_code}, '${product.product_name}','${product.product_description}','${product.product_category}','${product.product_gender}','${product.product_stock_quantity}', '${product.product_price}', '${product.product_photo}','${product.brand}')">Edit</button>
	                <form action='<%= request.getContextPath() %>/DeleteProductServlet' method="post">
	                	<input type="text" name = "code" value="${product.product_code}" style="display:none;">
	                	<button type = "submit" class="delete">Delete</button>
	                </form>
	            </div>
			</c:forEach>
			<%} %>
    </div>
    
   <div class="product-edit-overlay" onclick="removeEditOverlay()"></div>
   <div class = "popup-edit-main" id="popup-edit-main" >
   <div class = "popup-edit" id= "popup-edit-main">
   <h3>Edit Product</h3>
   </div>
     <form action='<%= request.getContextPath() %>/EditProductServlet' method = 'post' id="popup-edit-form">
     

   </form>
   </div>

    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="<%=request.getContextPath()%>/script/script.js"></script>
    
    <script>
    
    	function showEditPopup(code, name, description, category, gender, stock, price, photo, brand){		
			var editForm = document.getElementById("popup-edit-form")	
			
			editForm.innerHTML = "<div class='product-details'><div class='product-containter'><img src=' http://localhost:8080/images/Products/"+photo+"'><br><br></div><br><div class='input-flex'><div class='input-box'><span class='details'>Product Name</span><br><input type='text' name = 'name' placeholder='Product Name' value='"+name+"' required><input type='text' name = 'code' placeholder='Product Name' value='"+code+"' required style='display: none;'></div><div class='input-box'><span class='details'>Product Price</span><br><input type='number' name = 'price' placeholder='Product Price' value='"+price+"' required></div></div><div class='input-flex'><div class='input-box'><span class='details'>Product Description</span><br><input type='text' name = 'description' placeholder='Product Description' value='"+description+"' required></div></div><div class='input-flex'><div class='input-box'><span class='details'>Product Stock</span><br><input type='number' placeholder='Product Stock' name = 'stock' value='"+stock+"' required></div><div class='input-box'><span class='details'>Product Category</span><br><input type='text' placeholder='Product Category' value='"+category+"' name = 'category' required></div></div><div class='input-flex'><div class='input-box'><span class='details'>Product Brand</span><br><input type='text' placeholder='Product Brand' name = 'brand' value='"+brand+"' required></div></div><div class='gender-details'><label for='dot-1'><span class='dot one'></span><span class='gender'>Male</span></label><input type='radio' name='gender' id='dot-1' required checked><label for='dot-2'><span class='dot two'></span><span class='gender'>Female</span></label><input type='radio' name='gender' id='dot-2'><label for='dot-3'><span class='dot three'></span><span class='gender'>Other</span></label><input type='radio' name='gender' id='dot-3'><span class='gender-title'><br><h3>Gender</h3></span><div class='category'></div><div class='button'><input type='submit' value='Edit'></div></div></div></div></div>";
			document.querySelector(".popup-edit-main").classList.add("popup-edit-show");
			document.querySelector(".product-edit-overlay").classList.add("show-product-edit-overlay");
			console.log("click");
    		
    	}
    	
    	function removeEditOverlay(){
   		   document.querySelector(".popup-edit-main").classList.remove("popup-edit-show");
  		   document.querySelector(".product-edit-overlay").classList.remove("show-product-edit-overlay");
  		   console.log("click");
    		
    	}
    
    </script>
    
    
  </body>
  </html>