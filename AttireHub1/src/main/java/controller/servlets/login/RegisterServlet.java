package controller.servlets.login;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
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
import model.Customers;
import resources.MyConstants;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet(asyncSupported = true, urlPatterns= "/RegisterServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,
	maxFileSize = 1024*1024*10, //10MB
	maxRequestSize = 1024*1024*50) //50MB
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
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
		
		//access database for user information
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		
		String cusName = fname + " " + lname;
		String dob = request.getParameter("dob");
		String gender = request.getParameter("gender"); 
		String email = request.getParameter("register-email");
		String phone = request.getParameter("register-phone");
		String password = request.getParameter("register-password");
		String cPassword = request.getParameter("confirm-password");
		
		//image as part
		Part image = request.getPart("image");
		String imageName = image.getSubmittedFileName();
		
		
		
		//password validation
		if(password.equals(cPassword)) {
			
			//connection
			DbConnection connection = new DbConnection();
			Boolean userExists = connection.emailExists(MyConstants.IS_REGISTERED_QUERY, email);//check is this user already exists
			System.out.println("Exists: " + userExists);
			

			if (!userExists) {
				//if exists 
				
				//generate new cus_code
				ResultSet cusResult = connection.selectAllQuery(MyConstants.GET_USERS_INFO); 
				int prevCusCode = 0;
				try {
					if(cusResult != null && cusResult.next()) {
						prevCusCode = cusResult.getInt("cus_code");
						while(cusResult.next()) {
							prevCusCode = cusResult.getInt("cus_code");
						}
		
					}else {
						prevCusCode = 0;
					}
					int cusCode = prevCusCode + 1;
					System.out.println("Customer Code:"+ cusCode);
					
					//customer model
					Customers customerModel = new Customers(cusCode, cusName, phone, email, imageName, 0, image, dob, gender, password);
					//save image file
					String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
					String fileName = customerModel.getImageUrlFromPart();
					System.out.println(savePath + fileName);
					if(!fileName.isEmpty() && fileName != null) {
						image.write(savePath + fileName);
					}
					
					//inserting into database
					int result = connection.addCustomer(MyConstants.ADD_USER, customerModel);
					System.out.println(result);
					if(result > 0) {
						//success
						request.setAttribute("successMessage", "You are registered Try Logging in.");
						RequestDispatcher inc = request.getRequestDispatcher("index.jsp");
						inc.include(request, response);
					}else {
						//failure
						request.setAttribute("errorMessage", "Oops! something Went wrong.");
						RequestDispatcher inc = request.getRequestDispatcher("index.jsp");
						inc.include(request, response);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else {
				//invalid login
				request.setAttribute("errorMessage", "The Email Address Already Exists.");
				RequestDispatcher inc = request.getRequestDispatcher("index.jsp");
				inc.include(request, response);
			}
		}else {
			//password invalid
			request.setAttribute("errorMessage", "Password and confirmpassword fields didn't match");
			RequestDispatcher inc = request.getRequestDispatcher("index.jsp");
			inc.include(request, response);
		}
		doGet(request, response);
	}

}
