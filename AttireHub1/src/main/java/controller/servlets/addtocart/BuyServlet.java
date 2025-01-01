package controller.servlets.addtocart;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.dbconnection.DbConnection;
import model.Customers;
import model.Dates;
import model.OrderLine;
import model.Orders;
import resources.MyConstants;

/**
 * Servlet implementation class BuyServlet
 */
@WebServlet("/BuyServlet")
public class BuyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BuyServlet() {
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
		DbConnection conn = new DbConnection();
		
		//inserting into dates table
		ResultSet dateResult = conn.selectAllQuery(MyConstants.GET_DATES);
		
		HttpSession session = request.getSession(false);
		String email = (String)session.getAttribute("user");
		int prevDateCode = 0;
		try {
			if(dateResult != null && dateResult.next()) {
				prevDateCode = dateResult.getInt("date_code");
				while(dateResult.next()) {
					prevDateCode = dateResult.getInt("date_code");
				}
			}else {
				prevDateCode = 0;
			}
			int dateCode = prevDateCode + 1;
			System.out.println("Date Code:"+ dateCode);
			Dates dateModel = new Dates(dateCode);
			int InsertDateResultesult = conn.addDate(MyConstants.ADD_NEW_DATE, dateModel);
			System.out.println("Date inserted: "+InsertDateResultesult);
			if(InsertDateResultesult > 0) {
				//inserting into orders table
				System.out.println("Value inserted in date");
				ResultSet orderResult = conn.selectAllQuery(MyConstants.GET_ORDERS);
				int prevOrderId = 0;
			
				if(orderResult != null && orderResult.next()) {
					prevOrderId = orderResult.getInt("order_id");
					while(orderResult.next()) {
						prevOrderId = orderResult.getInt("order_id");
					}
				}else {
					prevOrderId = 0;
				}
				int orderId = prevOrderId + 1;
				System.out.println("OrderID:"+ orderId);
				
				//for customer_ID
				ResultSet cusResult = conn.selectUserUsingEmail(MyConstants.IS_REGISTERED_QUERY, email);
				int cusID = 0;
				if(cusResult != null && cusResult.next()) {
					cusID = cusResult.getInt("cus_code");
				}
				System.out.println("CustomerID:"+ cusID);
				//for total bill
				int totalbBill = conn.getTotalBill(MyConstants.GET_TOTAL_BILL , email);
				System.out.println("Total Bill:"+ totalbBill);
				//INSERTING INTO ORDERS
				Orders orderModel = new Orders( orderId, dateCode, cusID, totalbBill);
				int insertOrderResult =  conn.addOrder(MyConstants.ADD_NEW_ORDER, orderModel);
				System.out.println("Order insert:"+ insertOrderResult);
				if(insertOrderResult < 0) {
					//error
					request.setAttribute("errorMessage", "Oops! An Error Occured While Purchasing");
					RequestDispatcher inc = request.getRequestDispatcher("pages/cart.jsp");
					inc.include(request, response);
				}else {
					//order_line operations
					//Extract all products in cart
					ResultSet cartResult = conn.getCartInfoByCusID(MyConstants.GET_CART_DETAILS_USING_USER_ID, cusID);
					int insertOrderLineResult = 0;
					while(cartResult.next()) {
						int productId = cartResult.getInt("product_id");
						int productQuantitiy = cartResult.getInt("product_quantity");
						int productTotalCost = cartResult.getInt("product_total_cost");
						
						OrderLine orderLineModel = new OrderLine(orderId, productId, productQuantitiy, productTotalCost);
						insertOrderLineResult = conn.addOrderLine(MyConstants.ADD_NEW_ORDER_LINE, orderLineModel);
						if(insertOrderLineResult < 0) {
							//error
							request.setAttribute("errorMessage", "Oops! An Error Occured While Purchasing");
							RequestDispatcher inc = request.getRequestDispatcher("pages/cart.jsp");
							inc.include(request, response);
							break;
						}
					}
					if(insertOrderLineResult > 0) {
						//remove from cart after buy
						int deleteCartResult = conn.deleteCart(MyConstants.DELETE_CART_USING_USER_ID, cusID);
						if(deleteCartResult < 0) {
							request.setAttribute("errorMessage", "Oops! An Error Occured While Purchasing");
							RequestDispatcher inc = request.getRequestDispatcher("pages/cart.jsp");
							inc.include(request, response);
						}else {
							//success code
							request.setAttribute("successMessage", "Purchase Successful.");
							RequestDispatcher inc = request.getRequestDispatcher("pages/cart.jsp");
							inc.include(request, response);
						}
					}
					
					
					
				}
			}else {
				//failure
				request.setAttribute("errorMessage", "Oops! An Error Occured While Purchasing");
				RequestDispatcher inc = request.getRequestDispatcher("pages/cart.jsp");
				inc.include(request, response);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			
			//exception
	    	request.setAttribute("errorMessage", "Oops!! something went wrong!");
	        RequestDispatcher inc = request.getRequestDispatcher("./index.jsp");
	        inc.include(request, response);
			e.printStackTrace();
		}
		
		
		
		 
		doGet(request, response);
	}

}
