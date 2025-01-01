package controller.dbconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;

import model.Customers;
import model.Dates;
import model.OrderLine;
import model.Orders;
import model.Cart;
import model.PasswordEncryptionWithAes;
import model.Products;
import resources.MyConstants;

public class DbConnection {
	
	//connection
	public Connection getConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/AttireHub",
					"root",
					"");
			System.out.println("Database connection Successful");
			return conn;
		}
		catch(SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
			return null;
			
		}
	}
	
	
	//select all query
	public ResultSet selectAllQuery(String query) {
		Connection DbConnection = getConnection();
		if(DbConnection != null) {
			try {
				PreparedStatement statement = DbConnection.prepareStatement(query);
				ResultSet result = statement.executeQuery();
				return result;
				
			}catch(SQLException ex) {
				return null;
			}
		}else {
		return null;
		}
	}
	
	
	//select using id
	public ResultSet selectUsingId(String query, int id) {
		Connection DbConnection = getConnection();
		if(DbConnection != null) {
			try {
				PreparedStatement statement = DbConnection.prepareStatement(query);
				statement.setInt(1, id);
				ResultSet result = statement.executeQuery();
				return result;
				
			}catch(SQLException ex) {
				return null;
			}
		}else {
		return null;
		}
		
	}
	
	
	//select user using email
	public ResultSet selectUserUsingEmail(String query, String email) {
		Connection DbConnection = getConnection();
		if(DbConnection != null) {
			try {
				PreparedStatement statement = DbConnection.prepareStatement(query);
				statement.setString(1, email);
				ResultSet result = statement.executeQuery();
				return result;
				
			}catch(SQLException ex) {
				return null;
			}
		}else {
		return null;
		}
		
	}
	
	//user exists
	public Boolean emailExists(String query, String email) {
		Connection DbConnection = getConnection();
		if(DbConnection != null) {
			try{
				PreparedStatement statement = DbConnection.prepareStatement(query);
				statement.setString(1,email);
				ResultSet result = statement.executeQuery();
				if(result.next())return true;
				else return false;
			  }catch(SQLException ex) {
				  return null;
			  }
		}else {
			return null;
		}
		
	}
	
	//is user registeres
	public Boolean isUserRegistered(String query, String username, String password) {
		Connection DbConnection = getConnection();
		if(DbConnection != null) {
			  try {
				  PreparedStatement statement = DbConnection.prepareStatement(query);
				  statement.setString(1,username);
				  ResultSet result = statement.executeQuery();
				  if(result.next()) {
					  String DbEmail = result.getString("cus_email");
					  String DbPassword = result.getString("cus_password");
					  String decPassword = PasswordEncryptionWithAes.decrypt(DbPassword, DbEmail);
					  if(decPassword != null && !decPassword.isEmpty() && DbEmail.equals(username) && decPassword.equals(password)) return true;
					  else return false;
				  }
				  else {
					  return false;
				  }
			  }catch(SQLException ex) {
				  return null;
			  }
			
		}else {
			return null;
		}
	}
	
	//admin registration 
	public Boolean isAdminRegistered(String query, String username, String password){
		Connection DbConnection = getConnection();
		if(DbConnection != null) {
			  try {
				  PreparedStatement statement = DbConnection.prepareStatement(query);
				  statement.setString(1,username);
				  ResultSet result = statement.executeQuery();
				  if(result.next()) {
					  String DbEmail = result.getString("admin_email");
					  String DbPassword = result.getString("admin_password");
					  String decPassword = PasswordEncryptionWithAes.decrypt(DbPassword, DbEmail);
					  if(decPassword != null && !decPassword.isEmpty() && DbEmail.equals(username) && decPassword.equals(password)) return true;
					  else return false;
				  }
				  else {
					  return false;
				  }
			  }catch(SQLException ex) {
				  return null;
			  }
			
		}else {
			return null;
		}
	}
	
	
	//customer registration
	public int addCustomer(String query, Customers cusModel) {
		Connection Dbconnection = getConnection();
		if(Dbconnection != null) {
			  try {
				  PreparedStatement statement = Dbconnection.prepareStatement(query);
				  statement.setInt(1, cusModel.getCusCode());
				  statement.setString(2, cusModel.getCusName());
				  statement.setString(3, cusModel.getCusContact());
				  statement.setString(4, cusModel.getCusEmail());
				  statement.setString(5, cusModel.getCusPhoto());
				  statement.setString(6, cusModel.getDob());
				  statement.setString(7, cusModel.getGender());
				  statement.setString(8, PasswordEncryptionWithAes.encrypt(cusModel.getCusEmail(), cusModel.getPassword()));

				  int result = statement.executeUpdate();
				  System.out.println("Query Ran"); 
				  return result;
			  }catch(SQLException ex) {
				  System.out.println("Query didnt Ran");
				  ex.printStackTrace();
				  return -1;
				  
			  }
			
		}else {

			return -1;
		}
		
	}
	
	//add to cart
	public int addToCart(String query, Cart cartModel) {
		Connection Dbconnection = getConnection();
		if(Dbconnection != null) {
			  try {
				  PreparedStatement statement = Dbconnection.prepareStatement(query);
				  statement.setInt(1, cartModel.getCusId());
				  statement.setInt(2, cartModel.getProductId());
				  statement.setInt(3, cartModel.getProductQuantity());
				  statement.setInt(4, cartModel.getTotalPrice());

				  int result = statement.executeUpdate();
				  System.out.println("Query Ran");
				  return result;
			  }catch(SQLException ex) {
				  System.out.println("Query didnt Ran");
				  ex.printStackTrace();
				  return -1;
				  
			  }
			
		}else {

			return -1;
		}
	}
	
	
	//update products
	public int updateProducts(String query, int quantity, int productCode) {
		Connection Dbconnection = getConnection();
		if(Dbconnection != null) {
			  try {
				  PreparedStatement statement = Dbconnection.prepareStatement(query);				  
				  statement.setInt(1, quantity);
				  statement.setInt(2, productCode);
				  int result = statement.executeUpdate();
				  System.out.println("Query Ran");
				  return result;
			  }catch(SQLException ex) {
				  System.out.println("Query didnt Ran");
				  ex.printStackTrace();
				  return -1;
				  
			  }
			
		}else {

			return -1;
		}

	}
	
	
	//update cart
	public int updateCart(String query, int productQuantity, int productTotalCost, int cusId , int productId) {
		Connection Dbconnection = getConnection();
		if(Dbconnection != null) {
			  try {
				  PreparedStatement statement = Dbconnection.prepareStatement(query);
				  statement.setInt(1, productQuantity);
				  statement.setInt(2, productTotalCost);
				  statement.setInt(3, cusId);
				  statement.setInt(4, productId);

				  int result = statement.executeUpdate();
				  System.out.println("Query Ran");
				  return result;
			  }catch(SQLException ex) {
				  System.out.println("Query didnt Ran");
				  ex.printStackTrace();
				  return -1;
				  
			  }
			
		}else {

			return -1;
		}
	}
	
	//delete cart
	public int deleteCart(String query, int cusId, int ProductID) {
		Connection Dbconnection = getConnection();
		if(Dbconnection != null) {
			  try {
				  PreparedStatement statement = Dbconnection.prepareStatement(query);
				  statement.setInt(1, cusId);
				  statement.setInt(2, ProductID);

				  int result = statement.executeUpdate();
				  System.out.println("Query Ran");
				  return result;
			  }catch(SQLException ex) {
				  System.out.println("Query didnt Ran");
				  ex.printStackTrace();
				  return -1;
				  
			  }
			
		}else {

			return -1;
		}

	}
	
	
	//add date values
	public int addDate(String query, Dates dateModel) {
		Connection Dbconnection = getConnection();
		if(Dbconnection != null) {
			  try {
				  PreparedStatement statement = Dbconnection.prepareStatement(query);
				  
				  //because month index starts from 0
				  int month = dateModel.getMonth()+1;
				  //SQL date type "YYYY-MM-DD"
				  String date = dateModel.getYear() + "-" + month +"-"+dateModel.getDay();
				  
				  statement.setInt(1, dateModel.getDateCode());
				  statement.setString(2, date);
				  statement.setInt(3, dateModel.getYear());
				  statement.setInt(4, month);
				  statement.setInt(5, dateModel.getDay());
				  statement.setInt(6, dateModel.getYearlyQuarter());
				  int result = statement.executeUpdate();
				  System.out.println("Query Ran");
				  return result;
			  }catch(SQLException ex) {
				  System.out.println("Query didnt Ran");
				  ex.printStackTrace();
				  return -1;
				  
			  }
			
		}else {

			return -1;
		}

	}
	
	
	//get total bill
	public int getTotalBill(String query, String cusEmail) {
		Connection DbConnection = getConnection();
		if(DbConnection != null) {
			try {
				PreparedStatement statement = DbConnection.prepareStatement(query);
				statement.setString(1, cusEmail);
				ResultSet result = statement.executeQuery();
				if(result.next()) {
					int totalBill = result.getInt("grand_total");
					return totalBill;
				}else {
					return 0;
				}
			}catch(SQLException ex) {
				return 0;
			}
		}else {
		return 0;
		}
	}
	
	//get product quantity
	public int getProductQuantityFromCart(String query, int cusID, int productID){
		Connection DbConnection = getConnection();
		if(DbConnection != null) {
			try {
				PreparedStatement statement = DbConnection.prepareStatement(query);
				statement.setInt(1, cusID);
				statement.setInt(2, productID);
				ResultSet result = statement.executeQuery();
				
				if(result.next()) {
					int cartProductQuantity = result.getInt("product_quantity");
					System.out.println(cartProductQuantity);
					return cartProductQuantity;
				}else {
					System.out.println("rows ta xains");
					return 0;
				}
			}catch(SQLException ex) {
				ex.printStackTrace();
				return 0;
			}
		}else {
		return 0;
		}
		
	}
	
	
	//add order record
	public int addOrder(String query, Orders orderModel) {
		Connection Dbconnection = getConnection();
		if(Dbconnection != null) {
			  try {
				  PreparedStatement statement = Dbconnection.prepareStatement(query);				  
				  statement.setInt(1, orderModel.getOrderId());
				  statement.setInt(2, orderModel.getOrderDate());
				  statement.setInt(3, orderModel.getOrderCustomer());
				  statement.setInt(4, orderModel.getOrderBill());

				  int result = statement.executeUpdate();
				  System.out.println("Query Ran");
				  return result;
			  }catch(SQLException ex) {
				  System.out.println("Query didnt Ran");
				  ex.printStackTrace();
				  return -1;
				  
			  }
			
		}else {

			return -1;
		}

	}
	
	//get cart  info by cart id
	public ResultSet getCartInfoByCusID(String query, int cusID) {
		Connection DbConnection = getConnection();
		if(DbConnection != null) {
			try {
				PreparedStatement statement = DbConnection.prepareStatement(query);
				statement.setInt(1, cusID);
				ResultSet result = statement.executeQuery();
				return result;
				
			}catch(SQLException ex) {
				return null;
			}
		}else {
		return null;
		}
	}
	
	
	//add order line entry
	public int addOrderLine(String query, OrderLine orderLineModel) {
		Connection Dbconnection = getConnection();
		if(Dbconnection != null) {
			  try {
				  PreparedStatement statement = Dbconnection.prepareStatement(query);				  
				  statement.setInt(1, orderLineModel.getOrderID());
				  statement.setInt(2, orderLineModel.getProductID());
				  statement.setInt(3, orderLineModel.getProductQuantity());
				  statement.setInt(4, orderLineModel.getProductTotalCost());

				  int result = statement.executeUpdate();
				  System.out.println("Query Ran");
				  return result;
			  }catch(SQLException ex) {
				  System.out.println("Query didnt Ran");
				  ex.printStackTrace();
				  return -1;
				  
			  }
			
		}else {

			return -1;
		}

	}
	
	
	//delete cart using customer id after buying
	public int deleteCart(String query, int cusID) {
		Connection Dbconnection = getConnection();
		if(Dbconnection != null) {
			  try {
				  PreparedStatement statement = Dbconnection.prepareStatement(query);				  
				  statement.setInt(1, cusID);
				  int result = statement.executeUpdate();
				  System.out.println("Query Ran");
				  return result;
			  }catch(SQLException ex) {
				  System.out.println("Query didnt Ran");
				  ex.printStackTrace();
				  return -1;
				  
			  }
			
		}else {

			return -1;
		}

	}
	
	//update user data
	public int updateUser(String query) {
		Connection Dbconnection = getConnection();
		if(Dbconnection != null) {
			  try {
				  PreparedStatement statement = Dbconnection.prepareStatement(query);				  
				  int result = statement.executeUpdate();
				  System.out.println("Query Ran");
				  return result;
			  }catch(SQLException ex) {
				  System.out.println("Query didnt Ran");
				  ex.printStackTrace();
				  return -1;  
			  }	
		}else {
			return -1;
		}
	}
	
	
	
	//Query to update customer data except email
	public String generateUpdateCustomerQuery(int cusCcode,String name, String dob, String gender,  String phone, String password, String imageName) {
		StringBuilder queryBuild = new StringBuilder("UPDATE customers SET ");
		boolean first = true;
		if(name != null && !name.isEmpty()) {
			if(!first) {
				queryBuild.append(",");
			}
			queryBuild.append("cus_name = '"+name +"' " );
			first = false;
		}
		
		if(dob != null && !dob.isEmpty()) {
			if(!first) {
				queryBuild.append(",");
			}
			queryBuild.append("cus_DOB = '"+dob +"' " );
			first = false;
		}
		
		if(gender != null && !gender.isEmpty()) {
			if(!first) {
				queryBuild.append(",");
			}
			queryBuild.append("cus_gender = '"+gender +"' " );
			first = false;
		}
		
		if(phone != null && !phone.isEmpty()) {
			if(!first) {
				queryBuild.append(",");
			}
			queryBuild.append("cus_contact = '"+phone +"' " );
			first = false;
		}
		
		if(password != null && !password.isEmpty()) {
			if(!first) {
				queryBuild.append(",");
			}
			queryBuild.append("cus_password = '"+password +"' " );
			first = false;
		}
		
		if(imageName != null && !imageName.isEmpty()) {
			if(!first) {
				queryBuild.append(",");
			}
			queryBuild.append("cus_photo = '"+imageName +"' " );
			first = false;
		}
		
		queryBuild.append("WHERE cus_code = " + cusCcode);
		return queryBuild.toString();
	}
	
	
	//add product
	public int addProduct( String query, Products productModel) {
		Connection conn = getConnection();
		if(conn != null) {
			  try {
				  PreparedStatement statement = conn.prepareStatement(query);
				  statement.setInt(1, productModel.getProductId());
				  statement.setString(2, productModel.getProductName());
				  statement.setString(3, productModel.getDescription());
				  statement.setString(4, productModel.getProductCategory());
				  statement.setString(5, productModel.getGender());
				  statement.setInt(6, productModel.getProductQty());
				  statement.setInt(7, productModel.getProductPrice());
				  statement.setString(8, productModel.getProductImage());
				  statement.setString(9, productModel.getProductDeals());
				  statement.setString(10, productModel.getProductBrand());
				  
				  int result = statement.executeUpdate();
				  return result;
			  }catch(SQLException ex) {
				  System.out.println("Query didnt Ran");
				  return -1;  
			  }
		}else {
			return -1;
			}
		}

	//edit product
	public int editProduct(String query, String productName, int productPrice, String productDescription, int productStockQuantity, String productCategory, String productBrand, String productGender, int productCode) {
		Connection conn = getConnection();
		if(conn != null) {
			  try {
				  PreparedStatement statement = conn.prepareStatement(query);
				  statement.setString(1, productName);
				  statement.setInt(2, productPrice);
				  statement.setString(3, productDescription);
				  statement.setInt(4, productStockQuantity);
				  statement.setString(5, productCategory);
				  statement.setString(6, productBrand);
				  statement.setString(7, productGender);
				  statement.setInt(8, productCode);
				  int result = statement.executeUpdate();
				  return result;
			  }catch(SQLException ex) {
				  System.out.println("Query didnt Ran");
				  return -1;  
			  }
		}else {
			return -1;
			}
	}
	
	
	//delete product
	public int deleteProduct(String query, int productCode) {
		Connection conn = getConnection();
		if(conn != null) {
			  try {
				  PreparedStatement statement = conn.prepareStatement(query);
				  statement.setInt(1, productCode);
				  int result = statement.executeUpdate();
				  System.out.println(result);
				  return result;
			  }catch(SQLException ex) {
				  System.out.println("Query didnt Ran");
				  return -1;  
			  }
		}else {
			return -1;
			}
	}
	
	public static void closeConnection(Connection conn) throws SQLException {
		if(conn != null) {
			conn.close();
		}
	}
}
