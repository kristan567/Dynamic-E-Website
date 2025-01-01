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
import model.Cart;
import resources.MyConstants;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//connection
		DbConnection conn = new DbConnection();
		HttpSession session = request.getSession(false);
		
		//logged in uer
		String email = (String)session.getAttribute("user");
		if(!(email == null)) {
			//product quantity and ID
			String quantityString = request.getParameter("product_quantity");
			int quantity = Integer.valueOf(quantityString);
			String productCodeString = request.getParameter("product_code");
			int productCode = Integer.valueOf(productCodeString);
			//query run
			ResultSet productResult = conn.selectUsingId(MyConstants.GET_PRODUCTS_INFO_USING_PRODUCT_ID, productCode);
			try {
				if(productResult.next()) {
					//rows
					int dbquantity = productResult.getInt("product_stock_quantity");
					if(quantity <= dbquantity) {
						//if quantity ,=DbQuantity
						ResultSet userResult = conn.selectUserUsingEmail(MyConstants.IS_REGISTERED_QUERY, email);
						if(userResult.next()) {
							
							//cart details from form
							int cusId = userResult.getInt("cus_code");
							int proId = productResult.getInt("product_code");
							int procost = productResult.getInt("product_price");
							int totalCost = procost * quantity;
							
							
							//cartModel
							Cart cartModel = new Cart(cusId, proId, quantity, totalCost);
							
							//cartModel.run query
							int insertResult = conn.addToCart(MyConstants.ADD_NEW_CART, cartModel);
							System.out.println(insertResult);
							if(insertResult >0) {
								//product quantity edit
								int updateProductResult = conn.updateProducts(MyConstants.SUBTRACT_PRODUCT_STOCK_QUERY, quantity, productCode);
								if(updateProductResult > 0) {
									//success
									System.out.println("Cart inserted");
									response.sendRedirect("pages/cart.jsp");
								}else {
									//failure
									request.setAttribute("errorMessage", "Oops! Something Went Wrong");
									RequestDispatcher inc = request.getRequestDispatcher("pages/shop.jsp");
									inc.include(request, response);
								}

							}else {
								//failure
								request.setAttribute("errorMessage", "Item Already added to cart");
								RequestDispatcher inc = request.getRequestDispatcher("pages/shop.jsp");
								inc.include(request, response);
							}
						}
					}else {
						//failure
						System.out.println("quantity not available");
						request.setAttribute("errorMessage", "Oops! Quantity Not Avaliable");
						RequestDispatcher inc = request.getRequestDispatcher("/pages/shop.jsp");
						inc.include(request, response);
					}
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
			//if no session
			System.out.println("No session");
			request.setAttribute("errorMessage", "Please Log-In to Continue");
			RequestDispatcher inc = request.getRequestDispatcher("/pages/shop.jsp");
			inc.include(request, response);
		}
		doGet(request, response);
	}
}
