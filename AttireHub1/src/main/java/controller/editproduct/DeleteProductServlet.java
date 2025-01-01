package controller.editproduct;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.dbconnection.DbConnection;
import resources.MyConstants;

/**
 * Servlet implementation class DeleteProductServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/DeleteProductServlet" })
public class DeleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteProductServlet() {
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
		//id of product
		String ID = request.getParameter("code");
		
		int id = Integer.parseInt(ID);
		
		//removing cart containing the product
		int resultCart = conn.deleteProduct(MyConstants.DELETE_CART_USING_PRODUCT_ID, id);

		//removing order containing the product
		int resultOrderLine = conn.deleteProduct(MyConstants.DELETE_ORDER_LINE_QUERY, id);

		//removing product
		int resultProduct = conn.deleteProduct(MyConstants.DELETE_PRODUCT_USING_PRODUCT_ID, id);
		if (resultProduct > 0) {
	        response.sendRedirect("pages/updateproducts.jsp");
	    } else {
	    	request.setAttribute("errorMessage", "Oops!! something went wrong!");
	        RequestDispatcher inc = request.getRequestDispatcher("./admin.jsp");
	        inc.include(request, response);
	        
	        
	    }

		
	}

}
