package resources;

import java.io.File;

public class MyConstants {
	//database connection queries
	public static final String DRIVER_NAME = "com.mysql.jdbc.Driver";
	public static final String DB_URL = "jdbc:mysql://localhost:3306/AttireHub";
	public static final String DB_USER_NAME = "root";
	public static final String  DB_USER_PASSWORD = "";
	
	//Select Queries
	public static final String GET_USERS_INFO = "SELECT * FROM customers";
	public static final String GET_ADMIN_INFO = "SELECT * FROM admins";
	public static final String GET_PRODUCTS_INFO = "SELECT * FROM products";
	public static final String GET_DATES = "SELECT * FROM dates";
	public static final String GET_ORDERS = "SELECT * FROM orders";
	public static final String GET_ORDER_LIST = "SELECT * FROM order_line";
	
	
	
	
	//insert Queries
	public static final String ADD_NEW_CART = "INSERT INTO cart VALUES(?,?,?,?)";
	public static final String ADD_NEW_DATE = "INSERT INTO dates VALUES(?,?,?,?,?,?)";
	public static final String ADD_NEW_ORDER = "INSERT INTO orders VALUES(?,?,?,?)";
	public static final String ADD_NEW_ORDER_LINE = "INSERT INTO order_line VALUES(?,?,?,?)";
	public static final String ADD_NEW_PRODUCT = "INSERT INTO products VALUES (?,?,?,?,?,?,?,?,?,?)";
	
	
	//DELETE QUERIES
	public static final String DELETE_CART_USING_USER_ID = "DELETE FROM cart WHERE cus_id = ?";
	public static final String REMOVE_CART = "DELETE FROM cart WHERE cus_id = ? AND product_id = ?";
	public static final String DELETE_PRODUCT_USING_PRODUCT_ID = "DELETE FROM products WHERE product_code = ?";
	public static final String DELETE_ORDER_LINE_QUERY = "DELETE FROM order_line WHERE product_id = ?";
	public static final String DELETE_CART_USING_PRODUCT_ID = "DELETE FROM cart WHERE product_id = ?";
	
	
	
	//UPDATE QUERIRS
	public static final String EDIT_CART_QUERY = "UPDATE cart SET product_quantity = ?, product_total_cost = ? WHERE cus_id = ? AND product_id = ?";
	public static final String SUBTRACT_PRODUCT_STOCK_QUERY = "UPDATE products SET product_stock_quantity = product_stock_quantity - ? WHERE  product_code = ?";
	public static final String ADD_PRODUCT_STOCK_QUERY = "UPDATE products SET product_stock_quantity = product_stock_quantity + ? WHERE  product_code = ?";
	public static final String EDIT_PRODUCT_QUERY = "UPDATE products SET product_name = ?, product_price = ?, product_description = ?, product_stock_quantity = ?, product_category = ?, brand = ?, gender = ? WHERE product_code = ?"; 
	

	
	
	
	
	
	
	
	
	public static final String GET_CART_DETAILS_USING_USER_ID = "SELECT * FROM cart WHERE cus_id = ?";
	
	public static final String GET_CART_DETAILS_USING_USER_ID_AND_PRODUCT_ID = "SELECT * FROM cart WHERE cus_id = ? AND product_id = ?";
	
	public static final String GET_TOTAL_BILL = "SELECT customers.cus_email, SUM(cart.product_total_cost) AS grand_total FROM products JOIN cart ON products.product_code=cart.product_id JOIN customers ON cart.cus_id = customers.cus_code  WHERE customers.cus_email = ? GROUP BY customers.cus_email;";
	
	public static final String IS_REGISTERED_QUERY = "SELECT * FROM customers WHERE cus_email = ?";
	
	public static final String IS_ADMIN_REGISTERED_QUERY = "SELECT * FROM admins WHERE admin_email = ?";
	
	public static final String GET_HOT_DEALS_PRODUCTS_INFO = "SELECT * FROM products WHERE hot_deals = 'yes'";
	public static final String GET_PRODUCTS_INFO_USING_PRODUCT_ID = "SELECT * FROM products WHERE product_code = ?";
	public static final String DELETE_USER_USING_ID = "DELETE FROM cusotmers WHERE cus_code = ?";
	public static final String SELL_PRODUCT_QUERY = "UPDATE Products SET product_stock_quantity = product_stock_quantity - ? WHERE product_code = ?";
	public static final String ADD_EXISTING_PRODUCT_QUERY = "UPDATE Products SET product_stock_quantity = product_stock_quantity + ? WHERE product_code = ?";
	public static final String ADD_USER = "INSERT INTO customers(cus_code, cus_name, cus_contact, cus_email, cus_photo, cus_DOB, cus_gender, cus_password) VALUES (?,?,?,?,?,?,?,?)";




	

	

	public static final String IMAGE_DIR = "xamppp\\tomcat\\webapps\\images\\Users\\";
	public static final String IMAGE_DIR_SAVE_PATH = "D:" + File.separator + IMAGE_DIR;
	
	public static final String PRODUCT_IMAGE_DIR = "xamppp\\tomcat\\webapps\\images\\Products\\";
	public static final String PRODUCT_IMAGE_DIR_SAVE_PATH = "D:" + File.separator + PRODUCT_IMAGE_DIR;
	
	
}
