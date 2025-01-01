package model;

public class OrderLine {
	
	private int orderID;
	private int productID;
	private int productQuantity;
	private int productTotalcost;

	public OrderLine() {}
	
	
	public OrderLine(int orderID, int productID, int productQuantity, int product_total_cost) {
		this.orderID = orderID;
		this.productID = productID;
		this.productQuantity =  productQuantity;
		this.productTotalcost = product_total_cost;
	}


	public int getOrderID() {
		return orderID;
	}


	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}


	public int getProductID() {
		return productID;
	}


	public void setProductID(int productID) {
		this.productID = productID;
	}


	public int getProductQuantity() {
		return productQuantity;
	}


	public void setProductQuantity(int productQuantity) {
		this.productQuantity = productQuantity;
	}


	public int getProductTotalCost() {
		return productTotalcost;
	}


	public void setProductTotalCost(int productTotalcost) {
		this.productTotalcost = productTotalcost;
	}

}
