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
 * Servlet implementation class EditProductServlet
 */
@WebServlet("/EditProductServlet")
public class EditProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProductServlet() {
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
		//inputs field inputs
		String code = request.getParameter("code");
		String name = request.getParameter("name");
		String price = request.getParameter("price");
		String description = request.getParameter("description");
		String stock  = request.getParameter("stock");
		String category = request.getParameter("category");
		String brand = request.getParameter("brand");
		String gender = request.getParameter("gender");
		
		//connection
		DbConnection conn = new DbConnection();

		//Query execution
		int result = conn.editProduct(MyConstants.EDIT_PRODUCT_QUERY, name, Integer.valueOf(price), description, Integer.valueOf(stock), category, brand, gender, Integer.valueOf(code));
		if(result>0) {
			//success
			response.sendRedirect("./pages/updateproducts.jsp");
		}else {
			
			//failure
	    	request.setAttribute("errorMessage", "Oops!! something went wrong!");
	        RequestDispatcher inc = request.getRequestDispatcher("./admin.jsp");
	        inc.include(request, response);
		}
		
		doGet(request, response);
	}

}
