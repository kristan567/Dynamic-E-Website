package controller.servlets.addtocart;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.dbconnection.DbConnection;
import resources.MyConstants;

/**
 * Servlet implementation class EditCartServlet
 */
@WebServlet("/EditCartServlet")
public class EditCartServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

/**
* @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
*/
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
// TODO Auto-generated method stub
response.getWriter().append("Served at: ").append(request.getContextPath());
}

/**
* @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
*/
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
// TODO Auto-generated method stub
	
	//connection
	DbConnection conn = new DbConnection();
	
	String productCodeString = request.getParameter("product-code");
	String  newProductQuantityString = request.getParameter("product-quantity");
	String productPriceString = request.getParameter("product-price");
	String[] remove = request.getParameterValues("remove[]");
	
	
	//typecasting
	int productCode = Integer.valueOf(productCodeString);
	int newProductQuantity = Integer.valueOf(newProductQuantityString);
	int productPrice = Integer.valueOf(productPriceString);
	int dbProductQuantity = 0;
	int cusCode = 0;
	
	//user email
	HttpSession session = request.getSession(false);
	String email = (String) session.getAttribute("user");
	
	//user details
	if(!email.isEmpty() && email != null) {
	ResultSet cusResult = conn.selectUserUsingEmail(MyConstants.IS_REGISTERED_QUERY, email);
	try {
		
	if(cusResult.next()) {
	cusCode = cusResult.getInt("cus_code");
	}
	} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
	}
	
	//db last id
	int prevQuantity = conn.getProductQuantityFromCart(MyConstants.GET_CART_DETAILS_USING_USER_ID_AND_PRODUCT_ID, cusCode, productCode);
	if(remove!=null || newProductQuantity <= 0) {
		int removeResult = conn.deleteCart(MyConstants.REMOVE_CART, cusCode, productCode);
		
		//products update 
		int addProductResult = conn.updateProducts(MyConstants.ADD_PRODUCT_STOCK_QUERY, prevQuantity, productCode);
		System.out.println("prevQuantity:" + prevQuantity );
		System.out.println(removeResult);
		System.out.println(addProductResult);
		if(removeResult>0 &&  addProductResult>0) {
			response.sendRedirect("./pages/cart.jsp");
		}else {
			request.setAttribute("errorMessage", "Operation Unseccessful");
			RequestDispatcher inc = request.getRequestDispatcher("./pages/cart.jsp");
			inc.include(request, response);
		}	
	}else {
		//select usign ID
		ResultSet productResult = conn.selectUsingId(MyConstants.GET_PRODUCTS_INFO_USING_PRODUCT_ID, productCode);
	try {
		
		//access stock quanitity
	if(productResult.next()) {
	dbProductQuantity = productResult.getInt("product_stock_quantity");
	}
	} catch (SQLException e1) {
	// TODO Auto-generated catch block
	e1.printStackTrace();
	}
	
	//validate stock
	if(dbProductQuantity >= newProductQuantity) {
	System.out.println("prevQuanitty: "+prevQuantity);
	System.out.println("new quantity: "+newProductQuantity);
	if(prevQuantity>newProductQuantity) {
	int quanitityDeducted = prevQuantity - newProductQuantity;
	
	//add in stock
	int addProductResult = conn.updateProducts(MyConstants.ADD_PRODUCT_STOCK_QUERY, quanitityDeducted, productCode);
	
	
	}else if(prevQuantity<newProductQuantity) {
	int quanitityAdded = newProductQuantity - prevQuantity;
	//reduce from stock
	int reduceProductResult = conn.updateProducts(MyConstants.SUBTRACT_PRODUCT_STOCK_QUERY, quanitityAdded, productCode);
	}
	
	//changing in cart table
	int totalPrice = newProductQuantity * productPrice;
	int result = conn.updateCart(MyConstants.EDIT_CART_QUERY, newProductQuantity, totalPrice, cusCode, productCode);
	if(result>0) {
	response.sendRedirect("pages/cart.jsp");
	}else {
	request.setAttribute("errorMessage", "Operation Unseccessful");
	RequestDispatcher inc = request.getRequestDispatcher("./pages/cart.jsp");
	inc.include(request, response);
	}
	}else {
		//invalid quantity
	request.setAttribute("errorMessage", "Oops! Quantity Not Avaliable");
	RequestDispatcher inc = request.getRequestDispatcher("./pages/cart.jsp");
	inc.include(request, response);
	}
	}
	
	}else {
	response.sendRedirect("index.jsp");
	}
	
	doGet(request, response);
	}


}
