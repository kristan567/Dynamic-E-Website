package controller.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import controller.dbconnection.DbConnection;
import model.Products;
import resources.MyConstants;

/**
 * Servlet implementation class ProductInsert
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/ProductInsertServlet" })
//for image inputs
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,
maxFileSize = 1024*1024*10, //10MB
maxRequestSize = 1024*1024*50) //50MB
public class ProductInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductInsert() {
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
		try {
			//image as part
			Part productImage = request.getPart("image");
			//data from input fields
			String productImageName = productImage.getSubmittedFileName();
			String productName = request.getParameter("name");
			String productPriceString = request.getParameter("price");
			int productPrice = Integer.valueOf(productPriceString);
			String ProductCategory = request.getParameter("category");
			String ProductBrand = request.getParameter("brand");
			String productDescription = request.getParameter("description");
			String productStockString = request.getParameter("stock");
			int productStock = Integer.valueOf(productStockString);
			String hotDeals = request.getParameter("deals");
			String productGender = request.getParameter("gender");
			
			//db connection
			DbConnection conn = new DbConnection();
			
			//getting previous product_code
			ResultSet productResult = conn.selectAllQuery(MyConstants.GET_PRODUCTS_INFO);
			int previousProductCode = 0;
		
			if(productResult != null && productResult.next()) {
				previousProductCode = productResult.getInt("product_code");
				while(productResult.next()) {
					previousProductCode = productResult.getInt("product_code");
				}

			}else {
				previousProductCode = 0;
			}
			int productCode = previousProductCode + 1;
			
			//saving Product image in server
			if(productImageName != null && !productImageName.isEmpty()) {
				String imageSavePath = MyConstants.PRODUCT_IMAGE_DIR_SAVE_PATH;
				productImage.write(imageSavePath + productImageName);
			}
			
			//model object creation and database insertion
			Products productModel = new Products(productCode, productName, productPrice, productDescription, productStock, ProductCategory, ProductBrand, productGender , productImageName, hotDeals);
			int result = conn.addProduct(MyConstants.ADD_NEW_PRODUCT, productModel);
			if(result >0) {
				response.sendRedirect("./pages/updateproducts.jsp");
			}else {
				//error
		    	request.setAttribute("errorMessage", "Oops!! something went wrong!");
		        RequestDispatcher inc = request.getRequestDispatcher("./admin.jsp");
		        inc.include(request, response);
			}
			
		}catch(Exception e) {
			//exception handling
	    	request.setAttribute("errorMessage", "Oops!! something went wrong!");
	        RequestDispatcher inc = request.getRequestDispatcher("./admin.jsp");
	        inc.include(request, response);
		}
		
		doGet(request, response);
	}

}
