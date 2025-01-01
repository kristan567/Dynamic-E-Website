package controller.servlet.editcustomer;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import controller.dbconnection.DbConnection;
import model.PasswordEncryptionWithAes;
import resources.MyConstants;

/**
 * Servlet implementation class EditCustomerServlet
 */
@WebServlet(asyncSupported = true, urlPatterns= "/EditCustomerServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,
	maxFileSize = 1024*1024*10,//10MB
	maxRequestSize = 1024*1024*50)//50MB
public class EditCustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditCustomerServlet() {
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
		
		//inputs from input fields
		String cusCodeString  = request.getParameter("edit-code");
		int cusCode = Integer.parseInt(cusCodeString);
		String name = request.getParameter("edit-name");
		String dob = request.getParameter("edit-dob");
		String gender = request.getParameter("edit-gender"); 
		String email = request.getParameter("edit-register-email");
		String phone = request.getParameter("edit-register-phone");
		
		String password = request.getParameter("edit-registered-password");
		String cPassword = request.getParameter("edit-confirm-password");
		
		//image storing in Part
		Part image = request.getPart("edit-image");
		String imageName = "";
		String encPassword = "";
		

		

		//saving image in tomcat server
		if(image != null) {
			imageName = image.getSubmittedFileName();
			String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
			System.out.println(savePath + imageName);
			if(!imageName.isEmpty() && imageName != null) {
				image.write(savePath + imageName);
			}
		}

		
		boolean passwordValidate = true;
		
		//validating password (pword == cpword)
		if(password != null && !password.isEmpty() && cPassword != null && !cPassword.isEmpty()  && !password.equals(cPassword)) {
			passwordValidate = false;
			}
		else if (password != null && !password.isEmpty() && cPassword != null && !cPassword.isEmpty()  && password.equals(cPassword) ) {
			encPassword = PasswordEncryptionWithAes.encrypt(email, password);
			System.out.println("Encrypted Password: " +encPassword);
		}
		
		
		//if validated
		if(passwordValidate) {
			
			//connection
			DbConnection conn = new DbConnection();
			
			//query generation
			String query = conn.generateUpdateCustomerQuery(cusCode, name, dob, gender, phone, encPassword, imageName);
			int updateResult = conn.updateUser(query);
			
			if (updateResult < 0) {
				//failure
				request.setAttribute("errorMessage", "Oops, You profile edit was unsuccessful");
				RequestDispatcher inc = request.getRequestDispatcher("pages/profile.jsp");
				inc.include(request, response);
			}else {
				//success
				request.setAttribute("successMessage", "Your Details Has Been Updated");
				RequestDispatcher inc = request.getRequestDispatcher("pages/profile.jsp");
				inc.include(request, response);
			}
		}else {
			//password invalidation
			request.setAttribute("errorMessage", "Password and Confirm Password Mismatch.");
			RequestDispatcher inc = request.getRequestDispatcher("pages/profile.jsp");
			inc.include(request, response);
		}
		
		doGet(request, response);
	}

}
